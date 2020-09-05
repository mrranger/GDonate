function mp.RefreshBalance(player,callback)
    mp.php.Requst("response",{sid=player:SteamID64(),balance=tostring(player:GetCurrency())},function(data)
        if tonumber(data) and player:IsValid() and player:GetCurrency() < tonumber(data) then

            player:SetCurrency(data)

        end -- Значит ошибочка в запросе или баланс не менялса

        if callback then
            callback()
        end
    end)
end
-- Значет, зачем это нахуй надо?
-- Ответ: Лучше и гораздо быстрее спрашивить PHP, об изменениях, а если спрашивать в MySQL сервак ебанётся, не ебите мне мозги это в 1000 раз лучше
local activatedevents = 0
function mp.BuyItem(player,class)
    if not player:IsValid() then return end
    if not class then mp.Notify(player,false,Color(255,255,255),mp.lang.itemnotfound) return end
    local item = mp.GetItem(class)
    if player:HasItem(class) and item:GetType() ~= "event" then mp.Notify(player,true,Color(255,255,255),mp.lang.alreadythis)  return end -- чекним первым делом
    if item:GetType() == "usergroup" and player:GetDonateUsergroup() == item:GetUsergroup() then mp.Notify(player,false,Color(255,255,255),mp.lang.alreadythis)  return end -- чекним первым делом
    if not item then mp.Notify(player,true,Color(255,255,255),mp.lang.itemnotfound) return end -- Лучше чекнуть наличие итема, а то всё бывает)
    if player:GetDonateUsergroup() == item:GetUsergroup() then mp.Notify(player,true,Color(255,255,255),mp.lang.alreadythis) return end -- Чтоб черт не купил то что уже есть и не ебал мозги уже серебру о возврате
    mp.RefreshBalance(player,function()
        if not player:IsValid() then return end
        if not player:CanAffordCurrency(item:GetPrice()) then mp.Notify(player,true,Color(255,255,255),mp.lang.notenoughmoney) return end
        if item:GetType() == "unban" and not player:IsBanned() then mp.Notify(player,true,Color(255,255,255),"Вы не забанены!") return end
        if item:GetType() == "groupup" and player:GetDonateExpires() > 0 then mp.Notify(player,true,Color(255,255,255),"Имея временную привилегию нельзя купить повышение") return end
        -- print(player:GetUserGroup())
        if item:GetType() == "groupup" and player:GetUserGroup():lower() == "user" then mp.Notify(player,true,Color(255,255,255),"Повышение возможно начиная с vip!") return end
        if item:GetType() == "groupup" and not povish[player:GetUserGroup():lower()] then mp.Notify(player,true,Color(255,255,255),"Повышение более не возможно!") return end
        
        if mp.c.events[item:GetClass()] then

            if activatedevents > CurTime() then
                mp.Notify(player,true,Color(255,255,255),"Запуск ивента доступен раз в 4 часа!")
                return
            end

            if #player.GetAll() < 45 then
                mp.Notify(player,true,Color(255,255,255),"На сервере должно быть больше 45 человек!")
                return
            end

            activatedevents = CurTime() + 14400

        end
        
        player:TakeCurrency(item:GetPrice())
        if item:GetType() ~= "event" and item:GetType() ~= "usergroup" and item:GetType() ~= "groupup" then
            player:AddItem(class)
        end
        item:Activate(player) -- Ну а хуле, сразу активе так сказать)
        -- mp.Notify(player,false,Color(255,255,255),mp.lang.thanksforbuy)
        mp.mysql.Log(player:GetDonateToken(),"Покупка "..item:GetName().."("..class.."), баланас до "..string.Comma(player:GetCurrency()).."₽ после "..string.Comma(player:GetCurrency()+item:GetPrice()).."₽",player:SteamID64())
        mp.Notify(player,false,color_white,"Вы приобрели "..mp.GetItem(class).name.." за "..item:GetPrice().."₽")
    end)
end

--The script is written by FOER © 2019