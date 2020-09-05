mp = mp or {}
PLAYER = FindMetaTable("Player")
mp.c = mp.c or {}

require 'nw'

require 'pon'

mp.Msg = function(...) MsgC(Color(200,162,200),"[MP Donate] ",Color(255,255,255),...,"\n") end
mp.DebugMsg = function(...) if not mp.c.debug then return end MsgC(Color(255,50,50),"(DEBUG) ",Color(200,162,200),"[MP Donate] ",Color(255,255,255),...,"\n") end
mp.isv = (SERVER) and include or function() end
mp.icl = (SERVER) and AddCSLuaFile or include
mp.ish = function(f) return mp.icl(f) or mp.isv(f) end
mp.AddFile = function(f)
	if string.find(f, '_sv.lua') then
		return mp.isv(f)
	elseif string.find(f, '_cl.lua') then
		return mp.icl(f)
	else
		return mp.ish(f)
	end
end
mp.AddDir = function(dir, recursive)
	local fol = dir .. '/'
	local files, folders = file.Find(fol .. '*', 'LUA')
	for _, f in ipairs(files) do
		mp.AddFile(fol .. f)
	end
	if (recursive ~= false) then
		for _, f in ipairs(folders) do
			mp.AddDir(dir .. '/' .. f)
		end
	end
end

mp.AddDir('utils',false)
mp.AddFile('mdonate/ui/ns.lua')
mp.AddFile('config_sv.lua')
mp.AddFile('lang.lua')
mp.AddDir('mdonate/providers',false) -- Провайдеры данных, крч я понял всю истерику по поводу MySQL, оставил только его...
mp.AddDir('mdonate/classes',false)   -- Тут тупа классы
mp.AddDir('mdonate/managment',false) -- чтоб можно было прикрутить любую админку
mp.AddDir('mdonate/interpreter',false) -- обработчик
mp.AddFile('mdonate/vars.lua')       -- Вары, удобно и быстро так сказать)
mp.AddDir('mdonate',false)
mp.AddFile('config.lua')
mp.AddDir('mdonate/ui') -- Визуал, думаю самое парашное из всего что существует тут
mp.AddDir('mdonate/saver')
mp.AddDir('mdonate/hats')
-- Думаю тут и так все понятно
