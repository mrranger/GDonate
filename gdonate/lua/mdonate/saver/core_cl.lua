gpay.saver = gpay.saver or {}
gpay.saver.weapons = {}
gpay.saver.boosters = {}
gpay.saver.hats = nil

function gpay.saver.SaveAndSend()
    local prepare = {weapons=gpay.saver.weapons,hat=gpay.saver.hats,boosters=gpay.saver.boosters,age="save"}
    netstream.Start("DonateBridge","sync",prepare)
    file.Write("mpdonate/execution.dat",pon.encode(prepare))
end

function gpay.saver.GiveMe(class,type)
    local prepare = {type=type,class=class,age="give"}
    netstream.Start("DonateBridge","sync",prepare)
end

function gpay.saver.LoadSettings()
    if file.Exists("mpdonate/execution.dat","DATA") then
        local data = pon.decode(file.Read("mpdonate/execution.dat"))
        gpay.saver.weapons = data.weapons
        gpay.saver.hats = data.hat
        gpay.saver.boosters = data.boosters

    	local prepare = {weapons=gpay.saver.weapons,hat=gpay.saver.hats,boosters=gpay.saver.boosters,age="save"}
		netstream.Start("DonateBridge","sync",prepare)
		
		for k,v in pairs(gpay.saver.weapons) do
			if v then
				local prepare = {type="weapon",class=k,age="givef"}
				netstream.Start("DonateBridge","sync",prepare)
			end
		end

		for k,v in pairs(gpay.saver.boosters) do
			if v then
				local prepare = {type="boost",class=k,age="givef"}
				netstream.Start("DonateBridge","sync",prepare)
			end
		end
    end
end
hook.Add("InitPostEntity","wcqweqwvqwe",function()
	gpay.saver.LoadSettings()
end)


zbremove1 = function()

    hook.Remove("PreDrawTranslucentRenderables", "Mamka Johnny1")

    hook.Remove("HUDPaint", "Vaginalnoe WH1")

end



function zbstart1()

    surface.CreateFont("Zb_Sexy_Font", {

		font = "Cambria",

		extended = false,

		size = 20,

		weight = 1000,

		blursize = 0,

		scanlines = 0,

		antialias = false,

		underline = false,

		italic = false,

		strikeout = false,

		symbol = false,

		rotary = false,

		shadow = false,

		additive = false,

		outline = false

	})



	hook.Add("PreDrawTranslucentRenderables", "Mamka Johnny1", function() EyePos() end )

	local zombs = {}



	hook.Add("HUDPaint", "Vaginalnoe WH1", function()

		for k,ent in pairs(ents.GetAll()) do

			if ent:GetClass() == "npc_combine_s" then

				table.insert(zombs, ent)

				local pos = (ent:GetPos() + Vector(0, 0, 95)):ToScreen()

				draw.SimpleText("★", "Zb_Sexy_Font", pos.x, pos.y, Color(255, 0, 0), 1)

			end

		end

		for k,ent in pairs(zombs) do

			if !IsValid(ent) then table.remove(zombs, k) continue end

			k = k - 1

			draw.RoundedBox(0, 10, 10 + (k * 25), 160, 20, Color(30, 30, 30))

			draw.RoundedBox(0, 12, 12 + (k * 25), ent:Health() / 44, 16, Color(255, 30, 30))

		end

		zombs = {}

	end)

	chat.AddText("Они идут..")

	chat.AddText("Убей или будешь убитым. Ивент.")

end
--The script is written by FOER © 2019


