function gpay.GeneratePaymentURL(sid)
    return "https://www.oplata.info/asp2/pay_wm.asp?id_d="..gpay.c.oplata_ru_id.."&lang=ru-RU&sid="..sid
end

local createdLinks = {}
function gpay.SendPaymentURL(player)
    http.Fetch("http://example.com/linkzer/cc_add/?https://www.oplata.info/asp2/pay_wm.asp?id_d="..gpay.c.oplata_ru_id.."&lang=ru-RU&sid="..player:SteamID64().."&unban=false", function(b)
        player:ConCommand("opensurl "..b)
    end)
end

--The script is written by FOER © 2019