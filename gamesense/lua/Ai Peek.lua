
local ffi = require("ffi")
local anti_aim = require("neverlose/anti_aim")
local clipboard = require("neverlose/clipboard")
local base64 = require("neverlose/base64")
local gradient = require("neverlose/gradient")
local color_print = require("neverlose/color_print")
local vmt_hook = require("neverlose/vmt_hook")
local csgo_weapons = require("neverlose/csgo_weapons")
ui.sidebar('Ai peek','dragon')

--首页----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

groups_main_inf = ui.create("Home", ui.get_icon("caret-right") .." link")
groups_main_link = ui.create("Home", ui.get_icon("caret-right") ..' link-')

groups_main_inf:label("\aD2FF6AFFHello player, \aFFFFFFFFwelcome to Ai Peek  By：Baisha" )

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ffi.cdef[[
    typedef void*(__thiscall* get_client_entity_t)(void*, int);

    bool CreateDirectoryA(const char* lpPathName, void* lpSecurityAttributes);
    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);

    bool DeleteUrlCacheEntryA(const char* lpszUrlName);
]]

local urlmon = ffi.load 'UrlMon'
local wininet = ffi.load 'WinInet'

local ffi_handler = {}
ffi_handler.download_file = function(url, path)
    wininet.DeleteUrlCacheEntryA(url)
    urlmon.URLDownloadToFileA(nil, url, path, 0,0)
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
        end
    end
    return false
end
local x, y = render.screen_size().x, render.screen_size().y
local notify=(function() notify_cache={} local a={callback_registered=false,maximum_count=4} 
    function a:set_callback()
        if self.callback_registered then return end; 
        events.render:set(function() 
            local c={x,y} 
            local d={0,0,0} 
            local e=1; 
            local f=notify_cache; 
            for g=#f,1,-1 do 
                notify_cache[g].time=notify_cache[g].time-globals.frametime; 
                local h,i=255,0; 
                local i2 = 0; 
                local lerpy = 150; 
                local lerp_circ1 = 0.5; 
                local j=f[g] 
                if j.time<0 then 
                    table.remove(notify_cache,g) 
                else 
                    local k=j.def_time-j.time; 
                    local k=k>1 and 1 or k; 
                    if j.time<1 or k<1 then 
                        i=(k<1 and k or j.time)/1; 
                        i2=(k<1 and k or j.time)/1; 
                        h=i*255; lerpy=i*150; 
                        lerp_circ1=i*0.5;
                        if i<0.2 then e=e+8*(1.0-i/0.2) end 
                    end; 

                end 
            end; 
            self.callback_registered=true 
        end) 
    end;
    function a:push(q,r) 
        local s=tonumber(q)+1; 
        for g=self.maximum_count,2,-1 do 
            notify_cache[g]=notify_cache[g-1] 
        end; 
        notify_cache[1]={time=s,def_time=s,draw=r} 
        self:set_callback()
    end;
    return a 
end)()


local Neverlose = {
    Peek_Assist = ui.find("Aimbot", "Ragebot", "Main", "Peek Assist"),
    Retreat_Mode = ui.find("Aimbot", "Ragebot", "Main", "Peek Assist", "Retreat Mode"),
    Double_Tap = ui.find("Aimbot", "Ragebot", "Main", "Double Tap"),
    DT_Options = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", 'Lag Options'),
    DT_FakeLag = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", 'Fake Lag Limit'),
    Minimum_Damage =  ui.find("Aimbot", "Ragebot", "Selection", "Min. Damage"),
    ThirdPerson = ui.find("Visuals", "World", "Main", "Force Thirdperson"),
}

local menu_tab = {
    ai_peek_main = ui.create('Ai Peek', 'Main'),
    ai_peek_init = ui.create('Ai Peek', 'Init'),
    ai_peek_detect = ui.create('Ai Peek', 'Detection'),
    ai_peek_indicator = ui.create('Ai Peek', 'Indicator'),
}

local menu = {
    ai_peek = {
        menu_tab.ai_peek_main:switch("Enable Ai Peek", true),
        menu_tab.ai_peek_main:switch("Ai Peek", false),

        -- Init Ai Peek
        menu_tab.ai_peek_init:slider("Distance", 0, 70, 25),
        menu_tab.ai_peek_init:slider("Department", 1, 5, 2),
        menu_tab.ai_peek_init:switch('Unlock Camera', false),
        menu_tab.ai_peek_init:switch("Middle Point", false),
        menu_tab.ai_peek_init:switch('Skip Teammate', false),

        -- Detection
        menu_tab.ai_peek_detect:list('Detection Mode', {'Current', 'All Target'}),
        menu_tab.ai_peek_detect:listable('Detection Hitbox', {'Head', 'Chest', 'Stomach', 'Legs'}),

        -- Misc Detection
        menu_tab.ai_peek_detect:switch('Retreat!!!'),
        menu_tab.ai_peek_detect:switch('Teleport Peek', false),
        menu_tab.ai_peek_detect:switch('Detect Fail Retreat', false),

        menu_tab.ai_peek_indicator:switch("Detection Point"),
        menu_tab.ai_peek_indicator:switch("Line Target"),
        
        menu_tab.ai_peek_indicator:color_picker('Detection Point Outer Color'),
        menu_tab.ai_peek_indicator:color_picker('Detection Point Inner Color'),
        menu_tab.ai_peek_indicator:color_picker('Line Target Color')
    },
}

local function ai_peek_menu_handler()
	local main = menu.ai_peek[1]
	for i,o in pairs(menu.ai_peek) do
		o:visibility(main:get())
	end

	main:visibility(true)
    menu.ai_peek[10]:visibility(false)
    menu.ai_peek[15]:visibility(main:get() and menu.ai_peek[13]:get())
    menu.ai_peek[16]:visibility(main:get() and menu.ai_peek[13]:get())
    menu.ai_peek[17]:visibility(main:get() and menu.ai_peek[14]:get())
end

ai_peek_menu_handler()
for i,o in pairs(menu.ai_peek) do
	o:set_callback(ai_peek_menu_handler)
end



local lua_functions = new_class()
    :struct 'init_data' {
        is_round_start = false,

        player_information = {
            playerView = vector(0, 0, 0),
            playerVec = vector(0, 0, 0),
        },
    
        aipeek_infomation = {
            is_enable = false,
            run_movement = false,
            peek_to_vec = vector(0, 0, 0),
        },
    
        enemy_status = {
            detected_damage = 0,
            detected_target = nil
        },
    }

    :struct 'math_functions' {
        normalize_yaw = function(self, p)
            while p > 180 do
                p = p - 360
            end
            while p < -180 do
                p = p + 360
            end
            return p
        end,

        extrapolate = function (self, player, origin, ticks)
            if ticks < 0 then ticks = 0 end
            local vel = player.m_vecVelocity
    
            if vel == nil then return nil end
        
            local predication_tick = globals.tickinterval * ticks
            return vector(origin.x + (vel.x * predication_tick), origin.y + (vel.y * predication_tick), origin.z + (vel.z * predication_tick))
        end,

        custom_world_to_screen = function(xdelta, ydelta)
            if xdelta == 0 and ydelta == 0 then return 0 end
            return math.deg(math.atan2(ydelta, xdelta))
        end,

        vector_to_angles = function(x1, y1, z1, x2, y2, z2)
            local origin_x, origin_y, origin_z
            local target_x, target_y, target_z
            if x2 == nil then
                target_x, target_y, target_z = x1, y1, z1
                local eye_origin = entity.get_local_player():get_eye_position()
                origin_x, origin_y, origin_z = eye_origin.x, eye_origin.y, eye_origin.z
                if origin_x == nil then return end
            else
                origin_x, origin_y, origin_z = x1, y1, z1
                target_x, target_y, target_z = x2, y2, z2
            end

            local delta_x, delta_y, delta_z = target_x-origin_x, target_y-origin_y, target_z-origin_z
            if delta_x == 0 and delta_y == 0 then
                return (delta_z > 0 and 270 or 90), 0
            else
                local yaw = math.deg(math.atan2(delta_y, delta_x))
                local hyp = math.sqrt(delta_x*delta_x + delta_y*delta_y)
                local pitch = math.deg(math.atan2(-delta_z, hyp))
                return pitch, yaw
            end
        end,
    }

    :struct 'player_animation' {
        is_in_air = function(self, player)
            return bit.band(player.m_fFlags, 1) == 0
        end,
    }

    :struct 'trace_settings' {
        end_trace_line_skip = function (localplayer)
            local teammate_list = {localplayer}
            local players_list = entity.get_players()
            for key, player in pairs(players_list) do
                if not player:is_enemy() then
                    table.insert(teammate_list, player)
                end
            end

            return teammate_list
        end,

        trace_bullet_skip = function ()
            local teammate_list = {}
            local players_list = entity.get_players()
            for key, player in pairs(players_list) do
                if not player:is_enemy() then
                    table.insert(teammate_list, player)
                end
            end

            return teammate_list
        end
    }

    :struct 'points_functions' {
        local_view_point = function(self, radius, v, vec)
            local eye_pos = vec
            local viewangle = self.init_data.player_information.playerView
            local a_vec = eye_pos + vector():angles(vector(0, (90 + viewangle.y + radius), 0)) * v
            return a_vec
        end,
    
        predict_point = function(self, radius, vec)
            local points = {}
            local my_vec = vec
            local segament = math.max(2, math.floor(2))
            local angles_pre_point = 360 / segament
            for i = 0, 360, angles_pre_point do
                local m_p = self:local_view_point(i, radius, my_vec)
                table.insert(points, m_p)
            end
    
            return points
        end,

        depart_point = function(self, cal_vec, my_vec, department, end_vector)
            local vec_1 = vector(cal_vec.x, cal_vec.y, 0)
            local vec_2 = vector(my_vec.x, my_vec.y, 0)
            local vec_3 = vector(end_vector.x, end_vector.y, 0)
    
            local each_plus = (vec_1 - vec_2) / department
            local end_vector_cal = (vec_3 - vec_2):length()
    
            local depart_point = {}
            for i = 1, department do
                local add_vec = each_plus * i
                if add_vec:length() < end_vector_cal then
                    table.insert(depart_point, my_vec + add_vec)
                end
            end
    
            return depart_point
        end,

        get_endpos = function(self, origin, dest_vec)
            local localplayer = entity.get_local_player()
    
            local trace
            if menu.ai_peek[10]:get() then
                local skip = self.trace_settings:end_trace_line_skip(localplayer)
                trace = utils.trace_line(origin, dest_vec, skip)
    
            else
                trace = utils.trace_line(origin, dest_vec, {localplayer})
            end
    
            return trace.end_pos, trace.fraction
        end,

        cal_end_pos = function(self, vec, my_vec)
            local localplayer = entity.get_local_player()
            local localplayer_head = localplayer:get_hitbox_position(3).z + 24

            local local_origin = localplayer:get_origin()
            local dx, dy, dz = local_origin.x, local_origin.y, local_origin.z
    
            local debug_vec = vector(my_vec.x, my_vec.y, localplayer_head)
            local debug_vec_2 = vector(vec.x, vec.y, localplayer_head)
            local pos_2, fraction_2 = self:get_endpos(debug_vec, debug_vec_2)
    
            local end_Pos = vector(pos_2.x, pos_2.y, localplayer_head)
            return end_Pos
        end,
    
        cal_real_point = function (self, my_vec)
            local real_points_list = {}
            local predict_point = self:predict_point(menu.ai_peek[3]:get(), my_vec)
    
            for i, o in pairs(predict_point) do
                if (menu.ai_peek[6]:get()) then
                    local halfone = predict_point[i+1]
                    halfone = halfone == nil and predict_point[1] or halfone
                    local halfpoint = vector((halfone.x + o.x)/2 ,(halfone.y + o.y)/2, o.z)
                    local end_pos = self:cal_end_pos(halfpoint, my_vec)
                    table.insert(real_points_list, {
                        endpos = end_pos,
                        ideal = halfpoint
                    })
                end
    
                local end_pos = self:cal_end_pos(o, my_vec)
                table.insert(real_points_list, {endpos = end_pos, ideal = o})
            end
    
            return real_points_list
        end,
    }

    :struct 'ragebot_functions' {
        get_hitbox = function(self, content)
            local hitbox = {}
        
            if content == nil then
                return hitbox
            end
            for index, value in pairs(content:get()) do
                if value == 1 then
                    table.insert(hitbox, 0)
                end
            
                if value == 2 then
                    table.insert(hitbox, 5)
                end
            
                if value == 3 then
                    table.insert(hitbox, 3)
                end
        
                
                if value == 4 then
                    table.insert(hitbox, 7)
                    table.insert(hitbox, 8)
                    table.insert(hitbox, 9)
                    table.insert(hitbox, 10)
               end
            end
            
            return hitbox
        end
    }

    :struct 'main' {
        run_points = function(self, department, my_vec)
            local localplayer = entity.get_local_player()
            local m_points = self.points_functions:cal_real_point(my_vec)
            local local_origin_z = localplayer:get_origin().z + 7
            local run_points = {}
    
            local do_color = menu.ai_peek[15]:get()
            local r, g, b, a = do_color.r, do_color.g, do_color.b, menu.ai_peek[13]:get() and do_color.a or 0
    
            local di_color = menu.ai_peek[16]:get()
            local ri, gi, bi, ai = di_color.r, di_color.g, di_color.b, menu.ai_peek[13]:get() and di_color.a or 0
    
            for i, o in pairs(m_points) do
                local calculate_vec = o.ideal
                local limit_vec = o.endpos
                table.insert(run_points, limit_vec)
    
                local circle_vec = vector(limit_vec.x, limit_vec.y, local_origin_z)
                render.circle_3d_gradient(circle_vec, color(r, g, b, a), color(ri, gi, bi, ai), 7, 270, 1)
    
                if department ~= 1 then
                    local department_points = self.points_functions:depart_point(calculate_vec, my_vec, department, limit_vec)
                    for _, depart_vec in pairs(department_points) do
                        table.insert(run_points, depart_vec)
    
                        local department_circle_vec = vector(depart_vec.x, depart_vec.y, local_origin_z)
                        render.circle_3d_gradient(department_circle_vec, color(r, g, b, a), color(ri, gi, bi, ai), 7, 270, 1)
                    end
                end
            end
    
            return run_points
        end,

        run_aipeek = function(self)
            local localplayer = entity.get_local_player()
            if localplayer == nil or not localplayer:is_alive() or (menu.ai_peek[1]:get()) == false or (menu.ai_peek[2]:get()) == false or self.init_data.is_round_start then return end
    
            local m_points = self:run_points(menu.ai_peek[4]:get(), self.init_data.player_information.playerVec)
            if localplayer:get_player_weapon():get_weapon_index() == 515 then return end
    
            local peek_hitbox = self.ragebot_functions:get_hitbox(menu.ai_peek[9])
    
            local predict_point = {}
            
            if menu.ai_peek[8]:get() == 2 then
                local players = entity.get_players(true, true)
                if players == nil then
                    self.init_data.aipeek_infomation.is_enable = false
                    self.init_data.aipeek_infomation.peek_to_vec = nil
                    return
                end

                for i, vec in pairs(m_points) do
                    for key, player in pairs(players) do
                        local player_status = player:get_anim_state()
                        if player_status.last_update_time == 0 then goto skip end
                        local position, rotation, is_out_of_fov = render.get_offscreen(player:get_origin(), 180, true)
                        if is_out_of_fov then goto skip end
    
                        if player ~= nil and player:is_alive() then
                            for _,v in pairs(peek_hitbox) do
                                local hitbox = player:get_hitbox_position(v)
                                local ex, ey, ez = hitbox.x, hitbox.y, hitbox.z
                                local e_vec = self.math_functions:extrapolate(player, vector(ex, ey, ez), globals.curtime - player_status.last_update_time)
    
                                local teammate = self.trace_settings:trace_bullet_skip()
                                local damage, trace = utils.trace_bullet(localplayer, vector(vec.x, vec.y, vec.z), e_vec, teammate)

                                -- 这个部分最重要，这样可以从 Department 5 40FPS 优化到 140FPS
                                if not (damage > 0) then
                                    goto skip
                                end
    
                                if damage >= math.min(Neverlose.Minimum_Damage:get(), player.m_iHealth) and damage ~= 0 then
                                    table.insert(predict_point, {target = player, damage = damage, vec = vec, enemy_vec = e_vec})
                                end
                            end
                        end
                        
                        ::skip::
                    end
                end

            else
                local player = entity.get_threat()
                if player == nil then
                    self.init_data.aipeek_infomation.is_enable = false
                    self.init_data.aipeek_infomation.peek_to_vec = nil
                    return
                end

                for i, vec in pairs(m_points) do
                    local player_status = player:get_anim_state()
                    if player_status.last_update_time == 0 then goto skip end
                    local position, rotation, is_out_of_fov = render.get_offscreen(player:get_origin(), 180, true)
                    if is_out_of_fov then goto skip end

                    if player ~= nil and player:is_alive() then
                        for _,v in pairs(peek_hitbox) do
                            local hitbox = player:get_hitbox_position(v)
                            local ex, ey, ez = hitbox.x, hitbox.y, hitbox.z
                            local e_vec = self.math_functions:extrapolate(player, vector(ex, ey, ez), globals.curtime - player_status.last_update_time)

                            local teammate = self.trace_settings:trace_bullet_skip()
                            local damage, trace = utils.trace_bullet(localplayer, vector(vec.x, vec.y, vec.z), e_vec, teammate)

                            -- 这个部分最重要，这样可以从 Department 5 40FPS 优化到 140FPS
                            if not (damage > 0) then
                                goto skip
                            end

                            if damage >= math.min(Neverlose.Minimum_Damage:get(), player.m_iHealth) and damage ~= 0 then
                                table.insert(predict_point, {target = player, damage = damage, vec = vec, enemy_vec = e_vec})
                            end
                        end
                    end
                    
                    ::skip::
                end
            end
    
            table.sort(predict_point, function(a, b)
                return a.damage > b.damage
            end)
    
            for i,o in pairs(predict_point) do
                if not o.target:is_alive() then table.remove(predict_point, i) end
                if o.target:get_network_state() == 5 then table.remove(predict_point, i) end
                if o.target:get_network_state() == 4 then table.remove(predict_point, i) end
            end
    
            if #predict_point >= 1 and (self.init_data.aipeek_infomation.run_movement) and not menu.ai_peek[10]:get() then
                local lib = predict_point[1]
                local vec = lib.vec
                local e_vec = lib.enemy_vec

                self.init_data.enemy_status.detected_damage = lib.damage
                self.init_data.enemy_status.detected_target = lib.target
    
                if Neverlose.ThirdPerson:get() == true then
                    local new_debug = vector(vec.x, vec.y, localplayer:get_origin().z + 7)
                    local new_debug_screen = render.world_to_screen(vector(new_debug.x, new_debug.y, new_debug.z))
                    if new_debug_screen == nil then
                        goto skip
                    end
    
                    local x1, y1 = new_debug_screen.x, new_debug_screen.y
    
                    local l_color = menu.ai_peek[17]:get()
                    local r, g, b, a = l_color.r, l_color.g, l_color.b, menu.ai_peek[14]:get() and l_color.a or 0
    
                    local e_vec_screen = render.world_to_screen(vector(e_vec.x, e_vec.y, e_vec.z))
                    if e_vec_screen == nil then
                        goto skip
                    end
    
                    local x2, y2 = e_vec_screen.x, e_vec_screen.y
                    render.line(vector(x1, y1), vector(x2, y2), color(r, g, b, a))
    
                    ::skip::
                end
                
                self.init_data.aipeek_infomation.is_enable = true
                self.init_data.aipeek_infomation.peek_to_vec = vec
    
                utils.execute_after(0.5, function ()
                    menu.ai_peek[10]:set(true)
    
                    utils.execute_after(0.015, function ()
                        menu.ai_peek[10]:set(false)
                    end)
                end)
    
            elseif #predict_point == 0 and (self.init_data.aipeek_infomation.run_movement) and not menu.ai_peek[10]:get() and menu.ai_peek[12]:get() then
                local function retreat()
                    menu.ai_peek[10]:set(true)
    
                    utils.execute_after(0.5, function ()
                        menu.ai_peek[10]:set(false)
                    end)
                end
    
                retreat()
    
                self.init_data.enemy_status.detected_damage = 0
                self.init_data.enemy_status.detected_target = nil
    
            else
                self.init_data.aipeek_infomation.is_enable = false
                self.init_data.aipeek_infomation.peek_to_vec = nil
    
                self.init_data.enemy_status.detected_damage = 0
                self.init_data.enemy_status.detected_target = nil
            end
        end,

        after_shot = function(self, shot)
            if not (globals.is_in_game) then return end
            if (menu.ai_peek[1]:get()) == false then return end
    
            self.init_data.aipeek_infomation.run_movement = false

        end,

        set_movement = function(self, cmd, desired_pos, mode)
            if desired_pos == nil then return false end
    
            local localplayer = entity.get_local_player()
            if not localplayer then return end
        
            local origin = localplayer.m_vecAbsOrigin
            local pitch, yaw = self.math_functions.vector_to_angles(origin.x, origin.y, origin.z, desired_pos.x, desired_pos.y, desired_pos.z)
    
            cmd.in_forward = 1
            cmd.in_back = 0
            cmd.in_moveleft = 0
            cmd.in_moveright = 0
            cmd.in_speed = 0
    
            cmd.forwardmove = 850
            cmd.sidemove = 0

            if Neverlose.Double_Tap:get() and menu.ai_peek[11]:get() then
                if mode == 'retreat' then
                    Neverlose.DT_Options:override('Always On')
                    Neverlose.DT_FakeLag:override(1)
    
                    cmd.move_yaw = yaw
    
                else
                    Neverlose.DT_Options:override('Always On')
                    Neverlose.DT_FakeLag:override(10)
                    cvar.sv_maxusrcmdprocessticks:int(18)
    
                    rage.exploit:force_teleport()
    
                    cmd.move_yaw = yaw
                end
            else
                if Neverlose.DT_Options:get_override() ~= nil then Neverlose.DT_Options:override() end
                if Neverlose.DT_FakeLag:get_override() ~= nil then Neverlose.DT_FakeLag:override() end

                cmd.move_yaw = yaw
            end
            
        end,

        retreat = function(self, cmd)
            if not (globals.is_in_game) then return end
            if Neverlose.Retreat_Mode:get_override() ~= nil then Neverlose.Retreat_Mode:override() end
    
            local localplayer = entity.get_local_player()
            if localplayer == nil or (menu.ai_peek[1]:get()) == false or self.init_data.is_round_start then return end

    
            local is_forward = cmd.in_forward
            local is_backward = cmd.in_back
            local is_left = cmd.in_moveleft
            local is_right = cmd.in_moveright
    
            if (menu.ai_peek[2]:get()) and localplayer:get_player_weapon():get_weapon_index() ~= 515 then
                if Neverlose.Peek_Assist:get() then
                    local mode = Neverlose.Retreat_Mode:get()
                    if table.contains(mode, 'On Key Release') then
                        table.remove(mode, #mode)
                        Neverlose.Retreat_Mode:override(mode)
                    end
                end
                
                local my_weapon = localplayer:get_player_weapon()
                if my_weapon == nil then return end
    
                local timer = globals.curtime
    
                local is_in_air = bit.band(localplayer.m_fFlags, 1) == 0
                local can_Fire = Neverlose.Double_Tap:get() and (localplayer.m_flNextAttack <= timer and my_weapon.m_flNextPrimaryAttack <= timer and rage.exploit:get() > 0) or (localplayer.m_flNextAttack <= timer and my_weapon.m_flNextPrimaryAttack <= timer)
        
                local local_origin = localplayer:get_origin()
                if math.abs(local_origin.x - self.init_data.player_information.playerVec.x) <= 10 then
                    self.init_data.aipeek_infomation.run_movement = true
                end
        
                if can_Fire == false then
                    self.init_data.aipeek_infomation.run_movement = false
                end
    
                if menu.ai_peek[10]:get() then
                    self.init_data.aipeek_infomation.run_movement = false
                end
                
                if self.init_data.aipeek_infomation.is_enable and self.init_data.aipeek_infomation.run_movement and is_in_air == false and self.init_data.aipeek_infomation.peek_to_vec ~= nil then
                    self:set_movement(cmd, self.init_data.aipeek_infomation.peek_to_vec, 'peek')
        
                elseif self.init_data.aipeek_infomation.run_movement == false and is_in_air == false and is_forward == false and is_backward == false and is_left == false and is_right == false then
                    self:set_movement(cmd, self.init_data.player_information.playerVec, 'retreat')
                end
            end
        end,
    
        override_view = function(self, o)
            if not (globals.is_in_game) then return end
    
            local localplayer = entity.get_local_player()
            if localplayer == nil then return end
    
            local localplayer_origin = localplayer:get_hitbox_position(3)
            local my_vec = vector(localplayer_origin.x, localplayer_origin.y, localplayer_origin.z)
    
            local manual_view = o.view
            if (not menu.ai_peek[2]:get()) or menu.ai_peek[5]:get() then
                self.init_data.player_information.playerView = vector(manual_view.x, manual_view.y, 0)
            end
            
            if (not menu.ai_peek[2]:get()) then
                self.init_data.player_information.playerVec = my_vec
            end
        end,

        round_start = function (self)
            self.init_data.is_round_start = true
            utils.execute_after(1, function()
                self.init_data.is_round_start = false
            end)
        end,
    }

local callbacks = {
    round_start = function()
        lua_functions.main:round_start()
    end,

    render = function ()
        local localplayer = entity.get_local_player()
        if (not globals.is_in_game) then return end
        if localplayer == nil or not localplayer:is_alive() then return end

        lua_functions.main:run_aipeek()
    end,

    createmove = function (cmd)
        local localplayer = entity.get_local_player()
        if (not globals.is_in_game) then return end
        if localplayer == nil or not localplayer:is_alive() then return end

        lua_functions.main:retreat(cmd)
    end,

    aim_ack = function (shot)
        lua_functions.main:after_shot(shot)
    end,

    override_view = function (o)
        local localplayer = entity.get_local_player()
        if (not globals.is_in_game) then return end
        if localplayer == nil or not localplayer:is_alive() then return end

        lua_functions.main:override_view(o)
    end,

    shutdown = function ()
        for key, value in pairs(Neverlose) do
            if value ~= nil then value:override() end
        end

        cvar.sv_maxusrcmdprocessticks:int(16)
    end
}

local ui_callback = function ()

    
end

function init()
    ui_callback()
end
init()


events.round_start:set(callbacks.round_start)
events.render:set(callbacks.render)
events.createmove:set(callbacks.createmove)
events.aim_ack:set(callbacks.aim_ack)
events.override_view:set(callbacks.override_view)
events.shutdown:set(callbacks.shutdown)


------------------载入 + 侧边---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
ui.sidebar(gradient_text(206,204,205,255,179,230,27,255, "Ai Peek"), "AI")
common.add_notify("\aCECCCDFFAi \aB3E61BFFPeek ", "\aFFFFFFFFWelcome to Ai Peek.lua"..common.get_username())

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------