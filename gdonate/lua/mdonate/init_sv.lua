mp.mysql.MakeTable() -- Мейкаем таблички

concommand.Add("mp_give",function(pl,_,args)

    if not pl:IsValid() or (mp.c.rights[pl:SteamID()] and args[1]) then
        local target = player.GetBySteamID(args[1])
        if target and target:IsValid() and args[3] then
            if string.lower(args[2]) == "currency" then
                target:AddCurrency(tonumber(args[3]))
                mp.Notify(target,true,Color(255,255,255),string.format(mp.lang.admingivedbalance,(pl:IsValid() and pl:GetName() or "CONSOLE"),(pl:IsValid() and pl:SteamID() or "CONSOLE"),args[3].." рублей"))
                mp.mysql.Log(target:GetDonateToken(),string.format(mp.lang.admingivedbalance,(pl:IsValid() and pl:GetName() or "CONSOLE"),(pl:IsValid() and pl:SteamID() or "CONSOLE"),args[3].." рублей"),target:SteamID64())
            elseif string.lower(args[2]) == "item" then
                local item = mp.GetItem(args[3])
                if item then
                    target:AddItem(args[3])
                    mp.Notify(target,false,Color(255,255,255),string.format(mp.lang.admingivedbalance,(pl:IsValid() and pl:GetName() or "CONSOLE"),(pl:IsValid() and pl:SteamID() or "CONSOLE"),args[3]))
                    mp.mysql.Log(target:GetDonateToken(),string.format(mp.lang.admingivedbalance,(pl:IsValid() and pl:GetName() or "CONSOLE"),(pl:IsValid() and pl:SteamID() or "CONSOLE"),args[3]),target:SteamID64())
                end
            end
        end
    else
        mp.Notify(pl,Color(255,255,255),mp.lang.norights)
    end
end)

concommand.Add("mp_take",function(pl,_,args)
    if not pl:IsValid() or (mp.c.rights[pl:SteamID()] and args[1]) then
        local target = player.GetBySteamID(args[1])
        if target and target:IsValid() and args[3] then
            if string.lower(args[2]) == "currency" then
                target:TakeCurrency(tonumber(args[3]))
                mp.Notify(target,Color(255,255,255),true,string.format(mp.lang.admintakebalance,(pl:IsValid() and pl:GetName() or "CONSOLE"),(pl:IsValid() and pl:SteamID() or "CONSOLE"),args[3].." рублей"))
                mp.mysql.Log(target:GetDonateToken(),string.format(mp.lang.admintakebalance,(pl:IsValid() and pl:GetName() or "CONSOLE"),(pl:IsValid() and pl:SteamID() or "CONSOLE"),args[3].." рублей"),target:SteamID64())
            elseif string.lower(args[2]) == "item" then
                local item = mp.GetItem(args[3])
                if item then
                    target:TakeItem(args[3])
                    mp.Notify(target,Color(255,255,255),false,string.format(mp.lang.admintakebalance,(pl:IsValid() and pl:GetName() or "CONSOLE"),(pl:IsValid() and pl:SteamID() or "CONSOLE"),args[3]))
                    mp.mysql.Log(target:GetDonateToken(),string.format(mp.lang.admintakebalance,(pl:IsValid() and pl:GetName() or "CONSOLE"),(pl:IsValid() and pl:SteamID() or "CONSOLE"),args[3]),target:SteamID64())
                end
            end
        end
    else
        mp.Notify(pl,Color(255,255,255),mp.lang.norights)
    end
end)

concommand.Add("mp_make",function(pl,_,args)
    if mp.c.rights[pl:SteamID()] then
        if !args[1] and !args[2] and !args[3] and !args[4] then mp.Notify(pl,Color(255,255,255),"mp_make <cupon> <type> <data> <maxuses>") return end
        if mp.GetCupon(args[1]) then mp.Notify(pl,Color(255,255,255),"Такой купон уже есть!") return end
        if args[2] ~= "currency" and args[2] ~= "item" then mp.Notify(pl,Color(255,255,255),"Типы только: item,currency") return end
        mp.MakeCupon(args[1])
        :SetType(args[2])
        :SetData(args[3])
        :SetMaxUses(args[4])

        mp.mysql.SaveCupon(args[1],args[2],args[3],args[4])
        mp.Notify(pl,Color(255,255,255),"Создан новый купон: "..args[1])
    else
        mp.Notify(pl,Color(255,255,255),mp.lang.norights)
    end
end)

-- Hook creation

hook.Add("PlayerInitialSpawn","mp.PlayerConnected",function(ply)
    ply:InitDonate()
end)

-- local z=  FindMetaTable("Player")
-- function z:SteamID64()
--     return "76561198231735676"
-- end
