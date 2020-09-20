gpay.mysql = gpay.mysql or {}
require("mysql")
gpay.mysql.object = mysql.Connect(gpay.c.db.host, gpay.c.db.login, gpay.c.db.password, gpay.c.db.database, 3306)

function gpay.mysql.MakeTable() -- Создаем табличку
    if gpay.mysql.object then
        gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_cupons`( `cupon` varchar(255) NOT NULL, `type` varchar(255) NOT NULL, `data` varchar(255) NOT NULL, `maxuses` int(255) NOT NULL, PRIMARY KEY (`cupon`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Основная таблица
        gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_cupons_used` ( `id` int(11) NOT NULL AUTO_INCREMENT, `cupon` varchar(255) NOT NULL, `sid` varchar(255) NOT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_game_log` ( `id` bigint(20) NOT NULL AUTO_INCREMENT, `sid` bigint(20), `description` varchar(255) NOT NULL, `pltoken` varchar(255) NOT NULL, `date` datetime NOT NULL DEFAULT current_timestamp(), PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_inventory` ( `id` bigint(20) NOT NULL AUTO_INCREMENT, `sid` bigint(20) DEFAULT NULL, `server` longtext NOT NULL, `class` longtext DEFAULT NULL, `expires` int(11) DEFAULT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_payment` ( `id` bigint(20) NOT NULL AUTO_INCREMENT, `unique_code` varchar(255) NOT NULL, `inv` bigint(20) NOT NULL, `id_goods` int(11) NOT NULL, `amount` decimal(10,0) NOT NULL, `date_pay` int(11) NOT NULL, `email` varchar(60) NOT NULL, `cnt_goods` float NOT NULL, `query_string` varchar(255) NOT NULL, `is_given` tinyint(1) DEFAULT NULL, `give_time` bigint(20) NOT NULL DEFAULT current_timestamp(), PRIMARY KEY (`id`), UNIQUE KEY `unique_code` (`unique_code`), UNIQUE KEY `inv` (`inv`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_players` ( `sid` bigint(20) NOT NULL, `balance` int(11) DEFAULT NULL, `pltoken` varchar(255) NOT NULL, PRIMARY KEY (`sid`), UNIQUE KEY `pltoken` (`pltoken`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
        gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `short_urls` ( `id` int(11) NOT NULL AUTO_INCREMENT, `long_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL, `short_code` varchar(25) COLLATE utf8_unicode_ci NOT NULL, `hits` int(11) NOT NULL DEFAULT 0, `created` datetime NOT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;") -- Инвентарь
        gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_groups` (`id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,`server` varchar(255) NOT NULL,`sid` bigint(255) NOT NULL,`expires` bigint(255) NOT NULL,`usergroup` varchar(255) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
      gpay.DebugMsg("Created tables if not exists")
    end
end


-------------------------
-- @input  sid(String), balance(Int), inventory(String), usergroup(String)
------------------------
function gpay.mysql.MakePlayer(sid,balance,token,grouponly) -- Создаем пресонажа
    if not grouponly then
        gpay.mysql.object:Query("INSERT INTO `mpdonate_players`(`sid`, `balance`,`pltoken`) VALUES ('"..sid.."',"..balance..","..sql.SQLStr(token)..")")
    end
    gpay.mysql.object:Query("INSERT INTO `mpdonate_groups`(`sid`,`server`, `expires`,`usergroup`) VALUES ('"..sid.."',"..sql.SQLStr(gpay.c.db.serverid)..",0,'user')")
    gpay.DebugMsg("Created player: "..sid)
end

-------------------------
-- @input  sid(String), var(String), value(All)
------------------------
function gpay.mysql.WriteVar(sid,table,var,value) -- сохранение отдельных варов в бд, шоб не ебать полной перезаписью
    gpay.mysql.object:Query("UPDATE `"..table.."` SET `"..var.."`="..value.." WHERE `sid` = "..sql.SQLStr(sid))
    gpay.DebugMsg("Saved player var: "..sid.." - Var: "..var..", Value: "..value)
end

function gpay.mysql.WriteVarServers(sid,table,var,value) -- сохранение отдельных варов в бд, шоб не ебать полной перезаписью
    gpay.mysql.object:Query("UPDATE `"..table.."` SET `"..var.."`="..value.." WHERE `sid` = "..sql.SQLStr(sid).." AND `server` = "..sql.SQLStr(gpay.c.db.serverid))
    gpay.DebugMsg("Saved player var: "..sid.." - Var: "..var..", Value: "..value)
end

-------------------------
-- @input  sid(String), var(String)
-- @callback (String)
------------------------
function gpay.mysql.GetPlayerVar(sid,var,cback) -- анолошично шоб не ебать бд и не ждать по 3 часа
    gpay.mysql.object:Query("SELECT `"..var.."` FROM `mpdonate_players` WHERE `sid` = "..sql.SQLStr(sid),function(data) cback(data[1][var]) end)
    gpay.DebugMsg("Getting player var: "..sid.." - Var: "..var..", Value: "..value)
end

-------------------------
-- @input  sid(String)
-- @callback (Table)
------------------------
function gpay.mysql.GetPlayer(sid,cback)
    gpay.mysql.object:Query("SELECT * FROM `mpdonate_players` WHERE `sid` = "..sql.SQLStr(sid),function(data) cback(data[1] or false) end)
    gpay.DebugMsg("Getting player: "..sid)
end

-------------------------
-- @input  sid(String)
-- @callback (Table)
------------------------
function gpay.mysql.GetPlayerGroup(sid,cback)
    gpay.mysql.object:Query("SELECT * FROM `mpdonate_groups` WHERE `sid` = "..sql.SQLStr(sid).." AND `server` = "..sql.SQLStr(gpay.c.db.serverid),function(data) cback(data[1] or false) end)
    gpay.DebugMsg("Getting player groups: "..sid)
end

-------------------------
-- @input  sid(String)
-- @callback (Table)
------------------------
function gpay.mysql.GetPlayerInventory(sid,cback)
    gpay.mysql.object:Query("SELECT * FROM `mpdonate_inventory` WHERE `sid` = "..sql.SQLStr(sid).." AND `server` = "..sql.SQLStr(gpay.c.db.serverid),function(data) cback(data or false) end)
    gpay.DebugMsg("Getting player inventory: "..sid)
end

-------------------------
-- @input  sid(String), balance(Int), inventory(String), usergroup(String)
------------------------
function gpay.mysql.SavePlayer(sid,balance,expires,usergroup)
    gpay.mysql.object:Query("UPDATE `mpdonate_players` SET `balance`="..balance.." WHERE `sid` = "..sql.SQLStr(sid))
    gpay.mysql.object:Query("UPDATE `mpdonate_groups` SET `expires`="..sql.SQLStr(expires)..",`usergroup`="..sql.SQLStr(usergroup).." WHERE `sid` = "..sql.SQLStr(sid).." AND `server` = "..sql.SQLStr(gpay.c.db.serverid))
    gpay.DebugMsg("Saved player: "..sid.." - Balance: "..balance..", Expires: "..expires..", UserGroup:"..usergroup)
end

function gpay.mysql.Log(pltoken,desc,sid)
    gpay.php.Requst("log",{pltoken=pltoken,desc=desc,sid=sid},function(data)
        print(data)
        gpay.DebugMsg("Added log data: "..desc)
    end)
end--desc

function gpay.mysql.AddPlayerInventory(sid,class,expires)
    gpay.mysql.object:Query("INSERT INTO `mpdonate_inventory`(`sid`,`server`, `class`, `expires`) VALUES ("..sql.SQLStr(sid)..","..sql.SQLStr(gpay.c.db.serverid)..","..sql.SQLStr(class)..","..sql.SQLStr(expires)..")")
    gpay.DebugMsg("Add to player inventory: "..sid)
end

function gpay.mysql.TakePlayerInventory(sid,class)
    gpay.mysql.object:Query("DELETE FROM `mpdonate_inventory` WHERE sid="..sid.." AND class="..sql.SQLStr(class).." AND `server` = "..sql.SQLStr(gpay.c.db.serverid))
    gpay.DebugMsg("Take from player inventory: "..sid)
end

function gpay.mysql.TakePlayerInventoryByID(sid,id)
    gpay.mysql.object:Query("DELETE FROM `mpdonate_inventory` WHERE sid="..sid.." AND id="..sql.SQLStr(id).." AND `server` = "..sql.SQLStr(gpay.c.db.serverid))
    gpay.DebugMsg("Take from player inventory: "..sid)
end

function gpay.mysql.SaveCupon(cupon,type,data,maxuses)
    gpay.mysql.object:Query("INSERT INTO `mpdonate_cupons`(`cupon`, `type`, `data`, `maxuses`) VALUES ("..sql.SQLStr(cupon)..","..sql.SQLStr(type)..","..sql.SQLStr(data)..","..sql.SQLStr(maxuses)..")")
    gpay.DebugMsg("Add new cupon: "..cupon)
end

function gpay.mysql.GetCupons(cback)
    gpay.mysql.object:Query("SELECT * FROM `mpdonate_cupons`",function(data) cback(data or false) end)
end

function gpay.mysql.GetCuponsActivators(cupon,cback)
    gpay.mysql.object:Query("SELECT * FROM `mpdonate_cupons_used` WHERE cupon = "..sql.SQLStr(cupon),function(data) cback(data or false) end)
end


function gpay.mysql.ActivatorCupon(sid,cupon)
    gpay.mysql.object:Query("INSERT INTO `mpdonate_cupons_used`(`sid`, `cupon`) VALUES ("..sql.SQLStr(sid)..","..sql.SQLStr(cupon)..")")
    gpay.DebugMsg("Add new cupon: "..cupon)
end
--The script is written by FOER © 2019