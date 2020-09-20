local ITEM = FindMetaTable("MPItem") or {}
ITEM.__index = ITEM

gpay.ITEMS = {}

local default = {
    class     = "null",
    name      = "EXAMPLE",
    type      = "event", -- type`s to detect
    category  = "Остальное", -- type`s to detect
    usergroup = "tochegonetine", -- for usergroups
    desc      = "EXAMPLE", -- for usergroups
    icon      = "https://imgholder.ru/200x200/000000/adb9ca&text=IMAGE+HOLDER&fz=23",
    booster   =  "nil",
    price     =  0,
    discount  =  0,
    expires   =  0,
    hatdata   =  {pos=nil,ang=nil,sz=0,model=""}, -- For hats :D
    callback  = function(args) gpay.Msg("Used a null item!") end, -- For events :D
}

--SETUP DONATE

function ITEM:SetName(text)
    self.name = text or default.name
    return self
end

function ITEM:SetType(text)
    self.type = text or default.type
    return self
end

function ITEM:SetUsergroup(text)
    self.usergroup = text or default.usergroup
    return self
end

function ITEM:SetIcon(text)
    self.icon = text or default.icon
    return self
end

function ITEM:SetBooster(text)
    self.booster = text or default.booster
    return self
end

function ITEM:SetDescription(text)
    self.desc = text or default.desc
    return self
end

function ITEM:SetCategory(text)
    self.category = text or default.category
    return self
end

function ITEM:SetPrice(text)
    self.price = tonumber(text) or default.price
    return self
end

function ITEM:SetDiscount(text)
    self.discount = tonumber(text) or default.discount
    return self
end

function ITEM:SetExpires(text)
    self.expires = tonumber(text) or default.expires
    return self
end

function ITEM:SetHatData(vec,ang,model,size)
    vec = vec or Vector(0,0,0)
    -- vec.z = vec.z + 10
    self.hatdata = {
        pos = vec,
        ang = ang  or Angle(0,0,0),
        model = model or "",
        sz  = size or 1
    }
    return self
end

function ITEM:SetCallBack(func)
    self.callback = func or default.callback
    return self
end

--GETTING INFORMATION

function ITEM:GetName()
    return self.name
end

function ITEM:GetBooster()
    return self.booster
end


function ITEM:GetDescription()
    return self.desc
end


function ITEM:GetType()
    return self.type
end

function ITEM:GetCategory()
    return self.category
end

function ITEM:GetIcon()
    return self.icon
end

function ITEM:GetClass()
    return self.class
end

function ITEM:GetUsergroup()
    return self.usergroup
end

function ITEM:GetPrice()
    if self.discount > 0 then
        return self.price - ( (self.price/100)  * self.discount ) -- Зарание калькулировать цену под скидочку
    end
    return self.price or default.price
end

function ITEM:GetPriceReal()
    return self.price or default.price
end

function ITEM:GetDiscount()
    return self.discount
end

function ITEM:GetExpires()
    return self.expires
end

function ITEM:GetHatData()
    return self.hatdata
end

function ITEM:CallBack(args)
    self.callback(args)
end

debug.getregistry()["MPItem"] = ITEM -- Крч я не ебу как еще можно замутить, у меня тупо мозгов не хватает)
function gpay.GetItem(class)
    local fonunded = gpay.ITEMS[class]
    if fonunded then
        return fonunded
    end
    return false
end

function gpay.Create(class)
    if !class then error("class not found") return end
    local item = table.Copy(default)
    setmetatable(item, ITEM)
    gpay.ITEMS[class] = item
    gpay.ITEMS[class].class = class
    return item
end
