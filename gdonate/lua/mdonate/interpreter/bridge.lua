if CLIENT then
    concommand.Add("opensurl",function(_, _, _, str)

        gui.OpenURL("http://example.com/linkzer/?"..str)
    
    end)

    netstream.Hook("DonateMessage",function(table,bad)
        local text = table[2]
        if not table[2] then
            text = table[1]
        end
        notification.AddLegacy( text, NOTIFY_GENERIC, 4 )
        surface.PlaySound(bad and "npc/roller/mine/rmine_blip3.wav" or "garrysmod/save_load4.wav")
    end)

    netstream.Hook("DonateSync",function(table,token)
        LocalPlayer().mp_donate = table
        LocalPlayer().donatetoken = token
    end)

    netstream.Hook("DonateSound",function(sound)
        surface.PlaySound(sound)
    end)


    local awaiting = 0
    function gpay.CheckAwait() -- мини антиспам
        if awaiting < CurTime() then
            awaiting = CurTime() + gpay.c.await
            return true
        end
        return false
    end

    function gpay.Call(type,args)
        if gpay.CheckAwait() and (type == "buy" or type == "refresha") then 
            notification.AddLegacy( gpay.lang.await, NOTIFY_GENERIC, 4 )
            surface.PlaySound(bad and "npc/roller/mine/rmine_blip3.wav" or "garrysmod/save_load4.wav")
        return end
        netstream.Start("DonateBridge",type,args)
    end
else
    
    function gpay.NotifySound(ply,sound)
        netstream.Start(ply,"DonateSound",sound)
    end

    function gpay.Notify(ply,bad,...)
        netstream.Start(ply,"DonateMessage",{...},bad)
    end
    function gpay.NotifyAll(bad,...)
        netstream.Start(nil,"DonateMessage",{...},bad)
    end
    function gpay.OpenURL(ply,url)
        netstream.Start(ply,"DonateOpenURL",url)
    end
    function gpay.PlayerInventorySync(ply)
        netstream.Start(ply,"DonateSync",ply:GetDonateInventory(),ply.donatetoken)
    end
end
-- Не вижу смысла это всё кодировать или что-то в этом роде
--The script is written by FOER © 2019