function PLAYER:GetDonateExpires()
    return self:GetNetVar("DonateUserGroupExpires") or 0
end

function PLAYER:GetDonateUsergroup()
    return self.donategroup or "user"
end

function PLAYER:GetDonateHat()
    return self:GetNWString("hat")
end

function PLAYER:GetDonateToken()
    return self.donatetoken or "nil"
end

function PLAYER:GetDonateInventory()
    return self.mp_donate or {}
end

function PLAYER:GetCurrency()
    return self:GetNetVar("DonateBalance") or 0
end

function PLAYER:HasItem(class) -- Идите нахуй, у меня тип таблицы другой. Я не юзаю ваши гейские записи JSON в ячейку!
    for k,v in pairs(self:GetDonateInventory()) do
        if v["class"] == class and gpay.GetItem(class) and gpay.GetItem(class):GetClass() ~= "event" then
            return tonumber(k)
        end
    end
    return false
end

function PLAYER:FindEmptySlot(class) -- От души мне похуй что вы там думаете о pairs, тут не та ситуация которая может нагружать
    for i=1,#self:GetDonateInventory() do
        if self.mp_donate[i] then
            return i
        end
    end
    return false
end

function PLAYER:CanAffordCurrency(amount)
    local cur = self:GetCurrency()
    if cur >= amount then
        return true
    end
    return false
end
