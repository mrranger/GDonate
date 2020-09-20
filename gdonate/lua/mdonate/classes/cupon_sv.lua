local CUPON = FindMetaTable("MPCupons") or {}
CUPON.__index = CUPON

gpay.CUPONS = {}

local default = {
    cupon     = "null",
    type      = "currency",
    data      = 0, -- Data on use :D
    maxuses   = 0,
    used      = {}, -- steamids :D
    callback  = function(args) gpay.Msg("Used a null CUPON!") end, -- For events :D
}

function CUPON:SetType(var)
    self.type = var or default.type
    return self
end
function CUPON:SetData(var)
    self.data = var or default.data
    return self
end
function CUPON:SetCallBack(var)
    self.callback = var or default.callback
    return self
end
function CUPON:SetMaxUses(var)
    self.maxuses = tonumber(var) or default.maxuses
    return self
end


--GETTING INFORMATION
function CUPON:GetMaxUses()
    return tonumber(self.maxuses)
end
function CUPON:GetType()
    return self.type
end
function CUPON:GetData()
    return self.data
end
function CUPON:CallBack(args)
    self.callback(args)
end
function CUPON:IsRelevant()
    return #self.used < self:GetMaxUses() or self:GetMaxUses() <= 0
end
function CUPON:GetSIDUsed(args)
    return self.used[args] or false
end
function CUPON:Use(ply)
    local sid = ply:SteamID64()
    if self:GetSIDUsed(sid) then return end

    if self.type == "currency" then
        ply:AddCurrency(tonumber(self:GetData()) or 0)    
    elseif self.type == "item" then
        ply:AddItem(self:GetData() or "null")
    end
    gpay.mysql.ActivatorCupon(sid,self.cupon)
    self.used[sid] = true
end

debug.getregistry()["MPCupons"] = CUPON -- Крч я не ебу как еще можно замутить, у меня тупо мозгов не хватает)

function gpay.GetCupon(class)
    local fonunded = gpay.CUPONS[class]
    if fonunded then
        return fonunded
    end
    return false
end

function gpay.MakeCupon(cup_var)
    if !cup_var then error("class not found") return end
    local cupon = table.Copy(default)
    setmetatable(cupon, CUPON)
    gpay.CUPONS[cup_var] = cupon
    gpay.CUPONS[cup_var].cupon = cup_var
    return cupon
end
gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_cupons`( `cupon` varchar(255) NOT NULL, `type` varchar(255) NOT NULL, `data` varchar(255) NOT NULL, `maxuses` int(255) NOT NULL, PRIMARY KEY (`cupon`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Основная таблица
gpay.mysql.object:Query("CREATE TABLE IF NOT EXISTS `mpdonate_cupons_used` ( `id` int(11) NOT NULL AUTO_INCREMENT, `cupon` varchar(255) NOT NULL, `sid` varchar(255) NOT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;") -- Инвентарь
timer.Simple(1,function()
    gpay.mysql.GetCupons(function(data)
        if not data then return end
        for k,v in pairs(data) do
            local cum = gpay.MakeCupon(v["cupon"])
            :SetType(v["type"])
            :SetData(v["data"])
            :SetMaxUses(v["maxuses"])
            gpay.DebugMsg("Returned cupon: "..v["cupon"])
            gpay.mysql.GetCuponsActivators(v["cupon"],function(data)
                if not data then return end
                for k,v in pairs(data) do
                    cum.used[v["sid"]] = true
                end
                gpay.DebugMsg("Returned actvators cupon: "..v["cupon"])
            end)
        end
    end)
end)