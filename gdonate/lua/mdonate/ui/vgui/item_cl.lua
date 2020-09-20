local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local surface_SetMaterial = surface.SetMaterial
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_SetTextColor = surface.SetTextColor
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize
local surface_SetTextPos = surface.SetTextPos
local surface_DrawText = surface.DrawText

function DrawScrollingText( text,FONT, xxx, y, texwide )
	surface.SetFont(FONT)

	local w = surface.GetTextSize( text  )
	w = w

	local x = math.fmod( CurTime() * 125, w ) * -1

	while ( x < texwide ) do

		surface.SetTextColor(255,255,255)
		surface.SetTextPos( x + xxx, y )
		surface.DrawText( text )

		x = x + w

	end

end

local PANEL = {}
function PANEL:Init()
	self.item = nil
	self.panel = nil
	self.titleshow = true
	self:SetText("")
	self.move = 0
	self.settings = false
end
function PANEL:SetInfoPanel(pnl)
	self.panel = pnl
end
local weapon_world_models = {

    weapon_crowbar = "models/weapons/w_crowbar.mdl",

    weapon_smg1 = "models/weapons/w_smg1.mdl",

    weapon_frag = "models/weapons/w_grenade.mdl",

    weapon_rpg = "models/weapons/w_rocket_launcher.mdl"

}
function PANEL:IsSettings(bool)
	self.settings = bool
end
spamingawating = CurTime()
function PANEL:SetItem(item)
	local main = self
	self.item = item

	self.loaded = false


		texture.Create(item:GetIcon())

		:SetSize((gpay.szmp*0.16194331983806), (gpay.szmp*0.17004048582996))

		:SetFormat(item:GetIcon():sub(-3) == "jpg" and "jpg" or "png")

		:Download(item:GetIcon(), function() if main and main:IsValid() then main.loaded = true end end, function()end)

	if self.item:GetType() == "hat" or self.item:GetType() == "weapon" then
		local hatdata = self.item:GetHatData()
		local mdlpnl = vgui.Create( "DModelPanel", self )
		mdlpnl:Dock(FILL)
		local size = 15
		if self.item:GetType() == "hat" then
			mdlpnl:SetModel( hatdata.model )
			size = 15
			if string.find( self.item:GetClass():lower(), "hat_" ) then
				mdlpnl:SetLookAt( mdlpnl.Entity:OBBCenter() )
			else
				local xtxt,ytyt = mdlpnl.Entity:GetModelBounds()
				mdlpnl:SetLookAt( (xtxt + ytyt) * 0.5 )
			end
		else
			size = 0
			mdlpnl:SetModel( weapons.Get( item:GetClass() ) and weapons.Get( item:GetClass() ).WorldModel or (weapon_world_models[item:GetClass()] and weapon_world_models[item:GetClass()] or "models/weapons/w_357.mdl") )

			local mn, mx = mdlpnl.Entity:GetRenderBounds()

			size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
			size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
			size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )
			mdlpnl:SetLookAt( (mn + mx) * 0.5 )
		end
		mdlpnl:SetMouseInputEnabled( false )
		mdlpnl:SetFOV( 65 )
		mdlpnl:SetCamPos( Vector( size, size, size ) )
		function mdlpnl:LayoutEntity( Entity ) return end
	end
end
local function time(num)

    if num > 82800 and num < 172800 then return "1 ДНЕЙ"

    elseif num > 3540 and num < 7200 then return "1 ЧАСОВ"

    elseif num > 86400 then return math.ceil(num/86400).." ДНЕЙ"

    elseif num > 3600 then return math.ceil(num/3600).." ЧАСОВ"

    elseif num > 60 then return math.ceil(num/60).." МИНУТ"

    else return "1 МИНУТ" end

end-- Из старого доната

local hatmodel = ClientsideModel("sex")
function PANEL:SetHideTitle(bool)
	self.titleshow = !bool
end
function PANEL:DoClick()
	if not self.panel or not self.panel:IsValid() then return end
	self.panel.selected = self.item
	local type = self.item:GetType()
	local hatdata = self.item:GetHatData()
	local name = self.item:GetName()
	local desc = self.item:GetDescription()
	local price = self.item:GetPrice()
	local exp = self.item:GetExpires()
	local realprice = self.item:GetPriceReal()
	local class = self.item:GetClass()
	local DESC = markup.Parse([[<center><font=gpay.font.15>]]..desc..[[</font></center>]])
	self.panel.avatar:Remove()
	self.panel.Paint = function(p, w, h)
		surface_SetDrawColor(0,0,0,100)
		surface_DrawRect(0, 0, w, h/4-(gpay.szmp*0.020242914979757))
		surface_SetTextColor(255, 255, 255,255)
		surface_SetFont( "gpay.font.30" )
		local sw, sh = surface_GetTextSize(name)
		surface_SetTextPos( w/2-sw/2, (gpay.szmp*0.0080971659919028) )
		surface_DrawText( name )


		surface_SetDrawColor(232,95,30)
		surface_DrawRect(0, (gpay.szmp*0.049392712550607), w/2-3, (gpay.szmp*0.024291497975709))


		surface_SetFont( "gpay.font.18" )
		local sw, sh = surface_GetTextSize(price.."₽")
		surface_SetTextPos( (w/2-3)/2-sw/2, (gpay.szmp*0.051821862348178) )
		surface_DrawText( price.."₽" )


		--[[surface_SetFont( "gpay.font.18" )
		local sw, sh = surface_GetTextSize("ЦЕНА БЕЗ СКИДКИ "..realprice.."₽")
		surface_SetTextPos((w/2)-sw/2, (gpay.szmp*0.051821862348178)+(gpay.szmp*0.024291497975709)+ (gpay.szmp*0.0040485829959514) )
		surface_DrawText( "ЦЕНА БЕЗ СКИДКИ "..realprice.."₽" )]]
		if realprice ~= price then

			surface_SetDrawColor(84,165,68)
			surface_DrawRect(0, (gpay.szmp*0.049392712550607)+(gpay.szmp*0.024291497975709) + (gpay.szmp*0.0040485829959514), w, (gpay.szmp*0.024291497975709))

			DrawScrollingText( "ЦЕНА БЕЗ СКИДКИ "..realprice.."₽              ","gpay.font.18", 0, (gpay.szmp*0.051821862348178)+(gpay.szmp*0.024291497975709)+ (gpay.szmp*0.0040485829959514), w )
		end
		surface_SetDrawColor(224,61,40)
		surface_DrawRect( w-(w/2-(gpay.szmp*0.0024291497975709))+(gpay.szmp*0.0016194331983806), (gpay.szmp*0.049392712550607), w/2-(gpay.szmp*0.0024291497975709), (gpay.szmp*0.024291497975709))
		if type == "hat" then
		elseif type == "weapon" then
			local wep = weapons.GetStored(class)
			local wep_dmg
			if wep and _G.type(wep) ~= "string" then
				wep_dmg = wep and wep.Damage or wep.Primary.Damage
			end
			local prepare = wep and isnumber(wep_dmg) and
            "Урон: "..wep_dmg.."\n"..

            "Магазин: "..wep.Primary.ClipSize.."\n"..

            "Скорострельность: "..(wep.FireDelay or math.Round(wep.Primary.RPM / 60000, 3)) or ""
			--[[if wep then
				local wep_dmg = 12
				local prepare = "Урон: Неизвестно\nМагазин: Неизвестно".."\nСкорострельность: Неизвестно"
				if _G.type(wep) ~= "string" then
					wep_dmg = wep and wep.Damage or wep.Primary.Damage
					prepare = "Урон: "..(wep_dmg or 0).."\nМагазин: "..(wep.Primary and wep.Primary.ClipSize or 0).."\nСкорострельность: "..(wep.Primary.RPM and (wep.FireDelay or math.Round(wep.Primary.RPM / 60000, 3)) or "1").." сек"
				end

			end]]
			if realprice ~= price then
				markup.Parse([[<div style="text-align: center;" ><font=gpay.font.25>]]..prepare..[[</font></div>]]):Draw(w/2, h/2-(gpay.szmp*0.072874493927125) + (gpay.szmp*0.0040485829959514)+4,1,1)
			else
				markup.Parse([[<div style="text-align: center;" ><font=gpay.font.25>]]..prepare..[[</font></div>]]):Draw(w/2, h/2-(gpay.szmp*0.072874493927125),1,1)
			end

		else
			--local height = select(2, surface.GetTextSize(desc))
			--draw.DrawText(desc, "gpay.font.18", w/2,h/2 - height / 2+25, Color(255,255,255), TEXT_ALIGN_CENTER)
		end
		surface_SetFont( "gpay.font.18" )
		local sw, sh = surface_GetTextSize(exp == 0 and (((type == "event" ) and "ОДНОРАЗОВО" or "НАВСЕГДА")) or  time(exp))
		surface_SetTextPos( w-(w/2-(gpay.szmp*0.0024291497975709))/2-sw/2, (gpay.szmp*0.051821862348178) )
		surface_DrawText( exp == 0 and (((type == "event" ) and "ОДНОРАЗОВО" or "НАВСЕГДА")) or time(exp))
	end
	local main = self

	if type == "hat" then  -- Нет, це и так оптимизэйшон, один хуй также будет
		if not self.panel.icon or not self.panel.icon:IsValid() then
			self.panel.icon = vgui.Create( "DModelPanel", self.panel )
			self.panel.icon:SetSize((gpay.szmp*0.2914979757085),(gpay.szmp*0.32064777327935))
			self.panel.icon:SetFOV(45)
			self.panel.icon:SetPos(0,(gpay.szmp*0.048582995951417))
			self.panel.icon:SetModel( "models/player/group01/male_02.mdl" )
			-- self.panel.icon:SetModel( LocalPlayer():GetModel() )
			local headpos = self.panel.icon.Entity:GetBonePosition(self.panel.icon.Entity:LookupBone("ValveBiped.Bip01_Head1"))
			self.panel.icon:SetLookAt(headpos+Vector(0, 1, 0))
			function self.panel.icon:LayoutEntity( Entity ) return end
			self.panel.icon:SetMouseInputEnabled( false )
			self.panel.icon.Entity:SetPos(Vector(0,0.4,-5))
			self.panel.icon:SetCamPos(headpos-Vector(-34, 0, 5))	-- Move cam in front of face
		end
		local kostil = main.panel

		hatmodel:SetModel(hatdata.model)

		function main.panel.icon.PostDrawModel()
			local hat = hatdata
			if not kostil then return end
			local ply = kostil.icon:GetEntity()
			local pos, ang = Vector(0,0,0),Angle(0,0,0)

			local attach_id = ply:LookupAttachment("eyes")
			if not attach_id then return end
			local attach = ply:GetAttachment(attach_id)
			if not attach then return end

			pos = attach.Pos
			ang = attach.Ang

			ang:RotateAroundAxis(ang:Forward(), hat.ang.p)

			ang:RotateAroundAxis(ang:Right(), hat.ang.y)

			ang:RotateAroundAxis(ang:Up(), hat.ang.r)

			-- print(hat.pos.z)
			hatmodel:SetModelScale(hat.sz or 1, 0)
			pos = pos	+ ((ang:Forward() * hat.pos.x)
						+ (ang:Right() * hat.pos.y)
						+ (ang:Up() * hat.pos.z))

			hatmodel:SetPos(pos)
			hatmodel:SetAngles(ang)

			hatmodel:SetRenderOrigin(pos)
			hatmodel:SetRenderAngles(ang)
			hatmodel:SetupBones()
			hatmodel:DrawModel()
		end
	else
		if self.panel.icon and self.panel.icon:IsValid() then
			self.panel.icon:Remove()
		end
	end
	if not self.panel.BuyButton then
		self.panel.BuyButton = vgui.Create("gpay.button", self.panel)
		self.panel.BuyButton:Dock(BOTTOM)
		self.panel.BuyButton:SetTall((gpay.szmp*0.024291497975709))
		self.panel.BuyButton:DockMargin((gpay.szmp*0.005668016194332), 0, (gpay.szmp*0.005668016194332), (gpay.szmp*0.0032388663967611))
	end
	if LocalPlayer():HasItem(class) then
		if type ~= "hat" and self.settings then

			if not self.panel.SpawnGive or not self.panel.SpawnGive:IsValid() then
				self.panel.SpawnGive = vgui.Create("gpay.checkbox", self.panel)

				self.panel.SpawnGive:SetTall((gpay.szmp*0.024291497975709))
			end

			self.panel.SpawnGive:SetPos((gpay.szmp*0.005668016194332),self.panel:GetTall() - (gpay.szmp*0.05748987854251))
			self.panel.SpawnGive:SetSize(self.panel:GetWide(),(gpay.szmp*0.024291497975709))
			self.panel.SpawnGive:SetButtonText("Выдавать при спавне")
			self.panel.SpawnGive:VarCheked(type == "boost" and gpay.saver.boosters[class] or gpay.saver.weapons[class])
			self.panel.SpawnGive:MoveToFront()
			function self.panel.SpawnGive:Think()
				self:MoveToFront()
			end
			self.panel.SpawnGive:AfterClick(function()

				if type == "weapon" then

					gpay.saver.weapons[class] = !gpay.saver.weapons[class]

					gpay.saver.SaveAndSend()
					return gpay.saver.weapons[class]

				elseif type == "boost" then

					gpay.saver.boosters[class] = !gpay.saver.boosters[class]

					gpay.saver.SaveAndSend()
					return gpay.saver.boosters[class]

				end

			end)

		else
			if self.panel.SpawnGive and self.panel.SpawnGive:IsValid() then
				self.panel.SpawnGive:Remove()
			end
		end

		if type == "weapon" or type == "boost" then
			self.panel.BuyButton:SetButtonText( gpay.lang.pickup )
		else
			self.panel.BuyButton:SetButtonText(gpay.saver.hats == class and "Снять" or "Надеть")

		end
	else
		self.panel.BuyButton:SetButtonText(LocalPlayer():HasItem(class) and lang.pickup or gpay.lang.buybutton)
		if self.panel.SpawnGive and self.panel.SpawnGive:IsValid() then
			self.panel.SpawnGive:Remove()
		end
	end

	function self.panel.BuyButton:Think()
		if LocalPlayer():HasItem(class) then



				if type == "weapon" or type == "boost" then

					self:SetButtonText( "Надеть")

				else


					self:SetButtonText(gpay.saver.hats == class and "Снять" or "Надеть")
				end


		end
	end

	function self.panel.BuyButton:DoClick()
		if LocalPlayer():HasItem(class) and spamingawating < CurTime() then

			if type == "weapon" or type == "boost" then

				gpay.saver.GiveMe(class,type)

			elseif type == "hat" then

				if gpay.saver.hats == class then
					gpay.saver.hats = nil
				else
					gpay.saver.hats = class
				end
				self:SetButtonText(gpay.saver.hats == class and "Снять" or "Надеть")

				surface.PlaySound("garrysmod/save_load4.wav")

				gpay.saver.SaveAndSend()

			end

			spamingawating = CurTime() + 2
			return
		elseif LocalPlayer():HasItem(class) and spamingawating > CurTime() then
			notification.AddLegacy( "Подождите...", NOTIFY_GENERIC, 4 )
			surface.PlaySound("npc/roller/mine/rmine_blip3.wav")
			return
		end
		local quest = vgui.Create("gpay.query")
		quest:SetQuestion("Вы уверенны что хотите купить\n"..name.."?")
		quest:OnOkay(function()
			netstream.Start("DonateBridge","buy",class)
		end)

	end


	if type == "weapon" then
		if not self.panel.WeaponPan or not self.panel.WeaponPan:IsValid() then
			self.panel.WeaponPan = vgui.Create( "DModelPanel", self.panel )
		end
		self.panel.WeaponPan:Dock(BOTTOM)
		self.panel.WeaponPan:SetTall((gpay.szmp*0.20242914979757))
		self.panel.WeaponPan:SetModel( weapons.Get(class) and weapons.Get( class ).WorldModel or (weapon_world_models[class] and weapon_world_models[class] or "models/weapons/w_357.mdl") )
		local mn, mx = self.panel.WeaponPan.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
		size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
		size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )
		self.panel.WeaponPan:SetMouseInputEnabled( false )
		self.panel.WeaponPan:SetFOV( (gpay.szmp*0.036437246963563) )
		self.panel.WeaponPan:SetCamPos( Vector( size, size, size ) )
		self.panel.WeaponPan:SetLookAt( (mn + mx) * (gpay.szmp*0.00040485829959514) )
		function self.panel.WeaponPan:PaintOver() self:SetCamPos( Vector( size + math.sin( CurTime()*1.3 )*10, size + math.cos( CurTime()*1.3 )*15, size ) )  end
		function self.panel.WeaponPan:LayoutEntity( Entity ) return end
	else
		if self.panel.WeaponPan and self.panel.WeaponPan:IsValid() then
			self.panel.WeaponPan:Remove()
		end
	end
	if type == "weapon" or type == "hat" then
		if self.panel.desc and self.panel.desc:IsValid() then
			self.panel.desc:Remove()
		end
		return
	end
	if not self.panel.desc or not self.panel.desc:IsValid() then
		self.panel.desc = vgui.Create( "DScrollPanel",self.panel)
	end
	self.panel.desc:Dock( FILL )
	self.panel.desc:DockMargin((gpay.szmp*0.00080971659919028), (gpay.szmp*0.080971659919028), 0, 0)
	self.panel.desc.VBar:SetWidth((gpay.szmp*0.0064777327935223))
	self.panel.desc.VBar:SetHideButtons( true )
	self.panel.desc:GetVBar().Paint = function(_,w,h)
		surface_SetDrawColor(255, 255, 255, 20)
		surface_DrawRect(0,0,w,h)
	end
	self.panel.desc:GetVBar().btnGrip.Paint = function(_,w,h)
		surface_SetDrawColor(255, 255, 255, 20)
		surface_DrawRect(0,0,w,h)
	end

	if self.panel.desc.inner and self.panel.desc.inner:IsValid() then
		self.panel.desc.inner:Remove()
	end
	self.panel.desc.inner = vgui.Create("DPanel",self.panel.desc)
	self.panel.desc.inner:Dock(FILL)
	local prepare = markup.Parse([[<div style="text-align: center;" ><center><font=gpay.font.25>]]..desc..[[</font></center></div>]],(gpay.szmp*0.2914979757085))

	local height = select(2, surface.GetTextSize(desc))
	if prepare:GetHeight() > (gpay.szmp*0.28744939271255) then
		self.panel.desc.inner:SetTall(prepare:GetHeight()+(gpay.szmp*0.024291497975709))
	else
		self.panel.desc.inner:SetTall((gpay.szmp*0.28744939271255))
	end

	self.panel.desc.inner.Paint = function(_,w,h)
		surface.SetFont("gpay.font.25")

		draw.DrawText(desc, "gpay.font.25", w/2,h/2 - height / 2, Color(255,255,255), TEXT_ALIGN_CENTER)

	end

end
function PANEL:PaintOver(w,h)
	if self.titleshow then
		surface_SetDrawColor(0,0,0,170)
		surface_DrawRect(0, h-(gpay.szmp*0.032388663967611), w, (gpay.szmp*0.032388663967611))
		surface_SetTextColor(255, 255, 255,255)
		surface_SetFont( "gpay.font.18" )

		local sw, sh = surface_GetTextSize(self.item:GetName())
		surface_SetTextPos( w/2-sw/2, h-(gpay.szmp*0.02753036437247) )
		surface_DrawText( self.item:GetName() )
	end

	local sw, sh = surface_GetTextSize(LocalPlayer():HasItem(self.item:GetClass()) and "КУПЛЕНО" or (LocalPlayer():GetUserGroup() == self.item:GetUsergroup() and "КУПЛЕНО" or self.item:GetPrice().."₽"))
	surface_SetDrawColor(84,165,68)
	surface_DrawRect(w-(sw+(gpay.szmp*0.0080971659919028))+1, (gpay.szmp*0.038056680161943), sw+(gpay.szmp*0.0080971659919028), (gpay.szmp*0.020242914979757))


	draw.SimpleText(LocalPlayer():HasItem(self.item:GetClass()) and "КУПЛЕНО" or (LocalPlayer():GetUserGroup() == self.item:GetUsergroup() and "КУПЛЕНО" or self.item:GetPrice().."₽"), "gpay.font.18",w-(gpay.szmp*0.0040485829959514)-1, (gpay.szmp*0.038056680161943), gpay.c.white,2,0)
	local sw, sh = surface_GetTextSize( self.item:GetExpires() > 0 and time(self.item:GetExpires()) or (self.item:GetType() == "event" ) and "ОДНОРАЗОВО" or "НАВСЕГДА")
	surface_SetDrawColor(224,61,40)
	surface_DrawRect(w-(sw+(gpay.szmp*0.0080971659919028))+1, (gpay.szmp*0.012145748987854), sw+(gpay.szmp*0.0080971659919028), (gpay.szmp*0.022672064777328))

	draw.SimpleText( self.item:GetExpires() > 0 and time(self.item:GetExpires()) or ((self.item:GetType() == "event" ) and "ОДНОРАЗОВО" or "НАВСЕГДА"), "gpay.font.18",w-(gpay.szmp*0.0040485829959514)-1, (gpay.szmp*0.012955465587045), gpay.c.white,2,0)

	if self.item:GetDiscount() > 0 then
		local sw2, sh2 = surface_GetTextSize("СКИДКА "..self.item:GetDiscount().."%")
		surface_SetDrawColor(HSVToColor( CurTime() * 50 % 360, 1, 1 ))
		surface_DrawRect(0, h-(!self.titleshow and (gpay.szmp*0.034008097165992) or (gpay.szmp*0.066396761133603)), sw2+(gpay.szmp*0.0080971659919028), (gpay.szmp*0.022672064777328))

		draw.SimpleText("СКИДКА "..self.item:GetDiscount().."%", "gpay.font.18",(gpay.szmp*0.0040485829959514), h-(!self.titleshow and (gpay.szmp*0.033198380566802) or (gpay.szmp*0.065587044534413)), gpay.c.white,0,0)
	end
	if self.panel and self.panel.selected == self.item then
		surface_SetDrawColor(255,255,255)
		surface.DrawOutlinedRect(0, 0, w, h)
		surface.DrawOutlinedRect(1, 1, w-2, h-2)
	end
	-- Ага ща нахуй

	if CurTime() % 3 < 1 and self.item:GetDiscount() > 0 then -- ВОТ ЕБАТЬ ОПТИМИЗАЦИЯ,А НЕ ТА ХУЙНЯ С ТАЙМЕРАМИ НА СТАРОМ
		self.move = self.move + (gpay.szmp*0.0080971659919028)
		surface_SetDrawColor(255, 255, 255,255)
		surface_SetMaterial(Material("data/mpdonate/light.png"))
		surface_DrawTexturedRectRotated(self.move, h/2, (gpay.szmp*0.24291497975709), (gpay.szmp*0.48582995951417), 0)
	else
		self.move = -(gpay.szmp*0.12955465587045)
	end
end
function PANEL:Paint(w,h)
	surface_SetDrawColor(gpay.c.itembg)
	surface_DrawRect(0, 0, w, h)

	surface_SetDrawColor(0,255,0,LocalPlayer():HasItem(self.item:GetClass()) and 20 or 0)
	surface_DrawRect(0, 0, w, h)
	if self.loaded and texture.Get(self.item:GetIcon()) and self.item:GetType() ~= "hat" and self.item:GetType() ~= "weapon" then
		surface_SetDrawColor(255, 255, 255,255)
		surface_SetMaterial(texture.Get(self.item:GetIcon()))
		surface_DrawTexturedRect(0, 0, w, h)
	end
end
vgui.Register('gpay.item', PANEL, "Button")

--The script is written by FOER © 2019