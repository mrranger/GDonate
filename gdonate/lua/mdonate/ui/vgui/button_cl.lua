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

local PANEL={}
AccessorFunc(PANEL, "btnText", "ButtonText")
AccessorFunc(PANEL, "btnImage", "ButtonImage")
function PANEL:Init()
	self.move = -(gpay.szmp*0.016194331983806)
end
local light = Material("data/mpdonate/light.png")
function PANEL:Paint(w,h)
    surface_SetDrawColor(self:IsHovered() and gpay.c.buttonhovercolor or gpay.c.buttoncolor)
    surface_DrawRect(0,0,w,h)
	if self:IsHovered() then
		self.move = self.move + (gpay.szmp*0.0080971659919028)
		surface_SetDrawColor(255, 255, 255,255)
		surface_SetMaterial(light)
		surface_DrawTexturedRectRotated(self.move, h/2, (gpay.szmp*0.12955465587045), (gpay.szmp*0.12955465587045), 0)
	else
		self.move = -(gpay.szmp*0.12955465587045)
	end
	if self:GetButtonImage() then
		surface_SetDrawColor(255, 255, 255,255)
		surface_SetMaterial(Material(self:GetButtonImage())) -- Не ебет
		surface_DrawTexturedRectRotated(w/2, h/2, (gpay.szmp*0.019433198380567), (gpay.szmp*0.019433198380567), 0)
	else
		surface_SetTextColor(255, 255, 255,255)
		surface_SetFont( "gpay.font.18" )

		local sw, sh = surface_GetTextSize(self:GetButtonText() or "Example")
		surface_SetTextPos( w/2-sw/2, h/2-sh/2 )
		surface_DrawText( self:GetButtonText() or "Example" )
	end
	return true
end

vgui.Register( "gpay.button", PANEL,"Button")
--The script is written by FOER © 2019