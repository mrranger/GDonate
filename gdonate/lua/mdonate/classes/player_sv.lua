function PLAYER:AdvancedSetUserGroup(usergroup)
    if ba then
        --FindMetaTable("MPItem"):SetGroupBAdmin(usergroup,self)
        ba.data.SetRank(self, usergroup, usergroup, 0)
    else
        self:SetUserGroup(usergroup)
    end
end

function PLAYER:SetDonateHat(class)
    return self:SetNWString("hat",class)
end

function PLAYER:SetCurrency(amount)
    self:SetNetVar("DonateBalance", tonumber(amount) or 0)
    gpay.mysql.WriteVar(self:SteamID64(),"mpdonate_players","balance",tonumber(amount) or 0)
end

function PLAYER:TakeCurrency(amount)
    if self:CanAffordCurrency(amount) then
        self:SetCurrency(self:GetCurrency() - (tonumber(amount) or 0))
    end
end

function PLAYER:AddCurrency(amount)
    self:SetCurrency(self:GetCurrency() + (tonumber(amount) or 0))
end

function PLAYER:AddItem(class)
    local slotid = self:HasItem(class)
    if not slotid then
        local item = gpay.GetItem(class)
        local exp = item:GetExpires() <= 0 and 0 or (os.time() + item:GetExpires())
        self.mp_donate[#self.mp_donate+1] = {
            ["class"] = class,
            ["expires"] = exp
        }
        gpay.mysql.AddPlayerInventory(self:SteamID64(),class,exp)
    else
        self.mp_donate[slotid]["expires"] = os.time() + gpay.GetItem(class):GetExpires() -- Кароче в чем прикол, нахуй нам еще создавать предметы, если можно просто перезаписать Expires?
    end
    gpay.PlayerInventorySync(self)
end

function PLAYER:TakeItem(class)
    local slotid = self:HasItem(class)
    if slotid then
        self.mp_donate[slotid] = nil
        gpay.mysql.TakePlayerInventory(self:SteamID64(),class)
    end
    gpay.PlayerInventorySync(self)
end

function PLAYER:CheckExpires()

    local d_usergroup = self:GetDonateUsergroup()
    local usergroup = self:GetUserGroup()
    local d_expires = self:GetDonateExpires()
    local haveitems = {}
    local edited = false
    if self.mp_donate then
        for k,v in pairs(self.mp_donate) do -- парсим все итемы которые знаем
            if (v['expires'] < os.time() and v['expires'] ~= 0) then -- если значет дата всё, тю-тю
                edited = true
                self.mp_donate[k] = nil -- Делитаем нахуй
                gpay.mysql.TakePlayerInventory(self:SteamID64(),v['class'])
            end
            if haveitems[v['class']] then
                gpay.mysql.TakePlayerInventoryByID(self:SteamID64(),v['id'])
                edited = true
            end
            haveitems[v['class']] = true
        end
    end
    if edited then gpay.PlayerInventorySync(self) end

    if d_expires <= 0 then return end
    -- print(d_expires, os.time(), d_expires > os.time())
    if d_expires > os.time() then
        -- if d_usergroup ~= usergroup then
        --     self:AdvancedSetUserGroup(d_usergroup)
        --     gpay.Msg(self:SteamID64().." usergroup recovery to "..d_usergroup)
        -- end
    else
        -- if d_usergroup == usergroup then
            self:AdvancedSetUserGroup("user")
            gpay.mysql.WriteVarServers(self:SteamID64(),"mpdonate_groups","expires",0)
            gpay.Msg(self:SteamID64().." usergroup expires end setting to DEFAULT(user)")
            gpay.mysql.Log(self:GetDonateToken(),"Вы были с привилегии "..d_usergroup.." так как срок закончен",self:SteamID64())
        -- end
    end
end

-- Entity(1):CheckExpires()

local function tokengeneration(sid)
	local length = 16
    local strexp = string.Explode("", sid)
    if length < 1 then return end

    local result = ""

	for i = 1, length do
		math.randomseed(SysTime())
        result = result .. strexp[i]+(math.Round(SysTime()/2))..string.char(math.random(97, 122))

    end

    return result
end
function PLAYER:InitDonate()
    local sid = self:SteamID64()
    self.mp_donate = {}
    gpay.mysql.GetPlayer(sid,function(data)
        if data then
            gpay.mysql.GetPlayerInventory(sid,function(inv)
                if inv then
                    self.mp_donate = inv
                else
                    gpay.DebugMsg(sid.." inventory not found, using default")
                end
                timer.Simple(1,function() gpay.PlayerInventorySync(self) end)
            end)
            gpay.DebugMsg(sid.." SETTING VAR DonateBalance From Data Base VALUE: "..(data["balance"] or "(БД ВЕРНУЛА NULL ЗНАЧЕНИЕ)") )
            self:SetNetVar("DonateBalance", tonumber(data["balance"] or 0) or 0)
            gpay.mysql.GetPlayerGroup(sid,function(data2)
                if data2 then
                    gpay.DebugMsg(sid.." SETTING VAR DonateUserGroupExpires From Data Base VALUE: "..(data2["expires"] or "(БД ВЕРНУЛА NULL ЗНАЧЕНИЕ)"))
                    self:SetNetVar("DonateUserGroupExpires", tonumber(data2["expires"] or 0) or 0)
                    self.donategroup = data2["usergroup"] or "user"
                else
                    gpay.mysql.MakePlayer(sid,0,token,true)
                end
            end)
            self.donatetoken = data["pltoken"]
        else
            local token = tokengeneration(sid)
            gpay.mysql.MakePlayer(sid,0,token)
            gpay.DebugMsg(sid.." SETTING VAR DonateBalance VALUE: 0")
            self:SetNetVar("DonateBalance", 0)
            gpay.DebugMsg(sid.." SETTING VAR DonateUserGroupExpires VALUE: 0")
            self:SetNetVar("DonateUserGroupExpires", 0)

            self.donategroup = "user"
            self.donatetoken = token
            gpay.DebugMsg(sid.." user not found, using default")
        end
        timer.Simple(1,function() self:CheckExpires() end) -- Как я понял эта залупа не успевает нихуя и вот, знаю гавно переделывать небуду
    end)
end
