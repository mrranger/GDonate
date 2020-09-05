<?php


class Player
{
    protected static $table = 'mpdonate_players';
    protected $sid;
    protected $balance;
    protected $expires;
    protected $usergroup;

    protected $pdo;
    protected $token;
    protected $timestamp;


    public function __construct(PDO $pdo, $sid, $token, $config)
    {

        $this->token = $token == $config['token'] ? true : false;
        $this->sid = $sid;
        $this->pdo = $pdo;
        $this->timestamp = date("Y-m-d H:i:s");
    }

    public function getPlayerBalance($balance)
    {
        $balance = trim($balance);
        if ($this->token)
        {
            $query = "SELECT balance FROM ".self::$table." WHERE sid = :sid LIMIT 1";
            $stmt = $this->pdo->prepare($query);
            $params=array(
                "sid" => $this->sid
            );
            $stmt->execute($params);

            $result = $stmt->fetch();

            if ($balance == $result['balance'])
            {
                exit("true");
            }
            else
            {
                exit($result['balance']);
            }
        }
        else
        {
            exit('false');
        }
    }
}