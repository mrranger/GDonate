local awaiting = {}
function mp.CheckAwait(pl) -- мини антиспам
    local sid = pl:SteamID64()
    if not awaiting[sid] then
        awaiting[sid] = 0
    end
    if awaiting[sid] < CurTime() then
        awaiting[sid] = CurTime() + mp.c.await
        return true
    end
    return false
end

local actions = {
    ["paylink"] = function(ply,_) mp.SendPaymentURL(ply) end,
    ["buy"] = function(ply,class) mp.BuyItem(ply,class) end,
    ["refresh"] = function(ply,_) mp.RefreshBalance(ply) end,
    ["refresha"] = function(ply,_) mp.Notify(ply,false,Color(255,255,255),"Обновление баланса") mp.RefreshBalance(ply) end,
    ["checkcupon"] = function(ply,cupon) mp.CuponCheck(ply,cupon) end,
    ["sync"] = function(ply,dat) mp.saver.GettingSettings(ply,dat) end,
}

netstream.Hook("DonateBridge",function(ply,type,args)
    if not mp.CheckAwait(ply) and (type == "buy" or type == "refresha" ) then mp.Notify(ply,true,Color(255,255,255),mp.lang.await) return end
    actions[type](ply,args)
end)

function mp.CuponCheck(player,cupon)
    if not player:IsValid() then return end
    if not cupon then mp.Notify(player,false,Color(255,255,255),mp.lang.cuponnotfound) return end
    local cupon_c = mp.GetCupon(cupon)
    if not cupon_c then mp.Notify(player,false,Color(255,255,255),mp.lang.cuponnotfound) return end -- Существует ли купон
    if cupon_c:GetSIDUsed(player:SteamID64()) then mp.Notify(player,false,Color(255,255,255),mp.lang.cuponalready) return end -- Юзал ли пользователь купон или еще нет
    if not cupon_c:IsRelevant() then mp.Notify(player,Color(255,255,255),mp.lang.cuponactivation) return end -- Проверка на актуальность купона
    cupon_c:Use(player)
    mp.Notify(player,false,Color(255,255,255),mp.lang.cuponactivation)
    mp.mysql.Log(player:GetDonateToken(),"Активация купона "..cupon,player:SteamID64())
end

local ITEM = FindMetaTable("MPItem") -- Ну а шо, модно же)

function ITEM:Activate(ply)
    local type = string.lower(self:GetType())
    if type == "event" then
        self:CallBack(ply)
    elseif type == "usergroup" then
        ply:AdvancedSetUserGroup(self:GetUsergroup())
        ply.donategroup = self:GetUsergroup()
        ply:SetNetVar("DonateUserGroupExpires",self:GetExpires() > 0 and (os.time() + tonumber(self:GetExpires())) or 0)
        mp.mysql.WriteVarServers(ply:SteamID64(),"mpdonate_groups","usergroup",sql.SQLStr(self:GetUsergroup()))
        mp.mysql.WriteVarServers(ply:SteamID64(),"mpdonate_groups","expires",self:GetExpires() > 0 and (os.time() + tonumber(self:GetExpires())) or 0)
    elseif type == "hat" then
        ply:SetDonateHat(self:GetClass())
    elseif type == "groupup" then
        groupup(ply)
    elseif type == "unban" then
        RunConsoleCommand("ba", "unban", ply:SteamID(), "Покупка разбана.")
    end
    mp.PlayerInventorySync(ply)
end

--The script is written by FOER © 2019