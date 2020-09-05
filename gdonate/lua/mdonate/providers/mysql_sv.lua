mp.mysql = mp.mysql or {}
require("mysql")
mp.mysql.object = mysql.Connect(mp.c.db.host, mp.c.db.login, mp.c.db.password, mp.c.db.database, 3306)

function mp.mysql.MakeTable() -- Создаем табличку
    if mp.mysql.object then
        mp.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_cupons`( `cupon` varchar(255) NOT NULL, `type` varchar(255) NOT NULL, `data` varchar(255) NOT NULL, `maxuses` int(255) NOT NULL, PRIMARY KEY (`cupon`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Основная таблица
        mp.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_cupons_used` ( `id` int(11) NOT NULL AUTO_INCREMENT, `cupon` varchar(255) NOT NULL, `sid` varchar(255) NOT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        mp.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_game_log` ( `id` bigint(20) NOT NULL AUTO_INCREMENT, `sid` bigint(20), `description` varchar(255) NOT NULL, `pltoken` varchar(255) NOT NULL, `date` datetime NOT NULL DEFAULT current_timestamp(), PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        mp.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_inventory` ( `id` bigint(20) NOT NULL AUTO_INCREMENT, `sid` bigint(20) DEFAULT NULL, `server` longtext NOT NULL, `class` longtext DEFAULT NULL, `expires` int(11) DEFAULT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        mp.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_payment` ( `id` bigint(20) NOT NULL AUTO_INCREMENT, `unique_code` varchar(255) NOT NULL, `inv` bigint(20) NOT NULL, `id_goods` int(11) NOT NULL, `amount` decimal(10,0) NOT NULL, `date_pay` int(11) NOT NULL, `email` varchar(60) NOT NULL, `cnt_goods` float NOT NULL, `query_string` varchar(255) NOT NULL, `is_given` tinyint(1) DEFAULT NULL, `give_time` bigint(20) NOT NULL DEFAULT current_timestamp(), PRIMARY KEY (`id`), UNIQUE KEY `unique_code` (`unique_code`), UNIQUE KEY `inv` (`inv`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        mp.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_players` ( `sid` bigint(20) NOT NULL, `balance` int(11) DEFAULT NULL, `pltoken` varchar(255) NOT NULL, PRIMARY KEY (`sid`), UNIQUE KEY `pltoken` (`pltoken`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        mp.mysql.object:Query("CREATE TABLE IF NOT EXISTS `short_urls` ( `id` int(11) NOT NULL AUTO_INCREMENT, `long_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL, `short_code` varchar(25) COLLATE utf8_unicode_ci NOT NULL, `hits` int(11) NOT NULL DEFAULT 0, `created` datetime NOT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;") -- Инвентарь
        mp.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_groups` (`id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,`server` varchar(255) NOT NULL,`sid` bigint(255) NOT NULL,`expires` bigint(255) NOT NULL,`usergroup` varchar(255) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
      mp.DebugMsg("Created tables if not exists")
    end
end


-------------------------
-- @input  sid(String), balance(Int), inventory(String), usergroup(String)
------------------------
function mp.mysql.MakePlayer(sid,balance,token,grouponly) -- Создаем пресонажа
    if not grouponly then
        mp.mysql.object:Query("INSERT INTO `mpdonate_players`(`sid`, `balance`,`pltoken`) VALUES ('"..sid.."',"..balance..","..sql.SQLStr(token)..")")
    end
    mp.mysql.object:Query("INSERT INTO `mpdonate_groups`(`sid`,`server`, `expires`,`usergroup`) VALUES ('"..sid.."',"..sql.SQLStr(mp.c.db.serverid)..",0,'user')")
    mp.DebugMsg("Created player: "..sid)
end

-------------------------
-- @input  sid(String), var(String), value(All)
------------------------
function mp.mysql.WriteVar(sid,table,var,value) -- сохранение отдельных варов в бд, шоб не ебать полной перезаписью
    mp.mysql.object:Query("UPDATE `"..table.."` SET `"..var.."`="..value.." WHERE `sid` = "..sql.SQLStr(sid))
    mp.DebugMsg("Saved player var: "..sid.." - Var: "..var..", Value: "..value)
end

function mp.mysql.WriteVarServers(sid,table,var,value) -- сохранение отдельных варов в бд, шоб не ебать полной перезаписью
    mp.mysql.object:Query("UPDATE `"..table.."` SET `"..var.."`="..value.." WHERE `sid` = "..sql.SQLStr(sid).." AND `server` = "..sql.SQLStr(mp.c.db.serverid))
    mp.DebugMsg("Saved player var: "..sid.." - Var: "..var..", Value: "..value)
end

-------------------------
-- @input  sid(String), var(String)
-- @callback (String)
------------------------
function mp.mysql.GetPlayerVar(sid,var,cback) -- анолошично шоб не ебать бд и не ждать по 3 часа
    mp.mysql.object:Query("SELECT `"..var.."` FROM `mpdonate_players` WHERE `sid` = "..sql.SQLStr(sid),function(data) cback(data[1][var]) end)
    mp.DebugMsg("Getting player var: "..sid.." - Var: "..var..", Value: "..value)
end

-------------------------
-- @input  sid(String)
-- @callback (Table)
------------------------
function mp.mysql.GetPlayer(sid,cback)
    mp.mysql.object:Query("SELECT * FROM `mpdonate_players` WHERE `sid` = "..sql.SQLStr(sid),function(data) cback(data[1] or false) end)
    mp.DebugMsg("Getting player: "..sid)
end

-------------------------
-- @input  sid(String)
-- @callback (Table)
------------------------
function mp.mysql.GetPlayerGroup(sid,cback)
    mp.mysql.object:Query("SELECT * FROM `mpdonate_groups` WHERE `sid` = "..sql.SQLStr(sid).." AND `server` = "..sql.SQLStr(mp.c.db.serverid),function(data) cback(data[1] or false) end)
    mp.DebugMsg("Getting player groups: "..sid)
end

-------------------------
-- @input  sid(String)
-- @callback (Table)
------------------------
function mp.mysql.GetPlayerInventory(sid,cback)
    mp.mysql.object:Query("SELECT * FROM `mpdonate_inventory` WHERE `sid` = "..sql.SQLStr(sid).." AND `server` = "..sql.SQLStr(mp.c.db.serverid),function(data) cback(data or false) end)
    mp.DebugMsg("Getting player inventory: "..sid)
end

-------------------------
-- @input  sid(String), balance(Int), inventory(String), usergroup(String)
------------------------
function mp.mysql.SavePlayer(sid,balance,expires,usergroup)
    mp.mysql.object:Query("UPDATE `mpdonate_players` SET `balance`="..balance.." WHERE `sid` = "..sql.SQLStr(sid))
    mp.mysql.object:Query("UPDATE `mpdonate_groups` SET `expires`="..sql.SQLStr(expires)..",`usergroup`="..sql.SQLStr(usergroup).." WHERE `sid` = "..sql.SQLStr(sid).." AND `server` = "..sql.SQLStr(mp.c.db.serverid))
    mp.DebugMsg("Saved player: "..sid.." - Balance: "..balance..", Expires: "..expires..", UserGroup:"..usergroup)
end

function mp.mysql.Log(pltoken,desc,sid)
    mp.php.Requst("log",{pltoken=pltoken,desc=desc,sid=sid},function(data)
        print(data)
        mp.DebugMsg("Added log data: "..desc)
    end)
end--desc

function mp.mysql.AddPlayerInventory(sid,class,expires)
    mp.mysql.object:Query("INSERT INTO `mpdonate_inventory`(`sid`,`server`, `class`, `expires`) VALUES ("..sql.SQLStr(sid)..","..sql.SQLStr(mp.c.db.serverid)..","..sql.SQLStr(class)..","..sql.SQLStr(expires)..")")
    mp.DebugMsg("Add to player inventory: "..sid)
end

function mp.mysql.TakePlayerInventory(sid,class)
    mp.mysql.object:Query("DELETE FROM `mpdonate_inventory` WHERE sid="..sid.." AND class="..sql.SQLStr(class).." AND `server` = "..sql.SQLStr(mp.c.db.serverid))
    mp.DebugMsg("Take from player inventory: "..sid)
end

function mp.mysql.TakePlayerInventoryByID(sid,id)
    mp.mysql.object:Query("DELETE FROM `mpdonate_inventory` WHERE sid="..sid.." AND id="..sql.SQLStr(id).." AND `server` = "..sql.SQLStr(mp.c.db.serverid))
    mp.DebugMsg("Take from player inventory: "..sid)
end

function mp.mysql.SaveCupon(cupon,type,data,maxuses)
    mp.mysql.object:Query("INSERT INTO `mpdonate_cupons`(`cupon`, `type`, `data`, `maxuses`) VALUES ("..sql.SQLStr(cupon)..","..sql.SQLStr(type)..","..sql.SQLStr(data)..","..sql.SQLStr(maxuses)..")")
    mp.DebugMsg("Add new cupon: "..cupon)
end

function mp.mysql.GetCupons(cback)
    mp.mysql.object:Query("SELECT * FROM `mpdonate_cupons`",function(data) cback(data or false) end)
end

function mp.mysql.GetCuponsActivators(cupon,cback)
    mp.mysql.object:Query("SELECT * FROM `mpdonate_cupons_used` WHERE cupon = "..sql.SQLStr(cupon),function(data) cback(data or false) end)
end


function mp.mysql.ActivatorCupon(sid,cupon)
    mp.mysql.object:Query("INSERT INTO `mpdonate_cupons_used`(`sid`, `cupon`) VALUES ("..sql.SQLStr(sid)..","..sql.SQLStr(cupon)..")")
    mp.DebugMsg("Add new cupon: "..cupon)
end
--The script is written by FOER © 2019