local log = client.log
local uid_to_entindex = client.userid_to_entindex
local entity_get_prop = entity.get_prop
local get_all_players = entity.get_players
local floor = math.floor
local get_localplayer = entity.get_local_player

local table_insert = table.insert
local damage_queue = { }
local getUI = ui.get
local setUI = ui.set

for i = 1,30,1 do 
	damage_queue[i] = { 0 , 0 , 0}
end

local damagelog = ui.new_checkbox("VISUALS", "Player ESP", "Custom Damage Log")



local function vectordistance(x1,y1,z1,x2,y2,z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow( y1 - y2, 2) + math.pow( z1 - z2 , 2) )
end

local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }

local function on_player_hurt(e)
	local attacker_uid = e.attacker
	local hitgroup = e.hitgroup
	local damage = e.dmg_health
	local attacker_entid = uid_to_entindex(attacker_uid)
	local victim_uid = e.userid
	local victim_entid = uid_to_entindex(victim_uid)
	local bestdistance = 100
	local duration = 5
	if attacker_entid == get_localplayer() then
		local originX,originY,originZ = entity_get_prop(victim_entid, "m_vecOrigin")
		local vecViewZ = entity_get_prop(victim_entid, "m_vecViewOffset[2]")
		originZ = originZ + vecViewZ
		
		local screen_width, screen_height = client.screen_size()
		local message = "-" .. damage .. "[" .. hitgroup_names[hitgroup + 1] .. "]"
		table_insert(damage_queue, {globals.realtime(), screen_height / 2 , message})
	end
end

local function on_paint(context)
	if getUI(damagelog) then
		local realtime = globals.realtime()
		for i = 1,#damage_queue do
		if damage_queue[i][1] ~= 0 then
			local screen_width, screen_height = client.screen_size()
			local a = 255
			
					
			damage_queue[i][2] = damage_queue[i][2] - 0.4 * 5
			
			a = (damage_queue[i][2] / screen_height) * 2 * 255
			 if a < 5 then
                damage_queue[i] = { 0 , 0 , 0}
            end
			client.draw_text(context,screen_width / 2, damage_queue[i][2] ,255,255,255,a,"c",0,damage_queue[i][3])
		end
	end
end
end

local function on_round_prestart(e)
	for i = 1,#damage_queue do 
		damage_queue[i] = { 0 , 0 , 0}
	end
end

local function on_round_start(e)
	for i = 1,#damage_queue do 
		damage_queue[i] = { 0 , 0 , 0}
	end
end

local function on_player_spawned(e)
	local userid = e.userid
	local entid = uid_to_entindex(userid)
	if entid == get_localplayer() then
		for i = 1,#damage_queue do 
			damage_queue[i] = { 0 , 0 , 0}
		end
	end
end

local err = client.set_event_callback("round_start", on_round_start) or client.set_event_callback("player_spawned", on_player_spawned) or client.set_event_callback("round_prestart", on_round_prestart) or client.set_event_callback('player_hurt', on_player_hurt) or client.set_event_callback('paint', on_paint) 
			
if err then
    client.log("set_event_callback failed: ", err)
end