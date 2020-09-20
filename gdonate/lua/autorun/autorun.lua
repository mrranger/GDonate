mp = mp or {}
PLAYER = FindMetaTable("Player")
gpay.c = gpay.c or {}

require 'nw'

require 'pon'

gpay.Msg = function(...) MsgC(Color(200,162,200),"[MP Donate] ",Color(255,255,255),...,"\n") end
gpay.DebugMsg = function(...) if not gpay.c.debug then return end MsgC(Color(255,50,50),"(DEBUG) ",Color(200,162,200),"[MP Donate] ",Color(255,255,255),...,"\n") end
gpay.isv = (SERVER) and include or function() end
gpay.icl = (SERVER) and AddCSLuaFile or include
gpay.ish = function(f) return gpay.icl(f) or gpay.isv(f) end
gpay.AddFile = function(f)
	if string.find(f, '_sv.lua') then
		return gpay.isv(f)
	elseif string.find(f, '_cl.lua') then
		return gpay.icl(f)
	else
		return gpay.ish(f)
	end
end
gpay.AddDir = function(dir, recursive)
	local fol = dir .. '/'
	local files, folders = file.Find(fol .. '*', 'LUA')
	for _, f in ipairs(files) do
		gpay.AddFile(fol .. f)
	end
	if (recursive ~= false) then
		for _, f in ipairs(folders) do
			gpay.AddDir(dir .. '/' .. f)
		end
	end
end

gpay.AddDir('utils',false)
gpay.AddFile('mdonate/ui/ns.lua')
gpay.AddFile('config_sv.lua')
gpay.AddFile('lang.lua')
gpay.AddDir('mdonate/providers',false) -- Провайдеры данных, крч я понял всю истерику по поводу MySQL, оставил только его...
gpay.AddDir('mdonate/classes',false)   -- Тут тупа классы
gpay.AddDir('mdonate/managment',false) -- чтоб можно было прикрутить любую админку
gpay.AddDir('mdonate/interpreter',false) -- обработчик
gpay.AddFile('mdonate/vars.lua')       -- Вары, удобно и быстро так сказать)
gpay.AddDir('mdonate',false)
gpay.AddFile('config.lua')
gpay.AddDir('mdonate/ui') -- Визуал, думаю самое парашное из всего что существует тут
gpay.AddDir('mdonate/saver')
gpay.AddDir('mdonate/hats')
-- Думаю тут и так все понятно
