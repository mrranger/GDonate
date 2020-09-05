<?php

//use Unban;

class Payment
{
    protected $check_url = 'http://shop.digiseller.ru/xml/check_unique_code.asp';
    protected static $table = 'mpdonate_payment';
    protected static $players_table = 'mpdonate_players';
    protected static $log_table = 'mpdonate_game_log';

    protected $pdo;
    protected $timestamp;
    protected $config;
    protected $unbanc;

    protected $unique_code;
    protected $inv;
    protected $id_goods;
    protected $amount;
    protected $date_pay;
    protected $email;
    protected $cnt_goods;
    protected $query_string;
    protected $sid;
    protected $unban;

    public function __construct(PDO $pdo,$config, Unban $unban)
    {

        $this->unbanc = $unban;
        $this->config = $config;
        $this->pdo = $pdo;
        $this->timestamp = date("Y-m-d H:i:s");
    }
    public function SuccessPayment($uuid, $id, $password)
    {
        $post = [
            'id_seller' => $id,
            'unique_code' => $uuid,
            'sign' => $this->PaymentHash($uuid, $id, $password)
        ];
        $this->PaymentSender($post, $this->check_url);

        if ($this->checkQuery())
        {
            if ($this->unban == "true" && $this->unban == $_GET['unban'] && $this->config['unban']['price'] == $this->cnt_goods && $this->config['unban']['allow'])
            {
                //описать действие для разбана
                if ($this->isGiven())
                {
                    throw new Exception('Вы уже оплатили и получили');
                }
                else
                {
                    $this->insertPaymenttoDB($this->unBan());
                    echo 'Вы разбанены';
                }
            }
            elseif( $this->unban == "false" || empty($this->unban))
            {
                if ($this->isGiven())
                {
                    throw new Exception('Вы уже оплатили и получили');
                }
                else
                {
                    $this->insertPaymenttoDB($this->Give());
                }
                if ($this->isGiven())
                {
                    $this->insertPaymenttoLog();
                    echo "Успешно";
                }
                else
                {
                    throw new Exception('По неопределенным причинам, оплата не была выдана сообщите код администрации' . $this->unique_code);
                }
            }
            else{
                throw new Exception('Ошибка платежа параметры не соответствуют');

            }


        }

    }
    private function PaymentHash($uuid, $id, $password)
    {
        return md5($id . ':' . $uuid. ':' . $password);
    }
    private function PaymentSender(array $post, $url)
    {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post));
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json'
        ));

        $result = json_decode(curl_exec($ch));

        curl_close($ch);
        $keys = ['unique_code', 'inv', 'id_goods', 'amount', 'date_pay', 'cnt_goods', 'email', 'query_string'];
        $filter = function ($key) use ($keys){
            return in_array($key, $keys);
        };
        foreach ($result as $key => $value) {
            if (in_array($key,$keys))
            {
                if($key == 'date_pay')
                {
                    $this->$key = strtotime($value);
                }
                elseif ($key == 'query_string')
                {
                    $this->query_string = $value;
                    $ar = explode('&', base64_decode($value));
                    foreach($ar as $key)
                    {
                        $value = explode('=',$key);
                        $val = $value[0];
                        $this->$val = $value[1];

                    }

                }
                elseif ($key == 'amount')
                {
                    $this->$key = str_replace(',','.',$value) ;
                }
                else
                {
                    $this->$key = $value;
                }
            }
        }

    }
    private function checkQuery()
    {
        $query = $this->sid;
        $sid = $_GET['sid'];
        if (!empty($query) && !empty($sid))
        {
            if ($query == $sid) {
                return true;
            } else {
                throw new Exception('Проверочное поле не соответствует. Обратитесь к администрации');
            }
        }
        else
        {
            throw new Exception('Проверочное поле отсутствует. Обратитесь к администрации');
        }
    }
    private function insertPaymenttoDB($give)
    {
        try {
            $query = "INSERT INTO ".self::$table." (unique_code,inv,id_goods,amount,date_pay,email,cnt_goods,query_string,is_given,give_time) VALUES (:unique_code,:inv,:id_goods,:amount,:date_pay,:email,:cnt_goods,:query_string,:is_given,:give_time) ON DUPLICATE KEY UPDATE is_given = :is_given";
            $stmnt = $this->pdo->prepare($query);
            $params = array(
                "unique_code" => $this->unique_code,
                "inv" => $this->inv,
                "id_goods" => $this->id_goods,
                "amount" => $this->amount,
                "date_pay" => $this->date_pay,
                "email" => $this->email,
                "cnt_goods" => $this->cnt_goods,
                "query_string" => $this->query_string,
                "is_given" => $give,
                "give_time" => time(),
            );
            $stmnt->execute($params);

            return $this->pdo->lastInsertId();
        }
        catch (PDOException $e)
        {
            if ($e->getCode() == 23000){
                throw new Exception('Вы уже оплатили и получили');
            }
            else
            {
                throw new Exception('Ошибка на стороне сервера, Обратитесь к администрации.' .  $e->getMessage());
            }
        }

    }
    private function isGiven()
    {
        $query = "SELECT is_given FROM ".self::$table." WHERE unique_code = :unique_code LIMIT 1";
        $stmt = $this->pdo->prepare($query);
        $params=array(
            "unique_code" => $this->unique_code
        );
        $stmt->execute($params);

        $result = $stmt->fetch();
        return $result['is_given'];
    }
    private function Give()
    {
        try{
            $query = "SELECT balance FROM ".self::$players_table." WHERE sid = :sid LIMIT 1";
            $stmt = $this->pdo->prepare($query);
            $params=array(
                "sid" => $this->sid
            );
            $stmt->execute($params);

            $result = $stmt->fetch();
            $balance = $result['balance'] + $this->cnt_goods;

            $query = "UPDATE  ".self::$players_table." SET balance = :balance WHERE sid = :sid";
            $stmt = $this->pdo->prepare($query);
            $params=array(
                'balance' => $balance,
                "sid" => (int) $this->sid
            );


            $stmt->execute($params);
        }

        catch (PDOException $e)
        {
            return false;
            throw new Exception('Что-то пошло не так. Код ошибки:' . $e->getCode());
        }
        return true;
    }
    private function insertPaymenttoLog()
    {
        $query = "SELECT pltoken FROM ".self::$players_table." WHERE sid = :sid LIMIT 1";
        $stmt = $this->pdo->prepare($query);
        $params=array(
            "sid" => $this->sid
        );
        $stmt->execute($params);

        $result = $stmt->fetch();
        $pltoken = $result['pltoken'];

        $query = "INSERT INTO ".self::$log_table." (sid, description, pltoken) VALUES (:sid, :description, :pltoken) ";
        $stmnt = $this->pdo->prepare($query);
        $params = array(
            'sid' => (int) $this->sid,
            'description' => 'Пополнил баланс на: ' . $this->cnt_goods . ' ' .  $this->config['currency'],
            'pltoken' => $pltoken,

        );
        $stmnt->execute($params);

        return $this->pdo->lastInsertId();

    }
    private function unBan()
    {
        return $this->unbanc->unban($this->sid);
    }
}