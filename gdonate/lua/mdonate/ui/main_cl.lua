mp.szmp = (ScrW() * ScrH())/1800

local w
concommand.Add("autodonate", function( ply, cmd, args )
    if w and w:IsValid() then w:Remove() end
   w = vgui.Create("mp.window")
end)

local pan

local whitelist = {

	"+forward",

	"+back",

	"+left",

	"+right"

}



hook.Add("PlayerBindPress", "ba.Jail", function(lp, b)

	--if lp:IsJailed() and !table.HasValue(whitelist, b) then return true end

	if !LocalPlayer():Alive() and b != "+jump" and b != "+voicerecord" then return true end

end)
local blur = Material("pp/blurscreen")

local function DrawBlurRect(x, y, w, h)

	local X, Y = 0,0



	surface.SetDrawColor(255,255,255)

	surface.SetMaterial(blur)



	for i = 1, 3 do

		blur:SetFloat("$blur", (i / 3) * (3))

		blur:Recompute()



		render.UpdateScreenEffectTexture()



		render.SetScissorRect(x, y, x+w, y+h, true)

			surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())

		render.SetScissorRect(0, 0, 0, 0, false)

	end



   draw.RoundedBox(0,x,y,w,h,Color(0,0,0,205))

   surface.SetDrawColor(0,0,0)

   surface.DrawOutlinedRect(x,y,w,h)



end
function bannedHandle()

    local loaded = false

    local unban = "https://mp.ru.net/cloud/donate/unban.png"

	texture.Create(unban)

	:SetSize(200, 210)

	:SetFormat(unban:sub(-3) == "jpg" and "jpg" or "png")

    :Download(unban, function() loaded = true end, function()end)
    
    pan = vgui.Create("DPanel")
    pan:SetSize(ScrW(),ScrH())
    pan.Paint = function(m,w,h)
        DrawBlurRect(0, 0, w, h)
        surface.SetDrawColor(0,0,0,200)
        surface.DrawRect(0,0,w,h)  
    end
	local pan2 = vgui.Create("DPanel",pan)

    pan2:SetSize(840, 215)

    local reason = LocalPlayer():GetNetVar("BanReason") or "TEST"

	local adm = LocalPlayer():GetNetVar("BanAdmin") or "PIDOR"

    pan2.Paint = function(m,w,h)
        surface.SetDrawColor(mp.c.addcolor)
        surface.DrawRect(0,0,w,h)

        if loaded then
            surface.SetDrawColor(255, 255, 255,255)
            surface.SetMaterial(texture.Get(unban))
            surface.DrawTexturedRect(0, 0, 215, 215)
        end
        surface.SetTextColor(255, 255, 255,255)
		surface.SetFont( "mp.font.30" )

        local sw,sh = surface.GetTextSize("Вы забанены")
        surface.SetTextPos(  100+(w)/2-sw/2, 5 ) 
        surface.DrawText( "Вы забанены" )

        local sw,sh = surface.GetTextSize("Причина: "..reason)
        surface.SetTextPos(  100+(w)/2-sw/2, 40 ) 
        surface.DrawText( "Причина: "..reason )
        
        local sw,sh = surface.GetTextSize(adm..": STEAM_0:1:62803385")
        surface.SetTextPos( 100+(w)/2-sw/2, 70 ) 
        surface.DrawText( adm..": STEAM_0:1:62803385" )

        surface.SetDrawColor(255, 255, 255,10)
        surface.DrawOutlinedRect( 220,5,w-225,30 )

        surface.SetDrawColor(255, 255, 255,10)
        surface.DrawOutlinedRect( 220,5,w-225,100 )
        
        
		surface.SetDrawColor(0,0,0,200)
        surface.DrawRect(220,h-105,w-225,30)

        surface.SetDrawColor(255, 255, 255,10)
        surface.DrawOutlinedRect( 220,h-105,w-225,30 )

        surface.DrawOutlinedRect( 0, 0, w, h )

		local sw, sh = surface.GetTextSize(string.Comma(LocalPlayer():GetCurrency()).."₽")
		surface.SetTextPos( (w-200)/2+(w/2-10)/2 - sw/2 - 30,h-sh-75 ) 
		surface.DrawText( string.Comma(LocalPlayer():GetCurrency()).."₽" )
    end
    local Refresh = vgui.Create("mp.button", pan2)
	Refresh:SetPos(pan2:GetWide()-35,pan2:GetTall()-105)
	Refresh:SetSize(30,30)
	Refresh:SetButtonImage("data/mpdonate/ref.png")
    function Refresh:DoClick()
        netstream.Start("DonateBridge","refresh",false)
    end

    local AddBalance = vgui.Create("mp.button", pan2)
	AddBalance:SetButtonText("ПОПОЛНИТЬ БАЛАНС")
	AddBalance:SetPos(220,pan2:GetTall()-70)
	AddBalance:SetSize(pan2:GetWide()-225,30)
    function AddBalance:DoClick()
        netstream.Start("DonateBridge","paylink",false)
    end
    AddBalance.PaintOver = function(m,w,h)
        surface.SetDrawColor(255, 255, 255,10)
        surface.DrawOutlinedRect( 0, 0, w, h )
    end


	pan2:MakePopup()

	pan2:Center()

    buyunban = vgui.Create("mp.button",pan2)
    buyunban:Dock(BOTTOM)
    buyunban:SetTall(30)
    buyunban:DockMargin(220, 5, 5, 5)
    buyunban:SetButtonText("Купить разбан за 150₽")
    function buyunban:DoClick(clr, btn)
        netstream.Start("DonateBridge","buy","unban")
    end
    buyunban.PaintOver = function(m,w,h)
        surface.SetDrawColor(255, 255, 255,10)
        surface.DrawOutlinedRect( 0, 0, w, h )
    end

	hook.Add("PlayerBindPress", "ba.Ban", function()

		return true

	end)

end
local baba = true
timer.Create("BanHandler2",2,0,function()
    baba = !baba
end)
timer.Create("BanHandler",1,0,function()
    if not false then
		if IsValid( pan ) then pan:Remove() end
		hook.Remove("PlayerBindPress", "ba.Ban")
	else
		if not IsValid( pan ) then bannedHandle() end
	end
end)
--The script is written by FOER © 2019