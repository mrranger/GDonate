<?php


class Install
{
    protected $pdo;
    protected $pdo1;
    public function __construct(PDO $pdo,PDO $pdo1)
    {
        $this->pdo = $pdo;
        $this->pdo1 = $pdo1;
    }
    public function install($config)
    {
        $query = [
            "CREATE TABLE IF NOT EXISTS `mpdonate_cupons`( `cupon` varchar(255) NOT NULL, `type` varchar(255) NOT NULL, `data` varchar(255) NOT NULL, `maxuses` int(255) NOT NULL, PRIMARY KEY (`cupon`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
            "CREATE TABLE IF NOT EXISTS `mpdonate_cupons_used` ( `id` int(11) NOT NULL AUTO_INCREMENT, `cupon` varchar(255) NOT NULL, `sid` varchar(255) NOT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
            "CREATE TABLE IF NOT EXISTS `mpdonate_game_log` ( `id` bigint(20) NOT NULL AUTO_INCREMENT, `description` varchar(255) NOT NULL, `pltoken` varchar(255) NOT NULL, `date` datetime NOT NULL DEFAULT current_timestamp(), PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
            "CREATE TABLE IF NOT EXISTS `mpdonate_inventory` ( `id` bigint(20) NOT NULL AUTO_INCREMENT, `sid` bigint(20) DEFAULT NULL, `class` longtext DEFAULT NULL, `expires` int(11) DEFAULT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
            "CREATE TABLE IF NOT EXISTS `mpdonate_payment` ( `id` bigint(20) NOT NULL AUTO_INCREMENT, `unique_code` varchar(40) NOT NULL, `inv` bigint(20) NOT NULL, `id_goods` int(11) NOT NULL, `amount` decimal(10,0) NOT NULL, `date_pay` int(11) NOT NULL, `email` varchar(60) NOT NULL, `cnt_goods` float NOT NULL, `query_string` bigint(20) NOT NULL, `is_given` tinyint(1) DEFAULT NULL, `give_time` bigint(20) NOT NULL DEFAULT current_timestamp(), PRIMARY KEY (`id`), UNIQUE KEY `unique_code` (`unique_code`), UNIQUE KEY `inv` (`inv`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
            "CREATE TABLE IF NOT EXISTS `mpdonate_players` ( `sid` bigint(20) NOT NULL, `balance` int(11) DEFAULT NULL, `expires` int(11) DEFAULT NULL, `usergroup` longtext DEFAULT NULL, `pltoken` varchar(255) NOT NULL, PRIMARY KEY (`sid`), UNIQUE KEY `pltoken` (`pltoken`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",
            "CREATE TABLE IF NOT EXISTS `short_urls` ( `id` int(11) NOT NULL AUTO_INCREMENT, `long_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL, `short_code` varchar(25) COLLATE utf8_unicode_ci NOT NULL, `hits` int(11) NOT NULL DEFAULT 0, `created` datetime NOT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;"
        ];
        foreach ($query as $key => $value)
        {
            $this->pdo->exec($value);
        }
        $stmt = $this->pdo1->query("SELECT NULL FROM `COLUMNS` WHERE `COLUMN_NAME` = 'id'AND `TABLE_NAME` = 'ba_bans' AND `TABLE_SCHEMA`= 'roleplay_admin'");
        $result = $stmt->fetch();
        var_dump($result);
    }

}