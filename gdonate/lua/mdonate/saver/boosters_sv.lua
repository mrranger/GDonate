local sexfeel_cds = {}
gpay.boosters = {
    ["HP250"] = function(ply)
        ply:SetHealth(250)
    end,
    ["AR228"] = function(ply)
        ply:SetArmor(250)
    end,
    ["DJUMP"] = function(ply)
        ply:SetJumpPower(ply:GetJumpPower()*2)
    end,
    ["FEEL"] = function(ply)
        if sexfeel_cds[ply:SteamID()] and CurTime() < sexfeel_cds[ply:SteamID()] then gpay.Notify(ply,Color(255,255,255),"Шестое чувство можно активировать раз в час") return end
        ply:SendLua"ad_sexfeel()"
        sexfeel_cds[ply:SteamID()] = CurTime() + 3600
        ply.sexfeel = true
    end,
    ["PROPS"] = function(ply)
        if ply.addproplimit then return end
        ply.addproplimit = 40
    end,
    ["HUNGRY"] = function(ply)
        if ply.antihungry then return end
        ply:HFM_SetHunger(100)
        ply.antihungry = true
    end,
}

povish = {

	-- ["user"] = "vip",

	["vip"] = "vip+",

	["vip+"] = "moderator",

	["moderator"] = "admin",

	["admin"] = "adminl1",

	["adminl1"] = "adminl2",

	["adminl2"] = "adminl3",

	["adminl3"] = "adminl4",

	["adminl4"] = "premadmin",

	["premadmin"] = "owner"

}

function groupup(ply)

	ply:AdvancedSetUserGroup(povish[string.lower(ply:GetUserGroup())])
	ply:SetNetVar("DonateUserGroupExpires",0)
	gpay.mysql.WriteVarServers(ply:SteamID64(),"mpdonate_groups","usergroup",sql.SQLStr(ply:GetUserGroup()))
	gpay.mysql.WriteVarServers(ply:SteamID64(),"mpdonate_groups","expires",0)

end

local function stop()
    hook.Remove("EntityTakeDamage", "Jopa v govne1")
    timer.Destroy("Mamka Johnny Sdohla1")
    for k,v in pairs(ents.GetAll()) do
        if v.pidorasObossaniy then v:Remove() end
    end
    BroadcastLua([[
        zbremove1()
    ]])
    concommand.Remove("stop_combine_sas")
end

function zbstart1()
    local zombs, pos, cops = 5, nil, {}

	for k,v in pairs(player.GetAll()) do
		if v:IsCP() then table.insert(cops, v) end
	end

	if #cops == 0 then
		pos = table.Random{
			Vector(3420, 1241, 94),
			Vector(1121, 1779, 92),
			Vector(1104, 155, 117),
			Vector(-173, -1181, 111),
			Vector(1935, -1317, 107),
			Vector(3418, 169, 100)
		}
	else
		pos = table.Random(cops):GetPos()
	end


	timer.Create("ZombieSas", 10, 5, function()
		local comb = ents.Create( 'npc_combine_s' )
		comb:SetPos( util.FindEmptyPos(pos) )
		comb:Spawn()
		comb:Activate()
		comb:SetHealth(7000)
		comb:Give'weapon_ar2'
		comb.pidorasObossaniy = true
	end)

    BroadcastLua"zbstart1()"

	local function win(pl, zb)
		pl:AddMoney(50000)
		pl:Notify(0, "Ты победил Бери 50 00$")
		zombs = zombs - 1
		zb:Remove()
		if zombs == 0 then
			stop()
		end
	end

	hook.Add("EntityTakeDamage", "Jopa v govne1", function(ent, dmg)
		local att = dmg:GetAttacker()
		if att.pidorasObossaniy then dmg:SetDamage(45) return end
		if !IsValid(att) or !att:IsPlayer() or !ent.pidorasObossaniy then return end
		if att:GetActiveWeapon():GetClass() == "swb_357_a" and !att:IsRoot() or att:GetBVar'adminmode' and !att:IsRoot() then att:Kill() dmg:SetDamage(0) return end
		if ent:Health() - dmg:GetDamage() < 1 then win(att, ent) end
	end)

	timer.Create("Mamka Johnny Sdohla1", 10, 0, function()
		local sas = math.random(0, 1)
		local zb
		for k,v in pairs(ents.GetAll()) do
			if v.pidorasObossaniy then zb = v end
		end
        if !zb then return end
		if sas == 0 then zb:SetColor(Color(255, 255, 255, math.random(50, 255))) zb:SetRenderMode( RENDERMODE_TRANSALPHA ) return end
		if sas == 1 then zb:SetModelScale(math.random(0.5, 2), 2) end
	end)

	concommand.Add("stop_combine_sas", function(p)
		if !p:IsRoot() then return end
		stop()
	end)
end
