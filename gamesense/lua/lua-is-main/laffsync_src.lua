-- local variables for API functions. any changes to the line below will be lost on re-generation
local bit_band, client_camera_angles, client_color_log, client_create_interface, client_delay_call, client_exec, client_eye_position, client_key_state, client_log, client_random_int, client_scale_damage, client_screen_size, client_set_event_callback, client_trace_bullet, client_userid_to_entindex, database_read, database_write, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_hitbox_position, entity_is_alive, entity_is_enemy, math_abs, math_atan2, require, error, globals_absoluteframetime, globals_curtime, globals_realtime, math_atan, math_cos, math_deg, math_floor, math_max, math_min, math_rad, math_sin, math_sqrt, print, renderer_circle_outline, renderer_gradient, renderer_measure_text, renderer_rectangle, renderer_text, renderer_triangle, string_find, string_gmatch, string_gsub, string_lower, table_insert, table_remove, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_hotkey, ui_new_multiselect, ui_reference, tostring, ui_is_menu_open, ui_mouse_position, ui_new_combobox, ui_new_slider, ui_set, ui_set_callback, ui_set_visible, tonumber, pcall = bit.band, client.camera_angles, client.color_log, client.create_interface, client.delay_call, client.exec, client.eye_position, client.key_state, client.log, client.random_int, client.scale_damage, client.screen_size, client.set_event_callback, client.trace_bullet, client.userid_to_entindex, database.read, database.write, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.hitbox_position, entity.is_alive, entity.is_enemy, math.abs, math.atan2, require, error, globals.absoluteframetime, globals.curtime, globals.realtime, math.atan, math.cos, math.deg, math.floor, math.max, math.min, math.rad, math.sin, math.sqrt, print, renderer.circle_outline, renderer.gradient, renderer.measure_text, renderer.rectangle, renderer.text, renderer.triangle, string.find, string.gmatch, string.gsub, string.lower, table.insert, table.remove, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_hotkey, ui.new_multiselect, ui.reference, tostring, ui.is_menu_open, ui.mouse_position, ui.new_combobox, ui.new_slider, ui.set, ui.set_callback, ui.set_visible, tonumber, pcall
local ui_menu_position, ui_menu_size, math_pi, renderer_indicator, entity_is_dormant, client_set_clan_tag, client_trace_line, entity_get_all, entity_get_classname = ui.menu_position, ui.menu_size, math.pi, renderer.indicator, entity.is_dormant, client.set_clan_tag, client.trace_line, entity.get_all, entity.get_classname
local local_player = entity.get_local_player()
local plist_set = plist.get
local vector = require('vector')
local images = require 'gamesense/surface'

local ffi = require('ffi')
local ffi_cast = ffi.cast

local js = panorama.open()
local persona_api = js.MyPersonaAPI
local name = persona_api.GetName()

client.color_log(255, 255, 255, "|--------------------------------------------------------|")
client.color_log(21, 235, 220,  "                       Welcome " .. name .. "!            ")
client.color_log(215, 115, 222, "                   discord.gg/luaterrorist                  ")
client.color_log(235, 221, 21,  "                          7/1/2021            ")
client.color_log(255, 255, 255, "|--------------------------------------------------------|")

local function includes(table, key)
    local state = false
    for i=1, #table do
        if table[i] == key then
            state = true
            break 
        end
    end
    return state
end

local extra_log = function(fn, ...)
	local data = { ... }

	for i=1, #data do
		if i==1 then
			local clr = {
				{ 255, 255, 0 },
				{ 255, 0, 0 },
			}

			client.color_log(clr[fn][1], clr[fn][2], clr[fn][3], ' - \0')
		end

		client.color_log(data[i][1], data[i][2], data[i][3],  string.format('%s\0', data[i][4]))

        if i == #data then
            client.color_log(255, 255, 255, ' ')
        end
	end
end

local create_callback = function(name, func)
    local get_func_index = function(fn)
        return ffi.cast("int*", ffi.cast(ffi.typeof("void*(__thiscall*)(void*)"), fn))[0]
    end

    local DEC_HEX = function(IN)
        local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
        while IN>0 do
            I=I+1
            IN,D=math.floor(IN/B),math.fmod(IN,B)+1
            OUT=string.sub(K,D,D)..OUT
        end
        return OUT
    end

    extra_log(2, { 255, 255, 255, 'Creating ' }, { 0, 255, 255, name .. ' ' }, { 255, 255, 255, 'callback ' }, { 0, 255, 255, string.format('(0x%s)', DEC_HEX(get_func_index(func))) })

    client.delay_call(0.1, function()
        client.set_event_callback(name, func)
    end)
end

local ref = {
	enabled = ui_reference("AA", "Anti-aimbot angles", "Enabled"),
	pitch = ui_reference("AA", "Anti-aimbot angles", "pitch"),
	yawbase = ui_reference("AA", "Anti-aimbot angles", "Yaw base"),
	yaw = { ui_reference("AA", "Anti-aimbot angles", "Yaw") },
    fakeyawlimit = ui_reference("AA", "anti-aimbot angles", "Fake yaw limit"),
    fsbodyyaw = ui_reference("AA", "anti-aimbot angles", "Freestanding body yaw"),
    edgeyaw = ui_reference("AA", "Anti-aimbot angles", "Edge yaw"),
    maxprocticks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
    fakeduck = ui_reference("RAGE", "Other", "Duck peek assist"),
    safepoint = ui_reference("RAGE", "Aimbot", "Force safe point"),
	forcebaim = ui_reference("RAGE", "Other", "Force body aim"),
	player_list = ui_reference("PLAYERS", "Players", "Player list"),
	reset_all = ui_reference("PLAYERS", "Players", "Reset all"),
	apply_all = ui_reference("PLAYERS", "Adjustments", "Apply to all"),
	load_cfg = ui_reference("Config", "Presets", "Load"),
	fl_limit = ui_reference("AA", "Fake lag", "Limit"),
	dt_limit = ui_reference("RAGE", "Other", "Double tap fake lag limit"),

	quickpeek = { ui_reference("RAGE", "Other", "Quick peek assist") },
	yawjitter = { ui_reference("AA", "Anti-aimbot angles", "Yaw jitter") },
	bodyyaw = { ui_reference("AA", "Anti-aimbot angles", "Body yaw") },
	freestand = { ui_reference("AA", "Anti-aimbot angles", "Freestanding") },
	os = { ui_reference("AA", "Other", "On shot anti-aim") },
	slow = { ui_reference("AA", "Other", "Slow motion") },
	dt = { ui_reference("RAGE", "Other", "Double tap") },
	ps = { ui_reference("RAGE", "Other", "Double tap") },
	fakelag = { ui_reference("AA", "Fake lag", "Enabled") }
}

local references = {
	aa_enable = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
	yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
	fyawlimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
	pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
	freestanding_byaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
	safe_point = ui.reference("RAGE", "Aimbot", "Force safe point"),
	double_tap_mode = ui.reference("RAGE", "Other", "Double tap mode"),
	double_tap_fake_lag_limit = ui.reference("RAGE", "Other", "Double tap fake lag limit"),
	double_tap_hc = ui.reference("RAGE", "Other", "Double tap hit chance"),
	fake_lag_type = ui.reference("AA", "Fake lag", "Amount"),
	fake_lag = ui.reference("AA", "Fake lag", "Limit"),
	fake_variance = ui.reference("AA", "Fake lag", "Variance"),
	legmovement = ui.reference("AA", "OTHER", "leg movement"),
	tickstoprocess = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
	holdaim = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks_holdaim"),
	tomi = ui.reference("Rage", "Other", "Force body aim"),
	fakeduck = ui.reference("Rage", "Other", "Duck peek assist"),
	onShot = {ui.reference("AA", "Other", "On shot anti-aim")},
}

local yaw2, yaw = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local bodyyaw, bodyyaw2 = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local jyaw, jyawslide = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")

local variables = {
	legit_changed = false,
	player_states = {"Global", "Standing", "Moving", "Slow motion", "Air", "On-key", "Crouched", "Moving2", "Dormant", "Freestanding"},
	state_to_idx = {["Global"] = 1, ["Standing"] = 2, ["Moving"] = 3, ["Slow motion"] = 4, ["Air"] = 5, ["On-key"] = 6, ["Crouched"] = 7, ["Moving2"] = 8, ["Dormant"] = 9, ["Freestanding"] = 10},
	l_s = {0, 0, 0},
	rec = {},
	aa_dir   = 0,
	auto_rage = false,
	active_i = 1,
	last_press_t = 0,
	forward = false,
	p_state = 0,
	last_sway_time = 0,
	choked_cmds = 0,
	miss = {},
	hit = {},
	shots = {},
	last_hit = {},
	stored_misses = {},
	stored_shots = {},
	last_nn = 0,
	best_value = 180,
	flip_value = 90,
	bestenemy = 0,
	flip_once = false,
	classnames = {
	"CWorld",
	"CCSPlayer",
	"CFuncBrush"
	},
	nonweapons = {
	"knife",
	"hegrenade",
	"inferno",
	"flashbang",
	"decoy",
	"smokegrenade",
	"taser"
	},
}

local nonweapons_c = 
{
	"CKnife",
	"CHEGrenade",
    "CMolotovGrenade",
    "CIncendiaryGrenade",
	"CFlashbang",
	"CDecoyGrenade",
	"CSmokeGrenade",
    "CWeaponTaser",
    "CC4"
}

local mshit = {
	enabled = ui.new_checkbox("AA", "Anti-aimbot angles", "Enable LAFFSYNC"),
	legit_aa_key = ui_new_hotkey("AA", "Anti-aimbot angles", "Legit AA on key"),
	manual_left = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual left"),
	manual_right = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual right"),
	manual_back = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual back"),
	manual_forward = ui_new_hotkey("AA", "Anti-aimbot angles", "Manual forward"),

	freestand = { ui_new_checkbox("AA", "Anti-aimbot angles", "Freestanding\nTS"),
				ui_new_hotkey("AA", "Anti-aimbot angles", "Freestanding key", true),
	},

	edge = { ui_new_checkbox("AA", "Anti-aimbot angles", "Edge yaw\nTS"), 
			ui_new_hotkey("AA", "Anti-aimbot angles", "Edge yaw key", true),
	},

	indicator_enable = ui.new_combobox("AA", "Anti-aimbot angles", "Indicators", { "Off", "On" }),
	extra_indicators = ui.new_checkbox("AA", "Anti-aimbot angles", "Extra Skeet Indicators"),
	visual_arrows = ui.new_checkbox("AA", "Anti-aimbot angles", "Arrow Indication"),
	desync = ui.new_checkbox("AA", "Anti-aimbot angles", "Desync Indicator"),
	desync_where = ui.new_combobox("AA", "Anti-aimbot angles", "Desync Indicator Location", "At Crosshair", "At Indicators"),
	x_slider = ui.new_slider("VISUALS", "Other ESP", "Desync Indicator X offset", 0, 960, 87),
	y_slider = ui.new_slider("VISUALS", "Other ESP", "Desync Indicator Y offset", 0, 540, 20),
	visual_text = ui.new_checkbox("AA", "Anti-aimbot angles", "Text Indication"),
	indicators = ui.new_multiselect("AA", "Anti-aimbot angles", "Indicator list", "AA States", "Doubletap", "Fakeduck", "Safepoint", "Hideshots", "Force body aim", "Fakelag"),

	label = ui.new_label("AA", "Anti-aimbot angles", "Manual AA Arrows Color"),
	color  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color", 194, 87, 116, 255),
	label2 = ui.new_label("AA", "Anti-aimbot angles", "LAFFSYNC Indicator Color"),
	color2  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color2", 147, 52, 235, 255),

	label3 = ui.new_label("AA", "Anti-aimbot angles", "AA Type Color"),
	color3  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color3", 98, 52, 235, 255),

	label9 = ui.new_label("AA", "Anti-aimbot angles", "Doubletap (Not Charged Color)"),
	color9  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color9", 254, 148, 148, 255),

	label10 = ui.new_label("AA", "Anti-aimbot angles", "Doubletap (Charged Color)"),
	color10 = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color10", 148, 252, 153, 255),

	label11 = ui.new_label("AA", "Anti-aimbot angles", "Fakeduck Color"),
	color11  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color11", 255, 255, 255, 255),

	label12 = ui.new_label("AA", "Anti-aimbot angles", "Safepoint Color"),
	color12  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color12", 255, 255, 255, 255),

	label13 = ui.new_label("AA", "Anti-aimbot angles", "Hideshots Color"),
	color13  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color13", 255, 255, 255, 255),

	label14 = ui.new_label("AA", "Anti-aimbot angles", "Force body aim Color"),
	color14  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color13", 255, 255, 255, 255),

	label8 = ui.new_label("AA", "Anti-aimbot angles", "FakeLag Color"),
	color8  = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator color8", 255, 255, 255, 255),
}

local yaw2, yaw = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local bodyyaw, bodyyaw2 = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local quick_peek_box, quick_peek_key = ui.reference( "Rage", "Other", "Quick peek assist" )

local deez_nutz = { }

deez_nutz[0] = {
	deez_nutz_mode = ui_new_combobox("AA", "Anti-aimbot angles", "Anti-aim mode", {"Rage", "Legit", "Automatic rage"}),
	player_state = ui_new_combobox("AA", "Anti-aimbot angles", "Player state", variables.player_states),
}
ui_set_visible(ref.maxprocticks, true)

for i=1, 10 do
	deez_nutz[i] = {
        enable_shit = i == 6 and ui.get(mshit.legit_aa_key) or ui_new_checkbox("AA", "Anti-aimbot angles", "Enable:" .. string_lower(variables.player_states[i]) .. " anti-aim"),
		pitch_shit = ui_new_combobox("AA", "Anti-aimbot angles", "Pitch\n\n Shit" .. variables.player_states[i], { "Off", "Default", "Up", "Down", "Minimal", "Random" }),
		yawbase_shit = ui_new_combobox("AA", "Anti-aimbot angles", "Yaw base\n Shit" .. variables.player_states[i], { "Local view", "At targets" }),
		yaw_shit = ui_new_combobox("AA", "Anti-aimbot angles", "Yaw\n Shit" .. variables.player_states[i], { "Off", "180", "Spin", "Static", "180 Z", "Crosshair" }),
		yawadd_shit = ui_new_slider("AA", "Anti-aimbot angles", "\nYaw add Shit" .. variables.player_states[i], -180, 180, 0),
		yawjitter_shit = ui_new_combobox("AA", "Anti-aimbot angles", "Yaw jitter Shit\n" .. variables.player_states[i], { "Off", "Offset", "Center", "Random" }),
		yawjitteradd_shit = ui_new_slider("AA", "Anti-aimbot angles", "\nYaw jitter add Shit" .. variables.player_states[i], -180, 180, 0),
		aa_mode_shit = ui_new_combobox("AA", "Anti-aimbot angles", "Body yaw type Shit\n" .. variables.player_states[i], {"LAFFSYNC", "GameSense"}),
		gs_bodyyaw_shit = ui_new_combobox("AA", "Anti-aimbot angles", "Body yaw\n GS Shit" .. variables.player_states[i], { "Off", "Opposite", "Jitter", "Static" }),
		gs_bodyyawadd_shit = ui_new_slider("AA", "Anti-aimbot angles", "\nBody yaw add Shit" .. variables.player_states[i], -180, 180, 0),
		bodyyaw_shit = ui_new_combobox("AA", "Anti-aimbot angles", "Body yaw Shit\n" .. variables.player_states[i], { "Off", "Opposite", "Freestanding", "Reversed Freestanding", "Jitter", "Random", "Max", "Max Jitter", "Max Jitter Freestand", "Ideal", "Sigma", "Sigma2", "TibzzyAir", "Random Jitter"}),
		bodyyaw_settings_shit = ui_new_multiselect("AA", "Anti-aimbot angles", "Body yaw settings Shit\n" .. variables.player_states[i], { "Jitter when vulnerable", "Anti-resolver", "Detect missed angle"}),
		fakeyawlimit_shit = ui_new_slider("AA", "Anti-aimbot angles", "Fake yaw limit Shit\n" .. variables.player_states[i], 0, 60, 60),
		fakeyawmode_shit = ui_new_combobox("AA", "Anti-aimbot angles", "Customize fake yaw limit Shit\n" .. variables.player_states[i], { "Off", "Jitter", "Random", "Smart", "Custom right" }),
		fakeyawamt_shit = ui_new_slider("AA", "Anti-aimbot angles", "\nFake yaw randomization Shit" .. variables.player_states[i], 0, 60, 0),
	}
end
ui_set(deez_nutz[1].enable_shit, true)
ui_set_visible(deez_nutz[1].enable_shit, false)

deez_nutz[11] = {
	aa_settings = ui_new_multiselect("AA", "Fake lag", "Anti-aim settings Shit", {"Anti-aim on use", "Disable use to plant"}),
}

for i=1, 64 do
    variables.miss[i], variables.hit[i], variables.shots[i], variables.last_hit[i], variables.stored_misses[i], variables.stored_shots[i] = {}, {}, {}, 0, 0, 0
	for k=1, 3 do
		variables.miss[i][k], variables.hit[i][k], variables.shots[i][k] = {}, {}, {}
		for j=1, 1000 do
			variables.miss[i][k][j], variables.hit[i][k][j], variables.shots[i][k][j] = 0, 0, 0
		end
	end
	variables.miss[i][4], variables.hit[i][4], variables.shots[i][4] = 0, 0, 0
end

local function contains(table, value)

	if table == nil then
		return false
	end
	
    table = ui_get(table)
    for i=0, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end

local function desync_on()
	ui.set(references.aa_enable, true)
end

local function desync_off()
	ui.set(references.aa_enable, false)
end

local jafeth = false
local function delaytimer()
	jafeth = true
end

local function delaytimer2()
	jafeth = false
end

local in_air_ass = false
local function in_air_stuff()
	in_air_ass = true
end
local function in_air_stuff2()
	in_air_ass = false
end
--[[local local_player_fake = ui.reference("Visuals", "Colored models", "Local player fake")

local function cool_onshot_thing()
	ui.set(local_player_fake, false)
end
--]]
local function aimFire()
	if not ui.get(mshit.enabled) then return end
	if variables.p_state == 6 then return end
	
	kneegrow = math.random(1, 5)
	kneegrow2 = math.random(5, 12)

	if not (ui_get(ref.dt[1]) and ui_get(ref.dt[2])) and (ui_get(ref.os[1]) and ui_get(ref.os[2])) or ui.get(ref.fakeduck) then else
	
		--client.delay_call(0.05, desync_off)
		--client.delay_call(0.1, desync_on)
	
		--client.delay_call((kneegrow/100), desync_off)
		--client.delay_call((kneegrow2/100), desync_on)
	end
	
	--[[ui.set(local_player_fake, true)
	client.delay_call(0.1, cool_onshot_thing)--]]
	
	--[[
	
	if jafeth == true then
		jafeth = false
	else
		jafeth = true
	end
	--]]
end
create_callback("aim_fire", aimFire)


local function set_og_menu(state)
	ui_set_visible(ref.enabled, state)
	ui_set_visible(ref.pitch, state)
	ui_set_visible(ref.yawbase, state)
	ui_set_visible(ref.yaw[1], state)
	ui_set_visible(ref.yaw[2], state)
	ui_set_visible(ref.yawjitter[1], state)
	ui_set_visible(ref.yawjitter[2], state)
	ui_set_visible(ref.bodyyaw[1], state)
	ui_set_visible(ref.bodyyaw[2], state)
	ui_set_visible(ref.fakeyawlimit, state)
	ui_set_visible(ref.fsbodyyaw, state)
	ui_set_visible(ref.edgeyaw, state)
	ui_set_visible(ref.freestand[1], state)
	ui_set_visible(ref.freestand[2], state)
end

local function menu_elements()
	variables.active_i = variables.state_to_idx[ui_get(deez_nutz[0].player_state)]
	
	set_og_menu(false)
	
	--[[
	ui_set_visible(deez_nutz[0].player_state, true)
	ui_set_visible(deez_nutz[0].deez_nutz_mode, true)
	ui_set_visible(deez_nutz[11].aa_settings, true)

    for i=1, 10 do
		state = ui.get(mshit.enabled)
		ui_set_visible(deez_nutz[i].enable_shit, variables.active_i == i and i > 1 and state)
		
        ui_set_visible(deez_nutz[i].pitch_shit, variables.active_i == i and state)
		ui_set_visible(deez_nutz[i].yawbase_shit, variables.active_i == i and state)
		ui_set_visible(deez_nutz[i].yaw_shit, variables.active_i == i and state)
		ui_set_visible(deez_nutz[i].yawadd_shit, variables.active_i == i and state)
		ui_set_visible(deez_nutz[i].yawjitter_shit, variables.active_i == i and state)
		ui_set_visible(deez_nutz[i].yawjitteradd_shit, variables.active_i == i and state)

		ui_set_visible(deez_nutz[i].aa_mode_shit, variables.active_i == i and state)

		ui_set_visible(deez_nutz[i].gs_bodyyaw_shit, variables.active_i == i and state)
		ui_set_visible(deez_nutz[i].gs_bodyyawadd_shit, variables.active_i == i and state)

		ui_set_visible(deez_nutz[i].bodyyaw_shit, variables.active_i == i and state)
		ui_set_visible(deez_nutz[i].bodyyaw_settings_shit, variables.active_i == i and state)
		
		ui_set_visible(deez_nutz[i].fakeyawlimit_shit, variables.active_i == i and state)
		ui_set_visible(deez_nutz[i].fakeyawmode_shit, variables.active_i == i and state)
		ui_set_visible(deez_nutz[i].fakeyawamt_shit, variables.active_i == i and state)
	end
	--]]
	
	ui_set_visible(deez_nutz[0].player_state, false)
	ui_set_visible(deez_nutz[0].deez_nutz_mode, false)
	ui_set_visible(deez_nutz[11].aa_settings, false)

    for i=1, 10 do
		state = ui.get(mshit.enabled)
		ui_set_visible(deez_nutz[i].enable_shit, false)
		
        ui_set_visible(deez_nutz[i].pitch_shit, false)
		ui_set_visible(deez_nutz[i].yawbase_shit, false)
		ui_set_visible(deez_nutz[i].yaw_shit, false)
		ui_set_visible(deez_nutz[i].yawadd_shit, false)
		ui_set_visible(deez_nutz[i].yawjitter_shit, false)
		ui_set_visible(deez_nutz[i].yawjitteradd_shit, false)

		ui_set_visible(deez_nutz[i].aa_mode_shit, false)

		ui_set_visible(deez_nutz[i].gs_bodyyaw_shit, false)
		ui_set_visible(deez_nutz[i].gs_bodyyawadd_shit, false)

		ui_set_visible(deez_nutz[i].bodyyaw_shit, false)
		ui_set_visible(deez_nutz[i].bodyyaw_settings_shit, false)
		
		ui_set_visible(deez_nutz[i].fakeyawlimit_shit, false)
		ui_set_visible(deez_nutz[i].fakeyawmode_shit, false)
		ui_set_visible(deez_nutz[i].fakeyawamt_shit, false)
	end
end

local function normalize_yaw(yaw)
	while yaw > 180 do yaw = yaw - 360 end
	while yaw < -180 do yaw = yaw + 360 end
	return yaw
end

local function round(num, decimals)
	local mult = 10^(decimals or 0)
	return math_floor(num * mult + 0.5) / mult
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
	local ydelta = local_y - enemy_y
	local xdelta = local_x - enemy_x
	local relativeyaw = math_atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math_pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
	return relativeyaw
end

local function angle_vector(angle_x, angle_y)
	local sy = math_sin(math_rad(angle_y))
	local cy = math_cos(math_rad(angle_y))
	local sp = math_sin(math_rad(angle_x))
	local cp = math_cos(math_rad(angle_x))
	return cp * cy, cp * sy, -sp
end

local function calc_shit(xdelta, ydelta)
    if xdelta == 0 and ydelta == 0 then
        return 0
	end
	
    return math_deg(math_atan2(ydelta, xdelta))
end

local function get_damage(plocal, enemy, x, y,z)
	local ex = { }
	local ey = { }
	local ez = { }
	ex[0], ey[0], ez[0] = entity_hitbox_position(enemy, 1)
	ex[1], ey[1], ez[1] = ex[0] + 40, ey[0], ez[0]
	ex[2], ey[2], ez[2] = ex[0], ey[0] + 40, ez[0]
	ex[3], ey[3], ez[3] = ex[0] - 40, ey[0], ez[0]
	ex[4], ey[4], ez[4] = ex[0], ey[0] - 40, ez[0]
	ex[5], ey[5], ez[5] = ex[0], ey[0], ez[0] + 40
	ex[6], ey[6], ez[6] = ex[0], ey[0], ez[0] - 40
	local ent, dmg = 0
	for i=0, 6 do
		if dmg == 0 or dmg == nil then
			ent, dmg = client_trace_bullet(enemy, ex[i], ey[i], ez[i], x, y, z)
		end
	end
	return ent == nil and client_scale_damage(plocal, 1, dmg) or dmg
end

local function get_distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
end

local function get_nearest_enemy(plocal, enemies)
	local lx, ly, lz = client_eye_position()
	local view_x, view_y, roll = client_camera_angles()

	local bestenemy = nil
    local fov = 180
    for i=1, #enemies do
        local cur_x, cur_y, cur_z = entity_get_prop(enemies[i], "m_vecOrigin")
        local cur_fov = math_abs(normalize_yaw(calc_shit(lx - cur_x, ly - cur_y) - view_y + 180))
        if cur_fov < fov then
			fov = cur_fov
			bestenemy = enemies[i]
		end
	end

	return bestenemy
end

local function get_entities(enemy_only, alive_only)
	local enemy_only = enemy_only ~= nil and enemy_only or false
    local alive_only = alive_only ~= nil and alive_only or true
    
    local result = {}
    local player_resource = entity.get_player_resource()
    
	for player = 1, globals.maxplayers() do
		if entity.get_prop(player_resource, 'm_bConnected', player) == 1 then
            local is_enemy, is_alive = true, true
            
			if enemy_only and not entity.is_enemy(player) then is_enemy = false end
			if is_enemy then
				if alive_only and entity.get_prop(player_resource, 'm_bAlive', player) ~= 1 then is_alive = false end
				if is_alive then table.insert(result, player) end
			end
		end
	end

	return result
end

local function is_valid(nn)
	if nn == 0 then
		return false
	end

	if not entity_is_alive(nn) then
		return false
	end

	if entity_is_dormant(nn) then
		return false
	end

	return true
end

local function enemy_visible(idx)
    for i=0, 8 do
        local cx, cy, cz = entity_hitbox_position(idx, i)
        if client.visible(cx, cy, cz) then
            return true
        end
    end
    return false
end

local function get_best_desync()
	local plocal = entity.get_local_player()
	
    local lx, ly, lz = client_eye_position()
	local view_x, view_y, roll = client_camera_angles()
	
	local players = entity_get_players(true)
	
	local enemies_visible = false
	
	for i=1, #players do
        local idx = players[i]

        if enemy_visible(idx) then
            enemies_visible = true
        end
	end

	local enemies = entity_get_players(true)

	if #enemies == 0 then
		if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Opposite" then
			variables.best_value = 180
		elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Jitter" then
			variables.best_value = 0
		else
			if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Random" then
				variables.best_value = math.random(20, 60)
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Random Jitter" then
				variables.best_value = math.random(20, 60)
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Sigma" then
				variables.best_value = -95
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Sigma2" then
				variables.best_value = 95
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "TibzzyAir" then
				variables.best_value = 98
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max" then
				variables.best_value = 180
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter" then
				variables.best_value = 180
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter Freestand" then
				variables.best_value = -180
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Ideal" then
				variables.best_value = -141
			else
				variables.best_value = 90
			end
		end

		return variables.best_value
    end

	variables.bestenemy = is_valid(variables.last_nn) and variables.last_nn or get_nearest_enemy(plocal, enemies)

    if variables.bestenemy ~= nil and variables.bestenemy ~= 0 and entity_is_alive(variables.bestenemy) then
        local calc_hit = variables.last_hit[variables.bestenemy] ~= 0 and contains(deez_nutz[variables.p_state].bodyyaw_settings_shit, "Anti-resolver")
        local calc_miss = variables.miss[variables.bestenemy][4] > 0 and contains(deez_nutz[variables.p_state].bodyyaw_settings_shit, "Anti-resolver")

		if not calc_hit and not calc_miss then
            local e_x, e_y, e_z = entity_hitbox_position(variables.bestenemy, 0)

            local yaw = calc_angle(lx, ly, e_x, e_y)
            local rdir_x, rdir_y, rdir_z = angle_vector(0, (yaw + 90))
			local rend_x = lx + rdir_x * 10
            local rend_y = ly + rdir_y * 10
            
            local ldir_x, ldir_y, ldir_z = angle_vector(0, (yaw - 90))
			local lend_x = lx + ldir_x * 10
            local lend_y = ly + ldir_y * 10
            
			local r2dir_x, r2dir_y, r2dir_z = angle_vector(0, (yaw + 90))
			local r2end_x = lx + r2dir_x * 100
			local r2end_y = ly + r2dir_y * 100

			local l2dir_x, l2dir_y, l2dir_z = angle_vector(0, (yaw - 90))
			local l2end_x = lx + l2dir_x * 100
            local l2end_y = ly + l2dir_y * 100      
			
			local ldamage = get_damage(plocal, variables.bestenemy, rend_x, rend_y, lz)
			local rdamage = get_damage(plocal, variables.bestenemy, lend_x, lend_y, lz)

			local l2damage = get_damage(plocal, variables.bestenemy, r2end_x, r2end_y, lz)
			local r2damage = get_damage(plocal, variables.bestenemy, l2end_x, l2end_y, lz)

			if not variables.auto_rage and ldamage > 0 and rdamage > 0 and contains(deez_nutz[variables.p_state].bodyyaw_settings_shit, "Jitter when vulnerable") then
				variables.best_value = 0
			else
				if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Opposite" then
					variables.best_value = 180
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Jitter" then
					variables.best_value = 0
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Sigma" then
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = -95
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = 95
						end
					end
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Sigma2" then
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = -95
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = 95
						end
					end
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "TibzzyAir" then
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = -98
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = 98
						end
					end
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Random" then
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = math.random(-60, 0)
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = math.random(0, 60)
						end
					end
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Random Jitter" then
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = math.random(20, 60)
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = math.random(-60, -20)
						end
					end
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max" then
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = -180
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = 180
						end
					end
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter" then
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = -180
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = 180
						end
					end
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter Freestand" then
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = 180
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = -180
						end
					end
				elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Ideal" then
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = -141
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = 141
						end
					end
				else
					if enemies_visible then else
						if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
							variables.best_value = ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Freestanding" and -90 or 90
						elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
							variables.best_value = ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Freestanding" and 90 or -90
						end
					end
				end
			end
        elseif calc_hit then
			if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Ideal" then
				variables.best_value = variables.last_hit[variables.bestenemy] == -141 and 141 or -141
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max" then
				variables.best_value = variables.last_hit[variables.bestenemy] == 180 and -180 or 180
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Random" then
				variables.best_value = variables.last_hit[variables.bestenemy] == math.random(0, 60) and math.random(-60, 0) or math.random(0, 60)
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Random Jitter" then
				variables.best_value = variables.last_hit[variables.bestenemy] == math.random(20, 60) and math.random(-60, -20) or math.random(20, 60)
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter" then
				variables.best_value = variables.last_hit[variables.bestenemy] == -180 and 180 or -180
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter Freestand" then
				variables.best_value = variables.last_hit[variables.bestenemy] == 180 and -180 or 180
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Sigma" then
				variables.best_value = variables.last_hit[variables.bestenemy] == -95 and 95 or -95
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Sigma2" then
				variables.best_value = variables.last_hit[variables.bestenemy] == 95 and -95 or 95
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "TibzzyAir" then
				variables.best_value = variables.last_hit[variables.bestenemy] == 98 and -98 or 98
			else
				variables.best_value = variables.last_hit[variables.bestenemy] == 90 and -90 or 90
			end
        elseif calc_miss then
			if variables.stored_misses[variables.bestenemy] ~= variables.miss[variables.bestenemy][4] then
                variables.best_value = variables.miss[variables.bestenemy][2][variables.miss[variables.bestenemy][4]]
                variables.stored_misses[variables.bestenemy] = variables.miss[variables.bestenemy][4]
            end
        end
	else
		if not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Opposite" then
			variables.best_value = 180
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Jitter" then
			variables.best_value = 0
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Ideal" then
			variables.best_value = -141
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Sigma" then
			variables.best_value = -95
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Sigma2" then
			variables.best_value = 95
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "TibzzyAir" then
			variables.best_value = 98
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max" then
			variables.best_value = 180
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Random" then
			variables.best_value = math.random(0, 60)
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Random Jitter" then
			variables.best_value = math.random(20, 60)
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter" then
			variables.best_value = -180
		elseif not variables.auto_rage and ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter Freestand" then
			variables.best_value = 180
		else
			variables.best_value = 90
		end
	end
	
    return variables.best_value
end

local function run_direction()

	ui_set(ref.freestand[2], "Always on")
	ui_set(mshit.manual_back, "On hotkey")
	ui_set(mshit.manual_forward, "On hotkey")
	ui_set(mshit.manual_left, "On hotkey")
	ui_set(mshit.manual_right, "On hotkey")
	
	local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1 and not client.key_state(0x20)
	local p_key = ui.get(mshit.legit_aa_key)

	local fs_e = ui_get(mshit.freestand[2]) and ui_get(mshit.freestand[1]) and on_ground and not p_key
	local edge_e = ui_get(mshit.edge[2]) and ui_get(mshit.edge[1]) and on_ground and not p_key
	
	ui_set(ref.freestand[1], fs_e and "Default" or "-")
	ui_set(ref.edgeyaw, edge_e)

	if fs_e then
		variables.last_press_t = globals_curtime()
		variables.aa_dir = 0
	end
	
	if ui_get(mshit.manual_back) then
		variables.aa_dir = 0
	elseif ui_get(mshit.manual_right) and variables.last_press_t + 0.2 < globals_curtime() then
		variables.aa_dir = variables.aa_dir == 90 and 0 or 90
		variables.last_press_t = globals_curtime()
	elseif ui_get(mshit.manual_left) and variables.last_press_t + 0.2 < globals_curtime() then
		variables.aa_dir = variables.aa_dir == -90 and 0 or -90
		variables.last_press_t = globals_curtime()
	elseif ui_get(mshit.manual_forward) and variables.last_press_t + 0.2 < globals_curtime() then
		variables.aa_dir = variables.aa_dir == 180 and 0 or 180
		variables.last_press_t = globals_curtime()
	elseif variables.last_press_t > globals_curtime() then
		variables.last_press_t = globals_curtime()
	end
end

local timeToShoot = 0
local shooting = false
local record_shit = 10
local function run_shit(c)
	local has_knife
	local vx, vy, vz = entity_get_prop(entity.get_local_player(), "m_vecVelocity")
	local is_scoped = entity_get_prop(entity.get_local_player(), "m_bIsScoped")
	local p_still = math_sqrt(vx ^ 2 + vy ^ 2) < 2
	local p_still2 = math_sqrt(vx ^ 2 + vy ^ 2) < 90
	local on_ground = bit_band(entity_get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1 and c.in_jump == 0
	local p_slow = ui_get(ref.slow[1]) and ui_get(ref.slow[2])
	local p_key = ui.get(mshit.legit_aa_key)
	local p_duck = entity.get_prop(entity.get_local_player(), "m_flDuckAmount")
	local weapon = entity.get_player_weapon(entity.get_local_player())
    local weapon_id = bit_band(entity_get_prop(weapon, "m_iItemDefinitionIndex"), 0xFFFF)
	local camera_angles = vector(client_camera_angles())
    local eye_position_x, eye_position_y, eye_position_z = client_eye_position()
	local hitbox_pos_x, hitbox_pos_y, hitbox_pos_z = entity_hitbox_position(entity.get_local_player(), 0)
    local substract = hitbox_pos_z - eye_position_z
	local local_player_weapon = entity.get_player_weapon(entity.get_local_player())
	local cur = globals.curtime()
	
	shooting = false
	
    if cur < entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") then
		if weapon_id == 9 then
			timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur - 1.2
		elseif weapon_id == 40 then
			timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur - 1
		elseif weapon_id == 64 then
			timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur - 0.2
		else
			timeToShoot = entity.get_prop(local_player_weapon, "m_flNextPrimaryAttack") - cur - 0.08 --shooting
		end
		shooting = true
    elseif cur < entity.get_prop(entity.get_local_player(), "m_flNextAttack") then
        timeToShoot = entity.get_prop(entity.get_local_player(), "m_flNextAttack") - cur - 0.022 --swapping
	end
	
	--client.log(record_shit)
	--client.log(weapon_id)
	--client.log(timeToShoot)

    if math.floor((timeToShoot * 1000) + 0.5) <= 10 then
        timeToShoot = 0
    end

    if timeToShoot > 1.9 then
        timeToShoot = 0
    end
	
	--client.log(shooting)
	--client.log(timeToShoot)
	--client.log(substract)

	local fs_e = ui_get(mshit.freestand[2]) and ui_get(mshit.freestand[1]) and on_ground and not p_key
	local nigger = math.random(0, 2) -- 0, 10
	variables.p_state = p_key and 6 or 9
	
	local enemies = get_entities(true, true)
	
    for i=1, #enemies do
        local player = enemies[i]
        local px, py, pz = entity.get_prop(player, "m_vecOrigin")
		local lx, ly, lz = entity_get_prop(entity.get_local_player(), "m_vecOrigin")
        local distance = get_distance(lx, ly, lz, px, py, pz)
		
		if px == nil or py == nil or pz == nil or lx == nil or ly == nil or lz == nil or distance == nil then 
			ass = false 
		else 
			ass = true 
		end
		
        local weapon = entity.get_player_weapon(player)
		
		--if p_key or ((entity_get_classname(weapon) == "CKnife" and distance <= 270) and variables.aa_dir ~= 180 and ass) then
		
		if entity_get_classname(weapon) == "CKnife" and distance <= 270 and variables.aa_dir ~= 180 and ass then
			has_knife = true
		else
			has_knife = false
		end
		
		if p_key or has_knife then  --if ((substract > -4) and on_ground and not (p_duck >= 0.7) and not p_key) or not entity.is_alive(player) and not p_key then
			variables.p_state = 6
		else
			--if timeToShoot >= 0.022 or not entity.is_alive(player) then
				--variables.p_state = 9
			--else
				if not on_ground and ui_get(deez_nutz[5].enable_shit) then
					variables.p_state = 5
				else
					if fs_e then
						variables.p_state = 10
					else
						if (p_duck >= 0.7 or ui.get(references.fakeduck)) and ui_get(deez_nutz[7].enable_shit) then
							variables.p_state = 7
						else
							if p_slow and ui_get(deez_nutz[4].enable_shit) and not p_still then
								variables.p_state = 4
							else
								if p_still and ui_get(deez_nutz[2].enable_shit) then
									variables.p_state = 2
								elseif not p_still and ui_get(deez_nutz[3].enable_shit) and ui_get(deez_nutz[8].enable_shit) then
									if is_scoped == 1 then -- and not p_still2 then
										variables.p_state = 8
									else
										variables.p_state = 3
									end
								end
							end
						end
					end
				end
			--end
		end
	end
end

create_callback("pre_render", function()
	if not entity.is_alive(entity.get_local_player()) or not ui.get(ref.enabled) then else
		on_ground = bit_band(entity_get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1
		entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, on_ground and 0 or 6) --legs
	end
end)

local function distance3d(x1, y1, z1, x2, y2, z2)
	return math_sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))
end

local function entity_has_c4(ent)
	local bomb = entity_get_all("CC4")[1]
	return bomb ~= nil and entity_get_prop(bomb, "m_hOwnerEntity") == ent
end

local function aa_on_use(c)

	if contains(deez_nutz[11].aa_settings, "Anti-aim on use") then
		local distance = 100
		local bomb = entity_get_all("CPlantedC4")[1]
		local bomb_x, bomb_y, bomb_z = entity_get_prop(bomb, "m_vecOrigin")

		if bomb_x ~= nil then
			local player_x, player_y, player_z = entity_get_prop(entity.get_local_player(), "m_vecOrigin")
			distance = distance3d(bomb_x, bomb_y, bomb_z, player_x, player_y, player_z)
		end
		
		local team_num = entity_get_prop(entity.get_local_player(), "m_iTeamNum")
		local defusing = team_num == 3 and distance < 62

		local on_bombsite = entity_get_prop(entity.get_local_player(), "m_bInBombZone")

		local has_bomb = entity_has_c4(entity.get_local_player())
		local trynna_plant = on_bombsite ~= 0 and team_num == 2 and has_bomb and not contains(deez_nutz[11].aa_settings, "Disable use to plant")
		
		local px, py, pz = client_eye_position()
		local pitch, yaw = client_camera_angles()
	
		local sin_pitch = math_sin(math_rad(pitch))
		local cos_pitch = math_cos(math_rad(pitch))
		local sin_yaw = math_sin(math_rad(yaw))
		local cos_yaw = math_cos(math_rad(yaw))

		local dir_vec = { cos_pitch * cos_yaw, cos_pitch * sin_yaw, -sin_pitch }

		local fraction, entindex = client_trace_line(entity.get_local_player(), px, py, pz, px + (dir_vec[1] * 8192), py + (dir_vec[2] * 8192), pz + (dir_vec[3] * 8192))

		local using = true

		if entindex ~= nil then
			for i=0, #variables.classnames do
				if entity_get_classname(entindex) == variables.classnames[i] then
					using = false
				end
			end
		end

		if not using and not trynna_plant and not defusing then
			c.in_use = 0
		end
	end
end

local function handle_shots()
	local enemies = entity_get_players(true)

	for i=1, #enemies do
		local idx = enemies[i]
		local s = variables.shots[idx][4]
		local h = variables.hit[idx][4]

		if s ~= variables.stored_shots[idx] then
			local missed = true
			
			if variables.shots[idx][1][s] == variables.hit[idx][1][h] then
				if variables.hit[idx][2][h] ~= 0 and variables.hit[idx][2][h] ~= 180 then
					variables.last_hit[idx] = variables.hit[idx][2][h]
				end
				missed = false
			end

			if missed then
				variables.last_hit[idx] = 0
				variables.hit[idx][2][h] = 0
				variables.miss[idx][4] = variables.miss[idx][4] + 1
				variables.miss[idx][2][variables.miss[idx][4]] = variables.shots[idx][2][s]
			end

			variables.last_nn = idx
			variables.stored_shots[idx] = s
		end
	end
end

local OldChoke = 0
--local toDraw5 = 0
local toDraw4 = 0
local toDraw3 = 0
local toDraw2 = 0
local toDraw1 = 0
local toDraw0 = 0
local angle = 0

local function fakelag_visuals(c)
	if c.chokedcommands < OldChoke then --sent
		toDraw0 = toDraw1
		toDraw1 = toDraw2
		toDraw2 = toDraw3
		toDraw3 = toDraw4
		toDraw4 = OldChoke
		--toDraw5 = ui.get(ref.fake_variance)
	end
	OldChoke = c.chokedcommands
	
	if c.chokedcommands == 0 then
		angle = math.min(57, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60))
	end
end

local testnigger = 0
local best_desync = 0
local function on_setup_command(c)

    if not ui_get(ref.enabled) then
        return
	end

	run_shit(c)
	run_direction()
	handle_shots()
	aa_on_use(c)
	--doubletap()
	fakelag_visuals(c)
	
	best_desync = get_best_desync()

	k = { ui_get(mshit.legit_aa_key) }

	doubletapping = ui_get(ref.dt[1]) and ui_get(ref.dt[2])
	onshotaa = ui_get(ref.os[1]) and ui_get(ref.os[2])
	low_legit_fl = ui_get(ref.fl_limit) < 3 and ui_get(deez_nutz[0].deez_nutz_mode) == "Legit"
	exploiting = doubletapping or onshotaa or low_legit_fl

	holding_e = (k[1] and k[3] == 69) or (variables.auto_rage and client_key_state(69))
	yaw_to_add = holding_e and 0 or variables.aa_dir
	
	variables.forward = ui_get(ref.yaw[2]) == 180

	if ui_get(deez_nutz[0].deez_nutz_mode) == "Rage" then
		ui_set(ref.pitch, ui_get(deez_nutz[variables.p_state].pitch_shit))
		ui_set(ref.yawbase, variables.aa_dir == 180 and "At targets" or variables.aa_dir == 0 and ui_get(deez_nutz[variables.p_state].yawbase_shit) or "Local view")
		ui_set(ref.yaw[1], ui_get(deez_nutz[variables.p_state].yaw_shit))
		ui_set(ref.yaw[2], normalize_yaw(ui_get(deez_nutz[variables.p_state].yawadd_shit) + yaw_to_add))
		ui_set(ref.yawjitter[1], ui_get(deez_nutz[variables.p_state].yawjitter_shit))
		ui_set(ref.yawjitter[2], ui_get(deez_nutz[variables.p_state].yawjitteradd_shit))
	elseif holding_e or ui_get(deez_nutz[0].deez_nutz_mode) == "Legit" then
		ui_set(ref.pitch, "Off")
		ui_set(ref.yawbase, "Local view")
		ui_set(ref.yaw[1], "Off")
		ui_set(ref.yaw[2], 180)
	else
		ui_set(ref.pitch, "Default")
		ui_set(ref.yawbase, variables.aa_dir == 0 and "At targets" or "Local view")
		ui_set(ref.yaw[1], "180")
		ui_set(ref.yaw[2], yaw_to_add)
		ui_set(ref.yawjitter[1], "Off")
	end

	local fakelimit = ui_get(deez_nutz[variables.p_state].fakeyawlimit_shit)
	local fakemode = ui_get(deez_nutz[variables.p_state].fakeyawmode_shit)
	local fakeamt = ui_get(deez_nutz[variables.p_state].fakeyawamt_shit)

	if fakemode == "Jitter" then
		fakelimit = testnigger == 1 and fakeamt or fakelimit
	elseif fakemode == "Random" then
		fakelimit = client_random_int(math_max(math_min(60, fakelimit - fakeamt), 0), fakelimit)
	elseif fakemode == "Smart" then
		fakelimit = best_desync == 90 and 40 or fakelimit
	end
	
	if testnigger == 0 then
		testnigger = 1
	else
		testnigger = 0
	end

	ui_set(ref.fakeyawlimit, holding_e and 60 or fakelimit)


	if ui_get(deez_nutz[variables.p_state].aa_mode_shit) == "LAFFSYNC" then
		if ui_get(deez_nutz[variables.p_state].bodyyaw_shit) ~= "Off" then
			if best_desync == 0 or best_desync == 180 then
				ui_set(ref.bodyyaw[1], best_desync == 0 and "Jitter" or "Opposite")
				ui_set(ref.bodyyaw[2], 0)
			elseif ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter" or ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Max Jitter Freestand" or ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Sigma" or ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "Random Jitter" or ui_get(deez_nutz[variables.p_state].bodyyaw_shit) == "TibzzyAir" then
				ui_set(ref.bodyyaw[1], "Jitter")
				ui_set(ref.bodyyaw[2], variables.forward and -best_desync or best_desync)
			else
				ui_set(ref.bodyyaw[1], "Static")
				ui_set(ref.bodyyaw[2], variables.forward and -best_desync or best_desync)
			end
		else
			ui_set(ref.bodyyaw[1], "Off")
		end
	else
		ui_set(ref.bodyyaw[1], ui_get(deez_nutz[variables.p_state].gs_bodyyaw_shit))
		ui_set(ref.bodyyaw[2], ui_get(deez_nutz[variables.p_state].gs_bodyyawadd_shit))
	end
	
	variables.choked_cmds = c.chokedcommands
	set_og_menu(false)
end

local function doubletap_charged()
    -- Make sure we have doubletap enabled, are holding our doubletap key & we aren't fakeducking.
    if not ui_get(ref.dt[1]) or not ui_get(ref.dt[2]) or ui.get(references.fakeduck) then return false end

    -- Sanity checks on local player (since paint & a few other events run even when dead).
    if not entity.is_alive(entity.get_local_player()) or entity.get_local_player() == nil then return end

    -- Get our local players weapon.
    local weapon = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")

    -- Make sure that it is valid.
    if weapon == nil then return false end

    -- Basic definitions used to calculate if we have recently shot or swapped weapons.
    local next_attack = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.25
	local jewfag = entity.get_prop(weapon, "m_flNextPrimaryAttack")
	
	if jewfag == nil then return end
	
    local next_primary_attack = jewfag + 0.5

    -- Make sure both values are valid.
    if next_attack == nil or next_primary_attack == nil then return false end

    -- Return if both are under 0 meaning our doubletap is charged / we can fire (you can also use these values as a 2nd return parameter to get the charge %).
    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end

local function on_paint()
    if not ui.get(mshit.enabled) or ui.get(mshit.indicator_enable) == "Off" or entity.get_local_player() == nil or not entity.is_alive(entity.get_local_player()) then return end
	
	screen = {client.screen_size()}
	center = {screen[1]/2, screen[2]/2}
	
	h_index = 0

    color_g = {ui.get(mshit.color)}
	color_g2 = {ui.get(mshit.color2)}
	color_g3 = {ui.get(mshit.color3)}
	color_g8 = {ui.get(mshit.color8)}
	color_g9 = {ui.get(mshit.color9)}
	color_g10 = {ui.get(mshit.color10)}
	color_g11 = {ui.get(mshit.color11)}
	color_g12 = {ui.get(mshit.color12)}
	color_g13 = {ui.get(mshit.color13)}
	color_g14 = {ui.get(mshit.color14)}
	
	if ui.get(mshit.visual_arrows) then
		--renderer.text(center[1], center[2] + 43, 45, 45, 45, 75, "cb+", 0, "⮟" )
		renderer.text(center[1] - 43, center[2] - 3, 45, 45, 45, 75, "c+d", 0, "⮜" )
		renderer.text(center[1] + 43, center[2] - 3, 45, 45, 45, 75, "c+d", 0, "⮞" )

		--if mode == "back" then
		--renderer.text(center[1], center[2] + 43, color_g[1], color_g[2], color_g[3], color_g[4], "cb+", 0, "⮟" )
		if variables.aa_dir == -90 then
			renderer.text(center[1] - 43, center[2] - 3, color_g[1], color_g[2], color_g[3], color_g[4], "c+d", 0, "⮜" )
		elseif variables.aa_dir == 90 then
			renderer.text(center[1] + 43, center[2] - 3, color_g[1], color_g[2], color_g[3], color_g[4], "c+d", 0, "⮞" )
		end
	end

	if ui.get(mshit.visual_text) then	
		renderer.text(center[1], center[2] + 17,  color_g2[1], color_g2[2], color_g2[3], color_g2[4], "c-d", 0, "LAFFSYNC" )
		
		if includes(ui.get(mshit.indicators), "AA States") then
			if variables.p_state == 2 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "c-d", 0, "NORMAL" )
			elseif variables.p_state == 4 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "c-d", 0, "LOW DELTA")
			elseif variables.p_state == 3 or variables.p_state == 8 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "c-d", 0, "OPPOSITE" )
			elseif variables.p_state == 5 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "c-d", 0, "JITTER" )
			elseif variables.p_state == 6 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "c-d", 0, "LEGIT" )
			elseif variables.p_state == 7 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "c-d", 0, "CROUCHED" )
			elseif variables.p_state == 9 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "c-d", 0, "DORMANT" )
			elseif variables.p_state == 10 then
				renderer.text(center[1], center[2] + 25 + (h_index * 12), color_g3[1], color_g3[2], color_g3[3], color_g3[4], "c-d", 0, "FREESTANDING" )
			end
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Doubletap") and ui_get(ref.dt[1]) and ui_get(ref.dt[2]) then
			if doubletap_charged() then
				renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g10[1], color_g10[2], color_g10[3], color_g10[4], "c-d", 0, "DOUBLETAP")
			else
				renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g9[1], color_g9[2], color_g9[3], color_g9[4], "c-d", 0, "DOUBLETAP")
			end
			local weapon = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")
			local next_attack = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.25
			local jewfag = entity.get_prop(weapon, "m_flNextPrimaryAttack")
			
			if jewfag == nil then return end
			
			local next_primary_attack = jewfag + 0.5
			
			if next_primary_attack - globals.curtime() < 0 and next_attack - globals.curtime() < 0 then
				nigaro = 0
			else
				nigaro = next_primary_attack - globals.curtime()
			end
			
			local jewjewjew = math.abs((nigaro * 10/6) - 1)

			renderer.circle_outline(center[1] + 28, center[2] + 25 + (h_index * 8), 0, 0, 0, jewjewjew == 1 and 1 or color_g10[4], 3, 270, 5, 1)
			renderer.circle_outline(center[1] + 28, center[2] + 25 + (h_index * 8), color_g9[1], color_g9[2], color_g9[3], jewjewjew == 1 and 1 or 255, 3, 270, jewjewjew, 1)
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Fakeduck") and ui.get(references.fakeduck) then
			local duck_amt = entity.get_prop(entity.get_local_player(), "m_flDuckAmount")
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g11[1], color_g11[2], color_g11[3], color_g11[4] - duck_amt * 155, "c-d", 0, "DUCK")
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Safepoint") and ui.get(references.safe_point) then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g12[1], color_g12[2], color_g12[3], color_g12[4], "c-d", 0, "SAFE")
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Hideshots") and ui.get(references.onShot[1]) and ui.get(references.onShot[2]) then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g13[1], color_g13[2], color_g13[3], color_g13[4], "c-d", 0, "HIDE")
			h_index = h_index + 1
		end

		if includes(ui.get(mshit.indicators), "Force body aim") and ui.get(references.tomi) then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g14[1], color_g14[2], color_g14[3], color_g14[4], "c-d", 0, "BAIM")
			h_index = h_index + 1
		end
		
		if includes(ui.get(mshit.indicators), "Fakelag") then
			renderer.text(center[1], center[2] + 25 + (h_index * 8), color_g8[1], color_g8[2], color_g8[3], color_g8[4], "c-d", 0, string.format('%i-%i-%i-%i-%i' ,toDraw4,toDraw3,toDraw2,toDraw1,toDraw0) )
			--renderer.text(center[1], center[2] + 37, color_g8[1], color_g8[2], color_g8[3], color_g8[4], "-c", 0, string.format('%i-%i-%i-%i-%i %d' ,toDraw4,toDraw3,toDraw2,toDraw1,toDraw0, toDraw5) )
			h_index = h_index + 1
		end
	end
	
	if ui.get(mshit.extra_indicators) then
		if ui.get(references.onShot[1]) and ui.get(references.onShot[2]) then
			cy = renderer.indicator(141, 232, 49, 255, "HS")+ui.get(mshit.y_slider)
		end
		
		if ui.get(references.tomi) then
			cy = renderer.indicator(235, 146, 52, 255, "FB")+ui.get(mshit.y_slider)
		end
		
		if ui.get(references.safe_point) then
			cy = renderer.indicator(50, 123, 168, 255, "SP")+ui.get(mshit.y_slider)
		end
	end

	if ui.get(mshit.desync) and entity.is_alive(entity.get_local_player()) then
		color = { 255-(angle*2.29824561404), angle*3.42105263158, angle*0.22807017543 }	
		--renderer.text(center[1] + 25, center[2] + 25 + (h_index * 8), 255, 255,255,255, "cb", 0, jewfaggotnigger)

		y = renderer.indicator(color[1], color[2], color[3], 255, "FAKE")+ui.get(mshit.y_slider)
		x = ui.get(mshit.x_slider)
		if ui.get(mshit.desync_where) == "At Crosshair" then
			renderer.circle_outline(center[1], center[2], 0, 0, 0, 155, 7, 270, 5, 3)
			renderer.circle_outline(center[1], center[2], color[1], color[2], color[3], 255, 7, 270, angle*0.01754385964, 3)
		end
		if ui.get(mshit.desync_where) == "At Indicators" then
			renderer.circle_outline(x, y, 0, 0, 0, 155, 10, 0, 1, 5)
			renderer.circle_outline(x, y, color[1], color[2], color[3], 255, 10, 0, angle*0.01754385964, 5)
		end
	end
end

local function entity_get_eye_pos(ent)
    local x, y, z = entity_hitbox_position(ent, 0)
    local x1, y1, z1 = entity_get_prop(ent, "m_vecOrigin")
    return x1, y1, z
end

local function dist_between(a, b, copy)

    if copy == nil then
        copy = false
    end

    if copy then
        b = { b[1], b[2], a[3] }
    end

    local val = (a[1]-b[1]) + (a[2]-b[2]) + (a[3]-b[3])

    if val < 0 then
        val = val*0.75
    end

    return val
end

local function dist_from_3dline(shooter, e)
	local x, y, z = entity_get_eye_pos(shooter)
	local x1, y1, z1 = entity_get_eye_pos(entity.get_local_player())

	--point
	local p = {x1,y1,z1}

	--line
	local a = {x,y,z}
	local b = {e.x,e.y,e.z}

	--line delta
	local ab = {b[1] - a[1], b[2] - a[2], b[3] - a[3]}

	--line length
	local len = math_sqrt(ab[1]^2 + ab[2]^2 + ab[3]^2)

	--line delta / line legth
	local d  = {ab[1] / len, ab[2] / len, ab[3] / len}

	--point to line origin delta
	local ap = {p[1] - a[1], p[2] - a[2], p[3] - a[3]}

	--direction
	local d2 = d[1]*ap[1] + d[2]*ap[2] + d[3]*ap[3]

	--closest point on line to point
	variables.ls = {a[1] + d2 * d[1], a[2] + d2 * d[2], a[3] + d2 * d[3]}

	--distance from closest point to point
	return dist_between(variables.ls, p, true)
end

local function dist_2d(shooter, plocal, e)
	local x, y, z = entity_get_eye_pos(shooter)
	local x1, y1, z1 = entity_get_eye_pos(plocal)

	return ((e.y - y)*x1 - (e.x - x)*y1 + e.x*y - e.y*x) / math_sqrt((e.y-y)^2 + (e.x - x)^2)
end

local function shot_at_player(d, point, enemy, plocal, e)
    local head = { entity_get_eye_pos(plocal) }
    local origin = { entity_get_prop(plocal, "m_vecOrigin") }

    --shot over our head / under our feet
    if point[3] > head[3] + 10 or point[3] < origin[3] then
        return false
    end

    --where tf
    if math_abs(dist_2d(enemy, plocal, e)) > 300 then
        return false
    end

    --its close enough
    if math_abs(d) < 30 then
        return true
    end

    --check if enemy is using extended bt
    local ping = entity_get_prop(entity.get_player_resource(), "m_iPing", enemy) 
    local last_rec = 14 - (ping * globals.tickinterval())
    
    if #variables.rec >= last_rec then
        local pos = variables.rec[last_rec]

        if pos == nil then
            return false
        end

        local bt_dist = dist_between(pos, head, true)

        return (d < 0 and (d > bt_dist) or (d < bt_dist)) and (math_abs(d) < math_abs(bt_dist)) or (math_abs(d) > math_abs(bt_dist))
    end

    return false
end

local function on_bullet_impact(e)
	local shooter = client_userid_to_entindex(e.userid)

	if not entity_is_enemy(shooter) or not entity_is_alive(entity.get_local_player()) then
		return
	end

	local d = dist_from_3dline(shooter, e)

	if shot_at_player(d, variables.ls, shooter, entity.get_local_player(), e) then
		local dsy = variables.forward and (ui_get(ref.bodyyaw[2]) * -1) or ui_get(ref.bodyyaw[2])

		local previous_record = variables.shots[shooter][1][variables.shots[shooter][4]] == globals_curtime()
		variables.shots[shooter][4] = previous_record and variables.shots[shooter][4] or variables.shots[shooter][4] + 1

		variables.shots[shooter][1][variables.shots[shooter][4]] = globals_curtime()

		local dtc = contains(deez_nutz[variables.p_state].bodyyaw_settings_shit, "Detect missed angle") or dsy == 0 or dsy == 180

		if dtc then
			variables.shots[shooter][2][variables.shots[shooter][4]] = math_abs(d) > 0.5 and (d < 0 and best_desync or -best_desync) or dsy
		else
			variables.shots[shooter][2][variables.shots[shooter][4]] = (best_desync == best_desync and -best_desync or best_desync)
		end
	end
end

local hitgroup_names = { 'generic', 'head', 'chest', 'stomach', 'left arm', 'right arm', 'left leg', 'right leg', 'neck', '?', 'gear' }
local function on_player_hurt(e)
	local victim = client_userid_to_entindex(e.userid)
	local attacker = client_userid_to_entindex(e.attacker)

	if not entity_is_enemy(attacker) or not entity_is_alive(entity.get_local_player()) then
		return
	end
	
	--[[
		if client.userid_to_entindex(userid) == entity.get_local_player() then 
			local hitbox_hit = e.hitgroup
		end
		
		if hitbox_hit ~= 1 then
			return
		end
	--]]
	
	for i=1, #variables.nonweapons do
		if e.weapon == variables.nonweapons[i] then
			return
		end
	end

	local dsy = variables.forward and (ui_get(ref.bodyyaw[2]) * -1) or ui_get(ref.bodyyaw[2])

	variables.hit[attacker][4] = variables.hit[attacker][4] + 1
	variables.hit[attacker][1][variables.hit[attacker][4]] = globals_curtime()
	variables.hit[attacker][2][variables.hit[attacker][4]] = victim ~= entity.get_local_player() and 0 or dsy
	variables.hit[attacker][3][variables.hit[attacker][4]] = e.hitgroup
end

local function reset_data(keep_hit)
	for i=1, 64 do -- 64
		variables.last_hit[i], variables.stored_misses[i], variables.stored_shots[i] = (keep_hit and variables.hit[i][2][variables.hit[i][4]] ~= 0) and variables.hit[i][2][variables.hit[i][4]] or 0, 0, 0
		for k=1, 3 do
			for j=1, 100 do --1000
				variables.miss[i][k][j], variables.hit[i][k][j], variables.shots[i][k][j] = 0, 0, 0
			end
		end
		variables.miss[i][4], variables.hit[i][4], variables.shots[i][4], variables.last_nn, variables.best_value = 0, 0, 0, 0, 180
	end
end

local ref_md = ui_reference("RAGE", "Aimbot", "Minimum damage")

local function is_auto_vis(local_player,lx,ly,lz,px,py,pz)
	entindex,dmg = client_trace_bullet(local_player,lx,ly,lz,px,py,pz)
	if entindex == nil then
		return false
	end
	if entindex == local_player then
		return false
	end
	if not entity_is_enemy(entindex) then
		return false
	end
		if dmg >  ref_md then
			return true
		else
			return false
		end
end

local function trace_positions(px,py,pz,px1,py1,pz1,px2,py2,pz2,lx2,ly2,lz2)
	if is_auto_vis(local_player,lx2,ly2,lz2,px,py,pz) then
		return true
	end
	if is_auto_vis(local_player,lx2,ly2,lz2,px1,py1,pz1) then
		return true
	end
	if is_auto_vis(local_player,lx2,ly2,lz2,px2,py2,pz2) then
		return true
	end
	return false
end

local function extrapolate_position(xpos,ypos,zpos,ticks,ent)
	x,y,z = entity_get_prop(ent, "m_vecVelocity")
	for i=0, ticks do
		xpos =  xpos + (x*globals.tickinterval())
		ypos =  ypos + (y*globals.tickinterval())
		zpos =  zpos + (z*globals.tickinterval())
	end
	return xpos,ypos,zpos
end

local function disable_aa()
	--global
	ui_set(deez_nutz[1].pitch_shit, "Off")
	ui_set(deez_nutz[1].yawbase_shit, "Local view")
	ui_set(deez_nutz[1].yaw_shit, "Off")
	ui_set(deez_nutz[1].yawadd_shit, 0)
	ui_set(deez_nutz[1].yawjitter_shit, "Off")
	ui_set(deez_nutz[1].yawjitteradd_shit, 0)
	ui_set(deez_nutz[1].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[1].bodyyaw_shit, "Off")
	ui_set(deez_nutz[1].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[1].fakeyawmode_shit, "Off")
	
	ui_set(deez_nutz[2].enable_shit, false)
	ui_set(deez_nutz[3].enable_shit, false)
	ui_set(deez_nutz[4].enable_shit, false)
	ui_set(deez_nutz[5].enable_shit, false)
	ui_set(deez_nutz[6].enable_shit, false)
	ui_set(deez_nutz[7].enable_shit, false)
	ui_set(deez_nutz[8].enable_shit, false)
	ui_set(deez_nutz[9].enable_shit, false)
	ui_set(deez_nutz[10].enable_shit, false)
	
	ui_set(references.fake_lag_type, "Dynamic")
	ui_set(references.fake_variance, 0)
	ui_set(deez_nutz[11].aa_settings, {"-"})
	
	ui_set(ref.enabled, false)
end

local marcel = 0
local function enable_aa()
	local p_slow = ui_get(ref.slow[1]) and ui_get(ref.slow[2])
	local p_duck = entity.get_prop(entity.get_local_player(), "m_flDuckAmount")
	local vx, vy, vz = entity_get_prop(entity.get_local_player(), "m_vecVelocity")
	local p_still2 = math_sqrt(vx ^ 2 + vy ^ 2) < 90
	local p_still3 = math_sqrt(vx ^ 2 + vy ^ 2) < 50
	local velocity_speed = math.sqrt((vx * vx) + (vy * vy))
	
	local lua_hc_score_ref = (velocity_speed / 720) * 250
	
	if lua_hc_score_ref > 60 then
		lua_hc_score_ref = 60
	end

	marcel = marcel + 1
	
	if marcel > 20 then
		marcel = 0
	end

	--global
	ui_set(deez_nutz[1].pitch_shit, "Default") -- pitch
	ui_set(deez_nutz[1].yawbase_shit, "At targets") -- at targets or local view
	ui_set(deez_nutz[1].yaw_shit, "Off") -- yaw
	ui_set(deez_nutz[1].yawadd_shit, 0) -- yaw ammount
	ui_set(deez_nutz[1].yawjitter_shit, "Off") -- yaw jitter
	ui_set(deez_nutz[1].yawjitteradd_shit, 0) -- yaw jitter slider
	ui_set(deez_nutz[1].aa_mode_shit, "LAFFSYNC") -- keep this to LAFFSYNC
	ui_set(deez_nutz[1].bodyyaw_shit, "Off") -- Freestanding, Reversed Freestanding, Jitter, Opposite, Random, Max, Max Jitter, Max Jitter Freestand, Ideal, Sigma
	ui_set(deez_nutz[1].fakeyawlimit_shit, 59) -- Fake yaw amt (desync)
	ui_set(deez_nutz[1].fakeyawmode_shit, "Off") -- Random = math.random, Jitter = it goes to ur value in the fake yaw, then back to the value below
	ui_set(deez_nutz[1].fakeyawamt_shit, 45) -- how much you math.random or jitter.
	
	--standing
	ui_set(deez_nutz[2].enable_shit, true)
	ui_set(deez_nutz[2].pitch_shit, "Default")
	ui_set(deez_nutz[2].yawbase_shit, "At targets")
	ui_set(deez_nutz[2].yaw_shit, "180")
	ui_set(deez_nutz[2].yawadd_shit, 10)
	ui_set(deez_nutz[2].yawjitter_shit, "Off")
	ui_set(deez_nutz[2].yawjitteradd_shit, 0)
	ui_set(deez_nutz[2].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[2].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[2].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[2].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[2].fakeyawmode_shit, "Jitter")
	ui_set(deez_nutz[2].fakeyawamt_shit, 45)
	
	--[[
	--moving
	ui_set(deez_nutz[3].enable_shit, true)
	ui_set(deez_nutz[3].pitch_shit, "Default")
	ui_set(deez_nutz[3].yawbase_shit, "At targets")
	ui_set(deez_nutz[3].yaw_shit, "180")
	ui_set(deez_nutz[3].yawadd_shit, 5)
	ui_set(deez_nutz[3].yawjitter_shit, "Center")
	ui_set(deez_nutz[3].yawjitteradd_shit, -23)
	ui_set(deez_nutz[3].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[3].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[3].bodyyaw_settings_shit, {"Detect missed angle"})
	ui_set(deez_nutz[3].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[3].fakeyawamt_shit, 0)

	--moving
	ui_set(deez_nutz[3].enable_shit, true)
	ui_set(deez_nutz[3].pitch_shit, "Default")
	ui_set(deez_nutz[3].yawbase_shit, "At targets")
	ui_set(deez_nutz[3].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[3].yawadd_shit, 12)
	else
		ui_set(deez_nutz[3].yawadd_shit, -12)
	end
	ui_set(deez_nutz[3].yawjitter_shit, "Center")
	ui_set(deez_nutz[3].yawjitteradd_shit, -23)
	ui_set(deez_nutz[3].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[3].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[3].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[3].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[3].fakeyawamt_shit, 0)
	--]]
	
	--moving
	--[[
	if p_still3 then
		ui_set(deez_nutz[3].enable_shit, true)
		ui_set(deez_nutz[3].pitch_shit, "Default")
		ui_set(deez_nutz[3].yawbase_shit, "At targets")
		ui_set(deez_nutz[3].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[3].yawadd_shit, 12)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		else
			ui_set(deez_nutz[3].yawadd_shit, -7)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		end
		ui_set(deez_nutz[3].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[3].bodyyaw_shit, "Freestanding")
		ui_set(deez_nutz[3].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[3].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[3].fakeyawamt_shit, 57)
	else
		ui_set(deez_nutz[3].enable_shit, true)
		ui_set(deez_nutz[3].pitch_shit, "Default")
		ui_set(deez_nutz[3].yawbase_shit, "At targets")
		ui_set(deez_nutz[3].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[3].yawadd_shit, 5)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		else
			ui_set(deez_nutz[3].yawadd_shit, 10)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		end
		ui_set(deez_nutz[3].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[3].bodyyaw_shit, "Max Jitter Freestand")
		ui_set(deez_nutz[3].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[3].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[3].fakeyawamt_shit, 57)
	end
	
		--moving
		ui_set(deez_nutz[3].enable_shit, true)
		ui_set(deez_nutz[3].pitch_shit, "Default")
		ui_set(deez_nutz[3].yawbase_shit, "At targets")
		ui_set(deez_nutz[3].yaw_shit, "180")
		if variables.best_value == -95 then
			ui_set(deez_nutz[3].yawadd_shit, 0)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		else
			ui_set(deez_nutz[3].yawadd_shit, 0)
			ui_set(deez_nutz[3].yawjitteradd_shit, 0)
			ui_set(deez_nutz[3].yawjitter_shit, "Off")
		end
		ui_set(deez_nutz[3].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[3].bodyyaw_shit, "Sigma2") -- sigma2 --opposite
		ui_set(deez_nutz[3].bodyyaw_settings_shit, {"Anti-resolver", "Jitter when vulnerable"})
		ui_set(deez_nutz[3].fakeyawlimit_shit, 45) --60 --45
		ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[3].fakeyawamt_shit, 57)
	--]]
	--[[
		--moving
		ui_set(deez_nutz[3].enable_shit, true)
		ui_set(deez_nutz[3].pitch_shit, "Default")
		ui_set(deez_nutz[3].yawbase_shit, "At targets")
		ui_set(deez_nutz[3].yaw_shit, "180")
		ui_set(deez_nutz[3].yawadd_shit, 0)
		ui_set(deez_nutz[3].yawjitteradd_shit, 0)
		ui_set(deez_nutz[3].yawjitter_shit, "Off")
		ui_set(deez_nutz[3].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[3].bodyyaw_shit, "Reversed Freestanding") -- sigma2 --opposite
		ui_set(deez_nutz[3].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[3].fakeyawlimit_shit, 60) --60 --45
		ui_set(deez_nutz[3].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[3].fakeyawamt_shit, 57)
	-]]
	--standing
	ui_set(deez_nutz[3].enable_shit, true)
	ui_set(deez_nutz[3].pitch_shit, "Default")
	ui_set(deez_nutz[3].yawbase_shit, "At targets")
	ui_set(deez_nutz[3].yaw_shit, "180")
	ui_set(deez_nutz[3].yawadd_shit, 10)
	ui_set(deez_nutz[3].yawjitter_shit, "Off")
	ui_set(deez_nutz[3].yawjitteradd_shit, 0)
	ui_set(deez_nutz[3].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[3].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[3].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[3].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[3].fakeyawmode_shit, "Jitter")
	ui_set(deez_nutz[3].fakeyawamt_shit, 45)
	--[[
	--moving (scoped)
		ui_set(deez_nutz[8].enable_shit, true)
		ui_set(deez_nutz[8].pitch_shit, "Default")
		ui_set(deez_nutz[8].yawbase_shit, "At targets")
		ui_set(deez_nutz[8].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[8].yawadd_shit, 20)
			ui_set(deez_nutz[8].yawjitteradd_shit, -5)
			ui_set(deez_nutz[8].fakeyawlimit_shit, 60)
		else
			ui_set(deez_nutz[8].yawadd_shit, -7)
			ui_set(deez_nutz[8].yawjitteradd_shit, lua_hc_score_ref)
			ui_set(deez_nutz[8].fakeyawlimit_shit, 60)
		end
		ui_set(deez_nutz[8].yawjitter_shit, "Center")
		ui_set(deez_nutz[8].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[8].bodyyaw_shit, "Freestanding")
		ui_set(deez_nutz[8].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[8].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[8].fakeyawamt_shit, 35)
	--]]
	--[[
	--moving (scoped)
	if p_still2 then
		ui_set(deez_nutz[8].enable_shit, true)
		ui_set(deez_nutz[8].pitch_shit, "Default")
		ui_set(deez_nutz[8].yawbase_shit, "At targets")
		ui_set(deez_nutz[8].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[8].yawadd_shit, 20)
			ui_set(deez_nutz[8].yawjitteradd_shit, -5)
		else
			ui_set(deez_nutz[8].yawadd_shit, -5)
			ui_set(deez_nutz[8].yawjitteradd_shit, 5)	
		end
		ui_set(deez_nutz[8].yawjitter_shit, "Center")
		ui_set(deez_nutz[8].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[8].bodyyaw_shit, "Freestanding")
		ui_set(deez_nutz[8].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[8].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[8].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[8].fakeyawamt_shit, 35)
	else
		ui_set(deez_nutz[8].enable_shit, true)
		ui_set(deez_nutz[8].pitch_shit, "Default")
		ui_set(deez_nutz[8].yawbase_shit, "At targets")
		ui_set(deez_nutz[8].yaw_shit, "180")
		if variables.best_value == -90 then
			ui_set(deez_nutz[8].yawadd_shit, 0)
			ui_set(deez_nutz[8].yawjitteradd_shit, 0)
			ui_set(deez_nutz[8].yawjitter_shit, "Off")
		else
			ui_set(deez_nutz[8].yawadd_shit, 0)
			ui_set(deez_nutz[8].yawjitteradd_shit, 0)
			ui_set(deez_nutz[8].yawjitter_shit, "Off")
		end
		ui_set(deez_nutz[8].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[8].bodyyaw_shit, "Max Jitter Freestand")
		ui_set(deez_nutz[8].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[8].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[8].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[8].fakeyawamt_shit, 57)
	end
	--]]
		--moving (scoped)
		ui_set(deez_nutz[8].enable_shit, true)
		ui_set(deez_nutz[8].pitch_shit, "Default")
		ui_set(deez_nutz[8].yawbase_shit, "At targets")
		ui_set(deez_nutz[8].yaw_shit, "180")
		ui_set(deez_nutz[8].yawadd_shit, 0)
		ui_set(deez_nutz[8].yawjitteradd_shit, 0)
		ui_set(deez_nutz[8].yawjitter_shit, "Off")
		ui_set(deez_nutz[8].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[8].bodyyaw_shit, "Reversed Freestanding") --sigma2 --opposite
		ui_set(deez_nutz[8].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[8].fakeyawlimit_shit, 60) --60 --45
		ui_set(deez_nutz[8].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[8].fakeyawamt_shit, 57)
	
	--[[
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -5)
		ui_set(deez_nutz[4].yawjitteradd_shit, 7)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 60)
	else
		ui_set(deez_nutz[4].yawadd_shit, 5)
		ui_set(deez_nutz[4].yawjitteradd_shit, 7)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 60)
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Center")
	ui_set(deez_nutz[4].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[4].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawamt_shit, 45)
	ui_set(deez_nutz[4].fakeyawmode_shit, "Random")
	
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -10)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 45)
	else
		ui_set(deez_nutz[4].yawadd_shit, 10)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 45)
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Center")
	ui_set(deez_nutz[4].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[4].bodyyaw_shit, "Reversed Freestanding")
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawamt_shit, 30)
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	
	
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -11)
		ui_set(deez_nutz[4].yawjitteradd_shit, 3)
	else
		ui_set(deez_nutz[4].yawadd_shit, 11)
		ui_set(deez_nutz[4].yawjitteradd_shit, 3)
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Off")
	ui_set(deez_nutz[4].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[4].bodyyaw_shit, "Freestanding") --Freestanding
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[4].fakeyawamt_shit, 25)
	
	
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -20)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 15)
	else
		ui_set(deez_nutz[4].yawadd_shit, 9)
		ui_set(deez_nutz[4].yawjitteradd_shit, 0)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 35)	
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Offset")
	ui_set(deez_nutz[4].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[4].bodyyaw_shit, "Freestanding") --Freestanding
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[4].fakeyawamt_shit, 25)
	
	
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, 0)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 42)
	else
		ui_set(deez_nutz[4].yawadd_shit, 7)
		ui_set(deez_nutz[4].yawjitteradd_shit, -5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 42)	
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Random")
	ui_set(deez_nutz[4].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[4].bodyyaw_shit, "Ideal")
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[4].fakeyawamt_shit, 25)
	
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -90 then
		ui_set(deez_nutz[4].yawadd_shit, -7)
		ui_set(deez_nutz[4].yawjitteradd_shit, 5)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 35)
	else
		ui_set(deez_nutz[4].yawadd_shit, 0)
		ui_set(deez_nutz[4].yawjitteradd_shit, -7)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 15)
	end
	ui_set(deez_nutz[4].yawjitter_shit, "Offset")
	ui_set(deez_nutz[4].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[4].bodyyaw_shit, "Reversed Freestanding") --Freestanding
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[4].fakeyawamt_shit, 25)
	--]]

	--[[
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	ui_set(deez_nutz[4].yawadd_shit, 7) -- 7
	ui_set(deez_nutz[4].yawjitteradd_shit, -7)
	ui_set(deez_nutz[4].yawjitter_shit, "Offset")
	ui_set(deez_nutz[4].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[4].bodyyaw_shit, "Sigma") --Freestanding
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"-"})
	ui_set(deez_nutz[4].fakeyawlimit_shit, 25)
	ui_set(deez_nutz[4].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[4].fakeyawamt_shit, 25)
	--]]
		
	--slow motion
	ui_set(deez_nutz[4].enable_shit, true)
	ui_set(deez_nutz[4].pitch_shit, "Default")
	ui_set(deez_nutz[4].yawbase_shit, "At targets")
	ui_set(deez_nutz[4].yaw_shit, "180")
	if variables.best_value == -95 then
		ui_set(deez_nutz[4].yawadd_shit, 0)
		ui_set(deez_nutz[4].yawjitter_shit, "Offset")
		ui_set(deez_nutz[4].yawjitteradd_shit, -3)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 37)
		ui_set(deez_nutz[4].fakeyawmode_shit, "Random")
		ui_set(deez_nutz[4].fakeyawamt_shit, 33)
	else
		ui_set(deez_nutz[4].yawadd_shit, -5)
		ui_set(deez_nutz[4].yawjitter_shit, "Random")
		ui_set(deez_nutz[4].yawjitteradd_shit, -4)
		ui_set(deez_nutz[4].fakeyawlimit_shit, 25)
		ui_set(deez_nutz[4].fakeyawmode_shit, "Random")
		ui_set(deez_nutz[4].fakeyawamt_shit, 25)
	end
	ui_set(deez_nutz[4].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[4].bodyyaw_shit, "Sigma")
	ui_set(deez_nutz[4].bodyyaw_settings_shit, {"Anti-resolver"})
	--ui_set(deez_nutz[4].fakeyawlimit_shit, 59)
	
	--[[
	--air
	ui_set(deez_nutz[5].enable_shit, true)
	ui_set(deez_nutz[5].pitch_shit, "Default")
	ui_set(deez_nutz[5].yawbase_shit, "At targets")
	ui_set(deez_nutz[5].yaw_shit, "180")
	if variables.best_value == -180 or variables.best_value ==180 then
		ui_set(deez_nutz[5].yawadd_shit, -12)
		ui_set(deez_nutz[5].yawjitteradd_shit, 0) --30
		ui_set(deez_nutz[5].fakeyawlimit_shit, 60)
	else
		ui_set(deez_nutz[5].yawadd_shit, 9)
		ui_set(deez_nutz[5].yawjitteradd_shit, 0) --30
		ui_set(deez_nutz[5].fakeyawlimit_shit, 60)
	end
	ui_set(deez_nutz[5].yawjitter_shit, "Off")
	ui_set(deez_nutz[5].aa_mode_shit, "LAFFSYNC")
	if not in_air_ass then
		ui_set(deez_nutz[5].bodyyaw_shit, "Reversed Freestanding")
		client.delay_call(0.15, in_air_stuff)
	else
		ui_set(deez_nutz[5].bodyyaw_shit, "Freestanding")
		client.delay_call(0.15, in_air_stuff2)
	end
	
	--ui_set(deez_nutz[5].bodyyaw_shit, "Jitter")
	--ui_set(deez_nutz[5].bodyyaw_settings_shit, {"Anti-resolver", "Detect missed angle"})
	ui_set(deez_nutz[5].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[5].fakeyawamt_shit, 50)
	
	--air
	ui_set(deez_nutz[5].enable_shit, true)
	ui_set(deez_nutz[5].pitch_shit, "Default")
	ui_set(deez_nutz[5].yawbase_shit, "At targets")
	ui_set(deez_nutz[5].yaw_shit, "180")
	ui_set(deez_nutz[5].yawadd_shit, 9)
	ui_set(deez_nutz[5].yawjitteradd_shit, 0) --30
	ui_set(deez_nutz[5].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[5].yawjitter_shit, "Off")
	ui_set(deez_nutz[5].aa_mode_shit, "LAFFSYNC")
	if not in_air_ass then
		ui_set(deez_nutz[5].bodyyaw_shit, "Reversed Freestanding")
		client.delay_call(0.15, in_air_stuff)
	else
		ui_set(deez_nutz[5].bodyyaw_shit, "Freestanding")
		client.delay_call(0.15, in_air_stuff2)
	end
	ui_set(deez_nutz[5].bodyyaw_settings_shit, {"Anti-resolver", "Detect missed angle"})
	ui_set(deez_nutz[5].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[5].fakeyawamt_shit, 50)
	--]]
	
	
	--air
	ui_set(deez_nutz[5].enable_shit, true)
	ui_set(deez_nutz[5].pitch_shit, "Default")
	ui_set(deez_nutz[5].yawbase_shit, "At targets")
	ui_set(deez_nutz[5].yaw_shit, "180")
	ui_set(deez_nutz[5].yawadd_shit, 0)
	ui_set(deez_nutz[5].yawjitteradd_shit, 0) --30
	ui_set(deez_nutz[5].yawjitter_shit, "Off")
	ui_set(deez_nutz[5].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[5].bodyyaw_shit, "Max")
	ui_set(deez_nutz[5].bodyyaw_settings_shit, {"Anti-resolver", "Detect missed angle"})
	ui_set(deez_nutz[5].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[5].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[5].fakeyawamt_shit, 50)
	
	
	--[[
	--on-key
	ui_set(deez_nutz[6].enable_shit, true)
	ui_set(deez_nutz[6].pitch_shit, "Off")
	ui_set(deez_nutz[6].yawbase_shit, "At targets")
	ui_set(deez_nutz[6].yaw_shit, "180")
	ui_set(deez_nutz[6].yawadd_shit, 180)
	ui_set(deez_nutz[6].yawjitter_shit, "Off")
	ui_set(deez_nutz[6].yawjitteradd_shit, 0)
	ui_set(deez_nutz[6].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[6].bodyyaw_shit, "Freestanding")
	ui_set(deez_nutz[6].bodyyaw_settings_shit, {"Detect missed angle"})
	ui_set(deez_nutz[6].fakeyawlimit_shit, 59)
	ui_set(deez_nutz[6].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[6].fakeyawamt_shit, 0)
	--]]
	
	
	--on-key
	ui_set(deez_nutz[6].enable_shit, true)
	ui_set(deez_nutz[6].pitch_shit, "Off")
	ui_set(deez_nutz[6].yawbase_shit, "At targets")
	ui_set(deez_nutz[6].yaw_shit, "180")
	ui_set(deez_nutz[6].yawadd_shit, 180)
	ui_set(deez_nutz[6].yawjitter_shit, "Off")
	ui_set(deez_nutz[6].yawjitteradd_shit, 0)
	ui_set(deez_nutz[6].aa_mode_shit, "LAFFSYNC")
	--if p_slow or p_duck >= 0.7 or p_still2 then
	ui_set(deez_nutz[6].bodyyaw_shit, "Freestanding")
	--else
		--ui_set(deez_nutz[6].bodyyaw_shit, "Max Jitter")
	--end
	ui_set(deez_nutz[6].bodyyaw_settings_shit, {"Detect missed angle"})
	ui_set(deez_nutz[6].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[6].fakeyawmode_shit, "Jitter")
	ui_set(deez_nutz[6].fakeyawamt_shit, 59)
	
	if entity.get_prop(entity.get_local_player(), 'm_iTeamNum') == 2 then --t side crouching
		--- T SIDE
		--crouched
		--[[
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Default")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		ui_set(deez_nutz[7].yawadd_shit, 0)
		ui_set(deez_nutz[7].yawjitter_shit, "Off")
		ui_set(deez_nutz[7].yawjitteradd_shit, 0)
		ui_set(deez_nutz[7].aa_mode_shit, "LAFFSYNC")
		if p_still2 then
			ui_set(deez_nutz[7].bodyyaw_shit, "Reversed Freestanding")
		else
			ui_set(deez_nutz[7].bodyyaw_shit, "Jitter")
		end
		ui_set(deez_nutz[7].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[7].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 5)
		--]]
		
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Down")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		ui_set(deez_nutz[7].yawadd_shit, 3)
		ui_set(deez_nutz[7].yawjitter_shit, "Off")
		ui_set(deez_nutz[7].yawjitteradd_shit, 0)
		ui_set(deez_nutz[7].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[7].bodyyaw_shit, "Reversed Freestanding") --Sigma2
		ui_set(deez_nutz[7].bodyyaw_settings_shit, {"Anti-resolver", "Jitter when vulnerable"}) -- {"Anti-resolver", "Jitter when vulnerable"})
		ui_set(deez_nutz[7].fakeyawlimit_shit, 43)
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 5)
	else --CT SIDE	
		--crouched
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Default")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		ui_set(deez_nutz[7].yawadd_shit, 0)
		ui_set(deez_nutz[7].yawjitter_shit, "Center")
		ui_set(deez_nutz[7].yawjitteradd_shit, math.random(-3, 19))
		ui_set(deez_nutz[7].aa_mode_shit, "Gamesense")
		ui_set(deez_nutz[7].gs_bodyyaw_shit, "Jitter")
		ui_set(deez_nutz[7].gs_bodyyawadd_shit, math.random(-7, 13))
		ui_set(deez_nutz[7].fakeyawlimit_shit, math.random(38, 55))
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 5)
		
		--[[
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Default")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		if variables.best_value <= -90 then
			ui_set(deez_nutz[7].yawadd_shit, -5)
		else
			ui_set(deez_nutz[7].yawadd_shit, 10) --10
		end
		ui_set(deez_nutz[7].yawjitter_shit, "Off")
		ui_set(deez_nutz[7].yawjitteradd_shit, 0)
		ui_set(deez_nutz[7].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[7].bodyyaw_shit, "Freestanding")
		ui_set(deez_nutz[7].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[7].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 25)
		--]]
		--[[
		--CT SIDE
		--crouched
		ui_set(deez_nutz[7].enable_shit, true)
		ui_set(deez_nutz[7].pitch_shit, "Default")
		ui_set(deez_nutz[7].yawbase_shit, "At targets")
		ui_set(deez_nutz[7].yaw_shit, "180")
		ui_set(deez_nutz[7].yawadd_shit, 5)
		ui_set(deez_nutz[7].yawjitter_shit, "Off")
		ui_set(deez_nutz[7].yawjitteradd_shit, 0)
		ui_set(deez_nutz[7].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[7].bodyyaw_shit, "Freestanding")
		ui_set(deez_nutz[7].bodyyaw_settings_shit, {"Anti-resolver"})
		ui_set(deez_nutz[7].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[7].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[7].fakeyawamt_shit, 25)
		--]]
	end
	
	--[[--dormant
	ui_set(deez_nutz[9].enable_shit, true)
	ui_set(deez_nutz[9].pitch_shit, "Default")
	ui_set(deez_nutz[9].yawbase_shit, "At targets")
	ui_set(deez_nutz[9].yaw_shit, "180")
	if variables.best_value <= -90 then
		ui_set(deez_nutz[9].yawadd_shit, 75)
	else
		ui_set(deez_nutz[9].yawadd_shit, -75)
	end
	ui_set(deez_nutz[9].yawjitter_shit, "Center")
	ui_set(deez_nutz[9].yawjitteradd_shit, 180)
	ui_set(deez_nutz[9].aa_mode_shit, "LAFFSYNC")
	if jafeth == true then
		ui_set(deez_nutz[9].bodyyaw_shit, "Max Jitter")
	else
		ui_set(deez_nutz[9].bodyyaw_shit, "Max Jitter Freestand")
	end
	ui_set(deez_nutz[9].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[9].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[9].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[9].fakeyawamt_shit, 25)
	
	--dormant
	ui_set(deez_nutz[9].enable_shit, true)
	ui_set(deez_nutz[9].pitch_shit, "Default")
	ui_set(deez_nutz[9].yawbase_shit, "At targets")
	ui_set(deez_nutz[9].yaw_shit, "180")
	if variables.best_value <= -90 then
		ui_set(deez_nutz[9].yawadd_shit, 12)
	else
		ui_set(deez_nutz[9].yawadd_shit, -12)
	end
	ui_set(deez_nutz[9].yawjitter_shit, "Off")
	ui_set(deez_nutz[9].yawjitteradd_shit, 0)
	ui_set(deez_nutz[9].aa_mode_shit, "LAFFSYNC")
	if jafeth == true then
		ui_set(deez_nutz[9].bodyyaw_shit, "Max Jitter")
	else
		ui_set(deez_nutz[9].bodyyaw_shit, "Max Jitter Freestand")
	end
	ui_set(deez_nutz[9].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[9].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[9].fakeyawmode_shit, "Off")
	ui_set(deez_nutz[9].fakeyawamt_shit, 25)
	
	--dormant
	ui_set(deez_nutz[9].enable_shit, true)
	ui_set(deez_nutz[9].pitch_shit, "Default")
	ui_set(deez_nutz[9].yawbase_shit, "At targets")
	ui_set(deez_nutz[9].yaw_shit, "180")
	if variables.best_value <= -90 then
		ui_set(deez_nutz[9].yawadd_shit, 0)
	else
		ui_set(deez_nutz[9].yawadd_shit, 0)
	end
	ui_set(deez_nutz[9].yawjitter_shit, "Off")
	ui_set(deez_nutz[9].yawjitteradd_shit, 0)
	ui_set(deez_nutz[9].aa_mode_shit, "LAFFSYNC")
	if jafeth == true then
		ui_set(deez_nutz[9].bodyyaw_shit, "Reversed Freestanding")
	else
		ui_set(deez_nutz[9].bodyyaw_shit, "Freestanding")
	end
	ui_set(deez_nutz[9].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[9].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[9].fakeyawmode_shit, "Jitter")
	ui_set(deez_nutz[9].fakeyawamt_shit, 40)
	
	--]]
	if shooting then
		if jafeth == false then
			ui_set(deez_nutz[9].bodyyaw_shit, "Freestanding")
			client.delay_call(0.1, delaytimer)
		else
			ui_set(deez_nutz[9].bodyyaw_shit, "Reversed Freestanding")
			client.delay_call(0.1, delaytimer2)
		end
	end
	
	if shooting then
		--onshot aa
		ui_set(deez_nutz[9].enable_shit, true)
		ui_set(deez_nutz[9].pitch_shit, "Default")
		ui_set(deez_nutz[9].yawbase_shit, "At targets")
		ui_set(deez_nutz[9].yaw_shit, "180")
		ui_set(deez_nutz[9].yawadd_shit, 0)
		ui_set(deez_nutz[9].yawjitter_shit, "Off")
		ui_set(deez_nutz[9].yawjitteradd_shit, 0)
		ui_set(deez_nutz[9].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[9].bodyyaw_settings_shit, {"-"})
		ui_set(deez_nutz[9].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[9].fakeyawmode_shit, "Off")
		ui_set(deez_nutz[9].fakeyawamt_shit, 40)
	else
		--dormant and weapon swap
		ui_set(deez_nutz[9].enable_shit, true)
		ui_set(deez_nutz[9].pitch_shit, "Default")
		ui_set(deez_nutz[9].yawbase_shit, "At targets")
		ui_set(deez_nutz[9].yaw_shit, "180")
		if variables.best_value <= -90 then
			ui_set(deez_nutz[9].yawadd_shit, 0)
		else
			ui_set(deez_nutz[9].yawadd_shit, 0)
		end
		ui_set(deez_nutz[9].yawjitter_shit, "Off")
		ui_set(deez_nutz[9].yawjitteradd_shit, 0)
		ui_set(deez_nutz[9].aa_mode_shit, "LAFFSYNC")
		ui_set(deez_nutz[9].bodyyaw_shit, "Sigma")
		ui_set(deez_nutz[9].bodyyaw_settings_shit, {"-"})
		ui_set(deez_nutz[9].fakeyawlimit_shit, 60)
		ui_set(deez_nutz[9].fakeyawmode_shit, "Random")
		ui_set(deez_nutz[9].fakeyawamt_shit, 60)
	end
	
	--freestanding
	ui_set(deez_nutz[10].enable_shit, true)
	ui_set(deez_nutz[10].pitch_shit, marcel == 1 and "Default" or "Minimal")
	ui_set(deez_nutz[10].yawbase_shit, "At targets")
	ui_set(deez_nutz[10].yaw_shit, "180")
	ui_set(deez_nutz[10].yawadd_shit, 0)
	ui_set(deez_nutz[10].yawjitter_shit, "Off")
	ui_set(deez_nutz[10].yawjitteradd_shit, 5)
	ui_set(deez_nutz[10].aa_mode_shit, "LAFFSYNC")
	ui_set(deez_nutz[10].bodyyaw_shit, "Jitter")
	ui_set(deez_nutz[10].bodyyaw_settings_shit, {"Anti-resolver"})
	ui_set(deez_nutz[10].fakeyawlimit_shit, 60)
	ui_set(deez_nutz[10].fakeyawmode_shit, "Jitter")
	ui_set(deez_nutz[10].fakeyawamt_shit, 20)

	ui_set(deez_nutz[11].aa_settings, {"Anti-aim on use", "Disable use to plant"})
	
	ui_set(ref.enabled, true)
end

local function paint_ui()
	if ui.get(mshit.enabled) then
		ui.set_visible(mshit.legit_aa_key, true)
		ui.set_visible(mshit.manual_back, true)
		ui.set_visible(mshit.manual_forward, true)
		ui.set_visible(mshit.manual_left, true)
		ui.set_visible(mshit.manual_right, true)
		ui.set_visible(mshit.freestand[1], true)
		ui.set_visible(mshit.freestand[2], true)
		ui.set_visible(mshit.edge[1], true)
		ui.set_visible(mshit.edge[2], true)
		ui.set_visible(mshit.indicator_enable, true)
	else
		ui.set_visible(mshit.legit_aa_key, false)
		ui.set_visible(mshit.manual_back, false)
		ui.set_visible(mshit.manual_forward, false)
		ui.set_visible(mshit.manual_left, false)
		ui.set_visible(mshit.manual_right, false)
		ui.set_visible(mshit.freestand[1], false)
		ui.set_visible(mshit.freestand[2], false)
		ui.set_visible(mshit.edge[1], false)
		ui.set_visible(mshit.edge[2], false)
		ui.set_visible(mshit.indicator_enable, false)
		ui.set(mshit.indicator_enable, "Off")
	end

	ui.set_visible(references.tickstoprocess, true)
	
	turnedon = ui.get(mshit.desync)
	ui.set_visible(mshit.desync_where, turnedon)
	ui.set_visible(mshit.x_slider, turnedon)
	ui.set_visible(mshit.y_slider, turnedon)
	
	if ui.get(mshit.indicator_enable) == "On" then
		ui.set_visible(mshit.extra_indicators, true)
		ui.set_visible(mshit.visual_arrows, true)
		ui.set_visible(mshit.visual_text, true)
		ui.set_visible(mshit.desync, true)
	else
		ui.set_visible(mshit.extra_indicators, false)
		ui.set_visible(mshit.visual_arrows, false)
		ui.set_visible(mshit.visual_text, false)
		ui.set_visible(mshit.desync, false)
		ui.set_visible(mshit.desync_where, false)
		ui.set_visible(mshit.x_slider, false)
		ui.set_visible(mshit.y_slider, false)
	end
	
	if ui.get(mshit.indicator_enable) == "On" and ui.get(mshit.visual_arrows) then
		ui.set_visible(mshit.color, true)
		ui.set_visible(mshit.label, true)
	else
		ui.set_visible(mshit.color, false)
		ui.set_visible(mshit.label, false)
	end
end

local function handleGUI2()
	if ui.get(mshit.indicator_enable) == "On" and ui.get(mshit.visual_text) then
		ui.set_visible(mshit.indicators, true)
		ui.set_visible(mshit.color2, true)
		ui.set_visible(mshit.label2, true)
		if includes(ui.get(mshit.indicators), "AA States") then
			ui.set_visible(mshit.color3, true)
			ui.set_visible(mshit.label3, true)
		else
			ui.set_visible(mshit.color3, false)
			ui.set_visible(mshit.label3, false)
		end
		if includes(ui.get(mshit.indicators), "Doubletap") then
			ui.set_visible(mshit.color9, true)
			ui.set_visible(mshit.label9, true)
			ui.set_visible(mshit.color10, true)
			ui.set_visible(mshit.label10, true)
		else
			ui.set_visible(mshit.color9, false)
			ui.set_visible(mshit.label9, false)
			ui.set_visible(mshit.color10, false)
			ui.set_visible(mshit.label10, false)
		end
		if includes(ui.get(mshit.indicators), "Fakeduck") then
			ui.set_visible(mshit.color11, true)
			ui.set_visible(mshit.label11, true)
		else
			ui.set_visible(mshit.color11, false)
			ui.set_visible(mshit.label11, false)
		end
		if includes(ui.get(mshit.indicators), "Safepoint") then
			ui.set_visible(mshit.color12, true)
			ui.set_visible(mshit.label12, true)
		else
			ui.set_visible(mshit.color12, false)
			ui.set_visible(mshit.label12, false)
		end
		if includes(ui.get(mshit.indicators), "Hideshots") then
			ui.set_visible(mshit.color13, true)
			ui.set_visible(mshit.label13, true)
		else
			ui.set_visible(mshit.color13, false)
			ui.set_visible(mshit.label13, false)
		end
		if includes(ui.get(mshit.indicators), "Force body aim") then
			ui.set_visible(mshit.color14, true)
			ui.set_visible(mshit.label14, true)
		else
			ui.set_visible(mshit.color14, false)
			ui.set_visible(mshit.label14, false)
		end
		if includes(ui.get(mshit.indicators), "Fakelag") then
			ui.set_visible(mshit.color8, true)
			ui.set_visible(mshit.label8, true)
		else
			ui.set_visible(mshit.color8, false)
			ui.set_visible(mshit.label8, false)
		end
	else
		ui.set_visible(mshit.indicators, false)
		ui.set_visible(mshit.color2, false)
		ui.set_visible(mshit.label2, false)
		ui.set_visible(mshit.color3, false)
		ui.set_visible(mshit.label3, false)
		ui.set_visible(mshit.color8, false)
		ui.set_visible(mshit.label8, false)
		ui.set_visible(mshit.color9, false)
		ui.set_visible(mshit.label9, false)
		ui.set_visible(mshit.color10, false)
		ui.set_visible(mshit.label10, false)
		ui.set_visible(mshit.color11, false)
		ui.set_visible(mshit.label11, false)
		ui.set_visible(mshit.color12, false)
		ui.set_visible(mshit.label12, false)
		ui.set_visible(mshit.color13, false)
		ui.set_visible(mshit.label13, false)
		ui.set_visible(mshit.color14, false)
		ui.set_visible(mshit.label14, false)
	end
	
	if ui.get(mshit.enabled) then
		ui.set_visible(mshit.indicator_enable, true)
	else
		ui.set_visible(mshit.indicator_enable, false)
		ui.set_visible(mshit.color, false)
		ui.set_visible(mshit.label, false)
		ui.set_visible(mshit.color2, false)
		ui.set_visible(mshit.label2, false)
		ui.set_visible(mshit.color3, false)
		ui.set_visible(mshit.label3, false)
		ui.set_visible(mshit.color8, false)
		ui.set_visible(mshit.label8, false)
		ui.set_visible(mshit.color9, false)
		ui.set_visible(mshit.label9, false)
		ui.set_visible(mshit.color10, false)
		ui.set_visible(mshit.label10, false)
		ui.set_visible(mshit.color11, false)
		ui.set_visible(mshit.label11, false)
		ui.set_visible(mshit.color12, false)
		ui.set_visible(mshit.label12, false)
		ui.set_visible(mshit.color13, false)
		ui.set_visible(mshit.label13, false)
		ui.set_visible(mshit.color14, false)
		ui.set_visible(mshit.label14, false)
	end
end

local function paint_all()
	on_paint()
end

local function paintui_all()
	menu_elements()
	paint_ui()
	handleGUI2()
end

local function turnshiton()
	if ui.get(mshit.enabled) then
		enable_aa()
	else
		disable_aa()
	end
end

local function shutdown()
	ui.set(ref.pitch, "Default")
	ui.set(yaw2, "180")
	ui.set(yaw, 0)
	ui.set(jyaw, "Random")
	ui.set(jyawslide, 0)
    ui.set(bodyyaw, "Static")
	ui.set(bodyyaw2, 0)
	ui.set(references.freestanding_byaw, false)
	ui.set(references.fyawlimit, 0)
	
	ui.set_visible(references.aa_enable, true)
	set_og_menu(true)
	
	ui.set(references.tickstoprocess, 16)
	cvar.r_3dsky:set_int(1)
	cvar.r_3dskyinreflection:set_int(1)
end

create_callback("bullet_impact", on_bullet_impact)
create_callback("player_hurt", on_player_hurt)
create_callback("paint_ui", paintui_all)
create_callback("setup_command", on_setup_command)
create_callback("setup_command", turnshiton)
create_callback("paint", paint_all)
create_callback("shutdown", shutdown)

create_callback("player_death", function(e)
	if client_userid_to_entindex(e.userid) == entity.get_local_player() then
		reset_data(true)
	end
end)

create_callback("round_start", function()
	reset_data(true)
	dt_latency = client.latency() * 1000
end)

create_callback("client_disconnect", function()
	reset_data(false)
end)

create_callback("game_newmap", function()
	reset_data(false)
end)

create_callback("cs_game_disconnected", function()
	reset_data(false)
end)

local function handle_callbacks()
    ui_set_callback(deez_nutz[11].aa_settings, menu_elements)
	ui_set_callback(deez_nutz[0].player_state, menu_elements)
	ui_set_callback(mshit.edge[1], menu_elements)
	ui_set_callback(mshit.freestand[1], menu_elements)

	for i=1, 10 do
		ui_set_callback(deez_nutz[i].aa_mode_shit, menu_elements)
		ui_set_callback(deez_nutz[i].yaw_shit, menu_elements)
		ui_set_callback(deez_nutz[i].yawadd_shit, menu_elements)
		ui_set_callback(deez_nutz[i].bodyyaw_shit, menu_elements)
        ui_set_callback(deez_nutz[i].yawjitter_shit, menu_elements)
        ui_set_callback(deez_nutz[i].fakeyawmode_shit, menu_elements)
	end
	
	-- Optimize Shit --
	cvar.r_3dsky:set_int(0)
	cvar.r_3dskyinreflection:set_int(0)
end
handle_callbacks()