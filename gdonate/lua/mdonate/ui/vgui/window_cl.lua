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

local close_tex = Material("data/mpdonate/close.png")
local settings_tex = Material("data/mpdonate/settings.png")
local info_tex = Material("data/mpdonate/info.png")

local PANEL={}

function PANEL:Init()
	self:SetAlpha(0)
	self:AlphaTo(255,0.2)
	mp.szmp = (ScrW() + ScrH())/ 2.3
	local main = self
	self.CurrentWindow = nil
	self.selected = nil
	self.categories = {} -- Кароче либо я тупой, либо че, но при получении #self.categories мне давало по кд 0
    for k,v in SortedPairs(mp.ITEMS) do

        if not self.categories[v:GetCategory()] then
            self.categories[v:GetCategory()] = {}
            self.categories[v:GetCategory()][1] = v
        else
            self.categories[v:GetCategory()][#self.categories[v:GetCategory()]+1] = v
        end

	end

    self:SetSize(mp.szmp*1,mp.szmp*0.48582995951417)
    local third = self:GetWide()/3.5
	local five = self:GetWide()/20
	self:Center()
	self:MakePopup()

	self.Close = vgui.Create("DButton",self)
	self.Close:SetSize(mp.szmp*0.032388663967611+1,mp.szmp*0.024291497975709)
	self.Close:SetPos(self:GetWide()-(mp.szmp*0.033198380566802)+1,0)
	self.Close:SetText("")
	self.Close.Paint = function(p, w, h)
		surface_SetDrawColor(p:IsHovered() and mp.c.closehover or mp.c.addcolor)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(0,0,0,130)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(255, 255, 255,p:IsHovered() and 255 or 150)
		surface_SetMaterial(close_tex)
		surface_DrawTexturedRectRotated(w/2, h/2, (mp.szmp*0.017813765182186), (mp.szmp*0.017813765182186), 0)
	end
	function self.Close:DoClick()
		main:Remove()
    end

    self.Settings = vgui.Create("DButton",self)
	self.Settings:SetSize(mp.szmp*0.032388663967611+1,mp.szmp*0.024291497975709)
	self.Settings:SetPos(self:GetWide()-(mp.szmp*0.064777327935223),0)
	self.Settings:SetText("")
	self.Settings.Paint = function(p, w, h)
		surface_SetDrawColor(p:IsHovered() and mp.c.addcolor or mp.c.addcolor)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(0,0,0,130)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(255, 255, 255,p:IsHovered() and 255 or 150)
		surface_SetMaterial(settings_tex)
		surface_DrawTexturedRectRotated(w/2, h/2, (mp.szmp*0.017813765182186), (mp.szmp*0.017813765182186), 0)
	end
    function self.Settings:DoClick()
        if main.CurrentWindow then main.CurrentWindow:Remove() end
		main.CurrentWindow = vgui.Create("DPanel",main)
		main.CurrentWindow:SetPos(0,(mp.szmp*0.024291497975709)+five)
		main.CurrentWindow:SetSize(main:GetWide()-main:GetWide()/3.5,main:GetTall()-five-mp.szmp*0.024291497975709)
		main.CurrentWindow.Paint = function(p, w, h)
			surface_SetDrawColor(0,0,0,100)
			surface_DrawRect(0,0,w,h)
		end
		main.selected = nil

		main.InnerInfo:Remove()
		main.InnerInfo = vgui.Create("DPanel",main.Right)
		main.InnerInfo:Dock(FILL)
		main.InnerInfo.Paint = function(p, w, h)
			surface.SetFont("mp.font.25")
			local text = string.format(mp.lang.maintext,LocalPlayer():GetName())
			local height = select(2, surface.GetTextSize(text))
			draw.DrawText(text, "mp.font.25", w/2,h/2 - height / 2, Color(255,255,255), TEXT_ALIGN_CENTER)
			surface_SetDrawColor( 255,255,255,15)
			surface_DrawRect(mp.szmp*0,mp.szmp*0.080161943319838,w,1)
		end

		main.InnerInfo.avatar = vgui.Create("mp.avatar",main.InnerInfo)
		main.InnerInfo.avatar:SetPos(mp.szmp*0.10526315789474,mp.szmp*0.0040485829959514)
		main.InnerInfo.avatar:SetSize(mp.szmp*0.072874493927125,mp.szmp*0.072874493927125)
		main.InnerInfo.avatar:SetPlayer(LocalPlayer(),90)

		main:DoSettingsClick(main.CurrentWindow,main.InnerInfo)
    end

    self.Info = vgui.Create("DButton",self)
	self.Info:SetSize(mp.szmp*0.032388663967611+1,mp.szmp*0.024291497975709)
	self.Info:SetPos(self:GetWide()-(mp.szmp*0.097165991902834),0)
	self.Info:SetText("")
	self.Info.Paint = function(p, w, h)
		surface_SetDrawColor(p:IsHovered() and mp.c.addcolor or mp.c.addcolor)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(0,0,0,130)
		surface_DrawRect(0,0,w,h)
		surface_SetDrawColor(255, 255, 255,p:IsHovered() and 255 or 150)
		surface_SetMaterial(info_tex)
		surface_DrawTexturedRectRotated(w/2, h/2, (mp.szmp*0.017813765182186), (mp.szmp*0.017813765182186), 0)
	end
    function self.Info:DoClick()
        if main.CurrentWindow then main.CurrentWindow:Remove() end
		main.CurrentWindow = vgui.Create("DPanel",main)
		main.CurrentWindow:SetPos(0,(mp.szmp*0.024291497975709)+five)
		main.CurrentWindow:SetSize(main:GetWide()-main:GetWide()/3.5,main:GetTall()-five-mp.szmp*0.024291497975709)
		main.CurrentWindow.Paint = function(p, w, h)
			surface_SetDrawColor(0,0,0,100)
			surface_DrawRect(0,0,w,h)
		end
		main.selected = nil
		main:DoInfoClick(main.CurrentWindow)

		main.InnerInfo:Remove()
		main.InnerInfo = vgui.Create("DPanel",main.Right)
		main.InnerInfo:Dock(FILL)
		main.InnerInfo.Paint = function(p, w, h)
			surface.SetFont("mp.font.25")
			local text = string.format(mp.lang.maintext,LocalPlayer():GetName())
			local height = select(2, surface.GetTextSize(text))
			draw.DrawText(text, "mp.font.25", w/2,h/2 - height / 2, Color(255,255,255), TEXT_ALIGN_CENTER)
			surface_SetDrawColor( 255,255,255,15)
			surface_DrawRect(mp.szmp*0,mp.szmp*0.080161943319838,w,1)
		end

		main.InnerInfo.avatar = vgui.Create("mp.avatar",main.InnerInfo)
		main.InnerInfo.avatar:SetPos(mp.szmp*0.10526315789474,mp.szmp*0.0040485829959514)
		main.InnerInfo.avatar:SetSize(mp.szmp*0.072874493927125,mp.szmp*0.072874493927125)
		main.InnerInfo.avatar:SetPlayer(LocalPlayer(),90)
	end

	self.Top = vgui.Create("DPanel",self)
	self.Top:SetPos(mp.szmp*0,mp.szmp*0.024291497975709)
	self.Top:SetSize(main:GetWide()-main:GetWide()/3.5,five)
	self.Top.Paint = function(p, w, h) end

	self.Right = vgui.Create("mp.side",self)
	self.Right:Dock(RIGHT)
	self.Right:DockMargin(0, (mp.szmp*0.024291497975709), 0, 0)
	self.Right:SetWide(self:GetWide()/3.5+(mp.szmp*0.00080971659919028))

	self.InnerInfo = vgui.Create("DPanel",self.Right)
	self.InnerInfo:Dock(FILL)
	self.InnerInfo.Paint = function(p, w, h)
		surface.SetFont("mp.font.25")
		local text = string.format(mp.lang.maintext,LocalPlayer():GetName())
		local height = select(2, surface.GetTextSize(text))
		draw.DrawText(text, "mp.font.25", w/2,h/2 - height / 2, Color(255,255,255), TEXT_ALIGN_CENTER)
		surface_SetDrawColor( 255,255,255,15)
		surface_DrawRect(mp.szmp*0,mp.szmp*0.080161943319838,w,1)
	end

	self.InnerInfo.avatar = vgui.Create("mp.avatar",self.InnerInfo)
	self.InnerInfo.avatar:SetPos(mp.szmp*0.10526315789474,mp.szmp*0.0040485829959514)
	self.InnerInfo.avatar:SetSize(mp.szmp*0.072874493927125,mp.szmp*0.072874493927125)
	self.InnerInfo.avatar:SetPlayer(LocalPlayer(),90)
	self.poen = false
	local custom_header = {"ПРИВЕЛЕГИИ","ОРУЖИЕ","ШАПКИ","ОСТАЛЬНОЕ"}
	for k,v in pairs(custom_header) do
		if not self.poen then
			self.poen = true
			if main.CurrentWindow then main.CurrentWindow:Remove() end
			main.CurrentWindow = vgui.Create("DPanel",main)
			main.CurrentWindow:SetPos(0,(mp.szmp*0.024291497975709)+five)
			main.CurrentWindow:SetSize(main:GetWide()-main:GetWide()/3.5,main:GetTall()-five-mp.szmp*0.024291497975709)
			main.CurrentWindow.Paint = function(p, w, h)
				surface_SetDrawColor(0,0,0,100)
				surface_DrawRect(0,0,w,h)
			end
			main:OpenDonatePanel(main.CurrentWindow,v,main.categories,main.InnerInfo)
			main.selected = v
		end
		local button = vgui.Create("mp.button",self.Top)
		button:SetWide((main:GetWide()-main:GetWide()/3.5)/table.Count(main.categories)+(mp.szmp*0.00080971659919028)+1)
		button:Dock(LEFT)
		button:SetText("")
		button.Paint = function(p, w, h)
			surface_SetDrawColor(p:IsHovered() and mp.c.buttonhovercolor or mp.c.addcolor)
			surface_DrawRect(0,0,w,h)

			surface_SetTextColor(255, 255, 255,255)
			surface_SetFont( "mp.font.18_blood" )

			local sw, sh = surface_GetTextSize(v or "Example")
			surface_SetTextPos( w/2-sw/2, h/2-sh/2 )
			surface_DrawText( v or "Example" )
			if main.selected == v then
				surface_SetDrawColor( 255,255,255,3)
				surface_DrawRect(0,0,w,h)
				surface_SetDrawColor( 255,255,255,255)
				surface_DrawRect(0,h-(mp.szmp*0.0024291497975709)+1,w,(mp.szmp*0.0024291497975709))
			end
		end
		button.DoClick = function()
			if main.CurrentWindow then main.CurrentWindow:Remove() end
			main.CurrentWindow = vgui.Create("DPanel",main)
			main.CurrentWindow:SetPos(0,(mp.szmp*0.024291497975709)+five)
			main.CurrentWindow:SetSize(main:GetWide()-main:GetWide()/3.5,main:GetTall()-five-mp.szmp*0.024291497975709)
			main.CurrentWindow.Paint = function(p, w, h)
				surface_SetDrawColor(0,0,0,100)
				surface_DrawRect(0,0,w,h)
			end
			main:OpenDonatePanel(main.CurrentWindow,v,main.categories,main.InnerInfo)
			main.selected = v
		end
	end
end
function PANEL:DoSettingsClick(panel,pnl)

	local Header = vgui.Create( "DLabel", panel )
    Header:Dock(TOP)
    Header:SetFont("mp.font.25")
    Header:SetHeight((mp.szmp*0.020242914979757))
    Header:DockMargin((mp.szmp*0.012145748987854), (mp.szmp*0.0080971659919028), (mp.szmp*0.012145748987854), 0)
	Header:SetText( "Приобретенные товары" )
	local Scroll = vgui.Create( "DScrollPanel",panel)
	Scroll:Dock( FILL )
	Scroll.VBar:SetWidth((mp.szmp*0.0064777327935223))
	Scroll.VBar:SetHideButtons( true )
	Scroll:GetVBar().Paint = function(_,w,h)
		surface_SetDrawColor(0, 0, 0, 150)
		surface_DrawRect(0,0,w,h)
	end
	Scroll:GetVBar().btnGrip.Paint = function(_,w,h)
		surface_SetDrawColor(255, 255, 255, 150)
		surface_DrawRect(0,0,w,h)
	end
	local List = vgui.Create( "DIconLayout" )
	List:DockMargin((mp.szmp*0.012145748987854),(mp.szmp*0.012145748987854),(mp.szmp*0.012145748987854),0)
	List:Dock( FILL )
	List:SetSpaceY( (mp.szmp*0.012145748987854) )
	List:SetSpaceX( (mp.szmp*0.012145748987854) )
	Scroll:AddItem(List)
	for k,v in pairs(LocalPlayer():GetDonateInventory()) do
		if not mp.GetItem(v["class"]) then continue end
		local item = List:Add("mp.item")
		item:SetItem(mp.GetItem(v["class"]))
		item:IsSettings(true)
		item:SetInfoPanel(pnl)
		item:SetSize(mp.szmp*0.16113360323887,mp.szmp*0.17004048582996)
	end

end

function PANEL:OpenDonatePanel(panel,category,listed,pnl)
	local Scroll = vgui.Create( "DScrollPanel",panel)
	Scroll:Dock( FILL )
	Scroll.VBar:SetWidth((mp.szmp*0.0064777327935223))
	Scroll.VBar:SetHideButtons( true )
	Scroll:GetVBar().Paint = function(_,w,h)
		surface_SetDrawColor(0, 0, 0, 150)
		surface_DrawRect(0,0,w,h)
	end
	Scroll:GetVBar().btnGrip.Paint = function(_,w,h)
		surface_SetDrawColor(255, 255, 255, 150)
		surface_DrawRect(0,0,w,h)
	end
	local List = vgui.Create( "DIconLayout" )
	List:DockMargin((mp.szmp*0.012145748987854),(mp.szmp*0.012145748987854),(mp.szmp*0.012145748987854),0)
	List:Dock( FILL )
	List:SetSpaceY( (mp.szmp*0.012145748987854) )
	List:SetSpaceX( (mp.szmp*0.012145748987854) )
	Scroll:AddItem(List)
	for k,v in SortedPairsByMemberValue(listed[category],"price") do
		local item = List:Add("mp.item")
		item:SetItem(v)
		item:SetHideTitle(category == "ПРИВЕЛЕГИИ")
		item:SetInfoPanel(pnl)
		item:SetSize(mp.szmp*0.16113360323887,mp.szmp*0.17004048582996)
	end
end
function PANEL:DoInfoClick(panel)
    local Header = vgui.Create( "DLabel", panel )
    Header:Dock(TOP)
    Header:SetFont("mp.font.25")
    Header:SetHeight((mp.szmp*0.020242914979757))
    Header:DockMargin((mp.szmp*0.012145748987854), (mp.szmp*0.0080971659919028), (mp.szmp*0.012145748987854), (mp.szmp*0.0040485829959514))
    Header:SetText( mp.lang.logtext )

    local LogsPanel = vgui.Create( "mp.logs", panel )
    LogsPanel:Dock(FILL)
    LogsPanel:DockMargin((mp.szmp*0.012145748987854), 0, (mp.szmp*0.012145748987854), (mp.szmp*0.0040485829959514))
	LogsPanel:SetHeight((mp.szmp*0.24291497975709))
	http.Post(mp.c.api_url.."log.php", {pltoken=LocalPlayer():GetDonateToken()}, function(dat)
		if not dat then end
		if not util.JSONToTable(dat) then return end
		if not LogsPanel:IsValid() then return end
		for k, v in pairs(util.JSONToTable(dat)) do
			LogsPanel:AddLog(v.date,v.description )
		end
	end)

    local Bottom = vgui.Create( "DPanel", panel )
    Bottom:Dock(BOTTOM)
    Bottom:DockMargin((mp.szmp*0.012145748987854), (mp.szmp*0.0040485829959514), (mp.szmp*0.012145748987854), (mp.szmp*0.0048582995951417))
    Bottom:SetHeight((mp.szmp*0.02834008097166))
    function Bottom:Paint() end

    local btn = vgui.Create("mp.button", Bottom)
    btn:Dock(LEFT)
    btn:SetWide((mp.szmp*0.32874493927126))
    btn:SetButtonText(mp.lang.activatecupon)
	function btn:DoClick()

		local windquest = vgui.Create("DFrame")
		windquest:SetSize(400,150)
		windquest:MakePopup()
		windquest:SetTitle('')
		windquest:ShowCloseButton(false)
		windquest:Center()
		function windquest:Paint() end
		local quest = vgui.Create("mp.querystring",windquest)
		quest:SetQuestion("Введите купон ниже")
		quest:BackPan(windquest)
		quest:OnOkay(function(text) if not text or text == "" then return end netstream.Start("DonateBridge","checkcupon",text) end)
		windquest:SizeToContents()

    end

    local btn2 = vgui.Create("mp.button", Bottom)
    btn2:Dock(RIGHT)
    btn2:SetWide((mp.szmp*0.32874493927126))
    btn2:SetButtonText(mp.lang.questionbtn)
    function btn2:DoClick()
        gui.OpenURL("http://millenium.myarena.ru/buym.html")
    end
end
function PANEL:Paint()
	surface_SetDrawColor(mp.c.maincolor)
	surface_DrawRect(0,(mp.szmp*0.024291497975709),self:GetWide()-self:GetWide()/3.5 ,self:GetTall())

	surface_SetDrawColor(mp.c.addcolor)
	surface_DrawRect(self:GetWide()-self:GetWide()/3.5,(mp.szmp*0.024291497975709),self:GetWide()/3.5+(mp.szmp*0.00080971659919028),self:GetTall())
	return true
end
vgui.Register( "mp.window", PANEL)
--The script is written by FOER © 2019