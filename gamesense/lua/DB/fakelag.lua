--uis
local ui_get, ui_set, ui_ref = ui.get, ui.set, ui.reference
local ui_new_checkbox = ui.new_checkbox
local ui_new_hotkey = ui.new_hotkey
local ui_new_combobox = ui.new_combobox
local ui_new_slider = ui.new_slider
local ui_multiselect = ui.new_multiselect
local ui_new_color_picker = ui.new_color_picker
local ui_reference = ui.reference
local ui_set_visible = ui.set_visible
local set_callback = ui.set_callback
--

--client
local client_log = client.log
local client_camera_angles = client.camera_angles
local client_trace_bullet = client.trace_bullet
local client_draw_text = client.draw_text
local client_screensize = client.screen_size
local set_event_callback = client.set_event_callback
local delay_call = client.delay_call
local client_trace_line = client.trace_line
--

--globals
local globals_curtime = globals.curtime
local globals_realtime = globals.realtime
local g_tickcount = globals.tickcount
local interval_per_tick = globals.tickinterval
--

--entity
local entity_is_alive = entity.is_alive
local get_prop = entity.get_prop
local get_local_player = entity.get_local_player
local entity_is_enemy = entity.is_enemy
local get_player_weapon = entity.get_player_weapon
local entity_get_player_weapon = entity.get_player_weapon
local entity_get_players = entity.get_players
local entity_hitbox_position = entity.hitbox_position
--

-- ref menu items 
local fakelag_exploit = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local ut_exploit = ui_reference("MISC", "Settings", "Anti-untrusted")
local dt_exploit = ui.reference("RAGE", "Other", "Double tap fake lag limit")
--RAGE tab
local rage_checkbox, rage_hotkey = ui_reference("RAGE", "Aimbot", "Enabled")
local ref_minimum_dmg = ui.reference("RAGE", "Aimbot", "Minimum Damage")
local ref_fakeduck = ui_reference("RAGE", "Other", "Duck peek assist")
local ref_doubletap, ref_doubletap_hk = ui_reference("RAGE", "Other", "Double tap")
--Fake-lag tab
local refk_checkbox, refk_checkbox_hk = ui_reference("AA", "Fake lag", "Enabled")
local refk_amount = ui_reference("aa", "Fake lag", "Amount")
local refk_variance = ui_reference("aa", "Fake lag", "Variance")
local refk_limit = ui_reference("aa", "Fake lag", "Limit")
--OTHER tab
local ref_slow_motion, ref_slow_motion_hk = ui_reference("aa", "Other", "Slow motion")
local ref_onshotaa, ref_hk_onshotaa = ui_reference("aa", "Other", "On shot anti-aim")
local ref_pitch = ui_reference("aa", "anti-aimbot angles", "Pitch")
--

local ui_fakelag = ui_new_checkbox("AA", "Fake lag", "[heaven.lua] Fake-lag heaven")
local hold_aim = ui_new_checkbox("AA", "Fake lag", "hold aim")
ui.set_visible(hold_aim, false)

local options = { "On shot correction", "Double tap correction", "Fake duck correction"}
local ui_settings = ui_multiselect("AA", "Fake lag", "Settings:", options)
local ui_inter_shot = ui_new_checkbox("AA", "Fake lag", "Disable On shot interpolation")

-- Extra fakelag opt
local b_amount = ui_new_combobox("AA", "Fake lag", "Amount", {"Adaptive", "Maximum", "Random", "Fluctuate", "Alternative"})
local b_alwaysfl = ui_new_checkbox("AA", "Fake lag", "Force fake lag chock")
local b_normal_limit = ui_new_slider("AA", "Fake lag", "Normal limit", 1, 15, 1, true)

local b_cond_opt = {"Standing", "Moving", "In air", "Slow walk"--[[, "Unduck"]]}
local b_trigger_opt = {--[["In air",]] "On peek"--[[, "On shot"]]}
local b_altercond = ui_multiselect("AA", "Fake lag", "alternative condition", b_cond_opt)
local b_send_limit = ui_new_slider("AA", "Fake lag", "Send limit", 1, 15, 1, true)
local b_choke_limit = ui_new_slider("AA", "Fake lag", "Choke limit", 1, 15, 1, true)
local b_triggers = ui_multiselect("AA", "Fake lag", "triggers", b_trigger_opt)
local b_trigger_slider = ui_new_slider("AA", "Fake lag", "trigger limit", 1, 15, 1, true)
ui.set(b_triggers, {""})
ui.set_visible(b_triggers, false)
ui.set_visible(b_trigger_slider, false)
--local debug_fd = ui_new_slider("AA", "Fake lag", "debug fd", 700000, 810000, 750000, true, "" , 0.000001)
--

--multi select function
local function contains(tab, val)
    for index, value in ipairs(ui.get(tab)) do
        if value == val then return true end
    end
    return false
end
--

local multi_exec = function(func, list)
    if func == nil then
        return
    end

    for ref, val in pairs(list) do
        func(ref, val)
    end
end

local c = false
local nc = false
local function desync_call(call)
    local c = ui_get(call)
    multi_exec(ui_set_visible, {
        [ui_settings] = c,
        [b_alwaysfl] = c,
        [ui_inter_shot] = c and contains(ui_settings, options[1]),
    })    
end

local function disable_itms()
    ui_set_visible(b_amount, false)
    ui_set_visible(b_normal_limit, false)
    ui_set_visible(b_altercond, false)
    ui_set_visible(b_send_limit, false)
    ui_set_visible(b_choke_limit, false)
    ui_set_visible(b_triggers, false)
    ui_set_visible(b_trigger_slider, false)
end
disable_itms()

-- Save fake lag/ fake lags
local vel = 0
local lag_dst = 0
local fk_dyn = false
local vec_data, flip = { }, true
local fk_jump = false
local in_jump = 0
local in_duck = 0
local random_limit = 1
local fix_lc = false

local reference = {
    pos = { },
    last_fl = 0
}

local cache = { }
local lag_data = { 
    count = 0, 
    extrapolated = { },
    should_lag = false
}

local function vec_add(a, b) 
    return { a[1] + b[1], a[2] + b[2], a[3] + b[3] }
end

--

-- Shot tick correction
local weapons_ignored = {
    "CKnife",
    "CWeaponTaser",
    "CC4",
    "CHEGrenade",
    "CSmokeGrenade",
    "CMolotovGrenade",
    "CSensorGrenade",
    "CFlashbang",
    "CDecoyGrenade",
    "CIncendiaryGrenade"
}

local function tablecont(table, item)
    for i=1, #table do
        if table[i] == item then
            return true
        end
    end
    return false
end
local data = {
    threshold = false,
    stored_last_shot = 0,
    stored_item = 0,
    onshot = 0,
}
--[[
local hotkey_modes = {
    [0] = "always on",
    [1] = "on hotkey",
    [2] = "toggle",
    [3] = "off hotkey"
}
local cache = { }
local set_cache = function(self)
    if not fk_dyn and not ui_get(ui_fakelag) then return end

    local process = function(name, condition, should_call, VAR)
    
        local _cond = ui_get(condition)
        local _type = type(_cond)
    
        local value, mode = ui_get(condition)
        local finder = mode ~= nil and mode or (_type == "boolean" and tostring(_cond) or _cond)
        cache[name] = cache[name] ~= nil and cache[name] or finder
    
        if should_call then ui_set(condition, mode ~= nil and hotkey_modes[VAR] or VAR) else
            if cache[name] ~= nil then
                local _cache = cache[name]
                
                if _type == "boolean" then
                    if _cache == "true" then _cache = true end
                    if _cache == "false" then _cache = false end
                end
    
                ui_set(condition, mode ~= nil and hotkey_modes[_cache] or _cache)
                cache[name] = nil
            end
        end
    end

    process("refk_limit", refk_limit, (self == nil and false or self), 1)
end
]]
local ch = {}
local hk_m = {
    [0] = "always on",
    [1] = "on hotkey",
    [2] = "toggle",
    [3] = "off hotkey"
}
local set_cache = function(self)
    local c_cache = function(active, name, cond ,call, c_var)

        if active then
            local c, t = ui_get(cond), type(c)
            local _, m = ui_get(cond)
            local f = m ~= nil and m or (t == "boolean" and tostring(c) or c)
            ch[name] = ch[name] ~= nil and ch[name] or f
            if call then ui_set(cond, m ~= nil and hk_m[c_var] or c_var) else
                if ch[name] ~= nil then
                    local chs = ch[name]
                    if t == "boolean" then
                        if chs == "true" then chs = true end
                        if chs == "false" then chs = false end               
                    end
                    ui_set(cond, m ~= nil and hk_m[chs] or chs)
                    ch[name] = nil
                end
            end
        end
    end
    c_cache(true ,"refk_limit", refk_limit , (self == nil and false or self) , 1)
    --c_cache(true ,"ut_exploit", ut_exploit , (self == nil and false or self) , false)
    --c_cache(true ,"ref_pitch", ref_pitch , (self == nil and false or self) , "Off")
end
set_event_callback("shutdown", set_cache)

set_event_callback("setup_command", function(cmd)
    if not ui_get(ui_fakelag) then return end
    if not fk_dyn or ui_get(ref_hk_onshotaa) and ui_get(ref_onshotaa) then return end
    if not ui_get(ref_doubletap_hk) then
        if ui_get(b_alwaysfl) or ui_get(b_amount) == "Alternative" then
            -- cmd.allow_send_packet = cmd.chokedcommands >= ui_get(refk_limit)
            cmd.allow_send_packet = false
        end
    end
    local me = get_local_player()
    local weapon = entity_get_player_weapon(me)
    local get_classname = entity.get_classname
    local duck_amount = get_prop(me, "m_flDuckAmount")
    local suprass_duck = duck_amount <= 0.78
    if weapon == nil or tablecont(weapons_ignored, get_classname(weapon)) then
        return
    end      

    local last_shot_time = get_prop(weapon, "m_fLastShotTime")
    local m_iItem = bit.band(get_prop(weapon, "m_iItemDefinitionIndex"), 0xFFFF)

    limitation = function(cmd)

        if not contains(ui_settings, options[1]) then return end
        if ui_get(ref_fakeduck) then return false end 

        if not data.threshold and last_shot_time ~= data.stored_last_shot then
            data.stored_last_shot = last_shot_time
            data.threshold = true
            return true
        end

        if data.threshold and cmd.chokedcommands >= 1 then
            data.threshold = false
            return true
        end   
        return false   
    end
    
    if data.stored_item ~= m_iItem then
        data.stored_last_shot = last_shot_time
        data.stored_item = m_iItem
    end   
   set_cache(limitation(cmd))
end)
--

-- Dynamic fakelag

--save fakelag
local saved_checkbox = nil
local saved_checkbox_hk = ""
local saved_trigger = nil
local saved_triggers = {}
local saved_amount = {}
local saved_variance = nil
local saved_limit = nil
local saved_dt = nil
local saved_bhop = nil
local saved_onshot = nil
local saved_onshot_hk = ""

local disabled_fakelag = false
local saved_fix_value = false
local fk_timer = 0
--

local enable_dyn_fk = false
local hk_check = false
local onetime_save = true
local function save_fk_profile()

    local hk_check = ui_get(ui_fakelag)

    local check_enable = ui_get(refk_checkbox)
    local check_enable_hk = refk_checkbox_hk
    local check_Amount = ui_get(refk_amount)
    local check_variance = ui_get(refk_variance)
    local check_limit = ui_get(refk_limit)
    local check_dt = ui_get(dt_exploit)

    --save slider  
    if ui_get(ui_fakelag) then
        if globals_realtime() >= fk_timer then    
            if hk_check then
                if not disabled_fakelag and not saved_fix_value then

                    disabled_fakelag = true
                    saved_fix_value = true

                    saved_checkbox = check_enable
                    saved_checkbox_hk = check_enable_hk
                    saved_trigger = check_trigger
                    saved_triggers = check_triggers
                    saved_amount = check_Amount
                    saved_variance = check_variance
                    saved_limit = check_limit 
                    saved_dt = check_dt       
                end           
            else
                if disabled_fakelag then
                    disabled_fakelag = false
                    delay_call(.01 , function()
                    ui_set(refk_checkbox, saved_checkbox)
                    ui_set(refk_checkbox_hk, saved_checkbox_hk)
                    ui_set(refk_amount, saved_amount)
                    ui_set(refk_variance, saved_variance)   
                    local fix_limit = saved_limit >= 15 and 14 or saved_limit
                    ui_set(refk_limit, saved_limit)
                    ui_set(dt_exploit, saved_dt)
                    end)
                end
            end
        end
    end

    if ui_get(ui_fakelag) then
        if disabled_fakelag and hk_check and not enable_dyn_fk then
            enable_dyn_fk = true
        end    
    end     

    if ui_get(ui_fakelag) then return end

    if disabled_fakelag and enable_dyn_fk then
        disabled_fakelag = false
        delay_call(.01 , function()
        ui_set(dt_exploit, 1)
        ui_set(refk_checkbox, saved_checkbox)
        ui_set(refk_checkbox_hk, saved_checkbox_hk)    
        ui_set(refk_amount, saved_amount)
        ui_set(refk_variance, saved_variance)                
        ui_set(refk_limit, saved_limit)    
        ui_set(dt_exploit, saved_dt)         
        saved_fix_value = false
        end)
        return
    end
end
local vx, vy, vz = 0, 0, 0
local function Length2DSqr(vec) return (vec[1]*vec[1] + vec[2]*vec[2]) end
local function vecMvec(vec, vec1) return { vec[1]-vec1[1], vec[2]-vec1[2] } end

local function get_player_velocity(Entity)
    vx, vy, vz = get_prop(Entity, "m_vecVelocity")

    return math.floor(math.min(10000, math.sqrt(vx^2 + vy^2) + 0.5))
end

local g_Local = get_local_player()
local in_airdb = 0
set_event_callback("run_command", function(cmd)
    g_Local = get_local_player()
    if g_Local ~= nil and cmd.chokedcommands == 0 then

        local x, y, z = get_prop(g_Local, "m_vecOrigin")
        vec_data[flip and 0 or 1] = { x, y }

        flip = not flip
    end

    vx, vy, vz = get_prop(g_Local, "m_vecVelocity")
    if vx ~= nil and vy ~= nil and vz ~= nil then
        vel = math.sqrt(vx^2 + vy^2)

        in_airdb = vz^2 > 0
    end    
end)

lag_data.should_lag = function() return (lag_data.count > 0) end
lag_data.reset = function()
    lag_data.count = 0
    lag_data.extrapolated = { }
    reference.pos = { }
end

local ticks_left = 0
lag_data.predict_player = function(player, simulation_tick_delta, no_collision)
    local simulation_data = {
        entity = player,
        on_ground = get_prop(player, "m_hGroundEntity") ~= nil,

        velocity = { get_prop(player, "m_vecVelocity") },
        origin = { get_prop(player, "m_vecOrigin") },
    }

    local simulate_movement = function(record)
        local sv_gravity = cvar.sv_gravity:get_int()
        local sv_jump_impulse = cvar.sv_jump_impulse:get_int()

        local data = record
        local predicted_origin = data.origin
        local tickinterval = interval_per_tick()
    
        if not data.on_ground and not no_collision then
            local gravity_per_tick = sv_gravity * tickinterval
            data.velocity[3] = data.velocity[3] - gravity_per_tick
        end
    
        predicted_origin = vec_add(predicted_origin, {
            data.velocity[1] * tickinterval,
            data.velocity[2] * tickinterval,
            data.velocity[3] * tickinterval
        })

        local fraction = client_trace_line(player, data.origin[1], data.origin[2], data.origin[3], predicted_origin[1], predicted_origin[2], predicted_origin[3])
        local ground_fraction = client_trace_line(player, data.origin[1], data.origin[2], data.origin[3], data.origin[1], data.origin[2], data.origin[3] - 2)
    
        if no_collision or fraction > 0.97 then
            data.origin = predicted_origin
            data.on_ground = (ground_fraction == 0)
    
            lag_data.extrapolated[#lag_data.extrapolated+1] = data.origin
        end
    
        return data
    end

    if simulation_tick_delta > 0 then
        ticks_left = simulation_tick_delta

        repeat
            simulation_data = simulate_movement(simulation_data)
            ticks_left = ticks_left - 1
        until ticks_left < 1

        return simulation_data
    end
end

lag_data.trace_positions = function(me, local_pos, list)
    local ray_exec = function(me, local_pos, data)
        local index, dmg = client_trace_bullet(me, 
            local_pos[1], local_pos[2], local_pos[3], 
            data[1], data[2], data[3]
        )
    
        if index == nil or index == me or not entity.is_enemy(index) then
            return false
        end
        
        return dmg > ui_get(ref_minimum_dmg)
    end

    if local_pos[1] ~= nil then
        for i = 1, #list do
            if list[i][1] ~= nil and ray_exec(me, local_pos, list[i]) then
                return true
            end
        end
    end
    
    return false
end

client.set_event_callback("setup_command", function(cmd)
    local me = get_local_player()
    local players = entity_get_players(true)
    local eye_pos = { client.eye_position() } 
    local ui_ticks = 9

    if players == nil or eye_pos[1] == nil then
        return
    end    

    lag_data.reset() -- Reset previous command
    
    -- Process prediction
    if vel < 1 then reference.pos[1] = eye_pos else
        local v_offset = { get_prop(me, "m_vecViewOffset") }

        for i = 1, ui_ticks do
            local predicted_data = lag_data.predict_player(me, i, true)
            reference.pos[i] = vec_add(predicted_data.origin, v_offset)
        end
    end

    for i=1, #players do
        if get_prop(players[i], "m_bGunGameImmunity") == 0 then
            local hitboxes = {
                { entity_hitbox_position(players[i], 0) },
                { entity_hitbox_position(players[i], 4) },
                { entity_hitbox_position(players[i], 2) }
            }

            local pass, rpos = 
                false, reference.pos

            for i = 1, #rpos do
                if not pass and lag_data.trace_positions(me, rpos[i], hitboxes) then
                    pass = true
                end
            end

            if pass then
                lag_data.count = lag_data.count + 1
            end
        end
    end
end)

local should_lag_f = false
local chock = nil
local function triggers_code()
    if ui_get(ref_fakeduck) then return end
    -- On peek
    if should_lag_f and vel > 35 then
        ui_set(refk_checkbox, true)
        if b_amount == "Alternative" then              
            if ui_get(b_choke_limit) == 15 and (vel > 80 or fk_jump) then
                ui_set(refk_limit, 15) 
            else
                ui_set(refk_limit, ui_get(b_trigger_slider))          
            end                 
        else
            if ui_get(b_normal_limit) == 15 and (vel > 80 or fk_jump) then
                ui_set(refk_limit, 15) 
            else
                ui_set(refk_limit, ui_get(b_trigger_slider))          
            end         
        end          
        if chock ~= nil then
            if chock >= ui_get(b_trigger_slider) then
                should_lag_f = false 
            end  
        end
        return
    end      
    --
end

local alter_send_limit = 0
local alter_send_cond = 0
local int_alternative_lag = true
local function alternative_code()
    int_alternative_lag = true

    if g_tickcount()%alter_send_cond >= alter_send_limit then
    	ui_set(refk_checkbox, true)
    	ui_set(refk_limit, ui_get(b_choke_limit))
 		if ui_get(b_choke_limit) == 15 and (vel > 80 or fk_jump) then
 			ui_set(refk_limit, 15) 
 		else
        	ui_set(refk_limit, ui_get(b_choke_limit))
        end            
    else
    	if not shots_fired then
    		ui_set(refk_limit, 1)
    		if in_airdb then
    			ui_set(refk_checkbox, false)
    		end
    	end
    end            
end 

set_event_callback("setup_command", function(cmd)
    in_jump = cmd.in_jump
    in_duck = cmd.in_duck
    if not contains(ui_settings, options[1]) then ui_set(hold_aim, false) else ui_set(hold_aim, true) end
end)

local should_lag = false
local function dyn_fakelag(cmd)
    --client_log(saved_limit)
    if not ui_get(ui_fakelag) then return end   

    if contains(ui_settings, options[3]) then
        if ui_get(ref_fakeduck) then 
            fk_dyn = true
            if fk_dyn then
                if disabled_fakelag then
                    ui_set(refk_amount, "Maximum")
                    ui_set(refk_variance, 0)
                    ui_set(refk_limit, 15)  
                end
            end 
        else
            if b_amount ~= "Alternative" then
                ui_set(refk_checkbox, true)
            end 
            fk_dyn = false
            --return
        end
    else
        ui_set(refk_limit, 14)
    end        

    if contains(ui_settings, options[2]) then
        if ui_get(ref_doubletap_hk) and not ui_get(ref_fakeduck) then 
            fk_dyn = true
            if fk_dyn then
                if disabled_fakelag then
                	ui_set(dt_exploit, 1)
                    ui_set(refk_checkbox, false)
                    ui_set(refk_amount, "Maximum")
                	ui_set(refk_limit, 1) 
                    ui_set(refk_variance, 0)
                    return
                end
            end 
        else
            if b_amount ~= "Alternative" then
                ui_set(refk_checkbox, true)
            end 
            fk_dyn = false
        end     
    end   
    chock = cmd.chokedcommands

    ui_set(refk_checkbox_hk, "Always on")
    ui_set(refk_variance, 0)
    --ui_set(refk_amount, "Maximum")
  

    if ui_get(ref_fakeduck) then fk_jump = false return end

    if in_jump == 0 and not in_airdb then
        fk_dyn = true
        fk_jump = false
    else
        fk_jump = true
    end 
    
    --LC calc
    if (vec_data[0] and vec_data[1]) then
        lag_dst = Length2DSqr(vecMvec(vec_data[0], vec_data[1]))
        if lag_dst ~= nil then
	        lag_dst = lag_dst - 64 * 64 -- m_flTeleportDistanceSqr (4096)
	        lag_dst = lag_dst < 0 and 0 or lag_dst / 30
	        lag_dst = lag_dst > 62 and 62 or lag_dst
	    end
    end
    --

    --Fix LC backtrack
    if lag_dst > 10 then ui_set(refk_limit, 1) end
    alter_send_limit = ui_get(b_send_limit) - 1
    if ui_get(b_choke_limit) == 15 and in_airdb then
      	alter_send_cond = (ui_get(b_send_limit) + ui_get(b_choke_limit)) 
    else
 		alter_send_cond = 1 + (ui_get(b_send_limit) + ui_get(b_choke_limit))
    end
    --    

    --Alternative                             
    should_lag = lag_data.should_lag()

    if not shots_fired then
        if contains(b_triggers, b_trigger_opt[1]) and should_lag then
            if should_lag_f then
                triggers_code()
                return
            end
        else
            should_lag_f = true
        end  
    end

	if ui_get(b_amount) == "Alternative" then
      
        if vel < 2 and contains(b_altercond, b_cond_opt[1]) then
            alternative_code()
        elseif vel > 2 and contains(b_altercond, b_cond_opt[2]) then
            alternative_code()
        elseif fk_jump and contains(b_altercond, b_cond_opt[3]) then
            alternative_code()
        elseif ui_get(ref_slow_motion_hk) and contains(b_altercond, b_cond_opt[4]) then
            alternative_code()
        elseif vel > 2 and should_lag and contains(b_altercond, b_cond_opt[5]) then
            alternative_code()
        else 
        	ui_set(refk_checkbox, true)
            int_alternative_lag = false
            if lag_dst > 10 and (ui_get(b_choke_limit) >= 15 or ui_get(b_normal_limit) >= 15) then
                ui_set(refk_limit, 1)
            else
                ui_set(refk_limit, ui_get(b_normal_limit))
            end          
        end
    else
    	int_alternative_lag = false
    end

    --client_log(get_prop(get_local_player(), "m_bIsAutoaimTarget"))

    if ui_get(b_amount) == "Adaptive" then
        ui_set(refk_amount, "Dynamic")
        ui_set(refk_limit, ui_get(b_normal_limit))
    elseif ui_get(b_amount) == "Maximum" then
        ui_set(refk_amount, "Maximum")
        ui_set(refk_limit, ui_get(b_normal_limit))
    elseif ui_get(b_amount) == "Random" then
        ui_set(refk_amount, "Maximum")
        if chock >= ui_get(refk_limit) - 1 then
            random_limit = math.random(1, ui_get(b_normal_limit))
        end
        ui_set(refk_limit, random_limit)
    elseif ui_get(b_amount) == "Fluctuate" then
        ui_set(refk_amount, "Fluctuate")
        ui_set(refk_limit, ui_get(b_normal_limit))     
    elseif ui_get(b_amount) == "Alternative" then
        ui_set(refk_amount, "Maximum")
    end 
end

-- Get if shooting
local function get_shoot(ctx)
	local local_player = get_local_player()
	if local_player == nil then return end

	local weap = get_player_weapon(local_player)
	if weap == nil then return end
	
	local m_flNextPrimaryAttack = get_prop(weap, "m_flNextPrimaryAttack")
	local m_nTickBase = get_prop(local_player, "m_nTickBase")
	--can_shoot = (m_flNextPrimaryAttack <= m_nTickBase * interval_per_tick() - 0.12)
end
set_event_callback("run_command", get_shoot)
--

local function fakelag_items()
    ui_set_visible(refk_checkbox, c)
    ui_set_visible(refk_checkbox_hk, c)
    ui_set_visible(refk_amount, c)
    ui_set_visible(refk_variance, c)
    ui_set_visible(refk_limit, c)
end

local function ui_menu(d)  
    fakelag_items()
    desync_call(ui_fakelag)
    if ui_get(ui_fakelag) then    
        c = false
        nc = true     
        --Set visivel menu item fakelag
        ui_set_visible(b_amount, true)
        ui_set_visible(b_normal_limit, true)
        --ui_set_visible(b_triggers, true)
        --ui_set_visible(b_trigger_slider, true)        

        if ui_get(b_amount) == "Alternative" then

            ui_set_visible(b_altercond, true)
            ui_set_visible(b_send_limit, true)
            ui_set_visible(b_choke_limit, true)
        else
            ui_set_visible(b_altercond, false)
            ui_set_visible(b_send_limit, false)
            ui_set_visible(b_choke_limit, false)
        end       
    elseif ui_get(ui_fakelag) then
        c = true
        nc = false  
        disable_itms()        
    else
        c = true
        nc = false  
        disable_itms()
    end 
end

local function on_shut()
    fk_dyn = false
    chock = 0
    fk_dyn = false    
    ui_set(fakelag_exploit, 16)
    if saved_checkbox ~= nil then
        ui_set(refk_checkbox, saved_checkbox)
        ui_set(refk_checkbox_hk, saved_checkbox_hk)    
        ui_set(refk_amount, saved_amount)
        ui_set(refk_variance, saved_variance)                
        ui_set(refk_limit, saved_limit)    
        ui_set(dt_exploit, saved_dt)       
    end
end
set_event_callback("shutdown", on_shut)
set_callback(ui_fakelag, desync_call)
set_callback(ui_fakelag, on_shut)
set_event_callback("run_command", save_fk_profile)
set_event_callback("run_command", dyn_fakelag)
set_event_callback("paint", ui_menu)

