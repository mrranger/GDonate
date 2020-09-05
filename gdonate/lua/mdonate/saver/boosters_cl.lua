function ad_sexfeel()

    hook.Add("HUDPaint", "ad_sexfeeeel", function()

        for k,v in pairs(player.GetAll()) do

            local sc = (v:EyePos() + Vector(0, 0, 5)):ToScreen()

            if !sc.visible or v:GetPos():DistToSqr(LocalPlayer():GetPos()) > 400000 then continue end

            draw.SimpleText("▼", "DermaDefault", sc.x, sc.y, Color(255, 0, 0), TEXT_ALIGN_CENTER)

        end

    end)

end



function ad_nosexfeel()

    hook.Remove("HUDPaint", "ad_sexfeeeel")

end