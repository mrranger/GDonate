local DONATE_DRAWHATS = function(ply)
    if ply:GetPos():DistToSqr(LocalPlayer():GetPos()) < 2000000 then
        local hat = ply:GetDonateHat()
        if not hat then return end
        hat = mp.GetItem(hat)
        if not hat then return end
        hat = hat:GetHatData()

        if hat.ang == nil or hat.pos == nil then return end
        local model = hat.model
        if IsValid(ply.hat) then
            if ply.hat.model ~= model then 
                ply.hat:SetModel(model)
                ply.hat:SetModelScale(hat.sz or 1, 0)
            end
            ply.hat.model = model
            ply.hat.ang = Angle()
            ply.hat.pos = Vector()
        else
            ply.hat = ClientsideModel(model)
            if IsValid(ply.hat) then
                ply.hat.model = model
                ply.hat:SetNoDraw(true)
            end
        end

        model = ply.hat

        local attach_id = ply:LookupAttachment("eyes")
        if attach_id == nil or attach_id == 0 then return end
        local attach = ply:GetAttachment(attach_id)
        if attach == nil then return end

        local ang, pos = attach.Ang, attach.Pos 

        ang:RotateAroundAxis(ang:Forward(), hat.ang.p)
        ang:RotateAroundAxis(ang:Right(), hat.ang.y)
        ang:RotateAroundAxis(ang:Up(), hat.ang.r)

        pos = pos    + ((ang:Forward() * hat.pos.x)
                    + (ang:Right() * hat.pos.y)
                    + (ang:Up() * hat.pos.z))

        --model:SetPos(pos)
        --model:SetAngles(ang)

        model:SetRenderOrigin(pos)
        model:SetRenderAngles(ang)
        --model:SetupBones()
        model:DrawModel()
    end
end

do
    local cv_hats = CreateConVar("fust_enable_hats", '1', FCVAR_ARCHIVE)
    cvars.AddChangeCallback('fust_enable_hats', function(name, oldvar, var)
        if oldvar ~= var then
            if var == '0' then
                for k, ply in next, player.GetAll() do
                    if IsValid(ply.hat) then
                        ply.hat:Remove()
                    end
                end

                hook.Remove("PostPlayerDraw", "mpdonate.hats")
            else
                hook.Add("PostPlayerDraw", "mpdonate.hats", DONATE_DRAWHATS)
            end
        end
    end)

    if cv_hats:GetBool() then
        hook.Add("PostPlayerDraw", "mpdonate.hats", DONATE_DRAWHATS)
    else
        hook.Remove("PostPlayerDraw", "mpdonate.hats")
    end
end