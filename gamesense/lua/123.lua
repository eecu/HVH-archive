local success_weapon, csgo_weapons = pcall(require, 'gamesense/csgo_weapons')
local success_images, images = pcall(require, 'gamesense/images')
--[[ local render = require('renderlib') ]]
local render = {}

render.circle_rect = function(x,y,width,height,r,g,b,a)
    renderer.circle_outline(x+width, y+height, r, g, b, a, 5, 0, 0.25, 1)
    renderer.circle_outline(x, y+height, r, g, b, a, 5, 90, 0.25, 1)
    renderer.circle_outline(x, y, r, g, b, a, 5, 180, 0.25, 1)
    renderer.circle_outline(x+width, y, r, g, b, a, 5, 270, 0.25, 1)
    renderer.line(x, y-5, x+width, y-5, r, g, b, a)
    renderer.line(x, y+height+5, x+width, y+height+5, r, g, b, a)
    renderer.line(x-5, y, x-5, y+height, r, g, b, a)
    renderer.line(x+5+width, y, x+5+width, y+height, r, g, b, a)
end
render.circle_gradient_rect = function(x,y,width,height,r,g,b,a,r1,g1,b1,a1,type)
    if type then -- 横着渐变
        renderer.circle_outline(x+width, y+height, r1,g1,b1,a1, 5, 0, 0.25, 1)
        renderer.circle_outline(x, y+height, r, g, b, a, 5, 90, 0.25, 1)
        renderer.circle_outline(x, y, r, g, b, a, 5, 180, 0.25, 1)
        renderer.circle_outline(x+width, y, r1,g1,b1,a1, 5, 270, 0.25, 1)

        renderer.gradient(x, y-5, width, 1, r, g, b, a, r1, g1, b1, a1, type)
        renderer.gradient(x, y+height+5, width, 1, r, g, b, a, r1, g1, b1, a1, type)
        renderer.rectangle(x-5, y, 1, height, r, g, b, a)
        renderer.rectangle(x+5+width, y, 1, height, r1, g1, b1, a1)
    else         -- 竖着渐变
        renderer.circle_outline(x+width, y+height, r1,g1,b1,a1, 5, 0, 0.25, 1)
        renderer.circle_outline(x, y+height, r1, g1, b1, a1, 5, 90, 0.25, 1)
        renderer.circle_outline(x, y, r, g, b, a, 5, 180, 0.25, 1)
        renderer.circle_outline(x+width, y, r,g,b,a, 5, 270, 0.25, 1)

        renderer.gradient(x-5, y, 1, height, r, g, b, a, r1, g1, b1, a1, type)
        renderer.gradient(x+5+width, y, 1, height, r, g, b, a, r1, g1, b1, a1, type)
        renderer.rectangle(x, y-5, width, 1, r, g, b, a)
        renderer.rectangle(x, y+5+height, width, 1, r1, g1, b1, a1)
        
    end
end
render.rect = function(x,y,width,height,r,g,b,a)
    renderer.rectangle(x, y, width, 1, r, g, b, a)         -- -----
    renderer.rectangle(x + width, y, 1, height, r, g, b, a)--      |
    renderer.rectangle(x, y + height, width, 1, r, g, b, a)-- -----
    renderer.rectangle(x, y, 1, height, r, g, b, a)-- |
end
render.gradient_rect = function(x,y,width,height,r,g,b,a,r1,g1,b1,a1,type)
    if type then -- 横着渐变
        renderer.rectangle(x, y, 1, height, r, g, b, a)
        renderer.rectangle(x + width, y, 1, height, r1,g1,b1,a1)
        renderer.gradient(x, y, width, 1, r,g,b,a,r1,g1,b1,a1,type)
        renderer.gradient(x, y + height, width, 1, r,g,b,a,r1,g1,b1,a1,type)
    else         -- 竖着渐变
        renderer.rectangle(x, y, width, 1, r, g, b, a)
        renderer.rectangle(x, y+height, width, 1, r1,g1,b1,a1)
        renderer.gradient(x, y, 1, height, r, g, b, a, r1,g1,b1,a1, type)
        renderer.gradient(x + width, y, 1, height, r, g, b, a, r1,g1,b1,a1, type)
    end
end

local vector_c = {}
local vector_mt = {__index = vector_c,}
local function vector(x, y, z)return setmetatable({x = x and x or 0,y = y and y or 0,z = z and z or 0},vector_mt)end
function vector_c:unpack()return self.x, self.y, self.z end
function vector_c:trace_bullet_to(destination, eid)return client.trace_bullet(eid,self.x,self.y,self.z,destination.x,destination.y,destination.z)end
local function angle(p, y, r)return setmetatable({p = p and p or 0,y = y and y or 0,r = r and r or 0},angle_mt)end
function vector_c:angle_to(destination)local delta_vector = vector(destination.x - self.x, destination.y - self.y, destination.z - self.z)local yaw = math.deg(math.atan2(delta_vector.y, delta_vector.x))local hyp = math.sqrt(delta_vector.x * delta_vector.x + delta_vector.y * delta_vector.y)local pitch = math.deg(math.atan2(-delta_vector.z, hyp))return angle(pitch, yaw)end
function vector_c.eye_position(eid)local origin = vector(entity.get_prop(eid, "m_vecOrigin", 3))local _, _, view_z = entity.get_prop(eid, "m_vecViewOffset")local duck_amount = entity.get_prop(eid, "m_flDuckAmount")origin.z = origin.z + view_z - duck_amount * 16 return origin end
local get_script_name = function()local funca, err = pcall(function() GS_THROW_ERROR() end)return (not funca and err:match("\\(.*):(.*):") or nil)end
local debug_count = function(tab)local count = 0 for _, _ in pairs(tab) do count = count + 1 end return count end
local dragging = (function()local a={}local b,c,d,e,f,g,h,i,j,k,l,m,n,o;local p={__index={drag=function(self,...)local q,r=self:get()local s,t=a.drag(q,r,...)if q~=s or r~=t then self:set(s,t)end;return s,t end,set=function(self,q,r)local j,k=client.screen_size()ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res)end,get=function(self)local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}}function a.new(u,v,w,x)x=x or 10000;local j,k=client.screen_size()local y=ui.new_slider("LUA","A",u.." window position",0,x,v/j*x)local z=ui.new_slider("LUA","A","\n"..u.." window position y",0,x,w/k*x)ui.set_visible(y,false)ui.set_visible(z,false)return setmetatable({name=u,x_reference=y,y_reference=z,res=x},p)end;function a.drag(q,r,A,B,C,D,E)if globals.framecount()~=b then c=ui.is_menu_open()f,g=d,e;d,e=ui.mouse_position()i=h;h=client.key_state(0x01)==true;m=l;l={}o=n;n=false;j,k=client.screen_size()end;if c and i~=nil then if(not i or o)and h and f>q and g>r and f<q+A and g<r+B then n=true;q,r=q+d-f,r+e-g;if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r))end end end;table.insert(l,{q,r,A,B})return q,r,A,B end;return a end)()
local hotkeys_dragging = dragging.new("Future_doubletap", database.read("Future_doubletap_ind_x") or 550, database.read("Future_doubletap_ind_y") or 550)
local script = {
	debug = false,
	reference = { },
	interface = {
		ui.new_checkbox('Rage','Other', 'Show indicator'),
	}
}

function script:ui(name)local define = self.reference[name] if define == nil then error(string.format('unknown reference %s', name)) end return {    get_ids = function() return define[1] end,get_reffer = function() return define[2] end,  call = function() local list = { } for i=1, #define[1] do list[#list+1] = ui.get(define[1][i]) end return unpack(list)end,   set = function(_, value, index, ignore_errors) local index = index or 1 return ignore_errors == true and ({ pcall(ui.set, define[1][index], value) })[1] or ui.set(define[1][index], value) end,  set_cache = function(_, index, should_call, var)local index = index or 1 if package._gcache == nil then package._gcache = { } end  local name, _cond =  tostring(define[1][index]),  ui.get(define[1][index]) local _type = type(_cond)  local _, mode = ui.get(define[1][index]) local finder = mode or (_type == 'boolean' and tostring(_cond) or _cond) package._gcache[name] = package._gcache[name] or finder local hotkey_modes = { [0] = 'always on', [1] = 'on hotkey', [2] = 'toggle', [3] = 'off hotkey' }if should_call then ui.set(define[1][index], mode ~= nil and hotkey_modes[var] or var) else if package._gcache[name] ~= nil then local _cache = package._gcache[name] if _type == 'boolean' then if _cache == 'true' then _cache = true end if _cache == 'false' then _cache = false end end ui.set(define[1][index], mode ~= nil and hotkey_modes[_cache] or _cache) package._gcache[name] = nil end end end, set_visible = function(_, value, index) local index = index or 1 ui.set_visible(define[1][index], value)end, }end
function script:ui_register(name, pdata) local ref_list = { }  local ids = { pcall(ui.reference, unpack(pdata)) } if ids[1] == false then error(string.format('%s cannot be defined (%s)', name, ids[2]))  end if self.reference[name] ~= nil then error(string.format('%s is already taken in metatable', name)) end for i=2, #ids do ref_list[#ref_list+1] = ids[i] end self.reference[name] = { ref_list, pdata } return self:ui(name) end
local bullet_icon = {
	32,
    32,
    '<?xml version="1.0" encoding="utf-8"?><svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="32" height="32"><g><g><path fill="#FFFFFF" d="M5,24.5l5.4,4.3l9.8-13c0.2-0.3,0.5-1.2,0.5-1.2s0.1-0.7,0.5-1.4c0.4-0.7,1.2-1.7,1.2-1.7l-3.7-3.1c0,0-1.6,1.5-1.8,1.7c-0.7,0.7-1.5,1-1.8,1.4S5,24.5,5,24.5z"/><polygon fill="#FFFFFF" points="19.3,7.8 23,10.8 27.9,1.8 26.6,0.7"/><path fill="#FFFFFF" d="M4.4,25.2l5.5,4.4l-0.5,0.5c0,0-2,0-3.7-1.3c-1.9-1.4-1.7-3.1-1.7-3.1L4.4,25.2z"/></g></g></svg>'
}
local dt_reserve = script:ui_register('dt_reserve', { 'Rage', 'Other', 'Double tap fake lag limit' })
local usrcmd_maxpticks = script:ui_register('usrcmd_maxpticks', { 'MISC', 'Settings', 'sv_maxusrcmdprocessticks' })
local hold_aim = script:ui_register('hold_aim', { 'MISC', 'Settings', 'sv_maxusrcmdprocessticks_holdaim' })

local double_tap = script:ui_register('double_tap', { 'RAGE', 'Other', 'Double tap' })
local double_tap_mode = script:ui_register('double_tap_mode', { 'RAGE', 'Other', 'Double tap mode' })

local show_dt_indicator = script:ui_register('show_dt_indicator', { 'Rage','Other', 'Show indicator' })

--[[ local enable_17_t = script:ui_register('enable_17_t', { 'Rage','Other', '17t' }) ]]
local dt_slider = ui.new_slider("Rage", "Other", "DT tick", 16, 20, 16)


usrcmd_maxpticks:set_visible(true)

local cmove = {
	old_tickbase = 0,
	old_sim_time = 0,
	old_command_num = 0,

	skip_next_differ = false,
	charged_before = false,

	did_shift_before = false,
	can_shift_tickbase = 0, -- 是否可以dt

	is_cmd_safe = true,
	last_charge = 0,
	delay = 0,
}

local caimbot = {
	data = {},
	shift_time = 0,
	shift_data = {},
}

local reset = function()

	for i in pairs(script.reference) do
		local element = script:ui(i)

		for j=1, #element:get_ids() do
			element:set_cache(j, false)
		end
	end
end

local can_exploit = function(me, wpn, ticks_to_shift)
  if wpn == nil then
    return false
  end

  local tickbase = entity.get_prop(me, 'm_nTickBase')
  local curtime = globals.tickinterval() * (tickbase-ticks_to_shift)

  if curtime < entity.get_prop(me, 'm_flNextAttack') then
    return false
  end

  if curtime < entity.get_prop(wpn, 'm_flNextPrimaryAttack') then
    return false
  end

  return true
end
-- DOUBLETAP HANDLER
local g_doubletap_controller = function(e)
	local next_shift_amount = 0

	local me = entity.get_local_player()
	local wpn = entity.get_player_weapon(me)

	local wpn_name = entity.get_classname(wpn) or ''
	local wpn_id = entity.get_prop(wpn, 'm_iItemDefinitionIndex')
	local m_item = wpn_id and bit.band(wpn_id, 0xFFFF) or 0

	local ready_to_shift = can_exploit(me, wpn, 14)
	local weapon_ready = can_exploit(me, wpn, math.abs(-1 - next_shift_amount))

	if ready_to_shift == true or weapon_ready == false and cmove.did_shift_before == true then
		next_shift_amount = 13
	else
		next_shift_amount = 0
	end

	local tickbase = entity.get_prop(me, 'm_nTickBase')
	if cmove.old_tickbase ~= 0 and tickbase < cmove.old_tickbase then

		if cmove.old_tickbase-tickbase > 11 then
			cmove.skip_next_differ = true
			cmove.charged_before = false
			cmove.can_shift_tickbase = false

		end
	end

	local difference = e.command_number - cmove.old_command_num

	if difference >= 11 and difference <= usrcmd_maxpticks:call() then
		cmove.can_shift_tickbase = not cmove.skip_next_differ
		cmove.charged_before = cmove.can_shift_tickbase
		cmove.last_charge = difference+1

		cmove.is_cmd_safe = difference > 3 and math.abs(usrcmd_maxpticks:call()-difference) <= 3
		cmove.delay = math.abs(usrcmd_maxpticks:call() - cmove.last_charge)
	end

	if ready_to_shift == false then
		cmove.can_shift_tickbase = false
	else
		cmove.can_shift_tickbase = cmove.charged_before
	end

	cmove.old_tickbase = tickbase
	cmove.old_command_num = e.command_number

	cmove.skip_next_differ = false
	cmove.did_shift_before = next_shift_amount ~= 0

	cmove.can_shift_tickbase = cmove.can_shift_tickbase and 2 or 0

	if cmove.can_shift_tickbase == 0 and cmove.charged_before == true then
		cmove.can_shift_tickbase = 1
	end

	if cmove.can_shift_tickbase == 0 then
		cmove.last_charge = 0
	end

end
-- AIMBOT MISS

-- AIMBOT HANDLER
local g_aimbot_listener = function(e)
	local dt, dt_key = double_tap:call()
	if not dt then return end
	if not dt_key then return end
	local run_qm = false
	if caimbot.shift_time == 0 and cmove.can_shift_tickbase == 2 then
		caimbot.shift_time = 1
		caimbot.data[debug_count(caimbot.data)+1] = { e.x, e.y, e.z }
		run_qm = true
	end

end

-- CURRENT COMMAND HANDLER
local rapid_shift = false
local g_command_controller = function(e)


	local dt, dt_key = double_tap:call()

	local cs_tickbase = cmove.can_shift_tickbase
	local me = entity.get_local_player()
	local losc = dt and dt_key and double_tap_mode:call() == 'Offensive'
	local fired_this_tick = false
	local m_vecvel = { entity.get_prop(me, 'm_vecVelocity') }
	local velocity = math.floor(math.sqrt(m_vecvel[1]^2 + m_vecvel[2]^2 + m_vecvel[3]^2) + 0.5)

	if caimbot.shift_time > 0 then

		local reset_command = false
		local max_commands = cmove.last_charge
		local aimbot_command = caimbot.data[debug_count(caimbot.data)]


		if debug_count(caimbot.data) > 0 and aimbot_command ~= nil and double_tap_mode:call() ~= "Defensive" then

			e.in_attack = 1

			local eye_pos = vector(client.eye_position())
			local fire_vector = vector(unpack(aimbot_command))

			local entindex, dmg = eye_pos:trace_bullet_to(fire_vector, me, true)
			local aim_at = eye_pos:angle_to(fire_vector)
			e.pitch = aim_at.p
			e.yaw = aim_at.y
			if dmg > 0 then
				fired_this_tick = true
				reset_command = true
			else
				e.in_attack = 0
			end
		end
		caimbot.shift_data[#caimbot.shift_data+1] = {caimbot.shift_time, cs_tickbase, e.chokedcommands, entity.get_prop(me, 'm_nTickBase'), globals.tickcount(), 'false'}
		if caimbot.shift_time ~= 0 and (reset_command == true or caimbot.shift_time == max_commands or max_commands < 1) then
			if cmove.is_cmd_safe == false or script.debug then
				local fdiff = caimbot.shift_data[1]
				local diff = caimbot.shift_data[#caimbot.shift_data]
			end
			caimbot.shift_time = 0
			caimbot.shift_data = { }
			caimbot.data = { }

		else
			caimbot.shift_time = caimbot.shift_time + 1
		end
	end
	if caimbot.shift_time == 0 and fired_this_tick == false and (
		(losc == true and cs_tickbase == 0) or
		(velocity <= 1 and cs_tickbase == 2)
	) then

		if debug_count(caimbot.shift_data) > 0 then
			caimbot.shift_data[debug_count(caimbot.shift_data)][6] = tostring(dt)
		end
	end

	rapid_shift = fired_this_tick
	g_miss = false
end

local g_dt_controller = function()
	local dt, dt_key = double_tap:call()
	if not dt or not dt_key then
		usrcmd_maxpticks:set_cache(1, true, 16)
		return
	end
	hold_aim:set(true)
	usrcmd_maxpticks:set_cache(1, true, ui.get(dt_slider))

end
local GLOBAL_ALPHA = 0
local weapon_id = {
	[1] = 4,
	[2] = 8,
	[3] = 6,
	[4] = 6,
	[7] = 10,
	[8] = 10,
	[9] = 0,
	[10] = 11,
	[11] = 4,
	[13] = 11,
	[14] = 12,
	[16] = 11,
	[17] = 13,
	[19] = 14,
	[23] = 12,
	[24] = 11,
	[25] = 2,
	[26] = 12,
	[27] = 1,
	[28] = 13,
	[29] = 1,
	[30] = 8,
	[31] = 6,
	[32] = 5,
	[33] = 12,
	[34] = 14,
	[35] = 1,
	[36] = 6,
	[38] = 4,
	[39] = 9,
	[40] = 0,
	[41] = -1,
	[42] = -1,
	[43] = 0,
	[44] = 0,
	[45] = 0,
	[46] = 0,
	[47] = 0,
	[48] = 0,
	[49] = 0,
	[59] = -1,
	[60] = 10,
	[61] = 5,
	[63] = 10,
	[64] = 2,
	[500] = -1,
	[505] = -1,
	[506] = -1,
	[507] = -1,
	[508] = -1,
	[509] = -1,
	[512] = -1,
	[514] = -1,
	[515] = -1,
	[516] = -1,
	[519] = -1,
	[520] = -1,
	[522] = -1,
	[523] = -1,
	[524] = -1
}

local get = ui.get
local dm = {}
local recharg_value = 0
local blur_pos = {}
local blur_render = false
local second_line_w = 0
local g_paint_handler = function()

	if entity.is_alive(entity.get_local_player()) == false then
		return reset()
	end
	

	local dt, dt_key = double_tap:call()

	local alpha = 1 + math.sin(math.abs(-math.pi + globals.realtime() % (math.pi * 4))) * 219

	local clr_alpha = 255
	local r, g, b, a = 89, 119, 239, 255

	if cmove.is_cmd_safe == false then r, g, b, a = 255, 167, 38, alpha end
	if cmove.can_shift_tickbase < 2 then r, g, b, a = 150, 150, 150, 150 end


	local frames = 4 * globals.frametime()


	if dt and dt_key then
        blur_render = true
		GLOBAL_ALPHA = GLOBAL_ALPHA + frames; if GLOBAL_ALPHA > 1 then GLOBAL_ALPHA = 1 end
	else
        blur_render = false
		GLOBAL_ALPHA = GLOBAL_ALPHA - frames; if GLOBAL_ALPHA < 0 then GLOBAL_ALPHA = 0 end
	end

	-----------------------

	local weapon_ent = entity.get_player_weapon(entity.get_local_player())
    if weapon_ent == nil then 
        blur_render = false
        return 
    end
    local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
    if weapon_idx == nil then 
        blur_render = false
        return 
    end
    local weapon = csgo_weapons[weapon_idx]
    local weapon_icon = images.get_weapon_icon(weapon)
	

	local me = entity.get_local_player()
	local menu_open = ui.is_menu_open()
	local me_weapon = entity.get_player_weapon(me)
	local cF = entity.get_classname(me_weapon) or ""
	local alpha = math.floor(math.sin((globals.realtime() % 3) * 4) * (255 / 2 - 1) + 255 / 2)

	local cM, cN = double_tap:call()
	local dl = 1
	if weapon_id[weapon_idx] < 9 and weapon_id[weapon_idx] > 2 then
		dl = 2
	elseif weapon_id[weapon_idx] >= 9 and weapon_id[weapon_idx] < 12 then
		dl = 3
	elseif weapon_id[weapon_idx] >= 12 and weapon_id[weapon_idx] < 14 then
		dl = 4
	elseif weapon_id[weapon_idx] > 13 then
		dl = 5
	elseif weapon_id[weapon_idx] == -1 then
		dl = 0
	end
	
	
	local dy = 9 * globals.frametime()
	
	local weapon_w,weapon_h = weapon_icon:measure() * 0.4
	local icon_test = database.read("future_icon") or {"⚡","☺"}
	local text = "Future doubletap"--string.format('tick: %s %s %s | Future |',cmove.last_charge,icon_test[1],icon_test[2]--[[ cmove.can_shift_tickbase ]])
	local x, y = hotkeys_dragging:get()
	local w , h  = renderer.measure_text(nil, text) + 8 , 17

	for am = 1, dl do
		local dF = {w = bullet_icon[1] * 0.55, h = bullet_icon[2] * 0.6}
		local cV = cmove.can_shift_tickbase == 2
		if am == dl and dl >= 2 then
			if cmove.delay > 1 then
				dF.w = dF.w * 0.8
				dF.h = dF.h * 0.8
			end
		end

		dF.svg = renderer.load_svg(bullet_icon[3], dF.w, dF.h)
		if dm[1] == nil then
			dm[1] = dy
		end
		if cV and dm[1] < 1 then
			dm[1] = dm[1] + dy
			if dm[1] > 1 then
				dm[1] = 1
			end
		elseif cV and dm[1] == 1 and dm[am] < dm[1] then
			dm[am] = dm[am] + dy
			if dm[am] > 1 then
				dm[am] = 1
			end
		elseif cV and dm[am - 1] == 1 and dm[am] < dm[am - 1] then
			dm[am] = dm[am] + dy
			if dm[am] > 1 then
				dm[am] = 1
			end
		elseif not cV then
			if dm[am] == nil then
				dm[am] = 0
			end
			dm[am] = dm[am] - dy
			if dm[am] <= 0 then
				dm[am] = 0
			end
		end
		local dG = 15 * am
		if cmove.delay > 1 and am == dl then
			dG = dG + 5
		end
			
		recharg_value = GLOBAL_ALPHA * dm[am]
		if cmove.can_shift_tickbase < 1 then
			recharg_value = 0
		end
--[[ 		if get(bullet_enable) then
			renderer.texture(dF.svg, x+75+dG+25, y+h+5, 13, 13, 255, 255, 255, 255*GLOBAL_ALPHA*dm[am], 'f')
		end ]]
	end
    if not show_dt_indicator:call() then return end
    local first_ammo = entity.get_prop(entity.get_player_weapon(entity.get_local_player()), "m_iClip1") or 0
    local second_ammo = entity.get_prop(entity.get_player_weapon(entity.get_local_player()), "m_iPrimaryReserveAmmoCount") or 0
    local ammo_text = string.format('    %s [ %s / %s ]   ',weapon.name,first_ammo,second_ammo)
    local ammo_text_w = renderer.measure_text('', ammo_text)
    local tick_text = string.format('tick: %s',cmove.last_charge)
    local tick_text_w = renderer.measure_text('',tick_text)
    second_line_w = tick_text_w + ammo_text_w + 5 + weapon_w

    renderer.text(x + second_line_w/2 - w/2, y + 2, 255, 255, 255, GLOBAL_ALPHA*255, '', 0, text)
	renderer.rectangle(x, y+h, second_line_w, 1, 255, 255, 255, GLOBAL_ALPHA*255)
    weapon_icon:draw(x, y+h+5, weapon_w,nil, 255,255,255,255*GLOBAL_ALPHA,true, "f")
    renderer.text(x + weapon_w + 5, y+h+5, 255, 255, 255, GLOBAL_ALPHA*255, '', 0, ammo_text)
    renderer.text(x + weapon_w + 5 + ammo_text_w, y+h+5, 255, 255, 255, GLOBAL_ALPHA*255, '', 0, tick_text)
    renderer.text(x , y+h*2+5, 255, 255, 255, GLOBAL_ALPHA*255, '', 0, "doubletap hitchance:")
    renderer.text(x , y+h*3+5, 255, 255, 255, GLOBAL_ALPHA*255, '', 0, "doubletap damage:")
    renderer.text(x , y+h*4+5, 255, 255, 255, GLOBAL_ALPHA*255, '', 0, "doubletap multi-point scale:")
    local ref_hc , ref_dmg ,ref_multi_scale = ui.reference('rage', 'aimbot', 'Minimum hit chance') ,ui.reference('rage', 'aimbot', 'Minimum damage') ,ui.reference('rage', 'aimbot', 'Multi-point scale')
    local hc_w, dmg_w , multi_w = renderer.measure_text('', ui.get(ref_hc)) ,renderer.measure_text('', ui.get(ref_dmg)) ,renderer.measure_text('', ui.get(ref_multi_scale))

    renderer.text(x + second_line_w - hc_w , y+h*2+5, 255, 255, 255, GLOBAL_ALPHA*255, '', 0,  ui.get(ref_hc))
    renderer.text(x + second_line_w - dmg_w , y+h*3+5, 255, 255, 255, GLOBAL_ALPHA*255, '', 0,  ui.get(ref_dmg))
    renderer.text(x + second_line_w - multi_w , y+h*4+5, 255, 255, 255, GLOBAL_ALPHA*255, '', 0,  ui.get(ref_multi_scale))
    --renderer.gradient(x +1, y+h*4+5, second_line_w*recharg_value, 8, 255, 255, 255, 255*GLOBAL_ALPHA,255, 255, 255, 255*GLOBAL_ALPHA,true)

    blur_pos.h_x = x
    blur_pos.h_y = y
    blur_pos.h_w = w
    blur_pos.h_h = h
    
	local ava = images.get_steam_avatar(entity.get_steam64(entity.get_local_player()))
	    
--[[ 	render.rect(x-1,y, w, h,         r_color[1], r_color[2], r_color[3], r_color[4]*GLOBAL_ALPHA)
	renderer.rectangle(x-1, y, w, h, r_color[1], r_color[2], r_color[3], r_color[4]/4*GLOBAL_ALPHA) ]]

	--ava:draw(x+w, y+2, 13, 13, 255, 255, 255, 255*GLOBAL_ALPHA, true)

	
	
--[[ 	render.gradient_rect(x-1, y+h+5, 70, 13,u_color_1[1], u_color_1[2], u_color_1[3], GLOBAL_ALPHA*u_color_1[4]*GLOBAL_ALPHA,u_color_2[1], u_color_2[2], u_color_2[3], u_color_2[4]*GLOBAL_ALPHA,true)

	weapon_icon:draw(x+75, y+h+5, weapon_w,nil, 255,255,255,255*GLOBAL_ALPHA,true, "f") ]]

	

	
	hotkeys_dragging:drag(w+20, h+18)        	 -- 刷新 X Y 坐标
    database.write("Future_doubletap_ind_x", w)  -- datebase 写入 X轴坐标 
    database.write("Future_doubletap_ind_y", y)  -- datebase 写入 Y轴坐标
end

client.set_event_callback('predict_command', g_doubletap_controller)
client.set_event_callback('setup_command', g_command_controller)
client.set_event_callback('run_command', g_dt_controller)
client.set_event_callback('aim_fire', g_aimbot_listener)
client.set_event_callback('paint', g_paint_handler)
client.set_event_callback('shutdown', reset)