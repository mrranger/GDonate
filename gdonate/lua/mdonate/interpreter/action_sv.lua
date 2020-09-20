local awaiting = {}
function gpay.CheckAwait(pl) -- мини антиспам
    local sid = pl:SteamID64()
    if not awaiting[sid] then
        awaiting[sid] = 0
    end
    if awaiting[sid] < CurTime() then
        awaiting[sid] = CurTime() + gpay.c.await
        return true
    end
    return false
end

local actions = {
    ["paylink"] = function(ply,_) gpay.SendPaymentURL(ply) end,
    ["buy"] = function(ply,class) gpay.BuyItem(ply,class) end,
    ["refresh"] = function(ply,_) gpay.RefreshBalance(ply) end,
    ["refresha"] = function(ply,_) gpay.Notify(ply,false,Color(255,255,255),"Обновление баланса") gpay.RefreshBalance(ply) end,
    ["checkcupon"] = function(ply,cupon) gpay.CuponCheck(ply,cupon) end,
    ["sync"] = function(ply,dat) gpay.saver.GettingSettings(ply,dat) end,
}

netstream.Hook("DonateBridge",function(ply,type,args)
    if not gpay.CheckAwait(ply) and (type == "buy" or type == "refresha" ) then gpay.Notify(ply,true,Color(255,255,255),gpay.lang.await) return end
    actions[type](ply,args)
end)

function gpay.CuponCheck(player,cupon)
    if not player:IsValid() then return end
    if not cupon then gpay.Notify(player,false,Color(255,255,255),gpay.lang.cuponnotfound) return end
    local cupon_c = gpay.GetCupon(cupon)
    if not cupon_c then gpay.Notify(player,false,Color(255,255,255),gpay.lang.cuponnotfound) return end -- Существует ли купон
    if cupon_c:GetSIDUsed(player:SteamID64()) then gpay.Notify(player,false,Color(255,255,255),gpay.lang.cuponalready) return end -- Юзал ли пользователь купон или еще нет
    if not cupon_c:IsRelevant() then gpay.Notify(player,Color(255,255,255),gpay.lang.cuponactivation) return end -- Проверка на актуальность купона
    cupon_c:Use(player)
    gpay.Notify(player,false,Color(255,255,255),gpay.lang.cuponactivation)
    gpay.mysql.Log(player:GetDonateToken(),"Активация купона "..cupon,player:SteamID64())
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
        gpay.mysql.WriteVarServers(ply:SteamID64(),"mpdonate_groups","usergroup",sql.SQLStr(self:GetUsergroup()))
        gpay.mysql.WriteVarServers(ply:SteamID64(),"mpdonate_groups","expires",self:GetExpires() > 0 and (os.time() + tonumber(self:GetExpires())) or 0)
    elseif type == "hat" then
        ply:SetDonateHat(self:GetClass())
    elseif type == "groupup" then
        groupup(ply)
    elseif type == "unban" then
        RunConsoleCommand("ba", "unban", ply:SteamID(), "Покупка разбана.")
    end
    gpay.PlayerInventorySync(ply)
end

--The script is written by FOER © 2019