local client_exec, client_userid_to_entindex, client_set_event_callback, client_random_int, entity_get_local_player = client.exec, client.userid_to_entindex, client.set_event_callback, client.random_int, entity.get_local_player

local killsays = {
  "你的aa比薯片脆",
    "实在不行你去买个模型吧",
    "你猜错了宝贝",
    "你的脑子只适合玩原神?",
    "滚去玩王者荣耀吧窝囊废",
    "你是没有手吗?",
    "Nice miss loser HAAHAH",
    "你的脑容量比你参群人数还少",
    "what was that xd",
    "银行卡密码都被我骗出来了",
    "农村人滚回去种地",
    "你怎么一骗就出了孩子",
    "Hello boy, are you lost?",
    "You're so fat you could be seen through three walls",
    "你在屏幕前红温的样子被我记录下来了",
    "我杀你只需要一根手指",
    "sit down dog",
    "ez",
    "这就死了吗...我都还没开始发力",
    "我没想到你参数这么垃圾...",
    "lol, I turned off the resolver xDD",
    "杀你只需要一根手指",
    "1",
    "1，你怎么这么菜...",
    "你在用otc么废物?",
    "easy xD",
    "1,别急",
    "农民你被你爹1了，滚去买个好点的参数吧",
    "Owned By 5r skc cfg",
    "5r参数击杀了你",
    "你也被脑控了吗",
}

local function onPlayerDeath(e)
	local attacker_entindex = client_userid_to_entindex(e.attacker)
	local victim_entindex   = client_userid_to_entindex(e.userid)
	local local_player 		= entity_get_local_player()

	if attacker_entindex ~= local_player or victim_entindex == local_player then
		return
	end
	
	client_exec("say "..killsays[client_random_int(1, #killsays)])
end

client_set_event_callback("player_death", onPlayerDeath)
