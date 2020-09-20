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

function PANEL:VarCheked(var)
	self.var = var or false
	self.fn = function() end
end
function PANEL:AfterClick(fn)
	self.fn = fn
end
function PANEL:Paint(w,h)
    surface_SetDrawColor(self:IsHovered() and gpay.c.buttonhovercolor or gpay.c.buttoncolor)
    surface_DrawRect(0,0,h,h)

	if self.var then
		surface_SetDrawColor(255,255,255,50)
		surface_DrawRect((gpay.szmp*0.0032388663967611),(gpay.szmp*0.0032388663967611),h-(gpay.szmp*0.0064777327935223),h-(gpay.szmp*0.0064777327935223))
	end

	surface_SetTextColor(255, 255, 255,255)
	surface_SetFont( "gpay.font.18" )

	local sw, sh = surface_GetTextSize(self:GetButtonText() or "Example")
	surface_SetTextPos( h+(gpay.szmp*0.0040485829959514), h/2-sh/2 ) 
	surface_DrawText( self:GetButtonText() or "Example" )

	return true
end
function PANEL:DoClick(clr, btn)
	--self.var = !self.var
	self.var = self.fn()
end
vgui.Register( "gpay.checkbox", PANEL,"Button")
--The script is written by FOER © 2019