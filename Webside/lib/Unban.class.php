<?php


class Unban
{
    protected $pdo;
    protected static $table = "ba_bans";
    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function unban($sid)
    {
        try{
            $query = "DELETE FROM ".self::$table." WHERE steamid = :sid";
            $stmt = $this->pdo->prepare($query);
            $params=array(
                "sid" => $sid
            );
            $stmt->execute($params);

            return true;
        }
        catch (PDOException $e)
        {
            throw new Exception('Что-то пошло не так. Код ошибки:' . $e->getCode());
        }
    }
}