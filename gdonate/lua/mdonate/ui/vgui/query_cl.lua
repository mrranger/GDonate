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
AccessorFunc(PANEL, "btnText", "Question")

function PANEL:OnOkay(func)
	self.fn = func
end
local close_tex = Material("data/mpdonate/close.png")
function PANEL:Init()
    self:SetAlpha(0)
    self:AlphaTo(255,0.2)
    self:SetSize(gpay.szmp*0.32388663967611,gpay.szmp*0.12145748987854)
    self:MakePopup()
    self:Center()
    local main = self
	self.Close = vgui.Create("DButton",self)
	self.Close:SetSize(gpay.szmp*0.024291497975709,gpay.szmp*0.024291497975709)
	self.Close:SetPos(self:GetWide()-(gpay.szmp*0.024291497975709),0)
	self.Close:SetText("")
	self.Close.Paint = function(p, w, h)
		surface_SetDrawColor(p:IsHovered() and gpay.c.closehover or gpay.c.addcolor)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(0,0,0,130)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(255, 255, 255,p:IsHovered() and 255 or 150)
		surface_SetMaterial(close_tex)
		surface_DrawTexturedRectRotated(w/2, h/2, (gpay.szmp*0.017813765182186), (gpay.szmp*0.017813765182186), 0)
	end
    function self.Close:DoClick()
		main:Remove()
    end

    self.Okay = vgui.Create("gpay.button",self)
	self.Okay:SetButtonText("Да")
	self.Okay:SetSize(gpay.szmp*0.15384615384615,gpay.szmp*0.024291497975709)
    self.Okay:SetPos(gpay.szmp*0.0040485829959514,gpay.szmp*0.093117408906883)
    function self.Okay:DoClick()
        main.fn()
		main:Remove()
    end

    self.NoOkay = vgui.Create("gpay.button",self)
    self.NoOkay:SetButtonText("Отмена")
	self.NoOkay:SetSize(gpay.szmp*0.15789473684211,gpay.szmp*0.024291497975709)
    self.NoOkay:SetPos(gpay.szmp*0.16194331983806,gpay.szmp*0.093117408906883)
    function self.NoOkay:DoClick()
		main:Remove()
    end
end

function PANEL:Paint(w,h)
    Derma_DrawBackgroundBlur(self, 0)
    self:MoveToFront()
	surface_SetDrawColor(gpay.c.addcolor)
	surface_DrawRect(0,(gpay.szmp*0.024291497975709),self:GetWide(),self:GetTall()-(gpay.szmp*0.024291497975709))
    local height = select(2, surface.GetTextSize(self:GetQuestion() or "Example question on whis"))
    draw.DrawText(self:GetQuestion() or "Example question on whis", "gpay.font.25", w/2, h/2-height/2, Color(255,255,255,255), 1,1)
	return true
end
vgui.Register( "gpay.query", PANEL)



local PANEL={}
AccessorFunc(PANEL, "btnText", "Question")

function PANEL:OnOkay(func)
	self.fn = func
end
function PANEL:BackPan(func)
	self.backpan = func
end
local close_tex = Material("data/mpdonate/close.png")
function PANEL:Init()
    self:SetAlpha(0)
    self:AlphaTo(255,0.2)
    self:SetSize(gpay.szmp*0.32388663967611,gpay.szmp*0.12145748987854)
    self:Center()
    local main = self
	self.Close = vgui.Create("DButton",self)
	self.Close:SetSize(gpay.szmp*0.024291497975709,gpay.szmp*0.024291497975709)
	self.Close:SetPos(self:GetWide()-(gpay.szmp*0.024291497975709),0)
	self.Close:SetText("")
	self.Close.Paint = function(p, w, h)
		surface_SetDrawColor(p:IsHovered() and gpay.c.closehover or gpay.c.addcolor)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(0,0,0,130)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(255, 255, 255,p:IsHovered() and 255 or 150)
		surface_SetMaterial(close_tex)
		surface_DrawTexturedRectRotated(w/2, h/2, (gpay.szmp*0.017813765182186), (gpay.szmp*0.017813765182186), 0)
	end
    function self.Close:DoClick()
        main.backpan:Remove()
		main:Remove()
    end

    self.Okay = vgui.Create("gpay.button",self)
	self.Okay:SetButtonText("Продолжить")
	self.Okay:SetSize(gpay.szmp*0.15384615384615,gpay.szmp*0.024291497975709)
    self.Okay:SetPos(gpay.szmp*0.0040485829959514,gpay.szmp*0.093117408906883)
    function self.Okay:DoClick()
        main.fn(main.TEXT:GetValue())
        main.backpan:Remove()
		main:Remove()
    end

    self.NoOkay = vgui.Create("gpay.button",self)
    self.NoOkay:SetButtonText("Отмена")
	self.NoOkay:SetSize(gpay.szmp*0.15789473684211,gpay.szmp*0.024291497975709)
    self.NoOkay:SetPos(gpay.szmp*0.16194331983806,gpay.szmp*0.093117408906883)
    function self.NoOkay:DoClick()
        main.backpan:Remove()
		main:Remove()
    end

    self.TEXT = vgui.Create( "DTextEntry",self ) -- create the form as a child of frame
    self.TEXT:SetSize(gpay.szmp*0.31578947368421,gpay.szmp*0.024291497975709)
    self.TEXT:SetMouseInputEnabled( true )
    self.TEXT:SetKeyboardInputEnabled( true )
    self.TEXT:SetPos(gpay.szmp*0.0040485829959514,gpay.szmp*0.064777327935223)
    self.TEXT:SetValue( "Placeholder Text" )

    self.TEXT.OnEnter = function( self )
        main.fn(self:GetValue())
		main:Remove()
    end
end

function PANEL:Paint(w,h)
    Derma_DrawBackgroundBlur(self, 0)
	surface_SetDrawColor(gpay.c.addcolor)
	surface_DrawRect(0,(gpay.szmp*0.024291497975709),self:GetWide(),self:GetTall()-(gpay.szmp*0.024291497975709))
    local height = select(2, surface.GetTextSize(self:GetQuestion() or "Example question on whis"))
    draw.DrawText(self:GetQuestion() or "Example question on whis", "gpay.font.25", w/2, (gpay.szmp*0.044534412955466)-height/2, Color(255,255,255,255), 1,1)
end
vgui.Register( "gpay.querystring", PANEL)
--The script is written by FOER © 2019