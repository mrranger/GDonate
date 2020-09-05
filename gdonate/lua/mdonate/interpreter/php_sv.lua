mp.php = mp.php or {}

---------------
-- TYPE REQUESTS:
-- check - Cheking player balance (data: {sid=text,balance=int}) @RETURN int
-- shortcut - Shortening links    (data: {longurl=text}) @RETURN string
---------------
function mp.php.Requst(type,data,callback)
    data.token = mp.c.token
    http.Post(mp.c.api_url..type..".php",data,callback,function(err) print(err) end,mp.c.token) 

end
-- Кароче, я не понимаю почему такая паника с сокетом, сделаю рефреш через PHP, Я НЕ БУДУ ДЕАТЬ ЭТО ЧЕРЕЗ МУСК, ЭТО ДОЛГО БУДЕТ, ТАК БЫСТРЕЕ!!!!!
-- И кстате нахуй делать проверку, мой не мой STEAMID, какая хуй разница, я всё равно получаю значение из БД :/
--The script is written by FOER © 2019