-- THEME
gpay.c.api_url = "https://example.net/newdonte/" -- API URL
gpay.c.maincolor = Color(170,170,170,180)
gpay.c.addcolor = Color(49,10,80,250)
gpay.c.closehover = Color(255,30,30,250)
gpay.c.buttoncolor = Color(69,50,110,250)
gpay.c.buttonhovercolor = Color(79,60,120,250)
gpay.c.events = {
  ["combines"] = true,
}

gpay.c.itembg = Color(30,30,30,200)
gpay.c.await = 5
gpay.Create("vip")
:SetName("VIP")
:SetDescription([[
В двое больше профессий

Префикс [VIP]

Voicemute | unvoicemute [TAB]

Mute | Unmute [TAB]

В 2 раза больше инвентарь]])
:SetPrice(70)
:SetDiscount(50)
:SetExpires(2592000)
:SetIcon("https://example.net/vip.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("vip")
:SetType("usergroup")

gpay.Create("vip+")
:SetName("VIP+")
:SetDescription([[

Все возможные профессии

Префикс [VIP+]

Voicemute | unvoicemute [TAB]

Jaillroom | Unroom

Mute | Unmute [TAB]

В 2 раза больше инвентарь ]])
:SetExpires(2592000)
:SetPrice(150)
:SetIcon("https://example.net/vip_plus.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("vip+")
:SetType("usergroup")

gpay.Create("moder")
:SetDescription([[
Возможность взаимодействовать
с чужими пропами

Возможность
перемещения игроков

Возможность полета

В 2 больше инвентарь

Voicemute | unvoicemute [TAB]

Jaillroom | Unroom

Mute | Unmute [TAB]

setjob [Only Moderator job]

Cloak | uncloak [TAB]

Freeze | unfreeze [TAB]

God | Ungod [TAB]

Kick [TAB]

В 2 раза больше инвентарь ]])
:SetName("Moderator")
:SetExpires(2592000)
:SetPrice(300)
:SetIcon("https://example.net/moder.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("moderator")
:SetType("usergroup")

gpay.Create("admin")
:SetName("Admin")
:SetDescription([[
Префикс [Admin]

В 2 раза больше инвентарь

Возможности Moderator'a

Gimp | ungimp

Stopsound

unarrest | uncuff

Set hp

spectate

●Goto | Teleport | return]])
:SetExpires(2592000)
:SetPrice(700)
:SetIcon("https://example.net/admin.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("admin")
:SetType("usergroup")

gpay.Create("premadmin")
:SetName("PremAdmin")
:SetDescription([[
Префикс [PremAdmin]

HP, Maul

Возможности Admin'a

Ragdolll | UnRagdolll

Reconnect, VoteKick

Uncloak | Cloak

Strip, Vote, Cleardecals

Clearragdolls, Stopsound

Cleanprops, Banjob

Возможность брать
игроков физганом

Возможность выдавать оружие

Возможность устанавливать
все профы]])
:SetExpires(2592000)
:SetPrice(750)
:SetIcon("https://example.net/padmin.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("premadmin")
:SetType("usergroup")

gpay.Create("owner")
:SetName("Owner")
:SetDescription([[
Доступны все команды и
возможности

Возможность выдачи валюты ($)

Префикс [OWNER]

В 3 раза больше инвентарь ]])
:SetExpires(2592000)
:SetPrice(1500)
:SetIcon("https://example.net/owner.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("owner")
:SetType("usergroup")

gpay.Create("vip_inf")
:SetDescription([[
В двое больше профессий

Префикс [VIP]

Voicemute | unvoicemute [TAB]

Mute | Unmute [TAB]

В 2 раза больше инвентарь]])
:SetName("VIP")
:SetPrice(150)
:SetIcon("https://example.net/vip.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("vip")
:SetType("usergroup")

gpay.Create("vip+_inf")
:SetName("VIP+")
:SetDescription([[
Все возможные профессии

Префикс [VIP+]

Voicemute | unvoicemute [TAB]

Jaillroom | Unroom

Mute | Unmute [TAB]

В 2 раза больше инвентарь ]])
:SetPrice(350)
:SetIcon("https://example.net/vip_plus.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("vip+")
:SetType("usergroup")

gpay.Create("moder_inf")
:SetDescription([[
Возможность взаимодействовать
  с чужими пропами

Возможность
перемещения игроков

Возможность полета

В 2 больше инвентарь

Voicemute | unvoicemute [TAB]

Jaillroom | Unroom

Mute | Unmute [TAB]

setjob [Only Moderator job]

Cloak | uncloak [TAB]

Freeze | unfreeze [TAB]

God | Ungod [TAB]

Kick [TAB]

В 2 раза больше инвентарь ]])
:SetName("Moderator")
:SetPrice(390)
:SetIcon("https://example.net/moder.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("moderator")
:SetType("usergroup")

gpay.Create("admin_inf")
:SetName("Admin")
:SetDescription([[
Префикс [Admin]

В 2 раза больше инвентарь

Возможности Moderator'a

Gimp | ungimp

Stopsound

unarrest | uncuff

Set hp

spectate

●Goto | Teleport | return]])
:SetPrice(850)
:SetIcon("https://example.net/admin.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("admin")
:SetType("usergroup")

gpay.Create("premadmin_inf")
:SetName("PremAdmin")
:SetDescription([[
Префикс [PremAdmin]

HP, Maul

Возможности Admin'a

Ragdolll | UnRagdoll

Reconnect, VoteKick

Uncloak | Cloak

Strip, Vote, Cleardecals

Clearragdolls, Stopsound

Cleanprops, Banjob

Возможность брать

игроков физганом

Возможность выдавать оружие

Возможность устанавливать

все профы]])
:SetPrice(1500)
:SetIcon("https://example.net/padmin.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("premadmin")
:SetType("usergroup")

gpay.Create("owner_inf")
:SetName("Owner")
:SetDescription([[
Доступны все команды и
возможности

Возможность выдачи валюты ($)

Префикс [OWNER]

В 3 раза больше инвентарь ]])
:SetPrice(2700)
:SetIcon("https://example.net/owner.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("owner")
:SetType("usergroup")

gpay.Create("curator_S_inf")
:SetName("Куратор")
:SetDescription([[
Доступны все команды и
возможности

Роль куратора в Discord

Разрешен полет в РП профе
(в крайних случаях)

Вас не будут видеть в TAB

Поддержка со стороны
Главной Администрации

В 4 раза больше инвентарь
Вашей основной задачей
является слежка за
администрацией и сервером

Вы играете важную роль!

Не подведите нас!]])
:SetPrice(7500)
:SetIcon("https://example.net/curator.png")
:SetCategory("ПРИВЕЛЕГИИ")
:SetUsergroup("curator_s")
:SetType("usergroup")

gpay.Create("weapon_agent")
:SetName("Маскировка фримена")
:SetPrice(400)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Маскировка фримена")
:SetType("weapon")

gpay.Create("weapon_rpg")
:SetName("RPG")
:SetPrice(2000)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("RPG")
:SetType("weapon")

gpay.Create("weapon_crowbar")
:SetName("Монтировка")
:SetPrice(100)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Монтировка")
:SetType("weapon")

gpay.Create("m9k_dbarrel")
:SetName("Двустволка")
:SetPrice(250)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Двустволка")
:SetType("weapon")

gpay.Create("m9k_barret_m82")
:SetName("М82")
:SetPrice(500)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("М82")
:SetType("weapon")

gpay.Create("m9k_dragunov")
:SetName("СВД")
:SetDiscount(50)
:SetPrice(200)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("СВД")
:SetType("weapon")

gpay.Create("weapon_smg1")
:SetName("SMG")
:SetPrice(100)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("SMG")
:SetType("weapon")

gpay.Create("swb_awp")
:SetName("AWP")
:SetPrice(500)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("AWP")
:SetType("weapon")

gpay.Create("m9k_spas12")
:SetName("Спас 12")
:SetPrice(375)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Спас 12")
:SetType("weapon")

gpay.Create("weapon_ak472")
:SetName("AK-47")
:SetPrice(150)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("AK-47")
:SetType("weapon")

gpay.Create("swb_scout")
:SetName("Скаут")
:SetPrice(200)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Скаут")
:SetType("weapon")

gpay.Create("swb_usp")
:SetName("USP")
:SetPrice(70)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("USP")
:SetType("weapon")

gpay.Create("m9k_lugeradm")
:SetName("Пистоль")
:SetPrice(4000)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Пистоль")
:SetType("weapon")

gpay.Create("swb_knife_m")
:SetName("Нож")
:SetPrice(300)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Нож")
:SetType("weapon")

gpay.Create("climb_swep2")
:SetName("Паркур")
:SetPrice(470)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Паркур")
:SetType("weapon")

gpay.Create("swb_smg")
:SetName("MP7 Ultra")
:SetPrice(2000)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("MP7 Ultra")
:SetType("weapon")

gpay.Create("swb_357_a")
:SetName("Ковбойка 1337")
:SetPrice(2660)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Ковбойка 1337")
:SetType("weapon")

gpay.Create("m9k_m249lmg")
:SetName("М249")
:SetPrice(1600)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("М249")
:SetType("weapon")

gpay.Create("weapon_frag")
:SetName("Граната")
:SetPrice(650)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Граната")
:SetType("weapon")

gpay.Create("m9k_minigun")
:SetName("Миниган")
:SetPrice(2000)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Миниган")
:SetType("weapon")

gpay.Create("swb_xm1014")
:SetName("Дробовик")
:SetPrice(375)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Дробовик")
:SetType("weapon")

gpay.Create("keypad_cracker")
:SetName("Кейпад хак")
:SetPrice(200)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Кейпад хак")
:SetType("weapon")

gpay.Create("weapon_vape_medicinal")
:SetName("Медицинский Вейп")
:SetPrice(150)
:SetIcon("https://i.ytimg.com/vi/qZryquk9QTA/maxresdefault.jpg")
:SetCategory("ОРУЖИЕ")
:SetUsergroup("Медицинский Вейп")
:SetType("weapon")

gpay.Create("hat_0")
:SetName("Пакет")
:SetPrice(15)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-2),Angle(0,0,0),"models/sal/halloween/bag.mdl")
:SetType("hat")

gpay.Create("hat_1")
:SetName("Ray Ban")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-0.20000000298023),Angle(0,0,0),"models/modified/glasses02.mdl")
:SetType("hat")

gpay.Create("hat_2")
:SetName("Dolce & Gabbana")
:SetPrice(1000)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4.5,0,-0.20000000298023),Angle(0,0,0),"models/modified/glasses01.mdl")
:SetType("hat")

gpay.Create("hat_3")
:SetName("Гопстоп")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-5.1999998092651,-0.20000000298023,2),Angle(0,0,0),"models/modified/hat04.mdl")
:SetType("hat")

gpay.Create("hat_4")
:SetName("Кепарик")
:SetPrice(150)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,2),Angle(0,0,0),"models/modified/hat06.mdl")
:SetType("hat")

gpay.Create("hat_5")
:SetName("Шляпа")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4, 0, 1.5),Angle(0,0,0),"models/modified/hat01_fix.mdl")
:SetType("hat")

gpay.Create("hat_6")
:SetName("Adidas")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4, -0, 2),Angle(0,0,0),"models/modified/hat03.mdl")
:SetType("hat")

gpay.Create("hat_7")
:SetName("Кепка")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-3.9000000953674,0,1.5),Angle(0,0,0),"models/modified/hat08.mdl")
:SetType("hat")

gpay.Create("hat_8")
:SetName("Бейсболка")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,1.5),Angle(0,0,0),"models/modified/hat07.mdl")
:SetType("hat")

gpay.Create("hat_9")
:SetName("Маска")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-2),Angle(0,0,0),"models/sal/halloween/doctor.mdl")
:SetType("hat")

gpay.Create("hat_10")
:SetName("Хоккейная Маска")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-2),Angle(0,0,0),"models/sal/acc/fix/mask_2.mdl")
:SetType("hat")

gpay.Create("hat_11")
:SetName("Маска безумца")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-2.5),Angle(0,0,0),"models/modified/mask5.mdl")
:SetType("hat")

gpay.Create("hat_12")
:SetName("Шапка болельщика")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4.3000001907349,0,1.1000000238419),Angle(0,0,0),"models/sal/acc/fix/beerhat.mdl")
:SetType("hat")

gpay.Create("hat_13")
:SetName("Маска Лисы")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-1),Angle(0,0,0),"models/sal/fox.mdl")
:SetType("hat")

gpay.Create("hat_14")
:SetName("Маска Медведя")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-2),Angle(0,0,0),"models/sal/bear.mdl")
:SetType("hat")

gpay.Create("hat_15")
:SetName("Маска Кота")
:SetPrice(50)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-1),Angle(0,0,0),"models/sal/cat.mdl")
:SetType("hat")

gpay.Create("hat_16")
:SetName("Маска Орла")
:SetPrice(500)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-4),Angle(0,0,0),"models/sal/hawk_1.mdl")
:SetType("hat")

gpay.Create("hat_17")
:SetName("Маска Орла2")
:SetPrice(499)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-4),Angle(0,0,0),"models/sal/hawk_2.mdl")
:SetType("hat")

gpay.Create("hat_18")
:SetName("Маска Пингвина")
:SetPrice(70)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,-0.20000000298023,-2),Angle(0,0,0),"models/sal/penguin.mdl")
:SetType("hat")

gpay.Create("hat_19")
:SetName("Маска Пряни")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-1.5),Angle(0,0,0),"models/sal/gingerbread.mdl")
:SetType("hat")

gpay.Create("hat_20")
:SetName("Повязка мумии")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4.25,0,-2.5),Angle(0,0,0),"models/sal/halloween/headwrap2.mdl")
:SetType("hat")

gpay.Create("hat_21")
:SetName("Колпак повара")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-3.7000000476837,0.30000001192093,4),Angle(0,0,0),"models/sal/acc/fix/cheafhat.mdl")
:SetType("hat")

gpay.Create("hat_22")
:SetName("Маска волка")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4.25,0,-2.5),Angle(0,0,0),"models/sal/wolf.mdl")
:SetType("hat")

gpay.Create("hat_23")
:SetName("Маска Свиньи")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4.25,0,-2.5),Angle(0,0,0),"models/sal/pig.mdl")
:SetType("hat")

gpay.Create("hat_24")
:SetName("Стальная маска")
:SetPrice(99)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-2.2000000476837),Angle(0,0,0),"models/sal/acc/fix/mask_4.mdl", 0.95)
:SetType("hat")

gpay.Create("hat_25")
:SetName("Череп")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4.5,0,-2.2000000476837),Angle(0,0,0),"models/modified/mask6.mdl", 0.95)
:SetType("hat")

gpay.Create("hat_26")
:SetName("Маска Франкенштейн")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4,0,-2.2000000476837),Angle(0,0,0),"models/sal/halloween/zombie.mdl")
:SetType("hat")

------------------------------------------------------------------------------------------

gpay.Create("snowman_head")
:SetName("Снеговик")
:SetPrice(60)
:SetCategory("ШАПКИ")
:SetHatData(Vector(0, 2, -0.6),Angle(0, 0, 270),"models/props/cs_office/Snowman_face.mdl",0.9)
:SetType("hat")

gpay.Create("dynamite")
:SetName("Бомбер")
:SetPrice(90)
:SetCategory("ШАПКИ")
:SetHatData(Vector(0, -3.1, -6.5),Angle(0, 0, 90),"models/dynamite/dynamite.mdl",1)
:SetType("hat")

gpay.Create("pumpkin_pack")
:SetName("Тыква")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-4, 0, -6.5),Angle(0, 0, 0),"models/draganm_custom/pumpkin_pack/jackolantd_01.mdl",0.9)
:SetType("hat")

gpay.Create("smile")
:SetName("Смайл")
:SetPrice(100)
:SetCategory("ШАПКИ")
:SetHatData(Vector(0, 0, 1), Angle(255, -90, 0),"models/smile/smile.mdl",1)
:SetType("hat")

gpay.Create("cube025x025x025")
:SetName("Куб")
:SetPrice(80)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-3, 0, 8),Angle(0, 0, 0),"models/hunter/blocks/cube025x025x025.mdl",0.8)
:SetType("hat")

gpay.Create("graduation_cap")
:SetName("Выпускник")
:SetPrice(150)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-3, 0, -3.3),Angle(0, 0, 0),"models/player/items/humans/graduation_cap.mdl",1)
:SetType("hat")

gpay.Create("snowman_hat")
:SetName("Кепи")
:SetPrice(90)
:SetCategory("ШАПКИ")
:SetHatData(Vector(0.3, 2, 2), Angle(350, 0, 270),"models/props/cs_office/snowman_hat.mdl",0.85)
:SetType("hat")

gpay.Create("terracotta01")
:SetName("Горшочек")
:SetPrice(60)
:SetCategory("ШАПКИ")
:SetHatData(Vector(3.6, 0, -7),Angle(0, 180, 0),"models/props_junk/terracotta01.mdl",0.55)
:SetType("hat")

gpay.Create("hotdog")
:SetName("Hot-Dog")
:SetPrice(88)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-2.8, 0, -7.7),Angle(0, 0, 0),"models/food/hotdog.mdl",1)
:SetType("hat")

gpay.Create("cactus")
:SetName("Кактус")
:SetPrice(85)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-3, 0, 7),Angle(0, 0, 0),"models/props_lab/cactus.mdl",0.8)
:SetType("hat")


gpay.Create("HGIBS")
:SetName("Череп")
:SetPrice(85)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-2.7, -0.1, 0),Angle(0, 0, 0),"models/Gibs/HGIBS.mdl",1.5)
:SetType("hat")

gpay.Create("vending_hat1")
:SetName("Кепка")
:SetPrice(33)
:SetCategory("ШАПКИ")
:SetHatData(Vector(0.2, 3, 1),Angle(0, 0, 270),"models/props/de_tides/vending_hat.mdl",0.8)
:SetType("hat")

gpay.Create("white_dama")
:SetName("Очки 360")
:SetPrice(200)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-3, 0, -1),Angle(0, 0, 0),"models/props_phx/games/chess/white_dama.mdl",0.6)
:SetType("hat")

gpay.Create("w_headcrab")
:SetName("ХедКраб")
:SetPrice(250)
:SetCategory("ШАПКИ")
:SetHatData(Vector(0, 0, 3),Angle(90, 90, 0),"models/nova/w_headcrab.mdl",0.95)
:SetType("hat")

gpay.Create("top_hat")
:SetName("Шляпа")
:SetPrice(50)
:SetCategory("ШАПКИ")
:SetHatData(Vector(-3,0,-2.5),Angle(0, 0, 0),"models/player/items/humans/top_hat.mdl",1)
:SetType("hat")



-------------------------------------------------------------------------------------------

gpay.Create("DJUMP")
:SetName("Двойной прыжок")
:SetDescription("В два раза выше прыжок!")
:SetPrice(500)
:SetIcon("https://example.net/jump.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("boost")

gpay.Create("HP250")
:SetName("250 ХП")
:SetDescription("250 ХП при спавне")
:SetPrice(500)
:SetIcon("https://example.net/hp.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("boost")

gpay.Create("AR228")
:SetName("250 БРОНИ")
:SetDescription("250 Брони при спавне")
:SetPrice(400)
:SetIcon("https://example.net/armor.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("boost")

gpay.Create("FEEL")
:SetName("Шестое чувство")
:SetDescription([[Это как ВХ, только
легально и без бана!]])
:SetPrice(3000)
:SetIcon("https://example.net/hack.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("boost")

gpay.Create("PROPS")
:SetName("100 Пропов")
:SetDescription([[100 пропов масималный
лимит при спавне!]])
:SetPrice(400)
:SetIcon("https://example.net/props.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("boost")

gpay.Create("HUNGRY")
:SetName("АНТИ-Голод")
:SetDescription("Вы не голодаете!")
:SetPrice(150)
:SetIcon("https://example.net/not_eat.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("boost")

gpay.Create("combines")
:SetName("Ивент Комбайны")
:SetDescription("Ивент, суть заключается в том\nчто появляюся.\nКомбайны в неизвестных точках.\nЗа голову Комбайна дается\nнаграда в 150к$ \nНачало ивента от 60 человек.")
:SetPrice(200)
:SetIcon("https://example.net/ivent.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("event")
:SetCallBack(zbstart1)

gpay.Create("100kmoney")
:SetName("$100.000")
:SetDescription("$100.000\nигровой валюты")
:SetPrice(50)
:SetIcon("https://example.net/money_100k.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("event")
:SetCallBack(function(ply) ply:AddMoney(100000) end)

gpay.Create("100kkmoney")
:SetName("$1.000.000")
:SetDescription("$1.000.000\nигровой валюты")
:SetPrice(150)
:SetIcon("https://example.net/money_100kk.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("event")
:SetCallBack(function(ply) ply:AddMoney(1000000) end)

gpay.Create("unban")
:SetName("Разбан")
:SetDescription("Разбан в случае бана")
:SetPrice(150)
:SetIcon("https://example.net/unban.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("unban")


gpay.Create("povishenie")
:SetName("Повышение")
:SetDescription("Повышение на ранг выше.")
:SetPrice(400)
:SetIcon("https://example.net/up.png")
:SetCategory("ОСТАЛЬНОЕ")
:SetType("groupup")
