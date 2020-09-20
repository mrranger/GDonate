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
local function time(num)

    if num > 82800 and num < 172800 then return "|".."1 ДН"

    elseif num > 3540 and num < 7200 then return "|".."1 Ч"

    elseif num > 86400 then return "|"..math.ceil(num/86400).." Д"

    elseif num > 3600 then return "|"..math.ceil(num/3600).." Ч"

	elseif num > 60 then return "|"..math.ceil(num/60).." МИН"

	elseif num <= 0 then return ""

    else return "|".."1 МИН" end

end-- Из старого доната

local PANEL={}
function PANEL:Init()
	local main = self
	self.Bottom = vgui.Create("DPanel",self)
	self.Bottom:SetHeight((gpay.szmp*0.064777327935223))
	self.Bottom:Dock(BOTTOM)
	self.Bottom.Paint = function(p, w, h)
		surface_SetTextColor(255, 255, 255,255)
		surface_SetFont( "gpay.font.15" )

		surface_SetDrawColor(0,0,0,200)
		surface_DrawRect((gpay.szmp*0.005668016194332),(gpay.szmp*0.0016194331983806),w/2-(gpay.szmp*0.011336032388664),(gpay.szmp*0.024291497975709))

		local sw, sh = surface_GetTextSize(string.upper(LocalPlayer():GetUserGroup()).." "..time(LocalPlayer():GetDonateExpires() - os.time()))
		surface_SetTextPos( (gpay.szmp*0.0040485829959514)+(w/2-(gpay.szmp*0.0080971659919028))/2 - sw/2,(gpay.szmp*0.014574898785425)-sh/2-2 )
		surface_DrawText( string.upper(LocalPlayer():GetUserGroup())..""..time(LocalPlayer():GetDonateExpires() - os.time()))
		-- DrawScrollingText(tet,"gpay.font.18", (gpay.szmp*0.0040485829959514)+(w/2-(gpay.szmp*0.0080971659919028))/2 - sw/2, (gpay.szmp*0.014574898785425)-sh/2-2, w/2-(gpay.szmp*0.011336032388664) )

		surface_SetDrawColor(0,0,0,200)
		surface_DrawRect(w-w/2,(gpay.szmp*0.0016194331983806),w/2-(gpay.szmp*0.011336032388664),(gpay.szmp*0.024291497975709))

		local sw, sh = surface_GetTextSize(string.Comma(LocalPlayer():GetCurrency()).."₽")
		surface_SetTextPos( w-(w/2+(gpay.szmp*0.024291497975709))/2 - sw/2,(gpay.szmp*0.014574898785425)-sh/2-2 )
		surface_DrawText( string.Comma(LocalPlayer():GetCurrency()).."₽" )
	end
	local Refresh = vgui.Create("gpay.button", self.Bottom)
	Refresh:SetPos(self:GetWide()-(gpay.szmp*0.02995951417004),(gpay.szmp*0.0016194331983806))
	Refresh:SetSize((gpay.szmp*0.024291497975709),(gpay.szmp*0.024291497975709))
	Refresh:SetButtonImage("data/mpdonate/ref.png")
	function Refresh:PaintOver()
		Refresh:SetPos(main:GetWide()-(gpay.szmp*0.02995951417004),(gpay.szmp*0.0016194331983806))
	end
    function Refresh:DoClick()
		netstream.Start("DonateBridge","refresha",false)
    end
    local AddBalance = vgui.Create("gpay.button", self.Bottom)
    AddBalance:Dock(BOTTOM)
	AddBalance:SetButtonText(gpay.lang.addbalance)
	AddBalance:SetTall((gpay.szmp*0.02834008097166))
	AddBalance:DockMargin((gpay.szmp*0.0048582995951417), (gpay.szmp*0.005668016194332), (gpay.szmp*0.005668016194332), (gpay.szmp*0.005668016194332))
    function AddBalance:DoClick()
        netstream.Start("DonateBridge","paylink",false)
    end
end
function PANEL:Paint(w,h)
	return true
end

vgui.Register( "gpay.side", PANEL)
--The script is written by FOER © 2019