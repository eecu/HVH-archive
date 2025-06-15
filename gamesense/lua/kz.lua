local aa = {
	enable = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
	pitch = ui.reference("AA", "Anti-aimbot angles", "pitch"),
	leg = ui.reference("AA", "Other", "Leg Movement"),
	yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
	yaw = { ui.reference("AA", "Anti-aimbot angles", "Yaw") },
    --fakeyawlimit = ui.reference("AA", "anti-aimbot angles", "Fake yaw limit"),
    fsbodyyaw = ui.reference("AA", "anti-aimbot angles", "Freestanding body yaw"),
    edgeyaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    fakeduck = ui.reference("RAGE", "Other", "Duck peek assist"),
	dmg = ui.reference("RAGE", "Aimbot", "Minimum damage"),
	roll = ui.reference("AA", "anti-aimbot angles", "Roll"),
	hc = ui.reference("RAGE", "Aimbot", "Minimum hit chance"),
	baim = ui.reference("RAGE", "Aimbot", "Force body aim"),
	preferbaim = ui.reference("RAGE", "Aimbot", "Prefer body aim"),
	prefersp = ui.reference("RAGE", "Aimbot", "Prefer safe point"),
	sp = { ui.reference("RAGE", "Aimbot", "Force safe point") },
	smtype = { ui.reference("AA", "Other", "Slow motion") },
	yawjitter = { ui.reference("AA", "Anti-aimbot angles", "Yaw jitter") },
	bodyyaw = { ui.reference("AA", "Anti-aimbot angles", "Body yaw") },
	fs = { ui.reference("AA", "Anti-aimbot angles", "Freestanding") },
	os = { ui.reference("AA", "Other", "On shot anti-aim") },
	sw = { ui.reference("AA", "Other", "Slow motion") },
	dt = { ui.reference("RAGE", "Aimbot", "Double tap") },
	ps = { ui.reference("MISC", "Miscellaneous", "Ping spike") },
	fakelag = ui.reference("AA", "Fake lag", "Limit"),
}
local reversed = false

local xadd = 0
local yadd = 0
local rad = 0
local cir = 0

local abftimer = globals.tickcount()
local vector = require "vector"
local paint_funcs = {}
paint_funcs.notifications = {}
paint_funcs.notifications.table_text = {}


-- References
local ref = {
    --fakeyawlimit = ui.reference('AA', 'anti-aimbot angles', 'Fake yaw limit'),
    fsbodyyaw = ui.reference('AA', 'anti-aimbot angles', 'Freestanding body yaw'),
	bodyyaw = {ui.reference('AA', 'Anti-aimbot angles', 'Body yaw')},
	fs = {ui.reference('AA', 'Anti-aimbot angles', 'Freestanding')},
	os = {ui.reference('AA', 'Other', 'On shot anti-aim')},
	dt = {ui.reference('RAGE', 'Aimbot', 'Double tap')}
}



-- Screen res
local sc 			= {client.screen_size()}
local cw 			= sc[1]/2
local ch 			= sc[2]/2

-- Menu Items




-- Variables	


-- Gui Creation
local iu = {
	x = database.read("ui_x") or 250,
	y = database.read("ui_y") or 250,
	w = 140,
	h = 1,
	dragging = false
}



local function intersect(x, y, w, h, debug) 
	local cx, cy = ui.mouse_position()
	return cx >= x and cx <= x + w and cy >= y and cy <= y + h
end

local function clamp(x, min, max)
	return x < min and min or x > max and max or x
end

local function contains(table, key)
    for index, value in pairs(table) do
        if value == key then return true end -- , index
    end
    return false -- , nil
end

local function KaysFunction(A,B,C)
    local d = (A-B) / A:dist(B)
    local v = C - B
    local t = v:dot(d) 
    local P = B + d:scaled(t)
    
    return P:dist(C)
end

local function reset_brute()
	table.insert(paint_funcs.notifications.table_text, {
    text = "[Kazune Yaw] \aFFFFFFFFAnti-Bruteforce reset",
    timer = globals.realtime(),

    --smooth_y = paint_funcs.notifications.vars.screen[2] + 100,
    alpha = 0,

    first_circle = 0,
    sencond_circle = 0,

    box_left = paint_funcs.notifications.vars.screen[1] / 2,
    box_right = paint_funcs.notifications.vars.screen[1] / 2,

    box_left_1 = paint_funcs.notifications.vars.screen[1] / 2,
    box_right_1 = paint_funcs.notifications.vars.screen[1] / 2
	})   
	reversed = false
	
end

local function on_bullet_impact(e)
	local local_player = entity.get_local_player()
	local shooter = client.userid_to_entindex(e.userid)

	if not true then return end

	if not entity.is_enemy(shooter) or not entity.is_alive(local_player) then
		return
	end

	local shot_start_pos 	= vector(entity.get_prop(shooter, "m_vecOrigin"))
	shot_start_pos.z 		= shot_start_pos.z + entity.get_prop(shooter, "m_vecViewOffset[2]")
	local eye_pos			= vector(client.eye_position())
	local shot_end_pos 		= vector(e.x, e.y, e.z)
	local closest			= KaysFunction(shot_start_pos, shot_end_pos, eye_pos)

	if globals.tickcount() - abftimer < 0 then
		abftimer = globals.tickcount()
	end

	if globals.tickcount() - abftimer > 3 and closest < 70 then
		abftimer = globals.tickcount()
		reversed = not reversed
		client.delay_call(7,reset_brute)
		local notifystate = reversed and 'P2[EXT]' or 'P1[DEF]'
		table.insert(paint_funcs.notifications.table_text, {
		text = "[Kazune Yaw] \aFFFFFFFFAnti-Bruteforce Reversed due to enemy shot  -  State : "..notifystate,
		timer = globals.realtime(),
		
		smooth_y = paint_funcs.notifications.vars.screen[2] + 100,
		alpha = 0,

		first_circle = 0,
		sencond_circle = 0,

		box_left = paint_funcs.notifications.vars.screen[1] / 2,
		box_right = paint_funcs.notifications.vars.screen[1] / 2,

		box_left_1 = paint_funcs.notifications.vars.screen[1] / 2,
		box_right_1 = paint_funcs.notifications.vars.screen[1] / 2
		})   		
	end
end




--

-- Handles all callbacks
local function handle_callbacks()
	local call_back = client.set_event_callback

	-- Handles Bruteforce
	call_back('bullet_impact', on_bullet_impact)



	-- Resets Bruteforce
	call_back('shutdown', function()
		reset_brute()
	end)

	call_back('round_end', reset_brute)
	call_back('round_start', reset_brute)
	call_back('client_disconnect', reset_brute)
	call_back('level_init', reset_brute)
	call_back('player_connect_full', function(e) if client.userid_to_entindex(e.userid) == entity.get_local_player() then reset_brute() end end)
end


handle_callbacks()





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

local function yuanjiao(xstart,ystart,r,startangle,endangle,rc,g,b,a)
	for i = startangle,endangle do
		rad = math.pi / 180 * i
		xadd = math.sin(rad) * r
		yadd = math.cos(rad) * r
		renderer.line(xstart - xadd, ystart - yadd, xstart - xadd + 1, ystart - yadd + 1, rc,g,b,a)
	end
end


local statetext = "DEFAULT"
local yawslider = 0
local jittermode = 'Off'
local jitterslider = 0
local byawmode = 'Static'
local byawslider = 180
local fyaw = 60
local roll = 0
local yawfs = false





local images = require "gamesense/images"
local csgo_weapons = require "gamesense/csgo_weapons"
local anti_aim = require 'gamesense/antiaim_funcs'
local vector = require "vector"
local ind_alpha = 255
local ind_reverse = false
local debug = false




local air_strafe = ui.reference("Misc", "Movement", "Air strafe")



--("AA", "Anti-aimbot angles","")

local shit_var = 0
local lasttick = globals.tickcount()
local screen_x, screen_y = client.screen_size()
local real_x, real_y = screen_x / 2, screen_y / 2
--local ctick = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
--ui.set_visible(ctick,true)
local fsmode = ui.new_combobox("AA", "Anti-aimbot angles","Freestanding keybind mode",{'Always on','On hotkey','Toggle','Off hotkey'})
local head = ui.new_label("AA", "Anti-aimbot angles","\aD6BE73FF--------------------[Kazune.lua]--------------------")
local enabled_aa = ui.new_checkbox("AA", "Anti-aimbot angles", "\aFB8EEAFF>>[Kazune Yaw] Enable"..'\a5FF2FFFF         - BETA')
--local dangerousmode = ui.new_checkbox("AA", "Anti-aimbot angles", "Dangerous Mode")
local tankaa = ui.new_checkbox("AA", "Anti-aimbot angles", "Experimental Mode")
local cetou = ui.new_checkbox("AA", "Anti-aimbot angles", "Untrusted AntiAims")
local onshotfix = ui.new_checkbox("AA", "Anti-aimbot angles", "Onshot Fakelag Fix")
local highspeed = ui.new_hotkey("AA", "Anti-aimbot angles",'\a2B9F34FF[+] '.."\aD6BE73FFForce roll on moving")
local fear_ideal_tick = ui.new_hotkey("AA", "Anti-aimbot angles", '\a2B9F34FF[+] '.."\aD6BE73FFIDEALTICK [FS]", false)
local rebindap = ui.new_hotkey("AA", "Anti-aimbot angles", '\a2B9F34FF[+] '.."\aD6BE73FFAUTO PEEK REBIND", false)
local manual_left_dir = ui.new_hotkey("AA", "Anti-aimbot angles", '\a2B9F34FF[+] '.."\aD6BE73FFManual Left")
local manual_right_dir = ui.new_hotkey("AA", "Anti-aimbot angles", '\a2B9F34FF[+] '.."\aD6BE73FFManual Right")
local manual_backward_dir = ui.new_hotkey("AA", "Anti-aimbot angles", '\a2B9F34FF[+] '.."\aD6BE73FFManual Back")
local reedgeyaw = ui.new_hotkey("AA", "Anti-aimbot angles",'\a2B9F34FF[+] '.."\aD6BE73FFReworked Edgeyaw")
local enable_it = ui.new_checkbox("AA", "Anti-aimbot angles", "Jumpscout")
local indicatortypes = ui.new_combobox("AA", "Anti-aimbot angles","Indicator Style",{'New V4',"New","Old"})
local sadfasdfasdf = ui.new_label("AA", "Anti-aimbot angles","Manual Arrows Distance")
local indgap = ui.new_slider("AA", "Anti-aimbot angles", "\n Manual Direction Number", 0, 300, 70)
local manual_state = ui.new_slider("AA", "Anti-aimbot angles", "\n Manual Direction Number", 0, 3, 0)
local text_label2 = ui.new_label("AA", "Anti-aimbot angles", "INDICATOR COLOR")
local text_color2 = ui.new_color_picker("AA", "Anti-aimbot angles", "\n Freestanding State Colors 2", 255, 255, 255, 255)
local text_label3 = ui.new_label("AA", "Anti-aimbot angles", "MANUAL AA COLOR")
local desync_real_color = ui.new_color_picker("AA", "Anti-aimbot angles", "\n Manual1", 255, 255, 255, 255)
local text_label4 = ui.new_label("AA", "Anti-aimbot angles", "MANUAL AA COLOR 2")
local desync_real_color2 = ui.new_color_picker("AA", "Anti-aimbot angles", "\n Manual2", 255, 255, 255, 255)
local text_label6 = ui.new_label("AA", "Anti-aimbot angles", "menu watermark color")
local menuclr = ui.new_color_picker("AA", "Anti-aimbot angles", "2", 255, 255, 255, 255)
local text_label7 = ui.new_label("AA", "Anti-aimbot angles", "V4 Indicator Text Color")
local text_color7 = ui.new_color_picker("AA", "Anti-aimbot angles", "asdfgh", 255, 255, 255, 255)
local text_label8 = ui.new_label("AA", "Anti-aimbot angles", "V4 Indicator Main Color")
local text_color8 = ui.new_color_picker("AA", "Anti-aimbot angles", "asdfgasdfh", 255, 255, 255, 255)
local weaponinfoui = ui.new_checkbox("AA", "Anti-aimbot angles", "Weapon Info Indicator")
local infocolor = ui.new_color_picker("AA", "Anti-aimbot angles", "Weapon Info Ind Color", 255, 255, 255, 255)
local infox = ui.new_slider("AA", "Anti-aimbot angles", "Info X", 0, screen_x, 0)
local infoy = ui.new_slider("AA", "Anti-aimbot angles", "Info Y", 0, screen_y, 0)
local head2 = ui.new_label("AA", "Anti-aimbot angles","\aD6BE73FF--------------------[Kazune.lua]--------------------")



paint_funcs.notifications.vars = {
    screen = {client.screen_size()}
}


local main = {}


local funcs = {}
funcs.math = {}

--function funcs.math:lerp(start, vend, time)
    --return start + (vend - start) * time
--end





table.insert(paint_funcs.notifications.table_text, {
    text = "[Kazune Yaw] \aFFFFFFFF Build - BETA   Version - 4.6.1",
    timer = globals.realtime(),

    smooth_y = paint_funcs.notifications.vars.screen[2] + 100,
    alpha = 0,

    first_circle = 0,
    sencond_circle = 0,

    box_left = paint_funcs.notifications.vars.screen[1] / 2,
    box_right = paint_funcs.notifications.vars.screen[1] / 2,

    box_left_1 = paint_funcs.notifications.vars.screen[1] / 2,
    box_right_1 = paint_funcs.notifications.vars.screen[1] / 2
})   

table.insert(paint_funcs.notifications.table_text, {
    text = "[Kazune Yaw] \aFFFFFFFFSetup Sucessfully",
    timer = globals.realtime(),

    smooth_y = paint_funcs.notifications.vars.screen[2] + 100,
    alpha = 0,

    first_circle = 0,
    sencond_circle = 0,

    box_left = paint_funcs.notifications.vars.screen[1] / 2,
    box_right = paint_funcs.notifications.vars.screen[1] / 2,

    box_left_1 = paint_funcs.notifications.vars.screen[1] / 2,
    box_right_1 = paint_funcs.notifications.vars.screen[1] / 2
})   
function paint_funcs.notifications:on_paint()
    if entity.get_local_player() == nil then
        return
    end

    local y = self.vars.screen[2] - 100

    
    for i, info in ipairs(self.table_text) do
        if i > 5 then
            table.remove(self.table_text,i)
        end
        if info.text ~= nil and info ~= "" then
            local text_size = {renderer.measure_text(nil,info.text)}
            if info.timer + 3.8 < globals.realtime() then
                --info.first_circle = funcs.math:lerp(info.first_circle,0,globals.frametime() * 1)
                --info.sencond_circle = funcs.math:lerp(info.sencond_circle,0,globals.frametime() * 1)
                --info.box_left = funcs.math:lerp(info.box_left,self.vars.screen[1]/2,globals.frametime() * 1)
                --info.box_right = funcs.math:lerp(info.box_right,self.vars.screen[1]/2,globals.frametime() * 1)
                --info.box_left_1 = funcs.math:lerp(info.box_left_1,self.vars.screen[1]/2,globals.frametime() * 1)
                --info.box_right_1 = funcs.math:lerp(info.box_right_1,self.vars.screen[1]/2,globals.frametime() * 1)
                --info.smooth_y = funcs.math:lerp(info.smooth_y,self.vars.screen[2] + 100,globals.frametime() * 2)
                --info.alpha = funcs.math:lerp(info.alpha,0,globals.frametime() * 4)

            else
                --info.alpha = funcs.math:lerp(info.alpha,255,globals.frametime() * 4)
                --info.smooth_y = funcs.math:lerp(info.smooth_y,y,globals.frametime() * 2)
                --info.first_circle = funcs.math:lerp(info.first_circle,275,globals.frametime() * 1)
                --info.sencond_circle = funcs.math:lerp(info.sencond_circle,-95,globals.frametime() * 1)
                --info.box_left = funcs.math:lerp(info.box_left,self.vars.screen[1]/2 - text_size[1] /2 -2,globals.frametime() * 1)
                --info.box_right = funcs.math:lerp(info.box_right,self.vars.screen[1]/2  - text_size[1] /2 +4,globals.frametime() * 1)
                --info.box_left_1 = funcs.math:lerp(info.box_left_1,self.vars.screen[1]/2- text_size[1] /2 -2,globals.frametime() * 1)
                --info.box_right_1 = funcs.math:lerp(info.box_right_1,self.vars.screen[1]/2 - text_size[1] /2 +4,globals.frametime() * 1)
            end
            --local add_y = math.floor(info.smooth_y)
            local alpha = math.floor(info.alpha)
            local first_circle = math.floor(info.first_circle)
            local second_circle = math.floor(info.sencond_circle)
            local left_box = math.floor(info.box_left)
            local right_box = math.floor(info.box_right)
            local left_box_1 = math.floor(info.box_left_1)
            local right_box_1 = math.floor(info.box_right_1)

            local r,g,b,unnnnnnnnnnnnnnnnnn = ui.get(text_color8)
            
            --renderer.blur(self.vars.screen[1] / 2 - text_size[1] / 2 - 9 ,add_y - 21,text_size[1] + 18,text_size[2] + 8,0,0,0,0)
            --renderer.gradient(self.vars.screen[1] / 2 - text_size[1] / 2 - 4 ,add_y - text_size[2] / 2 + 2, text_size[1] + text_size[2] / 2 + 4,2,r,g,b,alpha,r,g,b,alpha,true)
            --renderer.gradient(self.vars.screen[1] / 2 - text_size[1] / 2 - 4 ,add_y - text_size[2] * 2 + 2, text_size[1] + text_size[2] / 2 + 4,2,r,g,b,alpha,r,g,b,alpha,true)
            --renderer.circle_outline(self.vars.screen[1] / 2 - text_size[1] / 2 - 4 ,add_y - text_size[2], r,g,b,alpha, text_size[2] / 2 + 4, 90, 0.5,2)
            --renderer.circle_outline(self.vars.screen[1] / 2 + text_size[1] / 2 + 4 ,add_y - text_size[2], r,g,b,alpha, text_size[2] / 2 + 4, 270, 0.5,2)

           
            renderer.text(
                --self.vars.screen[1] / 2 - text_size[1] / 2 ,add_y - 18,
                r,g,b,alpha,nil,0,info.text
            )
    
            y = y - 30
            if info.timer + 4 < globals.realtime() then
                table.remove(self.table_text,i)
            end
        end
    end

end

function main:paint_ui()
    paint_funcs.notifications:on_paint()
end


client.set_event_callback("paint_ui",main.paint_ui)







--epeek

client.set_event_callback("setup_command",function(e)
    local weaponn = entity.get_player_weapon()
        if weaponn ~= nil and entity.get_classname(weaponn) == "CC4" then
            if e.in_attack == 1 then
                e.in_attack = 0 
                e.in_use = 1
            end
        else
            if e.chokedcommands == 0 then
                e.in_use = 0
            end
        end
end)

--manual bind system

local bind_system = {left = false, right = false, back = false,}
function bind_system:update()
	ui.set(manual_left_dir, "On hotkey")
	ui.set(manual_right_dir, "On hotkey")
	ui.set(manual_backward_dir, "On hotkey")
	local m_state = ui.get(manual_state)
	local left_state, right_state, backward_state = 
		ui.get(manual_left_dir), 
		ui.get(manual_right_dir),
		ui.get(manual_backward_dir)

	if left_state == self.left and 
		right_state == self.right and
		backward_state == self.back then
		return
	end

	self.left, self.right, self.back = 
		left_state, 
		right_state, 
		backward_state

	if (left_state and m_state == 1) or (right_state and m_state == 2) or (backward_state and m_state == 3) then
		ui.set(manual_state, 0)
		return
	end

	if left_state and m_state ~= 1 then
		ui.set(manual_state, 1)
	end

	if right_state and m_state ~= 2 then
		ui.set(manual_state, 2)
	end

	if backward_state and m_state ~= 3 then
		ui.set(manual_state, 3)	
	end
end

local sv2 = 0
local rtnyaw = 0

function update_fakeyaw(minf,maxf,tickspd,stage)

	if globals.tickcount() - sv2 > tickspd then
		rtnyaw = rtnyaw + stage
		sv2 = globals.tickcount()
	end
	if globals.tickcount() < sv2 then
		sv2 = globals.tickcount()
		rtnyaw = minf
	end
	if rtnyaw > maxf then
		rtnyaw = minf
	end
	return rtnyaw
end

local chokex = 0
local curtick = 0
local gettick = globals.tickcount
local curchoke = globals.chokedcommands
local yawreversed = false
local yawshit = 0
local function tankyaw(a,b)
		if curtick - yawshit > 1 and chokex == 1 then
			yawreversed = not yawreversed
			yawshit = curtick
		end
		if curtick - yawshit > 20 or curtick - yawshit < 0 then
			yawshit = curtick
		end
		return yawreversed and a or b
end

local byawreversed = false
local byawshit = 0
local function tankbyaw(a,b)
		if curtick - byawshit > 1 and chokex == 1 then
			byawreversed = not byawreversed
			byawshit = curtick
		end
		if curtick - byawshit > 20 or curtick - byawshit < 0 then
			byawshit = curtick
		end
		return byawreversed and a or b
end

local fyawreversed = false
local fyawshit = 0
local function tankfyaw(a,b)
		if curtick - fyawshit > 1 and chokex == 1 then
			fyawreversed = not fyawreversed
			fyawshit = curtick
		end
		if curtick - fyawshit > 20 or curtick - fyawshit < 0 then
			fyawshit = curtick
		end
		return fyawreversed and a or b
end




--main antiaim part
client.set_event_callback("paint_ui", function(e)

	ui.set(aa.roll,0)
	ui.set_visible(manual_state,debug)
	ui.set_visible(aa.pitch,debug)
	ui.set_visible(aa.yawbase,debug)
	ui.set_visible(aa.yaw[1],debug)
	ui.set_visible(aa.yaw[2],debug)
	--ui.set_visible(aa.fakeyawlimit,debug)
	ui.set_visible(aa.fsbodyyaw,debug)
	ui.set_visible(aa.edgeyaw,debug)
	ui.set_visible(aa.yawjitter[1],debug)
	ui.set_visible(aa.yawjitter[2],debug)
	ui.set_visible(aa.bodyyaw[1],debug)
	ui.set_visible(aa.bodyyaw[2],debug)
	ui.set_visible(aa.roll,debug)


	local local_player = entity.get_local_player()
	
	if not entity.is_alive(local_player) or not ui.get(enabled_aa) then
		return
	end
	local vx, vy = entity.get_prop(local_player, "m_vecVelocity")
	local speed = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))
	



	local onground = (bit.band(entity.get_prop(local_player, "m_fFlags"), 1) == 1)
	local infiniteduck = (bit.band(entity.get_prop(local_player, "m_fFlags"), 2) == 2)
	local epeek = client.key_state(0x45)

	bind_system:update()

	if ui.get(reedgeyaw) and onground then
		ui.set(aa.edgeyaw,true)
	else
		ui.set(aa.edgeyaw,false)
	end


	if ui.get(onshotfix) and ui.get(aa.dt[2]) and not ui.get(aa.fakeduck) then
		ui.set(aa.fakelag,1)
	elseif ui.get(onshotfix) and ui.get(aa.os[2]) and not ui.get(aa.fakeduck) then
		ui.set(aa.fakelag,1)
	elseif ui.get(onshotfix) then
		ui.set(aa.fakelag,14)
	end




	--statetext = 
	--yawslider = 
	--jittermode = 
	--jitterslider = 
	--byawmode = 
	--byawslider = 
	--fyaw = 
	--roll = 
	--yawfs =


	

	
	if ui.get(tankaa) then
		chokex = curchoke()
		curtick = gettick()
		if onground and speed > 5 then
			statetext = 'TANKAA[EX]'
			yawslider = ui.get(highspeed) and 20 or reversed and tankyaw(-38,38) or tankyaw(-39,39)
			yawslider = yawslider + math.random(-2,2)
			jittermode = ui.get(highspeed) and 'Off' or 'Center'
			jitterslider = ui.get(highspeed) and 0 or 0
			byawmode = ui.get(highspeed) and 'Static' or 'Static'
			byawslider = ui.get(highspeed) and 180 or tankbyaw(-111,111)
			fyaw = ui.get(highspeed) and 60 or 59
			roll = ui.get(highspeed) and 50 or 0
			yawfs =	false

		elseif onground then
			statetext = ui.get(cetou) and 'EXTDESYNC' or 'STANDING'
			yawslider = ui.get(cetou) and -3 or ui.get(aa.dt[2]) and tankyaw(-44,45) or -11
			jittermode = ui.get(cetou) and 'Off' or 'Center'
			jitterslider = ui.get(cetou) and 0 or 5
			byawmode = ui.get(cetou) and 'Static' or 'Static'
			byawslider = ui.get(cetou) and 180 or 180
			fyaw = ui.get(cetou) and 60 or 25
			roll =  ui.get(cetou) and 50 or 0
			yawfs =	false
		end
		

		if not ui.get(aa.dt[2]) and not ui.get(aa.os[2]) and speed > 5 then
			statetext = 'MOVING[CHK]'
			yawslider = 0
			byawmode = 'Jitter'
			jitterslider = 47
			fyaw = 59
			yawfs = false
		end

		if ui.get(aa.sw[1]) and ui.get(aa.sw[2]) then
			statetext = ui.get(cetou) and 'EXTDESYNC' or 'SLOWWALKING'
			yawslider = ui.get(cetou) and 3 or -7
			jittermode = ui.get(cetou) and 'Off' or 'Center'
			jitterslider = 66
			byawmode = ui.get(cetou) and 'Static' or 'Jitter'
			byawslider = ui.get(cetou) and 180 or 0
			fyaw = ui.get(cetou) and 60 or 59
			roll = ui.get(cetou) and 50 or 0
			yawfs = false
		end
		
		if onground and infiniteduck or onground and ui.get(aa.fakeduck) then
			statetext = ui.get(cetou) and 'EXTDESYNC' or 'CROUCHING'
			yawslider = ui.get(cetou) and 45 or 7
			jittermode = ui.get(cetou) and 'Off' or 'Center'
			jitterslider = 66
			byawmode = ui.get(cetou) and 'Static' or 'Jitter'
			byawslider = ui.get(cetou) and 180 or 0
			fyaw = ui.get(cetou) and 60 or 59
			roll = ui.get(cetou) and 50 or 0
			yawfs = false
		end

		--anti_aim.get_desync(2) < 0

		if client.key_state(0x20) or not onground then
			statetext = ui.get(cetou) and 'EXTDESYNC' or 'INAIR'
			yawslider = ui.get(cetou) and 7 or reversed and tankfyaw(-33,34) + math.random(-2,2) or tankfyaw(-33,35) + math.random(-1,1)
			jittermode =  ui.get(cetou) and 'Off' or 'Center'
			jitterslider = ui.get(cetou) and 0 or 0
			byawmode = ui.get(cetou) and 'Static' or 'Static'
			byawslider = ui.get(cetou) and 180 or tankbyaw(-111,111)
			fyaw = ui.get(cetou) and 60 or 59
			roll = ui.get(cetou) and 50 or 0
			yawfs =	ui.get(cetou) and false or false
		end
		
		if not ui.get(aa.dt[2]) and not ui.get(aa.os[2]) and not onground or ui.get(aa.fakeduck) then
			statetext = 'INAIR[CHK]'
			yawslider = 7
			byawmode = 'Jitter'
			jitterslider = 55
			fyaw = 60
		end

	else

		if speed > 5 then
			statetext = 'WALKING'
			yawslider = 0
			jittermode = 'Center'
			jitterslider = 5
			byawmode = 'Jitter'
			byawslider = 90
			fyaw = 60
			roll = 0
			yawfs =	true
		else
			statetext = ui.get(cetou) and 'EXTDESYNC' or 'STANDING'
			yawslider = ui.get(cetou) and -3 or 6
			jittermode = 'Off'
			jitterslider = 0
			byawmode = 'Static'
			byawslider = ui.get(cetou) and 180 or 180
			fyaw = 60
			roll =  ui.get(cetou) and 50 or 0
			yawfs =	false
		end

		if ui.get(aa.sw[1]) and ui.get(aa.sw[2]) then
			statetext = ui.get(cetou) and 'EXTDESYNC' or 'SLOWWALKING'
			yawslider = ui.get(cetou) and 3 or 2
			jittermode = ui.get(cetou) and 'Off' or 'Random'
			jitterslider = 5
			byawmode = ui.get(cetou) and 'Static' or 'Jitter'
			byawslider = ui.get(cetou) and 180 or 0
			fyaw = 60
			roll = ui.get(cetou) and 50 or 0
			yawfs = ui.get(cetou) and false or true
		end
		
		if onground and infiniteduck or onground and ui.get(aa.fakeduck) then
			statetext = ui.get(cetou) and 'EXTDESYNC' or 'CROUCHING'
			yawslider = ui.get(cetou) and 45 or 0
			jittermode = ui.get(cetou) and 'Off' or 'Center'
			jitterslider = 9
			byawmode = ui.get(cetou) and 'Static' or 'Jitter'
			byawslider = ui.get(cetou) and 180 or 0
			fyaw = 60
			roll = ui.get(cetou) and 50 or 0
			yawfs = ui.get(cetou) and false or true
		end

		if client.key_state(0x20) or not onground then
			statetext = ui.get(cetou) and 'EXTDESYNC' or 'INAIR'
			yawslider = ui.get(cetou) and 7 or 0
			jittermode = ui.get(cetou) and 'Off' or 'Center'
			jitterslider = ui.get(cetou) and 0 or 5
			byawmode = ui.get(cetou) and 'Static' or 'Jitter'
			byawslider = ui.get(cetou) and 180 or 90
			fyaw = 60
			roll = ui.get(cetou) and 50 or 0
			yawfs =	ui.get(cetou) and false or true
		end

	end


	--manual & epeek part

	if ui.get(manual_state) == 1 then
		statetext = "MANUAL-LEFT"
		yawslider = -97
		jittermode = 'Off'
		jitterslider = 0
		byawmode = 'Static'
		byawslider = -180
		fyaw = 60
		roll = ui.get(cetou) and ui.get(aa.sw[1]) and ui.get(aa.sw[2]) and 50 or 0
		yawfs = false
	end

	if ui.get(manual_state) == 2 then
		statetext = "MANUAL-RIGHT"
		yawslider = 83
		jittermode = 'Off'
		jitterslider = 0
		byawmode = 'Static'
		byawslider = 180
		fyaw = 60
		roll = ui.get(cetou) and ui.get(aa.sw[1]) and ui.get(aa.sw[2]) and -50 or 0
		yawfs = false
	end
	
	if ui.get(manual_state) == 3 then
		statetext = "FORCEBACK"
	end





	if epeek then
		statetext = "LEGIT-AA"
		byawslider = -180
		yawfs = true
	end


	--uiset part

	ui.set(aa.pitch,epeek and "Off" or "Minimal")
	ui.set(aa.yawbase,ui.get(manual_state) == 0 and "At targets" or "Local view")
	ui.set(aa.yaw[1],epeek and "Off" or "180")
	ui.set(aa.yaw[2],yawslider)
	ui.set(aa.yawjitter[1],jittermode)
	ui.set(aa.yawjitter[2],jitterslider)
	ui.set(aa.bodyyaw[1],byawmode)
	ui.set(aa.bodyyaw[2],byawslider)
	--ui.set(aa.fakeyawlimit,fyaw)
	ui.set(aa.fsbodyyaw,yawfs)

	
end)


--Extended desync part

function desync(cmd)
	cmd.roll = roll
end

client.set_event_callback("setup_command",desync)

--Jumpscout

client.set_event_callback("setup_command", function(c)
    if (ui.get(enable_it)) then
        local vel_x, vel_y = entity.get_prop(entity.get_local_player(), "m_vecVelocity")
        local vel = math.sqrt(vel_x^2 + vel_y^2)
        ui.set(air_strafe, not (c.in_jump and (vel < 10)) or ui.is_menu_open())
    end
end)

--idealtick

local a = { ui.reference("Rage", "Other", "Quick peek assist") }
local b = { ui.reference("Rage", "Aimbot", "Double tap") }
local c = { ui.reference("AA", "Anti-aimbot angles", "Freestanding") }

client.set_event_callback("paint_ui", function()
    if ui.get(fear_ideal_tick) then
        ui.set(b[2], "Always on")
        ui.set(c[2], client.key_state(0x11) and "On hotkey" or "Always on")
    else
        ui.set(b[2], "Toggle")
        ui.set(c[2], ui.get(fsmode))
    end

	if ui.get(rebindap) then
		ui.set(a[2], "Always on")
	else
		ui.set(a[2], "On hotkey")
	end
end)

--indicators part


local last_reversed = false
local animalpha = 256
local abftimer = globals.tickcount()

client.set_event_callback('paint_ui',function(e)
	local local_player = entity.get_local_player()

	if not entity.is_alive(local_player) or not ui.get(enabled_aa) then
		return
	end

	local mr,mg,mb,ma = ui.get(text_color8)

	--if last_reversed ~= reversed then
	--	animalpha = 0
	--	realpha = true
	--	client.log('Anti-Bruteforce Reversed')
	--end
	--last_reversed = reversed
	--if animalpha < 254 then	
	--	animalpha = animalpha + 1
	--elseif animalpha < 256 then
	--	animalpha = animalpha + 0.01
	--end

	last_reversed = reversed
	--local notifytext = gradient_text(238,130,238,255,186,85,211,255,'YAW  SWITCHED  DUE  TO  ANTI-BRUTEFORCE')
	--if animalpha < 256 then
	--	renderer.blur(real_x - 260,real_y + 290,520,20,0,0,0,0)
	--	renderer.text(real_x - 140, real_y + 295, 135,206,250,255, "-", 0, "[KAZUNE YAW]  -  EXPERIMENTAL MODE")
	--	renderer.text(real_x, real_y + 295, 135,206,250,255, "-", 0, notifytext..'    STATE -'..notifystate)
	--end





	local exactyaw = anti_aim.get_desync(2)
	local indyaw = exactyaw < 0
	local text_r2,text_g2,text_b2,text_a2 = ui.get(text_color2)
	local real_r, real_g, real_b, real_a = ui.get(desync_real_color)
	local real_r2, real_g2, real_b2, real_a2 = ui.get(desync_real_color2)
	local dmg_text = ui.get(aa.dmg)
	local fsstate = fs_direction == 'Right' and '[-]' or '[+]'
	local stateindtext = "STATE | " .. statetext .. fsstate
	if not ind_reverse then
		ind_alpha = ind_alpha - 1
	end
	if not ind_reverse and ind_alpha < 55 then
		ind_reverse = true
	end
	if ind_reverse then
		ind_alpha = ind_alpha + 1
	end
	if ind_reverse and ind_alpha >= 255 then
		ind_reverse = false
	end

	if ui.get(indicatortypes) == 'Old' then
		renderer.text(real_x - 23, real_y + 75, 245,245,245,255, "-", 0, "KAZUNE")
		renderer.text(real_x + 7, real_y + 75, text_r2,text_g2,text_b2,ind_alpha, "-", 0, "BETA")
	
		renderer.text(real_x - 23, real_y + 95, 245,245,245,255, "-", 0, stateindtext)

		if ui.get(aa.dt[2]) then
			renderer.text(real_x - 23, real_y + 85, 0,205,0,255, "-", 0, "DT")
		else
			renderer.text(real_x - 23, real_y + 85, 245,245,245,255, "-", 0, "DT")
		end
	
		if ui.get(aa.os[2]) then
			renderer.text(real_x - 11, real_y + 85, 255,185,15,255, "-", 0, "HS")
		else
			renderer.text(real_x - 11, real_y + 85, 245,245,245,255, "-", 0, "HS")
		end

		if ui.get(aa.fs[2]) then
			renderer.text(real_x + 2, real_y + 85, 72,118,255,255, "-", 0, "FS")
		else
			renderer.text(real_x + 2, real_y + 85, 245,245,245,255, "-", 0, "FS")
		end

		if ui.get(reedgeyaw) then
			renderer.text(real_x + 13, real_y + 85, 72,118,255,255, "-", 0, "EDGE")
		else
			renderer.text(real_x + 13, real_y + 85, 245,245,245,255, "-", 0, "EDGE")
		end


	elseif ui.get(indicatortypes) == 'New' then
		--renderer.rectangle(real_x - 40,real_y + 40,80,40,0,0,0,100)
		renderer.gradient(real_x - 40, real_y + 40, 40, 1, text_r2,text_g2,text_b2, 255, 255, 255, 255, 0, true)
		renderer.gradient(real_x - 40, real_y + 40, 1, 20, text_r2,text_g2,text_b2, 255, 255, 255, 255, 0, false)
		renderer.gradient(real_x + 40, real_y + 80, -40, 1, text_r2,text_g2,text_b2, 255, 255, 255, 255, 0, true)
		renderer.gradient(real_x + 40, real_y + 81, 1, -20, text_r2,text_g2,text_b2, 255, 255, 255, 255, 0, false)
		renderer.text(real_x - 12, real_y + 25, indyaw and 245 or text_r2,indyaw and 245 or text_g2,indyaw and 245 or text_b2,255, "cb", 0, "KAZUNE")
		renderer.text(real_x + 22, real_y + 25, indyaw and text_r2 or 245,indyaw and text_g2 or 245,indyaw and text_b2 or 245,255, "cb", 0, "YAW")
		renderer.text(real_x, real_y + 45, text_r2,text_g2,text_b2,ind_alpha, "c-", 0, "[BETA]")
		renderer.gradient(real_x, real_y + 32, exactyaw * -0.7, 5, text_r2,text_g2,text_b2, 255, 255, 255, 255, 0, true)
		
		if ui.get(aa.os[2]) and ui.get(aa.fakeduck) then
			renderer.text(real_x, real_y + 52, 190,20,20,255, "c-", 0, "HS")
		elseif ui.get(aa.os[2]) then
			renderer.text(real_x, real_y + 52, text_r2,text_b2,text_g2,255, "c-", 0, "HS")
		else
			renderer.text(real_x, real_y + 52, 190,190,190,255, "c-", 0, "HS")
		end		
		if ui.get(aa.dt[2]) and ui.get(aa.fakeduck) then
			renderer.text(real_x, real_y + 59, 190,20,20,255, "c-", 0, "DT")
		elseif ui.get(aa.dt[2]) then
			renderer.text(real_x, real_y + 59, text_r2,text_b2,text_g2,255, "c-", 0, "DT")
		else
			renderer.text(real_x, real_y + 59, 190,190,190,255, "c-", 0, "DT")
		end
		if ui.get(aa.fs[2]) then
			renderer.text(real_x, real_y + 66, text_r2,text_b2,text_g2,255, "c-", 0, "FS")
		else
			renderer.text(real_x, real_y + 66, 190,190,190,255, "c-", 0, "FS")
		end
		if ui.get(reedgeyaw) then
			renderer.text(real_x, real_y + 73, text_r2,text_b2,text_g2,255, "c-", 0, "EDGE")
		else
			renderer.text(real_x, real_y + 73, 190,190,190,255, "c-", 0, "EDGE")
		end

	else
		local yawj = exactyaw < 0 and exactyaw * -1 or exactyaw
		local spercent = math.ceil(yawj / 60 * 100)
		if spercent > 100 then
			spercent = 100
		end
		local textr,textg,textb,texta = ui.get(text_color7)
		--yuanjiao(real_x - 50,real_y + 30,5,0,87,mr,mg,mb,255)
		--yuanjiao(real_x + 50,real_y + 30,-5,91,178,mr,mg,mb,255)
		renderer.circle_outline(real_x - 50,real_y + 30, mr,mg,mb,255, 5, 180, 0.25, 1)
		renderer.circle_outline(real_x + 50,real_y + 30, mr,mg,mb,255, 5, 270, 0.25, 1)


		--renderer.circle_outline(real_x - 250,real_y + 300, mr,mg,mb,animalpha, 11, 90, 0.5, 1.5)
		--renderer.gradient(real_x - 250,real_y + 289, 500,2,mr,mg,mb,animalpha,mr,mg,mb,animalpha,true)
		--renderer.circle_outline(real_x + 250,real_y + 300, mr,mg,mb,animalpha, 11, 270, 0.5, 1.5)
		--renderer.gradient(real_x - 250,real_y + 309, 500,2,mr,mg,mb,animalpha,mr,mg,mb,animalpha,true)
		
		--renderer.line(real_x - 50, real_y + 25, real_x + 50, real_y + 25, text_r2,text_g2,text_b2,255)
		renderer.gradient(real_x - 50, real_y + 25, 100, 1, mr,mg,mb,255,mr,mg,mb,255,true)
		renderer.gradient(real_x - 55, real_y + 30, 1, 15,mr,mg,mb,255,mr,mg,mb,0,false)
		renderer.gradient(real_x + 54, real_y + 30, 1, 15, mr,mg,mb,255,mr,mg,mb,0,false)
		renderer.text(real_x, real_y + 32, textr,textg,textb,255, "cb", 0, "kazune.tech")
		renderer.text(real_x, real_y + 42, text_r2,text_g2,text_b2,ind_alpha, "c-", 0, "[BETA]")
		renderer.text(real_x, real_y + 50, text_r2,text_g2,text_b2,200, "c-", 0, statetext..'  -  '..spercent..'%')
		local counts = 0
		local os = ui.get(aa.os[2])
		local dt = ui.get(aa.dt[2])
		local fs = ui.get(aa.fs[2])
		local edge = ui.get(reedgeyaw)
		local ostext = gradient_text(238,130,238,255,186,85,211,255,'ONSHOT')
		local dttext = gradient_text(188,255,0,255,0,255,0,255,'DOUBLETAP')
		if ui.get(aa.fakeduck) then
			dttext = gradient_text(255,0,0,255,139,0,0,255,'DOUBLETAP')
			ostext = gradient_text(255,0,0,255,139,0,0,255,'ONSHOT')
		end
		local fstext = gradient_text(240,128,128,255,255,20,147,255,'FREESTAND')
		local edgetext = gradient_text(255,165,0,255,205,102,0,255,'EDGEYAW')
		

		if os then
			counts = counts + 1
		end	

		if dt then
			counts = counts + 1
		end

		if fs then
			counts = counts + 1
		end

		if edge then
			counts = counts + 1
		end




		if lastcounts ~= counts then
			indyadd = 0
		end

		if indyadd < 10 then
			indyadd = indyadd + 1
		end


		lastcounts = counts


		if edge then
			renderer.text(real_x, real_y + indyadd + counts * 10 + 40, 255,255,255,255, "c-", 0, edgetext)
			counts = counts - 1
		end
		if fs then
			renderer.text(real_x, real_y + indyadd + counts * 10 + 40, 255,255,255,255, "c-", 0, fstext)
			counts = counts - 1
		end
		if dt then
			renderer.text(real_x, real_y + indyadd + counts * 10 + 40, 255,255,255,255, "c-", 0, dttext)
			counts = counts - 1
		end
		if os then
			renderer.text(real_x, real_y + indyadd + counts * 10 + 40, 255,255,255,255, "c-", 0, ostext)
			counts = counts - 1
		end



	end
	if globals.tickcount() - abftimer < 0 then
		abftimer = globals.tickcount()
	end
	local gapvalue = ui.get(indgap)

	if ui.get(manual_state) == 3 then
			renderer.text(real_x, real_y + gapvalue, real_r, real_g, real_b, real_a, "c+", 0, "v")
			renderer.text(real_x - gapvalue, real_y, real_r, real_g, real_b, real_a, "c+", 0, "<")
			renderer.text(real_x + gapvalue, real_y, real_r, real_g, real_b, real_a, "c+", 0, ">")
			renderer.text(real_x, real_y + gapvalue, real_r2, real_g2, real_b2, real_a2, "c+", 0, "v")
	end

	if ui.get(manual_state) == 1 or ui.get(manual_state) == 2 then
			renderer.text(real_x, real_y + gapvalue, real_r, real_g, real_b, real_a, "c+", 0, "v")
			renderer.text(real_x - gapvalue, real_y, real_r, real_g, real_b, real_a, "c+", 0, "<")
			renderer.text(real_x + gapvalue, real_y, real_r, real_g, real_b, real_a, "c+", 0, ">")
			renderer.text(real_x + (ui.get(manual_state) == 1 and - gapvalue or gapvalue), real_y, real_r2, real_g2, real_b2, real_a2, "c+", 0, ui.get(manual_state) == 1 and "<" or ">")
	end

end)


--weaponinfo

client.set_event_callback("paint_ui", function()
	local local_player = entity.get_local_player()

	if not entity.is_alive(local_player) or not ui.get(enabled_aa) then
		return
	end

	if ui.get(weaponinfoui) then
		local incr,incg,incb,inca = ui.get(infocolor)
		local weapon_entindex = entity.get_player_weapon(entity.get_local_player())
		local weapon = csgo_weapons[entity.get_prop(weapon_entindex, "m_iItemDefinitionIndex")]
		if weapon == nil then
			return
		end
		local weapon_icon = images.get_weapon_icon(weapon)
		local text_r2,text_g2,text_b2,text_a2 = ui.get(text_color2)
		local infox = ui.get(infox)
		local infoy = ui.get(infoy)
		renderer.gradient(infox - 81, infoy - 1, 80, 1, text_r2,text_g2,text_b2, 255, 255, 255, 255, 0, true)
		renderer.gradient(infox - 81, infoy - 1, 1, 40, text_r2,text_g2,text_b2, 255, 255, 255, 255, 0, false)
		renderer.gradient(infox + 80, infoy + 80, -80, 1, text_r2,text_g2,text_b2, 255, 255, 255, 255, 0, true)
		renderer.gradient(infox + 80, infoy + 81, 1, -40, text_r2,text_g2,text_b2, 255, 255, 255, 255, 0, false)
		renderer.rectangle(infox - 80 ,infoy,160,80,0,0,0,100)
		renderer.text(infox,infoy + 8, 255,255,255,255, "c-", 0, "[KAZUNE] WEAPON  INFO")
		weapon_icon:draw(infox - 70, infoy + 20, nil, 25, 255, 255, 255, 255)
		renderer.text(infox - 65,infoy + 45, 255,255,255,255, "b", 0, 'HC:'..ui.get(aa.hc))
		renderer.text(infox - 65,infoy + 55, 255,255,255,255, "b", 0, 'DMG:'..ui.get(aa.dmg))
		if ui.get(aa.baim) then
			renderer.text(infox + 25,infoy + 56, incr,incg,incb,inca, "b", 0, 'BAIM')
		else
			renderer.text(infox + 25,infoy + 56, 255,255,255,100, "b", 0, 'BAIM')
		end
		if ui.get(aa.sp[1]) then
			renderer.text(infox + 25,infoy + 44, incr,incg,incb,inca, "b", 0, 'SAFE')
		else
			renderer.text(infox + 25,infoy + 44, 255,255,255,100, "b", 0, 'SAFE')
		end
		if ui.get(aa.preferbaim) then
			renderer.text(infox + 25,infoy + 32, incr,incg,incb,inca, "b", 0, '|BAIM|')
		else
			renderer.text(infox + 25,infoy + 32, 255,255,255,100, "b", 0, '|BAIM|')
		end
		if ui.get(aa.prefersp) then
			renderer.text(infox + 25,infoy + 20, incr,incg,incb,inca, "b", 0, '|SAFE|')
		else
			renderer.text(infox + 25,infoy + 20, 255,255,255,100, "b", 0, '|SAFE|')
		end

	end
end)

--menu part

client.set_event_callback("paint_ui", function()
	
	local menux, menuy = ui.menu_position()
	if ui.is_menu_open() then
	--if false then
		renderer.gradient(menux - 300, menuy + 80, 270, 2, 135, 206, 235, 255, 0, 0, 255, 0, true)
		renderer.blur(menux - 300, menuy + 80, 270, 270, 0, 0, 0, 100)
		renderer.text(menux - 280, menuy + 90, 255, 255, 255, 255, '-', 0, 'UPDATE  LOG')
		renderer.text(menux - 230, menuy + 90, 0, 255, 0, 255, '-', 0, 'V4.6.1')
		renderer.text(menux - 200, menuy + 90, 255, 127, 0, 255, '-', 0, 'BETA')
		renderer.text(menux - 280, menuy + 110, 255, 225, 255, 255, '-', 0, '[ANTI-AIM]')
		renderer.text(menux - 270, menuy + 120, 255, 255, 255, 255, '-', 0, '^BETTER  PRESETS')
		renderer.text(menux - 280, menuy + 130, 255, 225, 255, 255, '-', 0, '[OTHERS]')
		renderer.text(menux - 270, menuy + 140, 255, 255, 255, 255, '-', 0, '^FIXED  COUNTLESS  BUGS')
		renderer.text(menux - 280, menuy + 180, 255, 225, 255, 255, '-', 0, '[DATE]')
		renderer.text(menux - 270, menuy + 190, 0, 255, 0, 255, '-', 0, '2022.04.09')
		renderer.text(menux - 270, menuy + 300, 255, 165, 0, 255, '-', 0, '>> KAZUNE  ANTI-AIM  SYSTEM')
	end
	
end)	

ui.set(manual_state, 0)