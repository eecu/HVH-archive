--powered by Ev1
require 'bit'
ffi = require "ffi"
vector = require "vector" -- there for the Vector struct to work in FFI
local antiaim = require 'gamesense/antiaim_funcs'
local client_userid_to_entindex, client_set_event_callback, client_screen_size, client_trace_bullet, client_unset_event_callback, client_color_log, client_camera_position, client_create_interface, client_random_int, client_latency, client_find_signature, client_delay_call, client_trace_line, client_register_esp_flag, client_exec, client_key_state, client_set_cvar, client_unix_time, client_error_log, client_draw_debug_text, client_update_player_list, client_camera_angles, client_eye_position, client_draw_hitboxes, client_random_float, entity_get_local_player, entity_is_enemy, entity_get_all, entity_set_prop, entity_is_alive, entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_is_dormant, entity_get_player_name, entity_get_origin, entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop, globals_absoluteframetime, globals_chokedcommands, globals_oldcommandack, globals_tickcount, globals_commandack, globals_lastoutgoingcommand, globals_curtime, globals_tickinterval, globals_framecount, globals_frametime, ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_new_checkbox, ui_new_multiselect, ui_new_hotkey, ui_set, ui_set_callback, ui_new_button, ui_new_label, ui_get, renderer_world_to_screen, renderer_circle_outline, renderer_rectangle, renderer_gradient, renderer_circle, renderer_text, renderer_line, renderer_triangle, renderer_measure_text, renderer_indicator, math_atan2, math_rad, math_ceil, math_tan, math_cos, math_sinh, math_random, math_huge, math_pi, math_max, math_floor, math_sqrt, math_deg, math_atan, math_pow, math_abs, math_min, math_sin, math_log, table_concat, string_format, string_byte, string_char, bit_band, panorama_loadstring, panorama_open = 
client.userid_to_entindex, client.set_event_callback, client.screen_size, client.trace_bullet, client.unset_event_callback, client.color_log, client.camera_position, client.create_interface, client.random_int, client.latency, client.find_signature, client.delay_call, client.trace_line, client.register_esp_flag, client.exec, client.key_state, client.set_cvar, client.unix_time, client.error_log, client.draw_debug_text, client.update_player_list, client.camera_angles, client.eye_position, client.draw_hitboxes, client.random_float, entity.get_local_player, entity.is_enemy, entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname, entity.get_player_resource, entity.is_dormant, entity.get_player_name, entity.get_origin, entity.hitbox_position, entity.get_player_weapon, entity.get_players, entity.get_prop, globals.absoluteframetime, globals.chokedcommands, globals.oldcommandack, globals.tickcount, globals.commandack, globals.lastoutgoingcommand, globals.curtime, globals.tickinterval, globals.framecount, globals.frametime, ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.new_checkbox, ui.new_multiselect, ui.new_hotkey, ui.set, ui.set_callback, ui.new_button, ui.new_label, ui.get, renderer.world_to_screen, renderer.circle_outline, renderer.rectangle, renderer.gradient, renderer.circle, renderer.text, renderer.line, renderer.triangle, renderer.measure_text, renderer.indicator, math.atan2, math.rad, math.ceil, math.tan, math.cos, math.sinh, math.random, math.huge, math.pi, math.max, math.floor, math.sqrt, math.deg, math.atan, math.pow, math.abs, math.min, math.sin, math.log, table.concat, string.format, string.byte, string.char, bit.band, panorama.loadstring, panorama.open
local globals_realtime = globals.realtime
local client_current_threat, client_find_signature, entity_get_local_player, entity_get_origin, entity_get_player_weapon, entity_get_prop, entity_is_alive, globals_chokedcommands, math_max, renderer_indicator, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_hotkey, ui_new_multiselect, ui_reference, ipairs, ui_set_callback, ui_set_visible = client.current_threat, client.find_signature, entity.get_local_player, entity.get_origin, entity.get_player_weapon, entity.get_prop, entity.is_alive, globals.chokedcommands, math.max, renderer.indicator, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_hotkey, ui.new_multiselect, ui.reference, ipairs, ui.set_callback, ui.set_visible
local antiaim_funcs = require "gamesense/antiaim_funcs"
local images = require "gamesense/images"
local base64 = require('gamesense/base64')
local clipboard_api = require('gamesense/clipboard')

local master_switch = ui_new_checkbox("AA", "Anti-aimbot angles", "\aFFED92FFEnabled Smoke-Tech  -Anti Aim \a6EBFFFFF--Alpha")
local menu = ui_new_combobox("AA", "Anti-aimbot angles", "[Q1995736] Owner-Principal   --- Ev1 ---", 'Anti-Aim', 'Indicators', 'Misc')
local air_strafe = ui.reference("Misc", "Movement", "Air strafe")

local items = {
    --aa
    anti_aim = ui_new_checkbox("AA", "Anti-aimbot angles", "\aFFD9D9FFAnti-aim high-intensity \a9FB9FFFFsync packet"),
    extra_conditions = ui_new_multiselect("AA", "Anti-aimbot angles", "Keybinds", "Manual left", "Manual right", "Manual back", "Edge yaw on key", "Freestanding on key", "Legit AA on use"),
    manual_left_dir = ui_new_hotkey("AA", "anti-aimbot angles", "Manual Left"),
    manual_right_dir = ui_new_hotkey("AA", "anti-aimbot angles","Manual Right"),
    manual_backward_dir = ui_new_hotkey("AA", "anti-aimbot angles","Manual Back"),
    edge = ui_new_hotkey("AA", "anti-aimbot angles", "Edge yaw on key"),
    freestanding = ui_new_hotkey("AA", "anti-aimbot angles", "Freestanding on key"),
    legit_aa = ui_new_checkbox("AA", "Anti-aimbot angles", "Legit AA on use"),
    manual_state = ui_new_slider("AA", "anti-aimbot angles","\n",0,3,0),
    fs_mode = ui_new_combobox("AA", "Anti-aimbot angles", "Body yaw mode", "Smart", "Reversed"),
    anti_knife = ui_new_checkbox("AA", "Anti-aimbot angles", "Enable \aFFFFFFFFanti-knife"),
    --indicators
    indbox = ui_new_multiselect("AA", "Anti-aimbot angles", "Indicator box", "Arrow indicators", "Crosshair indicators", "Debug indicators"),
    indbox2 = ui_new_multiselect("AA", "Anti-aimbot angles", "Crosshair ind", "indication", "watermark"),
    bodyyaw_ind = ui_new_combobox("AA", "Anti-aimbot angles", "Arrow type", "A", "B","C"),
    Debug_box = ui_new_combobox("AA", "Anti-aimbot angles", "Debug ind", "+", "-"),
    arrows_label = ui.new_label("AA", "Anti-aimbot angles", "Arrow type"),
    arrows_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "Arrow type", 155, 255, 255, 255),
    main_label = ui.new_label("AA", "Anti-aimbot angles", "Main color A"),
    main_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "Main color", 155, 255, 255, 255),
    main_label_1 = ui.new_label("AA", "Anti-aimbot angles", "Main color B"),
    main_clr_a = ui.new_color_picker("AA", "Anti-aimbot angles", "Main color 1", 255, 155, 255, 255),
    clr_size = ui.new_slider("AA", "Anti-aimbot angles", "Arrow size location", 8, 14, 10),
    x_offset = ui.new_slider("AA", "Anti-aimbot angles", "Debug left location", -1000, 1000, 0), 
    y_offset = ui.new_slider("AA", "Anti-aimbot angles", "Debug Right location", -1000, 1000, 0), 
    z_offset = ui.new_slider("AA", "Anti-aimbot angles", "Crosshair left location", -1000, 1000, 0), 
	--Misc
	enable_it = ui.new_checkbox("AA", "Anti-aimbot angles", "> Enable Jumpscout"),
    Animation = ui.new_multiselect("AA", "other", '\aaecbfdffA\abbc4fbffn\ac9bdf9ffi\ad6b6f7ffm\ae4aff5ffa \af1a8f3fft\afea1f1ffi \aff96edffon(serverside)', { 'Leg Movement', 'Static Legs', '0 Pitch on land' } ),
	keyshow = ui_new_checkbox("AA", "Anti-Aimbot Angles", "> Enable extra slow motion limit"),
	limit_reference = ui_new_slider("AA", "Anti-Aimbot Angles", "Slow motion limit", 10, 57, 50, 57, "", 1, {[57] = "Max", [47] = "Better", [10] = "Minimum"}),
}
--ROLL AA
	
	
local refs = {
    dt = { ui_reference("RAGE", "Aimbot", "Double tap") },
    pitch = ui_reference("AA", "Anti-aimbot angles", "pitch"),
    yaw = { ui_reference("AA", "Anti-aimbot angles", "Yaw") },
    yaw_base = { ui_reference("AA", "Anti-aimbot angles", "Yaw base") },
    yawj = { ui_reference("AA", "Anti-aimbot angles", "Yaw jitter") },
    bodyyaw = { ui_reference("AA", "Anti-aimbot angles", "Body yaw") },
    fs = { ui_reference("AA", "Anti-aimbot angles", "Freestanding") },
    slowwalk = { ui_reference("AA", "Other", "Slow motion") },
    leg_movement = ui_reference("AA", "Other", "Leg movement"),
    hs = { ui_reference("AA", "Other", "On shot anti-aim") },
    quickpeek = { ui_reference("RAGE", "Other", "Quick peek assist") },
    quickpeek_clr = ui_reference("RAGE", "Other", "Quick peek assist mode"),
    edge_yaw = ui_reference("AA", "Anti-aimbot angles", "Edge yaw"),
    md = ui_reference("RAGE", "Aimbot", "Minimum damage"),
    sp_key = ui_reference("RAGE", "Aimbot", "Force safe point"),
    baim_key = ui_reference("RAGE", "Aimbot", "Force body aim"),
    ping_spike = { ui.reference('MISC', 'Miscellaneous', 'Ping spike') },
    fd = ui_reference("RAGE", "Other", "Duck peek assist"),
    --dt_mode = ui_reference("RAGE", "Other", "Double tap mode"),
    dt_hc = ui_reference("RAGE", "Aimbot", "Double tap hit chance"),
    dt_fl = ui_reference("RAGE", "Aimbot", "Double tap fake lag limit"),
    pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch"),
    yaw_base = ui_reference("AA", "Anti-aimbot angles", "Yaw base"),
    fs_bodyyaw = ui_reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
    --fakelimit = ui_reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
    fl = ui_reference("AA", "Fake lag", "Enabled"),
    fl_amt = ui_reference("AA", "Fake lag", "Amount"),
    fl_var = ui_reference("AA", "Fake lag", "Variance"),
    fl_limit = ui_reference("AA", "Fake lag", "Limit"),
    --maxprocessticks = ui_reference("Misc", "Settings", "sv_maxusrcmdprocessticks"),
    holdaim = ui_reference("Misc", "Settings", "sv_maxusrcmdprocessticks_holdaim"),
    aa_enabled = ui_reference("AA", "Anti-aimbot angles", "Enabled"),
    slowwalk = { ui_reference("AA", "Other", "Slow motion") },
    fakeduck = ui.reference("Rage", "Other", "Duck peek assist"),
    --sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
    
}
local fakelag = ui.reference("AA", "Fake lag", "Limit")
local function containo(A, B)
	if A == nil then
		return false
	end
    A = ui.get(A)
    for i=0, #A do
        if A[i] == B then
            return true
        end
    end
    return false
end

local bind_systeam = {
	left = false,
	right = false,
	back = false,
}

local indicator = {
	bar = 0,
	hbar = 0,
}

--SmokeYAW Ev1 Ex
local handler_ui = {}

handler_ui.menu_need_to_export = {
    ['number'] = {},
    ['string'] = {},
    ['boolean'] = {},
    ['table'] = {},
}

local function arr_to_string(arr)
	arr = ui.get(arr)
	local str = ""
	for i=1, #arr do
		str = str .. arr[i] .. (i == #arr and "" or ",")
	end

	if str == "" then
		str = "-"
	end

	return str
end

local function str_to_sub(input, sep)
	local t = {}
	for str in string.gmatch(input, "([^"..sep.."]+)") do
		t[#t + 1] = string.gsub(str, "\n", "")
	end
	return t
end

local function to_boolean(str)
	if str == "true" or str == "false" then
		return (str == "true")
	else
		return str
	end
end

function handler_ui:menu_funcs(register,need_export, ... )
    local number_ = register

    if need_export then
        if type(number_) == 'number' then
                table.insert(self.menu_need_to_export[type(ui.get(number_))],number_)
        end
    end

    --print(type(ui.get(number_)))
    return number_
end

--Jumpscout
client.set_event_callback("setup_command", function(c)
    if not ui.get(items.enable_it) then return end
		local vel_x, vel_y = entity.get_prop(entity.get_local_player(), "m_vecVelocity")
        local vel = math.sqrt(vel_x^2 + vel_y^2)
        ui.set(air_strafe, not (c.in_jump and (vel < 10)) or ui.is_menu_open())
end)

local data = { }

local function resolve_flag_get( )
    data = { }

    local players = entity.get_players( true )
    for i, player in ipairs( players ) do repeat
        local body_yaw = entity.get_prop( player, 'm_flPoseParameter', 11 )
        if not body_yaw then
            break
        end

        data[ player ] = body_yaw * 120 - 60
    until true end
end

--Leg movement
function legfucker( )
    local z = math.random( 1, 3 )
    if z == 1 then
        ui.set( refs.leg_movement, "Always slide" )
    elseif z == 2 then
        ui.set( refs.leg_movement, "Never slide" )
    elseif z == 3 then
        ui.set( refs.leg_movement, "Always slide" )
    end
end
local ground_ticks, end_time = 1, 0
client.set_event_callback("pre_render", function()
    local localplayer = entity.get_local_player( )
    if localplayer == nil then return end
    if containo(items.Animation, "Static Legs") then 
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 6) 
    end
    if containo(items.Animation, "0 Pitch on land") then
        local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1)

        if on_ground == 1 then
            ground_ticks = ground_ticks + 1
        else
            ground_ticks = 0
            end_time = globals.curtime() + 1
        end 
    
        if ground_ticks > ui.get(fakelag)+1 and end_time > globals.curtime() then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0.5, 12)
        end
    end
    if containo(items.Animation, "Leg Movement") then
        legfucker( )
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 8, 0)
    end
end)

local vars = {
    state_to_idx = { ["Default"]=1, ["Dormant"]=2, ["Body right"]=3, ["Body left"]=4, ["Slow motion"]=5, ["Yaw left"]=6, ["Yaw right"]=7, ["In air"]=8,['Crouching'] = 9,['Standing'] = 10,['Air Crouching'] = 11,['Fake Lag'] = 12 },
    player_states = { "Default", "Dormant", "Body right", "Body left", "Slow motion", "Yaw left", "Yaw right", "In air",'Crouching','Standing','Air Crouching','Fake Lag'},
    active_i = 1,
    p_state = 0,
    yaw_status = "DEFAULT",
    best_enemy = nil,
    best_angle = 0,
    indexed_angle = 0,
    misses = { },
    last_miss = 0,
    last_dt_fire = 0,
    on_use_aa = false
}

local anti_aim = { }

local function velocity()
    local me = entity_get_local_player()
    local velocity_x, velocity_y = entity_get_prop(me, "m_vecVelocity")
    return math.sqrt(velocity_x ^ 2 + velocity_y ^ 2)
end

local function contains(tbl, val)
    for i = 1, #tbl do
        if tbl[i] == val then
            return true
        end
    end
    return false
end



local Exploit = ui.new_multiselect(
    "AA",
    "other",
    "Legit Anti-aim options:",
    "Enable Rolling",
    "Lower Body Yaw (move)",
    "\aB6B665FFValve Server Bypass"
)

local slider_roll = ui.new_slider("AA", "other", "Roll Angle", -90, 90, 50, true, "°")

roll = function(h)

    h.roll = ui.get(slider_roll)

end


lean_lby = function(cmd)

    if (math.abs(cmd.forwardmove) > 1) or (math.abs(cmd.sidemove) > 1) or cmd.in_jump == 1 then
        return
    end

    if (entity.get_prop(entity.get_local_player(), "m_MoveType") or 0) == 9 then --ladder fix
        return
    end

    local desync_amount = antiaim.get_desync(2)

    if desync_amount == nil then
        return
    end
    
    if math.abs(desync_amount) < 15 or cmd.chokedcommands == 0 then
        return
    end

    if velocity() > 80 then return end

    cmd.forwardmove = 0
    cmd.in_forward = 1

end

local gamerules_ptr = client.find_signature("client.dll", "\x83\x3D\xCC\xCC\xCC\xCC\xCC\x74\x2A\xA1")
local gamerules = ffi.cast("intptr_t**", ffi.cast("intptr_t", gamerules_ptr) + 2)[0]

local function bypass()
    if contains(ui.get(Exploit), "\aB6B665FFValve Server Bypass") then
        local is_valve_ds = ffi.cast('bool*', gamerules[0] + 124)
        if is_valve_ds ~= nil then
            is_valve_ds[0] = 0
        end
    end
end


local function setup_commands(h)
    
    if contains(ui.get(Exploit), "Enable Rolling") then
        roll(h)
        ui_set_visible(slider_roll, true)
    else
        ui_set_visible(slider_roll, false)
    end

    if contains(ui.get(Exploit), "Lower Body Yaw (move)") then
        lean_lby(h)
    end

    if contains(ui.get(Exploit), "\aB6B665FFValve Server Bypass") then
        bypass()
        --ui.set(refs.sv_maxusrcmdprocessticks, 7)
    else
        --ui.set(refs.sv_maxusrcmdprocessticks, 17)
    end

end

client.set_event_callback('setup_command', setup_commands)

local label1 = ui.new_label("AA", "Anti-aimbot angles", "\aFFD9D9FF---------  Customize the perfect goal  ---------")

local conditions = handler_ui:menu_funcs(ui_new_combobox("AA","Anti-aimbot angles","Player state", vars.player_states),true)

for i=1, 12 do
    anti_aim[i] = {
        enabled = handler_ui:menu_funcs(ui.new_checkbox("AA","Anti-aimbot angles","Enable "..vars.player_states[i].." status"),true),
        pitch = handler_ui:menu_funcs(ui_new_combobox("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Pitch" , { "Off", "Default", "Up", "Down", "Minimal", "Random" }),true),
		yawbase = handler_ui:menu_funcs(ui_new_combobox("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Yaw base", { "Local view", "At targets" }),true),
		yaw = handler_ui:menu_funcs(ui_new_combobox("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Yaw", { "Off", "180", "Spin", "Static", "180 Z", "Crosshair" }),true),
        yaw_left = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Yaw add left \aFFBCBCFF[definition]", -180, 180, 0, true, "°" ),true),
        yaw_right = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Yaw add right \aFFBCBCFF[definition]", -180, 180, 0, true, "°" ),true),
        yaw_speed = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Yaw add Speed \aFFBCBCFF[definition]", 0, 10, 0, true, "ms" ),true),
		yawjitter = handler_ui:menu_funcs(ui_new_combobox("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter"  }),true),
		yawjitteradd_left = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Yaw jitter add left \aFFBCBCFF[definition]", -180, 180, 0, true, "°" ),true),
        yawjitteradd_right = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Yaw jitter add right \aFFBCBCFF[definition]", -180, 180, 0, true, "°" ),true),
		bodyyaw = handler_ui:menu_funcs(ui_new_combobox("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Body yaw", { "Off", "Opposite", "Jitter", "Static"}),true),
        bodyyaw_left = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Body yaw add left \aFFBCBCFF[definition]", -180, 180, 0, true, "°" ),true),
        bodyyaw_right = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Body yaw add right \aFFBCBCFF[definition]", -180, 180, 0, true, "°" ),true),
		fakeyawlimit = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Fake yaw limit", 0, 60, 60, true, "°" ),true),
		randomfakeyawlimit = handler_ui:menu_funcs(ui.new_checkbox("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Enable random limit"),true),
		randomfakeyawlimit1 = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Random limit(min)", 0, 60, 60, true, "°" ),true),
		randomfakeyawlimit2 = handler_ui:menu_funcs(ui_new_slider("AA", "Anti-aimbot angles", "["..vars.player_states[i].."] Random limit(max)", 0, 60, 60, true, "°" ),true),
	}
end

local includes = function(table, value)
    for _, v in ipairs(ui_get(table)) do
        if v == value then return true end
    end
    return false
end

local function draw_gradient( ctx, x, y, w, h, r1, g1, b1, a1, r2, g2, b2, a2, ltr )
    client.draw_gradient( ctx, x, y, w, h, r1, g1, b1, a1, r2, g2, b2, a2, ltr )
end


function bind_systeam:updata()

    ui.set(items.manual_left_dir,"On hotkey")
	ui.set(items.manual_right_dir,"On hotkey")
	ui.set(items.manual_backward_dir,"On hotkey")
	
	m_state = ui.get(items.manual_state)
	
	left_state,right_state,backward_state = 
	ui.get(items.manual_left_dir),
	ui.get(items.manual_right_dir), 
	ui.get(items.manual_backward_dir)

	if left_state == self.left and
		right_state == self.right and
		backward_state == self.back then
		return
	end
	
	self.left,self.right,self.back =
		left_state,
		right_state,
		backward_state

	if (left_state and m_state == 1) or (right_state and m_state == 2)  then
		ui.set(items.manual_state, 0)
		return
	end

	if left_state and m_state ~= 1 and includes(items.extra_conditions, "Manual left") then
		ui.set(items.manual_state,1)
	end
	if right_state and m_state ~= 2 and includes(items.extra_conditions, "Manual right") then  
		ui.set(items.manual_state,2)
	end
	if backward_state and m_state ~= 0 and includes(items.extra_conditions, "Manual back") then
		ui.set(items.manual_state,0)
	end
end


local color = function(_r, _g, _b, _a) 
	return { r = _r or 0, g = _g or 0, b = _b or 0, a = _a or 0 } 
end

local vec_3 = function(_x, _y, _z) 
	return { x = _x or 0, y = _y or 0, z = _z or 0 } 
end

local function vec_dist(current, target)
    local len = vec_3(target.x - current.x, target.y - current.y, target.z - current.z)
    return math_sqrt(len.x * len.x + len.y * len.y + len.z * len.z)
end

local function normalize_yaw(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end

    return yaw
end

local function ang_on_screen(x, y)
    if x == 0 and y == 0 then
        return 0
    end
    return math_deg(math_atan2(y, x))
end

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
    local x, y = local_x - enemy_x, local_y - enemy_y
	local relative_yaw = normalize_yaw( math_atan( y / x ) * 180 / math_pi )
	if x >= 0 then
		relative_yaw = normalize_yaw(relative_yaw + 180)
	end
	return relative_yaw
end

local function angle_vector(angle_x, angle_y)
	local sy, cy = math_sin(math_rad(angle_y)), math_cos(math_rad(angle_y))
    local sp, cp = math_sin(math_rad(angle_x)), math_cos(math_rad(angle_x))
	return cp * cy, cp * sy, -sp
end

local function extrapolate_position(pos, ticks, ent)
	local velocity = vec_3(entity_get_prop(ent, "m_vecVelocity"))
	for i=0, ticks do
		pos.x = pos.x + (velocity.x*globals_tickinterval())
		pos.y = pos.y + (velocity.y*globals_tickinterval())
		pos.z = pos.z + (velocity.z*globals_tickinterval())
	end
	return pos.x, pos.y, pos.z
end

local function get_player_position(ent)
    local pos, duck_amt = vec_3(entity_get_origin(ent)), entity_get_prop(ent, "m_flDuckAmount") or 0

    pos.z = pos.z + 46 + (1 - duck_amt) * 18
    return pos.x, pos.y, pos.z
end


local function get_best_enemy()
    local enemies = entity_get_players(true)
    if #enemies == 0 then
        vars.best_enemy = nil
        return
    end

    local eye_pos, cam_ang = vec_3(client_eye_position()), vec_3(client_camera_angles())
    local best_fov = math_huge

    for i=1, #enemies do
        local enemy_pos = vec_3(get_player_position(enemies[i]))
        local cur_fov = math_abs(normalize_yaw(ang_on_screen(eye_pos.x - enemy_pos.x, eye_pos.y - enemy_pos.y) - cam_ang.y + 180))
        if cur_fov < best_fov then
            best_fov, vars.best_enemy = cur_fov, enemies[i]
        end
    end
end

local event_handler_functions = {
    [true]  = client.set_event_callback,
    [false] = client.unset_event_callback,
}

local function get_distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
end

local function on_run_command()
    local players = entity.get_players(true)
    local lx, ly, lz = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
	local yaw, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
    for i=1, #players do
        local x, y, z = entity.get_prop(players[i], "m_vecOrigin")
        local distance = get_distance(lx, ly, lz, x, y, z)
        local weapon = entity.get_player_weapon(players[i])
        if entity.get_classname(weapon) == "CKnife" and distance <= 200 then
            ui.set(yaw_slider,180)
        end
    end
end

local function on_script_toggle_change()
    local state = ui.get(items.anti_knife)
    local handle_event = event_handler_functions[state]
    handle_event("run_command", on_run_command)
end

on_script_toggle_change()
ui.set_callback(items.anti_knife, on_script_toggle_change)

local function ticks_to_time(ticks)
    return globals.tickinterval() * ticks
end

local function will_peek()
    local enemies = entity.get_players(true)
    if (#enemies == 0) then
        return false
    end

    local me = entity.get_local_player()
    local predicted = ui.get(ui.reference("aa", "Fake lag", "Limit"))
    local eye_pos = vec_3(client.eye_position())
    local vel_prop_local = vec_3(entity.get_prop(me, "m_vecVelocity"))
    local local_vel = math.sqrt(vel_prop_local.x^2+vel_prop_local.y^2)

  

    local pred_eye_pos = vec_3(eye_pos.x + vel_prop_local.x * ticks_to_time(predicted), eye_pos.y + vel_prop_local.y * ticks_to_time(predicted), eye_pos.z + vel_prop_local.z * ticks_to_time(predicted))

    for i = 1, #enemies do
        local player = enemies[i]

        local vel_prop = vec_3(entity.get_prop(player, "m_vecVelocity"))
        local origin = vec_3(entity.get_prop(player, "m_vecOrigin"))
        local pred_origin = vec_3(origin.x + vel_prop.x * ticks_to_time(16), origin.y + vel_prop.y * ticks_to_time(16), origin.x + vel_prop.x * ticks_to_time(16))

        entity.get_prop(player, "m_vecOrigin", pred_origin)

        local head_origin = vec_3(entity.hitbox_position(player, 0))
        local pred_head_origin = vec_3(head_origin.x + vel_prop.x * ticks_to_time(16), head_origin.y + vel_prop.y * ticks_to_time(16), head_origin.z + vel_prop.z * ticks_to_time(16))
        local trace_entity, damage = client.trace_bullet(me, pred_eye_pos.x, pred_eye_pos.y, pred_eye_pos.z, pred_head_origin.x, pred_head_origin.y, pred_head_origin.z)

        entity.get_prop(player, "m_vecOrigin", origin)

        local current_player = player

        if damage > 0 and entity.is_alive(current_player) then
            if player ~= current_player then
                return false
            end

            current_player = player
            return true
        end
    end

    return false
end

local function get_best_angle()
    if not ui_get(items.anti_aim) or vars.best_enemy == nil then
        vars.best_angle, vars.indexed_angle = 0, 0
        return
    end

    local me = entity_get_local_player()

    local local_pos, enemy_pos = vec_3(get_player_position(me)), vec_3(get_player_position(vars.best_enemy))

    local yaw = calc_angle(local_pos.x, local_pos.y, enemy_pos.x, enemy_pos.y)
    local l_dir, r_dir = vec_3(angle_vector(0, (yaw + 90))), vec_3(angle_vector(0, (yaw - 90)))
    local l_pos, r_pos = vec_3(local_pos.x + l_dir.x * 110, local_pos.y + l_dir.y * 110, local_pos.z), vec_3(local_pos.x + r_dir.x * 110, local_pos.y + r_dir.y * 110, local_pos.z)

    local fraction, hit_ent = client_trace_line(vars.best_enemy, enemy_pos.x, enemy_pos.y, enemy_pos.z, l_pos.x, l_pos.y, l_pos.z)
    local fraction_s, hit_ent_s = client_trace_line(vars.best_enemy, enemy_pos.x, enemy_pos.y, enemy_pos.z, r_pos.x, r_pos.y, r_pos.z)
    
        if fraction > fraction_s then
            vars.best_angle = ui_get(items.fs_mode) == "Smart" and 1 or 2
        elseif fraction_s > fraction then
            vars.best_angle = ui_get(items.fs_mode) == "Smart" and 2 or 1
        else
            vars.best_angle = 3
            return
        end
   
    vars.indexed_angle = vars.best_angle == 3 and vars.indexed_angle or vars.best_angle
end


local function miss_detection(e)
    local me, shooter = entity_get_local_player(), client_userid_to_entindex(e.userid)

    if not ui_get(items.anti_aim) or not entity_is_alive(me) or not entity_is_enemy(shooter) or entity_is_dormant(shooter) or globals_curtime() - vars.last_miss <= 0.005 then
        return
    end

    local enemy_pos = vec_3(get_player_position(shooter))

    for i=1, 19 do
        local local_pos = vec_3(entity_hitbox_position(me, i - 1))
        local dist = ((e.y - enemy_pos.y)*local_pos.x - (e.x - enemy_pos.x)*local_pos.y + e.x*enemy_pos.y - e.y*enemy_pos.x) / math_sqrt((e.y-enemy_pos.y)^2 + (e.x - enemy_pos.x)^2)

        if math_abs(dist) <= 35 then
            vars.last_miss = globals_curtime()
            if vars.misses[shooter] ~= nil and vars.misses[shooter] >= 2 then
                vars.misses[shooter] = nil
            else
                vars.misses[shooter] = vars.misses[shooter] == nil and 1 or vars.misses[shooter] + 1
            end
            return
        elseif math_abs(dist) > 250 then
            return
        end
    end
end


local function is_under_health()

    under_health = false

    if (entity_get_prop(entity.get_local_player(), "m_iHealth") <= ui.get(anti_aim[9].hplimit)) then

        under_health = true

    else

        under_health = false

    end

    return under_health

end

local function anti_aim1(cmd)

    bind_systeam:updata()
 
    local is_os = ui.get(refs.hs[1]) and ui.get(refs.hs[2])

	local is_fd = ui.get(refs.fd)

    local doubletapping = ui.get(refs.dt[1]) and ui.get(refs.dt[2])

	local is_dt = ui.get(refs.dt[1]) and ui.get(refs.dt[2])

    local on_ground = (bit.band(entity.get_prop(entity_get_local_player(), 'm_fFlags'), 1) == 1)

    if not ui_get(items.anti_aim) then

        return
        
    end

    if includes(items.extra_conditions, "Edge yaw on key") then

        ui.set(refs.edge_yaw, ui.get(items.edge) and true or false)

    end

    if includes(items.extra_conditions, "Freestanding on key") then

        --ui_set(refs.fs[1], ui.get(items.freestanding) and "Default" or "-")

        ui_set(refs.fs[2], ui.get(items.freestanding) and "Always on" or "On hotkey")

        vars.p_state = 10

    end

    if vars.best_angle == 0 and ui_get(anti_aim[2].enabled) then

        vars.p_state = 2

        vars.yaw_status = "Dormant"

    elseif vars.best_angle == 1 or vars.indexed_angle == 1  then

        if  ui_get(anti_aim[3].enabled) then

            if vars.misses[vars.best_enemy] == nil then  

                vars.p_state = 3--body yaw right

                vars.yaw_status = ui_get(items.fs_mode) == "Condit Smart" and "Condit Smart" or "Reversed"

            else

                vars.p_state = 4--abf

                vars.yaw_status = "Break-brute"

            end

        else  vars.yaw_status = "Condit Def"

                vars.p_state = 1

        end
            

    elseif vars.best_angle == 2 or vars.indexed_angle == 2 then

        if  ui_get(anti_aim[4].enabled) then

            if vars.misses[vars.best_enemy] == nil or vars.misses[vars.best_enemy] == 2 then

                vars.p_state = 4--body yaw left

                vars.yaw_status = ui_get(items.fs_mode) == "Condit Smart" and "Condit Smart" or "Reversed"

            else

                vars.p_state = 3--abf

                vars.yaw_status = "Break-brute"
            end

        else  vars.yaw_status = "Condit Def"

            vars.p_state = 1

        end

    else

        vars.p_state = 1

        vars.yaw_status = "Condit Def"

    end

    if ui_get(refs.slowwalk[1]) and ui_get(refs.slowwalk[2])  and ui_get(anti_aim[5].enabled)   then

        vars.p_state = 5

        vars.yaw_status = "slow walk"

    end


    if math.max(cmd.in_forward, cmd.in_back, cmd.in_moveleft, cmd.in_moveright) == 0 and ui_get(anti_aim[10].enabled) then

        vars.p_state = 10

        vars.yaw_status = 'Standing'
        
    end
    
    if entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.8 and ui_get(anti_aim[9].enabled) then

        vars.p_state = 9

        vars.yaw_status = 'Condit Duck'

    end
    
    if not on_ground   and ui_get(anti_aim[8].enabled) then

        vars.p_state = 8

        vars.yaw_status = "Condit Air"

    end

    if not on_ground   and entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.8 and ui_get(anti_aim[11].enabled) then

        vars.p_state = 11

        vars.yaw_status = "Air Duck"

    end

    if not is_dt and not is_os and not p_still and ui_get(anti_aim[12].enabled) then

        vars.p_state = 12

        vars.yaw_status = "Fake Lag"

    end

    if ui_get(items.manual_state) == 1 and ui_get(anti_aim[6].enabled) and includes(items.extra_conditions, "Manual left") then

        vars.yaw_status = "Mal left"

        vars.p_state = 6
        
    elseif ui_get(items.manual_state) == 2 and ui_get(anti_aim[7].enabled) and includes(items.extra_conditions, "Manual right") then

            vars.yaw_status = "Mal right"

            vars.p_state = 7

    end

	if includes(items.extra_conditions, "Legit AA on use") and ui_get(items.legit_aa) and client.key_state(0x45) then

        vars.yaw_status = "Legit-aa" 

    end

end


--dt 
local function doubletap_charged()
    if not ui.get(refs.dt[1]) or not ui.get(refs.dt[2])  then
        return false
    end
    if not entity.is_alive(entity.get_local_player()) or entity.get_local_player() == nil then
        return
    end
    local weapon = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")
    if weapon == nil then
        return false
    end

    local next_attack = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.25
    local jewfag = entity.get_prop(weapon, "m_flNextPrimaryAttack")
    if jewfag == nil then
        return
    end
    local next_primary_attack = jewfag + 0.5
    if next_attack == nil or next_primary_attack == nil then
        return false
    end
    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end

local function gradient_text(r1, g1, b1, a1, r2, g2, b2, a2, text)
	local output = ''

	local len = #text-1

	local rinc = (r2 - r1) / len
	local ginc = (g2 - g1) / len
	local binc = (b2 - b1) / len
	local ainc = (a2 - a1) / len

	for i=1, len+1 do
		output = output .. ('\a%02x%02x%02x%02x%s'):format(r1, g1, b1, a1, text:sub(i, i))

		r1 = r1 + rinc

		g1 = g1 + ginc
		b1 = b1 + binc
		a1 = a1 + ainc
	end

	return output
end

    --fl指示器
    function lerp(start, vend, time)
    return start + (vend - start) * time end
    local ani = {
        dt = 0,
        onshot = 0,
        fd = 0,
        fs = 0,
        baim = 0,
        ping = 0,
        sp = 0,
        s = 0,
        xx = 0,
        x1 =0,
        x2 = 0,
        x3 = 0,
        x4 = 0,
        x5 = 0,
        x6 = 0,
        x7 = 0,
        y1 = 0,
        y2 = 0,
        y3 = 0,
        y4 = 0,
        y5 = 0,
        y6 = 0,
        y7 = 0,
        yy1 = 0,
        yy2 = 0,
        yy3 = 0,
        yy4 = 0,
        yy5 = 0,
        yy6 = 0,
        yy7 = 0,
        fs_alpha = 0,
        dt_alpha = 0,
        hide_alpha = 0,
        baim_alpha = 0,
        duck_alpha = 0,
        ping_alpha = 0,
        sp_alpha = 0,
        glow = 0,
        glow2 = 0,
    }
local function draw_crosshair_indicators()

    if ui.get(items.freestanding) then
        ani.y1 = lerp(ani.y1,10,globals.frametime() * 6)
        ani.yy1 = lerp(ani.yy1,80,globals.frametime() * 6)
        ani.fs_alpha = lerp(ani.fs_alpha,255,globals.frametime() * 6)
    else
        ani.y1 = lerp(ani.y1,0,globals.frametime() * 6)
        ani.yy1 = lerp(ani.yy1,0,globals.frametime() * 6)
        ani.fs_alpha = lerp(ani.fs_alpha,0,globals.frametime() * 6)
    end
    if ui_get(refs.dt[2]) then
        ani.y2 = lerp(ani.y2,10,globals.frametime() * 6)
        ani.yy2 = lerp(ani.yy2,80,globals.frametime() * 6)
        ani.dt_alpha = lerp(ani.dt_alpha,255,globals.frametime() * 6)
    else
        ani.y2 = lerp(ani.y2,0,globals.frametime() * 6)
        ani.yy2 = lerp(ani.yy2,0,globals.frametime() * 6)
        ani.dt_alpha = lerp(ani.dt_alpha,0,globals.frametime() * 6)
    end
    if ui.get(refs.hs[2]) then
        ani.y3 = lerp(ani.y3,10,globals.frametime() * 6)
        ani.yy3 = lerp(ani.yy3,80,globals.frametime() * 6)
        ani.hide_alpha = lerp(ani.hide_alpha,255,globals.frametime() * 6)
    else
        ani.y3 = lerp(ani.y3,0,globals.frametime() * 6)
        ani.yy3 = lerp(ani.yy3,0,globals.frametime() * 6)
        ani.hide_alpha = lerp(ani.hide_alpha,0,globals.frametime() * 6)
    end
    if ui.get(refs.baim_key) then
        ani.y4 = lerp(ani.y4,10,globals.frametime() * 6)
        ani.yy4 = lerp(ani.yy4,80,globals.frametime() * 6)
        ani.baim_alpha = lerp(ani.baim_alpha,255,globals.frametime() * 6)
    else
        ani.y4 = lerp(ani.y4,0,globals.frametime() * 6)
        ani.yy4 = lerp(ani.yy4,0,globals.frametime() * 6)
        ani.baim_alpha = lerp(ani.baim_alpha,0,globals.frametime() * 6)
    end
    if ui.get(refs.fakeduck) then
        ani.y5 = lerp(ani.y5,10,globals.frametime() * 6)
        ani.yy5 = lerp(ani.yy5,80,globals.frametime() * 6)
        ani.duck_alpha = lerp(ani.duck_alpha,255,globals.frametime() * 6)
    else
        ani.y5 = lerp(ani.y5,0,globals.frametime() * 6)
        ani.yy5 = lerp(ani.yy5,0,globals.frametime() * 6)
        ani.duck_alpha = lerp(ani.duck_alpha,0,globals.frametime() * 6)
    end
    if ui.get(refs.ping_spike[1] ) and ui.get( refs.ping_spike[2]) then
        ani.y6 = lerp(ani.y6,10,globals.frametime() * 6)
        ani.yy6 = lerp(ani.yy6,80,globals.frametime() * 6)
        ani.ping_alpha = lerp(ani.ping_alpha,255,globals.frametime() * 6)
    else
        ani.y6 = lerp(ani.y6,0,globals.frametime() * 6)
        ani.yy6 = lerp(ani.yy6,0,globals.frametime() * 6)
        ani.ping_alpha = lerp(ani.ping_alpha,0,globals.frametime() * 6)
    end
    if ui.get(refs.sp_key) then
        ani.y7 = lerp(ani.y7,10,globals.frametime() * 6)
        ani.yy7 = lerp(ani.yy7,80,globals.frametime() * 6)
        ani.sp_alpha = lerp(ani.sp_alpha,255,globals.frametime() * 6)
    else
        ani.y7 = lerp(ani.y7,0,globals.frametime() * 6)
        ani.yy7 = lerp(ani.yy7,0,globals.frametime() * 6)
        ani.sp_alpha = lerp(ani.sp_alpha,0,globals.frametime() * 6)
    end
    local first_offset = ani.y1
    local second_offset = first_offset + ani.y2
    local thrid_offset = second_offset + ani.y3
    local fourth_offset = thrid_offset + ani.y4
    local fiveth_offset = fourth_offset + ani.y5
    local sixth_offset = fiveth_offset + ani.y6
    local seventh_offset = sixth_offset + ani.y7
    local local_player = entity.get_local_player()
    local is_scoped = entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_zoomLevel" )
    local my_weapon = entity.get_player_weapon(local_player)
    local wpn_id = entity.get_prop(entity.get_player_weapon(entity.get_local_player()), "m_iItemDefinitionIndex")
    local is_grenade =
        ({
        [43] = true,
        [44] = true,
        [45] = true,
        [46] = true,
        [47] = true,
        [48] = true,
        [68] = true
    })[wpn_id] or false
    if is_scoped == nil then is_scoped = 0 end
    if is_scoped >= 1 or is_grenade then
        ani.s = lerp(ani.s, 40,globals.frametime() * 4)
        ani.xx = lerp(ani.xx, 35,globals.frametime() * 4)
        ani.x1 = lerp(ani.x1, 42,globals.frametime() * 4)
        ani.x2 = lerp(ani.x2, 33,globals.frametime() * 4)
        ani.x3 = lerp(ani.x3, 30,globals.frametime() * 4)
        ani.x4 = lerp(ani.x4, 31,globals.frametime() * 4)
        ani.x5 = lerp(ani.x5, 32,globals.frametime() * 4)
        ani.x6 = lerp(ani.x6, 30,globals.frametime() * 4)
        ani.x7 = lerp(ani.x7, 30,globals.frametime() * 4)
        ani.glow = lerp(ani.glow, 0,globals.frametime() * 4)
        ani.glow2 = lerp(ani.glow2, 255,globals.frametime() * 4)
    else
        ani.glow = lerp(ani.glow, 255,globals.frametime() * 4)
        ani.glow2 = lerp(ani.glow2, 0,globals.frametime() * 4)
        ani.s = lerp(ani.s, 0,globals.frametime() * 4)
        ani.xx = lerp(ani.xx, 0,globals.frametime() * 4)
        ani.x1 = lerp(ani.x1, 0,globals.frametime() * 4)
        ani.x2 = lerp(ani.x2, 0,globals.frametime() * 4)
        ani.x3 = lerp(ani.x3, 0,globals.frametime() * 4)
        ani.x4 = lerp(ani.x4, 0,globals.frametime() * 4)
        ani.x5 = lerp(ani.x5, 0,globals.frametime() * 4)
        ani.x6 = lerp(ani.x6, 0,globals.frametime() * 4)
        ani.x7 = lerp(ani.x7, 0,globals.frametime() * 4)
    end

    local center_x, center_y = client_screen_size()
    local w, h = center_x , center_y
    local plocal = entity_get_local_player()
    if not entity.is_alive(entity.get_local_player()) then
        return
    end
    local h_index = 1
    local realtime = globals_realtime() % 3
	local alpha = math.floor(math.sin(realtime * 4) * (255/3-1) + 255/2) or 255
    local r2, g2, b2, a2 = ui.get(items.arrows_clr)
    local r4, g4, b4, a4 = ui.get(items.main_clr)
    local r5, g5, b5, a5 = ui.get(items.main_clr_a)
    local rounding = 4
    local o = 20
    local rad = rounding + 2
    local n = 45
    local RoundedRect = function(x, y, w, h, radius, r, g, b, a) renderer.rectangle(x+radius,y,w-radius*2,radius,r,g,b,a)renderer.rectangle(x,y+radius,radius,h-radius*2,r,g,b,a)renderer.rectangle(x+radius,y+h-radius,w-radius*2,radius,r,g,b,a)renderer.rectangle(x+w-radius,y+radius,radius,h-radius*2,r,g,b,a)renderer.rectangle(x+radius,y+radius,w-radius*2,h-radius*2,r,g,b,a)renderer.circle(x+radius,y+radius,r,g,b,a,radius,180,0.25)renderer.circle(x+w-radius,y+radius,r,g,b,a,radius,90,0.25)renderer.circle(x+radius,y+h-radius,r,g,b,a,radius,270,0.25)renderer.circle(x+w-radius,y+h-radius,r,g,b,a,radius,0,0.25) end
    local OutlineGlow = function(x, y, w, h, radius, r, g, b, a) renderer.rectangle(x+2,y+radius+rad,1,h-rad*2-radius*2,r,g,b,a)renderer.rectangle(x+w-3,y+radius+rad,1,h-rad*2-radius*2,r,g,b,a)renderer.rectangle(x+radius+rad,y+2,w-rad*2-radius*2,1,r,g,b,a)renderer.rectangle(x+radius+rad,y+h-3,w-rad*2-radius*2,1,r,g,b,a)renderer.circle_outline(x+radius+rad,y+radius+rad,r,g,b,a,radius+rounding,180,0.25,1)renderer.circle_outline(x+w-radius-rad,y+radius+rad,r,g,b,a,radius+rounding,270,0.25,1)renderer.circle_outline(x+radius+rad,y+h-radius-rad,r,g,b,a,radius+rounding,90,0.25,1)renderer.circle_outline(x+w-radius-rad,y+h-radius-rad,r,g,b,a,radius+rounding,0,0.25,1) end
    local FadedRoundedGlow = function(x, y, w, h, radius, r, g, b, a, glow, r1, g1, b1) local n=a/255*n;renderer.rectangle(x+radius,y,w-radius*2,1,r,g,b,140)renderer.circle_outline(x+radius,y+radius,r,g,b,140,radius,180,0.25,1)renderer.circle_outline(x+w-radius,y+radius,r,g,b,140,radius,270,0.25,1)renderer.rectangle(x,y+radius,1,h-radius*2,r,g,b,140)renderer.rectangle(x+w-1,y+radius,1,h-radius*2,r,g,b,140)renderer.circle_outline(x+radius,y+h-radius,r,g,b,140,radius,90,0.25,1)renderer.circle_outline(x+w-radius,y+h-radius,r,g,b,140,radius,0,0.25,1)renderer.rectangle(x+radius,y+h-1,w-radius*2,1,r,g,b,140) for radius=4,glow do local radius=radius/2;OutlineGlow(x-radius,y-radius,w+radius*2,h+radius*2,radius,r1,g1,b1,glow-radius*2)end end
    local container_glow = function(x, y, w, h, r, g, b, a, alpha,r1, g1, b1, fn) if alpha*255>0 then renderer.blur(x,y,w,h)end;RoundedRect(x,y,w,h,rounding,17,17,17,a)FadedRoundedGlow(x,y,w,h,rounding,r,g,b,alpha*255,alpha*o,r1,g1,b1)if not fn then return end;fn(x+rounding,y+rounding,w-rounding*2,h-rounding*2.0) end
    local body = math.min(57, entity.get_prop(plocal, "m_flPoseParameter", 11)*120-60)
    local e_pose_param = math.min(57, entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60)
    local me = entity_get_local_player()
    local perc = math.abs( e_pose_param )/60
    local dys = math.floor( perc*40 )
    local velocity_x, velocity_y = entity.get_prop(entity.get_local_player(), "m_vecVelocity")
    local velocity = math.sqrt(velocity_x^2 + velocity_y^2)
    local offset = (400 - velocity)/400*60
    local screen = {client.screen_size()}
    local center = {screen[1] / 2, screen[2] / 2}

    if ui.get(master_switch) and ui.get(items.anti_aim) then
        if includes(items.indbox, "Arrow indicators") then
            if ui.get(items.bodyyaw_ind) == "A" then
                if ui.get(items.manual_state) == 0 then 
                elseif ui.get(items.manual_state) == 1 then 
                    renderer.text(center_x / 2 - 80, h / 2 , r2, g2, b2, 255, "cb+", 0, "<")
                elseif ui.get(items.manual_state) == 2  then
                    renderer.text(center_x / 2 + 80, h / 2 , r2, g2, b2, 255, "cb+", 0, ">")
                end
            elseif ui.get(items.bodyyaw_ind) == "B" then
                if ui.get(items.manual_state) == 0 then 
                    renderer.text(center_x / 2 - 55 , center_y / 2 , 25, 25, 25, 80, "cb+", 0, "<")
                    renderer.text(center_x / 2 + 55 , center_y / 2 , 25, 25, 25, 80, "cb+", 0, ">")
                elseif ui.get(items.manual_state) == 1 then 
                    renderer.text(center_x / 2 - 55 , center_y / 2 , r2, g2, b2, 255, "cb+", 0, "<")
                    renderer.text(center_x / 2 + 55 , center_y / 2 , 25, 25, 25, 80, "cb+", 0, ">")
                elseif ui.get(items.manual_state) == 2  then
                    renderer.text(center_x / 2 + 55 , center_y / 2 , r2, g2, b2, 255, "cb+", 0, ">")
                    renderer.text(center_x / 2 - 55 , center_y / 2 , 25, 25, 25, 80, "cb+", 0, "<")
                end
            elseif ui.get(items.bodyyaw_ind) == "C" then
                crosshair_size_1 = ui.get(items.clr_size)
                angle = math.min(57, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11) * 120 - 60))
                color = {296 - (angle * 2.614035087719298), angle * 3.666666666666667, angle * 0.7543859649122807}
                local function normalize_yaw(yaw)
                    while yaw > 180 do
                        yaw = yaw - 360
                    end
                    while yaw < -180 do
                        yaw = yaw + 360
                    end
                    return yaw
                end
                local function calc_angle(local_x, local_y, enemy_x, enemy_y)
                    local ydelta = local_y - enemy_y
                    local xdelta = local_x - enemy_x
                    local relativeyaw = math_atan(ydelta / xdelta)
                    relativeyaw = normalize_yaw(relativeyaw * 180 / math_pi)
                    if xdelta >= 0 then
                        relativeyaw = normalize_yaw(relativeyaw + 180)
                    end
                    return relativeyaw
                end
                local cam = vector(client_camera_angles())
                local plocal = entity.get_local_player()
                local h = vector(entity_hitbox_position(plocal, "head_0"))
                local p = vector(entity_hitbox_position(plocal, "pelvis"))
                local scrsize_x, scrsize_y = client.screen_size()
                local center_x, center_y = scrsize_x / 2, scrsize_y / 2.003
        
                local yaw = normalize_yaw(calc_angle(p.x, p.y, h.x, h.y) - cam.y + 120)
                if mode_state == 1 then
                    renderer.circle_outline(center_x + 1, center_y, r2, g2, b2, a2, crosshair_size_1, 270, 5, 4)
                    renderer.circle_outline(center_x + 1, center_y, r2, g2, b2, a2, crosshair_size_1 * 1.833,(yaw * -1) - 15, 0.14, 4)
                else
                    renderer.circle_outline(center_x + 1, center_y, r2, g2, b2, a2,crosshair_size_1 * 1.833, (yaw * -1) - 15, 0.14, 3.6)
                    end
                end
            end

        --indicators
    if includes(items.indbox, "Crosshair indicators") then    
        if includes(items.indbox2, "indication") then
            local logo = gradient_text(r4, g4, b4, 255, r5, g5, b5,  alpha, ("SMK.tech"))
            renderer.text(w / 2 + ani.s , h / 2 + 30 , 255, 255, 255, 255, "c-", 0, string.upper(logo))
            renderer.text(w / 2  + ani.s , h / 2 + 40 , 255, 255, 255, ani.glow, "c-", 0, body > 0 and "%" or "/", string.upper(""..vars.yaw_status), 0, body > 0 and "%" or "/")
            renderer_rectangle(w / 2 - 12 + ani.xx,h / 2 + 37 , 41, 8, 15, 15, 15, ani.glow2)
            renderer.gradient(w / 2 - 11 + ani.xx,h / 2 + 39 ,math.floor(math.abs(dys)), 4, r4,g4,b4,ani.glow2, r5, g5, b5, ani.glow2,true)
            renderer.text(w / 2 + 38 + ani.xx , h / 2 + 40 , 255, 255, 255, ani.glow2, "c-", 0, string.upper(math.floor(math.abs(dys))).." %")
            renderer.text(w / 2  + ani.x1 , h / 2 + 59 - math_floor(ani.y1) , 220, 220, 220, ani.fs_alpha, "c-", nil, "FREESTAND")
            renderer.text(w / 2  + ani.x2 , h / 2 + 59 - math_floor(ani.y2) + first_offset , 255, 0, 0, ani.dt_alpha, "c-", nil, "READY")
            renderer.text(w / 2  + ani.x3 , h / 2 + 59 - math_floor(ani.y3) + second_offset , 255, 255, 255, ani.hide_alpha, "c-", nil, "HIDE")
            renderer.text(w / 2  + ani.x4 , h / 2 + 59 - math_floor(ani.y4) + thrid_offset , 170, 50, 255, ani.baim_alpha, "c-", nil, "BAIM")
            renderer.text(w / 2  + ani.x5 , h / 2 + 59 - math_floor(ani.y5) + fourth_offset , 80, 80, 255, ani.duck_alpha, "c-", nil, "DUCK")
            renderer.text(w / 2  + ani.x6 , h / 2 + 59 - math_floor(ani.y6) + fiveth_offset , 255, 255, 255, ani.ping_alpha, "c-", nil, "PING")
            renderer.text(w / 2  + ani.x7 , h / 2 + 59 - math_floor(ani.y7) + sixth_offset , 120, 200, 120, ani.sp_alpha, "c-", nil, "SAFE")
            end
        end
    if includes(items.indbox, "Crosshair indicators") then            
        if includes(items.indbox2, "watermark") then
            container_glow(center_x / 2 - 137 , center_y / 2 + 702 + ui.get(items.z_offset), 270, 16, 148, 155, 255, 30, 0, 148, 155, 255)
            renderer.text(center_x / 2 , center_y / 2 + 710 + ui.get(items.z_offset), 255, 255, 255, 255, "cb", 0, "\aADB5FFFFSmoke.tech \aFFFFFFFFCustom \aFFE092FFAnti Aim \aFFFFFFFFUser:\aFFB4B4FF Ev1-1337")
        end
    end     

            if includes(items.indbox, "Debug indicators") then
                if ui.get(items.Debug_box) == "+" then            
            local SM1 = gradient_text(148, 155, 255, 170, 255, 255, 255, 255, "smoke-exploits.te")
            renderer.text(200 + ui.get(items.y_offset) , h / 2 + 209 + ui.get(items.x_offset) , 255, 255, 255, 255, "b", 0, SM1)
            local SM2 = gradient_text(255, 255, 255, 255, 148, 155, 255, 170, "ch - version: Alpha")
            renderer.text(290 + ui.get(items.y_offset) , h / 2 + 209 + ui.get(items.x_offset) , 255, 255, 255, 255, "b", 0, SM2)
            renderer.text(200 + ui.get(items.y_offset) , h / 2 + 240 + ui.get(items.x_offset) , 185, 255, 225, 200, nil, nil, string.lower("> player info : state - "..vars.yaw_status))
            renderer.text(200 + ui.get(items.y_offset) , h / 2 + 224 + ui.get(items.x_offset) , 147, 154, 200, 255, "", 0, string.lower("> anti aim : side - (")..vars.best_angle..", "..vars.p_state..", "..vars.indexed_angle..")",vars.best_enemy == nil and string.lower(" - predicted target: nil") or string.lower(" - predicted target: ")..entity_get_player_name(vars.best_enemy))
            if not (vars.misses[vars.best_enemy] == nil or vars.misses[vars.best_enemy] == 2) then
                renderer.text(200 + ui.get(items.y_offset) , h / 2 + 255 + ui.get(items.x_offset) , 235, 185, 145, 215, "", 0, string.lower("> anti-bruteforce - ").."true",string.lower(" - brute info misses : ")..vars.indexed_angle)
            else
                renderer.text(200 + ui.get(items.y_offset) , h / 2 + 255 + ui.get(items.x_offset) , 215, 185, 205, 215, "", 0, string.lower("> anti-bruteforce - ").."false",string.lower(" - brute info misses : ")..vars.indexed_angle)
            end
        elseif ui.get(items.Debug_box) == "-" then               
                local scrsize_x, scrsize_y = client.screen_size()
                local center_x, center_y = scrsize_x / 2, scrsize_y / 2.003
                local local_avatar = images.get_steam_avatar(entity.get_steam64(entity.get_local_player()))
                container_glow(center_x-960 + ui.get(items.y_offset), center_y - 12 + ui.get(items.x_offset), 220, 50, 148, 175, 255, 30, 0, 148, 155, 255)
                local_avatar:draw(center_x-952 + ui.get(items.y_offset), center_y - 4 + ui.get(items.x_offset), nil, 33)
                renderer.text(center_x-910 + ui.get(items.y_offset), center_y + 19 + ui.get(items.x_offset), 255, 255, 255, 255, "b", 0, "Latest update time  - 2023 . 3.24 ")
                local SM3 = gradient_text(148, 155, 255, 255, 255, 255, 255, 255, "Smoke.tech* expl ")
                renderer.text(center_x-910 + ui.get(items.y_offset), center_y - 7 + ui.get(items.x_offset), 255, 255, 255, 255, 'b', 0, SM3)
                local SM4 = gradient_text(255, 255, 255, 255, 148, 155, 255, 255, " oits [Alpha]")
                renderer.text(center_x-825 + ui.get(items.y_offset), center_y - 7 + ui.get(items.x_offset), 255, 255, 255, 255, 'b', 0, SM4)
                renderer.text(center_x-913 + ui.get(items.y_offset), center_y + 6 + ui.get(items.x_offset), 255, 255, 255, 255, 'b', 0, " \a90AEFFFFPredicted:\aFFFFFFFF "..entity_get_player_name(vars.best_enemy))
                       end
                   end
                end
            end
local function anti_aim_on_use(e)

    if includes(items.extra_conditions, "Legit AA on use") and ui_get(items.legit_aa) and e.in_use == 1 then

        if entity_get_classname(entity_get_player_weapon(entity_get_local_player())) == "CC4" then return end

        if e.in_attack == 1 then

            e.in_use = 1

        end
    
        if e.chokedcommands == 0 then

            e.in_use = 0

        end

    end

end

--local menu = handler_ui:menu_funcs(ui.new_checkbox('AA', 'Anti-aimbot angles', 'SMOKE YAW'),true)

local export = ui.new_button("AA","other",'\aFFDEADFFExport from clipboard',function ()
    self = handler_ui or self
	local str = ""
    --print(1)
    for i,o in pairs(self.menu_need_to_export['number']) do
        str = str .. tostring(ui.get(o)) .. '|'
    end
    for i,o in pairs(self.menu_need_to_export['string']) do
        --print(ui.get(o))
        str = str .. ui.get(o) .. '|'
    end
    for i,o in pairs(self.menu_need_to_export['boolean']) do
        str = str .. tostring(ui.get(o)) .. '|'
    end
    for i,o in pairs(self.menu_need_to_export['table']) do
        str = str .. arr_to_string(o) .. '|'
    end

    clipboard_api.set(base64.encode(str, 'base64'))
end)

local import = ui.new_button("AA","other",'\aFFDEADFFImport from clipboard',function ()
    self = handler_ui or self
	local tbl = str_to_sub(base64.decode(clipboard_api.get(), 'base64'), "|")
    local p = 1

    for i,o in pairs(self.menu_need_to_export['number']) do
        ui.set(o,tbl[p])
        p = p + 1
    end
    for i,o in pairs(self.menu_need_to_export['string']) do
        --print(ui.name(o),tbl[p])
        ui.set(o,(tbl[p]))
        p = p + 1
    end
    for i,o in pairs(self.menu_need_to_export['boolean']) do
        ui.set(o,to_boolean(tbl[p]))
        p = p + 1
    end
    for i,o in pairs(self.menu_need_to_export['table']) do
        ui.set(o,str_to_sub(tbl[p],','))
        p = p + 1
    end
end)

--slowwalk limit
local function modify_velocity(cmd, goalspeed)
	if goalspeed <= 0 then
		return
	end
	
	local minimalspeed = math_sqrt((cmd.forwardmove * cmd.forwardmove) + (cmd.sidemove * cmd.sidemove))
	
	if minimalspeed <= 0 then
		return
	end
	
	if cmd.in_duck == 1 then
		goalspeed = goalspeed * 2.94117647 -- wooo cool magic number
	end
	
	if minimalspeed <= goalspeed then
		return
	end
	
	local speedfactor = goalspeed / minimalspeed
	cmd.forwardmove = cmd.forwardmove * speedfactor
	cmd.sidemove = cmd.sidemove * speedfactor
end

local function on_setup_cmd(cmd)	
	local checkbox = ui.get(refs.slowwalk[1])
	local hotkey = ui.get(refs.slowwalk[2])
	local limit = ui.get(items.limit_reference)
	
	if limit >= 57 then
		return
	end
	
	if checkbox and hotkey and ui.get(items.keyshow) and ui.get(master_switch) then
		modify_velocity(cmd, limit)
	end
end

client.set_event_callback('setup_command', on_setup_cmd)

local time = globals.realtime()
local switch = false

local events = {
    setup_command = function(e)
        anti_aim_on_use(e)
        anti_aim1(e)

        local lp_bodyyaw = entity_get_prop(entity_get_local_player(), "m_flPoseParameter", 11) * 120 - 60

        if ui.get(master_switch) and ui.get(items.anti_aim) then 
            ui.set(refs.pitch, ui.get(anti_aim[vars.p_state].pitch))
            ui.set(refs.yaw_base, ui.get(anti_aim[vars.p_state].yawbase))
            ui.set(refs.yaw[1], ui.get(anti_aim[vars.p_state].yaw))

            if globals.realtime() - time > ui.get(anti_aim[vars.p_state].yaw_speed) / 10 then
                if not switch then
                    switch = true
                else
                    switch = false
                end
                time = globals.realtime()
            end

            if not switch then
                ui.set(refs.yaw[2], ui.get(anti_aim[vars.p_state].yaw_left))
            else
                ui.set(refs.yaw[2], ui.get(anti_aim[vars.p_state].yaw_right))
            end
            --ui.set(refs.yaw[2], (lp_bodyyaw < 0 and ui.get(anti_aim[vars.p_state].yaw_left) or ui.get(anti_aim[vars.p_state].yaw_right)))

            ui.set(refs.yawj[1], ui.get(anti_aim[vars.p_state].yawjitter))
            ui.set(refs.yawj[2], (lp_bodyyaw < 0 and ui.get(anti_aim[vars.p_state].yawjitteradd_left) or ui.get(anti_aim[vars.p_state].yawjitteradd_right)))
            ui.set(refs.bodyyaw[1], ui.get(anti_aim[vars.p_state].bodyyaw))
            ui.set(refs.bodyyaw[2], (lp_bodyyaw < 0 and ui.get(anti_aim[vars.p_state].bodyyaw_left) or ui.get(anti_aim[vars.p_state].bodyyaw_right)))
            ui.set(refs.fs_bodyyaw, false)
            if ui.get(anti_aim[vars.p_state].randomfakeyawlimit) then
                --ui.set(refs.fakelimit, math.random(ui.get(anti_aim[vars.p_state].randomfakeyawlimit1),ui.get(anti_aim[vars.p_state].randomfakeyawlimit2)))
            else --ui.set(refs.fakelimit, ui.get(anti_aim[vars.p_state].fakeyawlimit))
            end
        end
    end,
    weapon_fire = function(e)
        
    end,
    paint = function()
        bind_systeam:updata()
        draw_crosshair_indicators()
    end,
    run_command = function(e)
        get_best_enemy()
        get_best_angle()
    end,
    bullet_impact = function(e)
        miss_detection(e)
    end,
    handle_menu = function()  
        vars.active_i = vars.state_to_idx[ui_get(conditions)]

        ui_set_visible(menu, ui_get(master_switch))
            --aa
            ui_set_visible(items.anti_aim, ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
            ui_set_visible(items.anti_knife, ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
            ui_set_visible(items.extra_conditions, ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
            ui_set_visible(items.legit_aa, ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and includes(items.extra_conditions, "Legit AA on use") and ui_get(master_switch))
            ui_set_visible(items.edge, ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch) and includes(items.extra_conditions, "Edge yaw on key"))
            ui_set_visible(items.freestanding, ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch) and includes(items.extra_conditions, "Freestanding on key"))
            ui_set_visible(items.manual_backward_dir, ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and includes(items.extra_conditions, "Manual back") and ui_get(master_switch))
            ui_set_visible(items.manual_left_dir, ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and includes(items.extra_conditions, "Manual left") and ui_get(master_switch))
            ui_set_visible(items.manual_right_dir, ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and includes(items.extra_conditions, "Manual right") and ui_get(master_switch))
            ui_set_visible(items.fs_mode, ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
            --indicators
            ui_set_visible(items.indbox, ui_get(menu) == "Indicators" and ui_get(master_switch))
            ui_set_visible(items.indbox2, ui_get(menu) == "Indicators" and includes(items.indbox, "Crosshair indicators") and ui_get(master_switch))
            ui_set_visible(items.Debug_box, ui_get(menu) == "Indicators" and includes(items.indbox, "Debug indicators") and ui_get(master_switch))
            ui_set_visible(items.bodyyaw_ind, ui_get(menu) == "Indicators" and includes(items.indbox, "Arrow indicators") and ui_get(master_switch))
            ui_set_visible(items.main_clr, ui_get(menu) == "Indicators" and includes(items.indbox, "Crosshair indicators") and ui_get(master_switch))
            ui_set_visible(items.main_clr_a, ui_get(menu) == "Indicators" and includes(items.indbox, "Crosshair indicators") and ui_get(master_switch))
            ui_set_visible(items.main_label, ui_get(menu) == "Indicators" and includes(items.indbox, "Crosshair indicators") and ui_get(master_switch))    
            ui_set_visible(items.main_label_1, ui_get(menu) == "Indicators" and includes(items.indbox, "Crosshair indicators") and ui_get(master_switch))
            ui_set_visible(items.arrows_clr, ui_get(menu) == "Indicators" and includes(items.indbox, "Arrow indicators") and ui_get(master_switch))
            ui_set_visible(items.arrows_label , ui_get(menu) == "Indicators" and includes(items.indbox, "Arrow indicators") and ui_get(master_switch))
            ui_set_visible(items.x_offset, ui_get(menu) == "Indicators" and (includes(items.indbox, "Debug indicators") and ui_get(master_switch)))
            ui_set_visible(items.y_offset, ui_get(menu) == "Indicators" and (includes(items.indbox, "Debug indicators") and ui_get(master_switch)))
            ui_set_visible(items.z_offset, ui_get(menu) == "Indicators" and (includes(items.indbox, "Crosshair indicators") and ui_get(master_switch)))
            ui_set_visible(items.clr_size, ui_get(menu) == "Indicators" and (includes(items.indbox, "Arrow indicators") and ui_get(master_switch)))
            --custom aa
            ui_set_visible(conditions,  ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
            ui_set_visible(label1,  ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
            ui_set_visible(export,  ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
            ui_set_visible(import,  ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
            for i= 1, 12 do
                ui_set_visible(anti_aim[i].enabled, vars.active_i == i and i > 1 and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].pitch, vars.active_i == i  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].yawbase, vars.active_i == i  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].yaw, vars.active_i == i  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].yaw_left, vars.active_i == i and ui_get(anti_aim[vars.active_i].yaw) ~= "Off"  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].yaw_right, vars.active_i == i and ui_get(anti_aim[vars.active_i].yaw) ~= "Off"  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].yaw_speed, vars.active_i == i and ui_get(anti_aim[vars.active_i].yaw) ~= "Off"  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].yawjitter, vars.active_i == i  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].yawjitteradd_left, vars.active_i == i and ui_get(anti_aim[vars.active_i].yawjitter) ~= "Off"  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].yawjitteradd_right, vars.active_i == i and ui_get(anti_aim[vars.active_i].yawjitter) ~= "Off"  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].bodyyaw, vars.active_i == i  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].bodyyaw_left, vars.active_i == i and (ui_get(anti_aim[i].bodyyaw) == "Jitter" or ui_get(anti_aim[i].bodyyaw) == "Static") and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].bodyyaw_right, vars.active_i == i and (ui_get(anti_aim[i].bodyyaw) == "Jitter" or ui_get(anti_aim[i].bodyyaw) == "Static") and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(master_switch))
                ui_set_visible(anti_aim[i].fakeyawlimit, flase)
                ui_set_visible(anti_aim[i].randomfakeyawlimit, flase)
                ui_set_visible(anti_aim[i].randomfakeyawlimit1, vars.active_i == i  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(anti_aim[i].randomfakeyawlimit) and ui_get(master_switch))
                ui_set_visible(anti_aim[i].randomfakeyawlimit2, vars.active_i == i  and ui_get(items.anti_aim) and ui_get(menu) == "Anti-Aim" and ui_get(anti_aim[i].randomfakeyawlimit) and ui_get(master_switch))
            end
            ui_set_visible(items.manual_state, false)
            --ui_set_visible(refs.maxprocessticks, not ui_get(master_switch))
            ui_set_visible(refs.yaw[2], not ui_get(master_switch))
            ui_set_visible(refs.yawj[1], not ui_get(master_switch))
            ui_set_visible(refs.yaw[1], not ui_get(master_switch))
            ui_set_visible(refs.yawj[2], not ui_get(master_switch))
            ui_set_visible(refs.pitch, not ui_get(master_switch))
            ui_set_visible(refs.bodyyaw[1], not ui_get(master_switch))
            ui_set_visible(refs.bodyyaw[2], not ui_get(master_switch))
            ui_set_visible(refs.fs_bodyyaw, not ui_get(master_switch))
            ui_set_visible(refs.yaw_base, not ui_get(master_switch))
            --ui_set_visible(refs.fakelimit, not ui_get(master_switch))
            ui_set_visible(refs.edge_yaw, not ui_get(master_switch))
            ui_set_visible(refs.fs[1], not ui_get(master_switch))
            ui_set_visible(refs.fs[2], not ui_get(master_switch))
			--Misc
            ui_set_visible(items.enable_it, ui_get(menu) == "Misc" and ui_get(master_switch))			
            ui_set_visible(items.keyshow, ui_get(menu) == "Misc" and ui_get(master_switch))	
            ui_set_visible(items.limit_reference, ui_get(menu) == "Misc" and ui_get(master_switch) and ui_get(items.keyshow))			
    end,
    reset = function()
        vars.misses, vars.last_miss, vars.indexed_angle = { }, 0, 0
    end
}

local function main()
    client.set_event_callback("setup_command", events.setup_command)
    client.set_event_callback("weapon_fire", events.weapon_fire)
    client.set_event_callback("paint", events.paint)
    client.set_event_callback("run_command", events.run_command)
    client.set_event_callback("bullet_impact", events.bullet_impact)
    client.set_event_callback("client_disconnect", events.reset)
    client.set_event_callback("game_newmap", events.reset)
    client.set_event_callback("cs_game_disconnected", events.reset)
    client.set_event_callback("round_start", events.reset)
end
main()
ui_set_callback(master_switch, main)
client_set_event_callback("paint_ui", events.handle_menu)

