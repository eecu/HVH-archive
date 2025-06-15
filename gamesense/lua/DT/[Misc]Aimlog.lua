local globals_realtime = globals.realtime
local globals_curtime = globals.curtime
local globals_frametime = globals.frametime
local globals_absolute_frametime = globals.absoluteframetime
local globals_maxplayers = globals.maxplayers
local globals_tickcount = globals.tickcount
local globals_tickinterval = globals.tickinterval
local globals_mapname = globals.mapname

local client_set_event_callback = client.set_event_callback
local client_console_log = client.log
local client_color_log = client.color_log
local client_console_cmd = client.exec
local client_userid_to_entindex = client.userid_to_entindex
local client_get_cvar = client.get_cvar
local client_set_cvar = client.set_cvar
local client_world_to_screen = client.world_to_screen
local client_latency = client.latency
local client_camera_angles = client.camera_angles
local client_trace_line = client.trace_line
local client_eye_position = client.eye_position
local client_system_time = client.system_time

local entity_get_local_player = entity.get_local_player
local entity_get_all = entity.get_all
local entity_get_players = entity.get_players
local entity_get_classname = entity.get_classname
local entity_set_prop = entity.set_prop
local entity_get_prop = entity.get_prop
local entity_is_enemy = entity.is_enemy
local entity_get_player_name = entity.get_player_name
local entity_get_player_weapon = entity.get_player_weapon
local entity_hitbox_position = entity.hitbox_position
local entity_get_steam64 = entity.get_steam64
local entity_get_bounding_box = entity.get_bounding_box
local entity_is_alive = entity.is_alive
local entity_is_dormant = entity.is_dormant

local ui_new_checkbox = ui.new_checkbox
local ui_new_slider = ui.new_slider
local ui_new_combobox = ui.new_combobox
local ui_new_multiselect = ui.new_multiselect
local ui_new_hotkey = ui.new_hotkey
local ui_new_button = ui.new_button
local ui_new_color_picker = ui.new_color_picker
local ui_reference = ui.reference
local ui_set = ui.set
local ui_get = ui.get
local ui_set_callback = ui.set_callback
local ui_set_visible = ui.set_visible
local ui_is_menu_open = ui.is_menu_open

local math_floor = math.floor
local math_random = math.random
local math_sqrt = math.sqrt
local table_insert = table.insert
local table_remove = table.remove
local table_size = table.getn
local table_sort = table.sort
local string_format = string.format
local string_length = string.len
local string_reverse = string.reverse
local string_sub = string.sub
local aimbotlog_enable = ui.new_checkbox("Rage", "Other", "Advanced aimbot logging")
local on_fire_enable = ui.new_checkbox("Rage", "Other", "Fire log")
local on_fire_colour = ui.new_color_picker("Rage", "Other", "Fire log", 147, 112, 219, 255)
local on_miss_enable = ui.new_checkbox("Rage", "Other", "Miss log")
local on_miss_colour = ui.new_color_picker("Rage", "Other", "Miss log", 255, 253, 166, 255)
local on_damage_enable = ui.new_checkbox("Rage", "Other", "Damage log")
local on_damage_colour = ui.new_color_picker("Rage", "Other", "Damage log", 100, 149, 237, 255)

local function handle_menu()
	if ui_get(aimbotlog_enable) then
		ui_set_visible(on_fire_enable, true)
		ui_set_visible(on_fire_colour, true)
		ui_set_visible(on_miss_enable, true)
		ui_set_visible(on_miss_colour, true)
		ui_set_visible(on_damage_enable, true)
		ui_set_visible(on_damage_colour, true)
	else
		ui_set_visible(on_fire_enable, false)
		ui_set_visible(on_fire_colour, false)
		ui_set_visible(on_miss_enable, false)
		ui_set_visible(on_miss_colour, false)
		ui_set_visible(on_damage_enable, false)
		ui_set_visible(on_damage_colour, false)
	end
end
handle_menu()
ui.set_callback(aimbotlog_enable, handle_menu)

local function on_aim_fire(e)
    if ui_get(aimbotlog_enable) and ui_get(on_fire_enable) and e ~= nil then
    	local r, g, b = ui_get(on_fire_colour)
        local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?"}
        local group = hitgroup_names[e.hitgroup + 1] or "?"
        local tickrate = client.get_cvar("cl_cmdrate") or 64
        local target_name = entity_get_player_name(e.target)
        local ticks = math.floor((e.backtrack * tickrate) + 0.5)

        client_color_log(r, g, b,
        "yeeted ", string.lower(target_name),
        ", hb: ", group,
        "  dmg: ", e.damage,
        "  hc: ", string.format("%d", e.hit_chance),
        "  bt: ", e.backtrack, " (", ticks, " tks)",
        "  hp: ", e.high_priority)
    end
end

local function on_player_hurt(e)
	if ui_get(aimbotlog_enable) and ui_get(on_damage_enable) then
    local attacker_id = client_userid_to_entindex(e.attacker)
    if attacker_id == nil then
        return
    end

    if attacker_id ~= entity_get_local_player() then
        return
    end

    local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?"}
    local group = hitgroup_names[e.hitgroup + 1] or "?"
    local target_id = client_userid_to_entindex(e.userid)
    local target_name = entity_get_player_name(target_id)
    local enemy_health = entity_get_prop(target_id, "m_iHealth")
    local rem_health = enemy_health - e.dmg_health
    if rem_health <= 0 then
        rem_health = 0
    end

    local message = "hit " .. string.lower(target_name) .. ", hb: " .. group .. "  dmg: " .. e.dmg_health .. "  rhp: " .. rem_health
    if rem_health <= 0 then
        message = message .. " (dead)"
    end

    
    local r, g, b = ui_get(on_damage_colour)
    client_color_log(r, g, b, message) 
    end
end

local function on_aim_miss(e)
	if ui_get(aimbotlog_enable) and ui_get(on_miss_enable) and e ~= nil then
	local r, g, b = ui_get(on_miss_colour)
    local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?" }
    local group = hitgroup_names[e.hitgroup + 1] or "?"
    local target_name = entity_get_player_name(e.target)
    local reason
    if e.reason == "?" then
    	reason = "resolver?"
    else
    	reason = e.reason
    end

        client_color_log(r, g, b,
        "missed ", string.lower(target_name),
        ", hb: ", group,
        "  r: ", reason)
    end
end

client.set_event_callback('aim_fire', on_aim_fire)
client.set_event_callback('player_hurt', on_player_hurt)
client.set_event_callback('aim_miss', on_aim_miss)