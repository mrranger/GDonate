<?php


class Log
{
    protected static $table = 'mpdonate_game_log';

    protected $description;
    protected $sid;
    protected $pltoken;
    protected $date;

    protected $pdo;
    protected $timestamp;

    public function __construct(PDO $pdo, $pltoken)
    {
        $this->pltoken = $pltoken;
        $this->pdo = $pdo;
        $this->timestamp = date("d.m.Y H:i");
    }

    public function getLog()
    {
        $this->prepareJSON($this->getPlayerLog($this->pltoken));
    }

    public function getPlayerLog($pltoken)
    {
        $query = "SELECT description, date FROM ".self::$table." WHERE pltoken = :pltoken ";
        $stmt = $this->pdo->prepare($query);
        $params=array(
            "pltoken" => $pltoken
        );
        $stmt->execute($params);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);


        return($result);

    }
    public function setPlayerLog($desc, $sid)
    {

        $query = "INSERT INTO ".self::$table." (sid, description, pltoken) VALUES (:sid, :description, :pltoken) ";
        $stmnt = $this->pdo->prepare($query);
        $params = array(
            'sid' => $sid,
            'description' => $desc,
            'pltoken' => $this->pltoken,

        );
        $stmnt->execute($params);

        exit($this->pdo->lastInsertId());
    }

    public function prepareJSON(array $post)
    {
        exit( json_encode($post,JSON_UNESCAPED_UNICODE));
    }
    public function GetAll()
    {
        $query = "SELECT * FROM ".self::$table."LIMIT 100";
        $stmt = $this->pdo->prepare($query);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return(json_encode($result, JSON_UNESCAPED_UNICODE));
    }
}