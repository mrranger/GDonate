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
local surface_DrawLine = surface.DrawLine

local PANEL={}

function PANEL:Init()
    local main = self


	self.Header = vgui.Create("DPanel",self)
    self.Header:Dock(TOP)
    self.Header:SetHeight((gpay.szmp*0.020242914979757))
	self.Header.Paint = function(p, w, h)
		surface_SetDrawColor(p:IsHovered() and gpay.c.buttonhovercolor or gpay.c.buttoncolor)
        surface_DrawRect(0,0,w,h)
        surface_SetDrawColor(255,255,255,30)
        surface_DrawLine((gpay.szmp*0.12145748987854),(gpay.szmp*0.0024291497975709),(gpay.szmp*0.12145748987854),h-(gpay.szmp*0.0040485829959514))
        
        surface_SetTextColor(255, 255, 255,100)
        surface_SetFont( "gpay.font.18" )
        surface_SetTextPos( (gpay.szmp*0.0040485829959514), 0 ) 
        surface_DrawText( "Дата" )

        surface_SetTextPos( (gpay.szmp*0.13117408906883), 0 ) 
        surface_DrawText( "Действие" )
	end
    
    self.Scroll = vgui.Create("DScrollPanel",self)
	self.Scroll:Dock(FILL)
	self.Scroll.Paint = function(p, w, h)
        surface_SetDrawColor(0,0,0,180)
        surface_DrawRect(0,0,w,h)
    end
    self.Scroll.VBar:SetWidth((gpay.szmp*0.0064777327935223))
	self.Scroll.VBar:SetHideButtons( true )
	self.Scroll:GetVBar().Paint = function(_,w,h)
		surface_SetDrawColor(0, 0, 0, 150)
		surface_DrawRect(0,0,w,h)
	end
	self.Scroll:GetVBar().btnGrip.Paint = function(_,w,h)
		surface_SetDrawColor(255, 255, 255, 150)
		surface_DrawRect(0,0,w,h)
	end
end
function PANEL:AddLog(time,info)
    local Line = self.Scroll:Add( "DPanel" )
    Line:Dock( TOP )
    Line:SetTall((gpay.szmp*0.020242914979757))
    Line:DockMargin( 0, 0, 0, 0 )
    Line.Paint = function(p, w, h)
        surface_SetDrawColor(255,255,255,30)
		surface_DrawLine((gpay.szmp*0.12145748987854),(gpay.szmp*0.0024291497975709),(gpay.szmp*0.12145748987854),h-(gpay.szmp*0.0040485829959514))
		surface_SetTextColor(255, 255, 255)
        surface_SetFont( "gpay.font.10" )
        surface_SetTextPos( (gpay.szmp*0.014574898785425), (gpay.szmp*0.0032388663967611) ) 
        surface_DrawText( time )


        surface_SetTextPos( (gpay.szmp*0.13117408906883), (gpay.szmp*0.0032388663967611) ) 
        surface_DrawText( info )
	end
    
end
function PANEL:Paint()
	return true
end

vgui.Register( "gpay.logs", PANEL)
--The script is written by FOER © 2019