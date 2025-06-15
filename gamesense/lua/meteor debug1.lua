local aa ,menu,handle_aa ,settings= {},{},{},{}
local base64 = require "gamesense/base64"
local clipboard = require 'gamesense/clipboard'
local debug= true
aa = {
	enable = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
	pitch = {ui.reference("AA", "Anti-aimbot angles", "pitch")},
	leg = ui.reference("AA", "Other", "Leg Movement"),
	yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
	yaw = { ui.reference("AA", "Anti-aimbot angles", "Yaw") },
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
	yawjitter = { ui.reference("AA", "Anti-aimbot angles", "Yaw jitter") },
	bodyyaw = { ui.reference("AA", "Anti-aimbot angles", "Body yaw") },
	fs = {ui.reference("AA", "Anti-aimbot angles", "Freestanding")},
	quickpeek = {ui.reference("RAGE", "Other", "Quick peek assist")},
	os = { ui.reference("AA", "Other", "On shot anti-aim") },
	sw = { ui.reference("AA", "Other", "Slow motion") },
	dt = { ui.reference("RAGE", "Aimbot", "Double tap") },
	ps = { ui.reference("MISC", "Miscellaneous", "Ping spike") },
	fakelag = ui.reference("AA", "Fake lag", "Limit"),

}

local menuToggle = function(state, reference)
	for i,v in pairs(reference) do
		if type(v) == "table" then
			for i2,v2 in pairs(v) do
				ui.set_visible(v2, state) 
			end
		else
			ui.set_visible(v, state)
		end
	end
end
local pstate = {"Global","STAND","MOVE","AIR","AIR*","AIR-D","AIR-D*","CROUCH","SLOWWALK"}
menu = {
	header = ui.new_label("AA", "Anti-aimbot angles", '\aD0B0FFFFMeteor Anti-Aim System - [ Beta ]'),
 	menu_choice = ui.new_combobox("AA", "Anti-aimbot angles","\a7FE5FFFF\nMenu",{"Keybinds",'Anti-Aim Builder','Misc'}),
	 manual_state = ui.new_slider("AA", "Anti-aimbot angles", "\n Manual Direction Number", 0, 3, 0),
	hotkey = {
		m_left = ui.new_hotkey("AA", "Anti-aimbot angles", "+ \aD0B0FFFFManual-Left \aFFFFFFFF+"),
		m_right = ui.new_hotkey("AA", "Anti-aimbot angles", "+ \aD0B0FFFFManual-Right \aFFFFFFFF+"),
		m_back = ui.new_hotkey("AA", "Anti-aimbot angles", "+ \aD0B0FFFFManual-Back \aFFFFFFFF+"),
		fs = ui.new_hotkey("AA", "Anti-aimbot angles", "+ \aD0B0FFFFFreestanding \aFFFFFFFF+"),
		edg = ui.new_hotkey("AA", "Anti-aimbot angles", "+ \aD0B0FFFFEdge-Yaw \aFFFFFFFF+"),
		epeek_enable = ui.new_hotkey("AA", "Anti-aimbot angles", "+ \a8BFF7CFFEnable E-Peek \aFFFFFFFF+"),

	},
	exploits = {
		killsay = ui.new_checkbox("AA", "Anti-aimbot angles", "- \a8BFF7CFFKill Say \aFFFFFFFF-"),
		anti_knife =ui.new_checkbox("AA", "Anti-aimbot angles","- \a8BFF7CFFAnti Knife \aFFFFFFFF-"),
		debug_menu = ui.new_checkbox("AA", "Anti-aimbot angles", "- \a8BFF7CFFDebug Menu \aFFFFFFFF-"),   
	},

	state = ui.new_combobox("AA", "Anti-aimbot angles","\aD0B0FFFFPlayer State",pstate),
	builder = (function()
		local element = {}
		for i=1,#pstate do
			if not element[i] then
				element[i] = {}
			end
			element[i] = {
				Enabled =  ui.new_checkbox("AA", "Anti-aimbot angles"," > \n"..pstate[i]),
				yawl =  ui.new_slider("AA", "Anti-aimbot angles","\n[L]"..pstate[i],-180,180,0),
				yawr =  ui.new_slider("AA", "Anti-aimbot angles","\n[R]"..pstate[i],-180,180,0),
				jittermode = ui.new_combobox("AA", "Anti-aimbot angles","Jitter Mode\n"..pstate[i],{"Off","Offset","Center","Random","skitter"}),
				jitter = ui.new_slider("AA", "Anti-aimbot angles","\njitter"..pstate[i],-180,180,0),
				byawmode = ui.new_combobox("AA", "Anti-aimbot angles","Body Yaw Mode\n"..pstate[i],{"off","Jitter","Static"}),
				byaw = ui.new_slider("AA", "Anti-aimbot angles","\nBody Yaw Value"..pstate[i],-180,180,0),

				Defensive =ui.new_checkbox("AA", "Anti-aimbot angles"," Defensive \n"..pstate[i]),
				Defensive_breaker =  ui.new_combobox("AA", "Anti-aimbot angles","Defensive Mod\n"..pstate[i],{"On Peek","Always On"}),
				Defensive_Yaw_Mod =  ui.new_combobox("AA", "Anti-aimbot angles","Defensive Yaw Mod\n"..pstate[i],{"Center","Random", "Spin","Down","Without","Circular","Switch Left","Switch Right","Free Sway"}),
				--[[
				x_way =  ui.new_slider("AA", "Anti-aimbot angles","\nX-way"..pstate[i],1,10,3),
				way_value = ui.new_slider("AA", "Anti-aimbot angles","\nX-value"..pstate[i],-180,180,50),
				]]
				spin =  ui.new_slider("AA", "Anti-aimbot angles","\nSpin"..pstate[i],1,90,25),
				center =  ui.new_slider("AA", "Anti-aimbot angles","\nCenter"..pstate[i],-180,180,0),
				Defensive_Pitch =  ui.new_combobox("AA", "Anti-aimbot angles","Defensive Pitch Mod\n"..pstate[i],{"Custom","Random","Paketa","Switch Down","Switch Up","Increase Up"}),
				Custom_pitch =  ui.new_slider("AA", "Anti-aimbot angles","\nCustom Pitch"..pstate[i],-89,89,0),
			}
		end
		return element
	end)(),
	hide_builder = function()
		ui.set(aa.roll,0)
		ui.set_visible(menu.manual_state,debug)
		ui.set_visible(aa.fs[1],debug)
		ui.set_visible(aa.fs[2],debug)
		ui.set_visible(aa.pitch[1],debug)
		ui.set_visible(aa.pitch[2],debug)
		ui.set_visible(aa.yawbase,debug)
		ui.set_visible(aa.yaw[1],debug)
		ui.set_visible(aa.yaw[2],debug)
		ui.set_visible(aa.fsbodyyaw,debug)
		ui.set_visible(aa.edgeyaw,debug)
		ui.set_visible(aa.yawjitter[1],debug)
		ui.set_visible(aa.yawjitter[2],debug)
		ui.set_visible(aa.bodyyaw[1],debug)
		ui.set_visible(aa.bodyyaw[2],debug)
		ui.set_visible(aa.roll,debug)
		local keybind = ui.get(menu.menu_choice) == "Keybinds"
		local Misc = ui.get(menu.menu_choice) == "Misc"
		menuToggle( keybind,  menu.hotkey)
		menuToggle( Misc, menu.exploits)
		local  buld = ui.get(menu.menu_choice)=="Anti-Aim Builder"
		for i=1,#pstate do
			local lp_state = pstate[i] == ui.get(menu.state)
			local else_ = (i == 1 and true or ui.get(menu.builder[i].Enabled))

			ui.set_visible(menu.builder[i].Enabled,	buld and i ~= 1 and lp_state)
			ui.set_visible(menu.builder[i].yawl , buld and lp_state and else_)
			ui.set_visible(menu.builder[i].yawr , buld and lp_state and else_)
			ui.set_visible(menu.builder[i].jittermode , buld and lp_state and else_)
			ui.set_visible(menu.builder[i].jitter , buld and lp_state and else_ and ui.get(menu.builder[i].jittermode)~="off")
			ui.set_visible(menu.builder[i].byawmode , buld and lp_state and else_)
			ui.set_visible(menu.builder[i].byaw , buld and lp_state and else_ and ui.get(menu.builder[i].byawmode)~="off")
			ui.set_visible(menu.builder[i].Defensive , buld and lp_state and else_)
			
			ui.set_visible(menu.builder[i].Defensive_breaker , buld and lp_state and else_ and ui.get(menu.builder[i].Defensive))
			
			ui.set_visible(menu.builder[i].Defensive_Yaw_Mod , buld and lp_state and else_ and ui.get(menu.builder[i].Defensive))
			
			--[[ui.set_visible(menu.builder[i].x_way , buld and lp_state and else_ and ui.get(menu.builder[i].Defensive_Yaw_Mod) == "X-Way"and ui.get(menu.builder[i].Defensive))
		
			ui.set_visible(menu.builder[i].way_value , buld and lp_state and else_ and ui.get(menu.builder[i].Defensive_Yaw_Mod) == "X-Way"and ui.get(menu.builder[i].Defensive))]]
			ui.set_visible(menu.builder[i].spin , buld and lp_state and else_ and (ui.get(menu.builder[i].Defensive_Yaw_Mod) == "Spin" or ui.get(menu.builder[i].Defensive_Yaw_Mod) == "Circular")and ui.get(menu.builder[i].Defensive))

			ui.set_visible(menu.builder[i].center , buld and lp_state and else_ and ui.get(menu.builder[i].Defensive_Yaw_Mod) == "Center"and ui.get(menu.builder[i].Defensive))
			
			
	
			ui.set_visible(menu.builder[i].Defensive_Pitch , buld and lp_state and else_ and ui.get(menu.builder[i].Defensive))
			ui.set_visible(menu.builder[i].Custom_pitch , buld and lp_state and else_ and ui.get(menu.builder[i].Defensive_Pitch)=="Custom"and ui.get(menu.builder[i].Defensive))


			
		end


	end
}

local v ={
    dir = 0,
    m_states = 0,
    left = false,
    right = false,
    back = false,

}
handle_aa.direction = function()
    m_states = ui.get(menu.manual_state)
    left= ui.get(menu.hotkey.m_left) 
    right =  ui.get(menu.hotkey.m_right) 
    back = ui.get(menu.hotkey.m_back) 
	ui.set(aa.fs[1],ui.get(menu.hotkey.fs))
    if left == v.left and right == v.right and back == v.back then return end

    v.left,v.right,v.back = left,right,back

    if (left and m_states == 1) or (right and m_states == 2) or (back and m_states == 3) then ui.set(menu.manual_state,0) return end

    if left and m_states ~= 1 then ui.set(menu.manual_state,1) end

    if right and m_states ~= 2 then ui.set(menu.manual_state,2) end

    if back and m_states ~= 3 then ui.set(menu.manual_state,3) end

    if ui.get(menu.manual_state) == 0 then v.dir = 0 end

    if ui.get(menu.manual_state) == 1 then v.dir = -90 end

    if ui.get(menu.manual_state) == 2 then v.dir = 90 end

    if ui.get(menu.manual_state) == 3 then v.dir = 0 end
end
settings = {
	snum = 1,
	defensive = 0,
	checker = 0,	
	pitch = 0,
	jitter = false,
	def_yaw = -120,
	switchChoke= false

}
local handle_math = {}
handle_math.chokerev = function(left_value, right_value)
	local lp_bodyyaw =  entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)* 120 - 60
	if globals.chokedcommands() == 0 then
		settings.chokereversed = lp_bodyyaw
	end
	return settings.chokereversed > 0 and left_value or right_value
end
handle_aa.set_antiaim =function(cmd)
	handle_aa.direction()
	local local_player = entity.get_local_player()
	local velocity_x, velocity_y = entity.get_prop(local_player, "m_vecVelocity")
	local speed =  math.sqrt(velocity_x ^ 2 + velocity_y ^ 2)
	local infiniteduck = (bit.band(entity.get_prop(local_player, "m_fFlags"), 2) == 2)
	local ongroud  = (bit.band(entity.get_prop(local_player, "m_fFlags"), 1) == 1)
	local onexploit = ui.get(aa.dt[2]) or ui.get(aa.os[2])
	if client.key_state(0x20) or not ongroud then
		if infiniteduck then
			if onexploit then
				settings.snum = 7
			else
				settings.snum = 6
			end
		else
			if onexploit then
				settings.snum = 5
			else
				settings.snum = 4
			end
		end
	elseif ongroud and infiniteduck or ongroud and ui.get(aa.fakeduck) then
		settings.snum = 8
	elseif  ui.get(aa.sw[1]) and ui.get(aa.sw[2])then
		settings.snum = 9
	elseif ongroud and speed > 5 then
		settings.snum = 3
	else
		settings.snum = 2
	end

	local i = ui.get(menu.builder[settings.snum].Enabled) and settings.snum or 1
	settings.yawmod = "180" 
	settings.yaw =handle_math.chokerev(ui.get(menu.builder[i].yawl),ui.get(menu.builder[i].yawr)) 
	settings.body = ui.get(menu.builder[i].byawmode)
	settings.byaw = ui.get(menu.builder[i].byaw)
	settings.jitter = ui.get(menu.builder[i].jitter)
	settings.jitter_mod = ui.get(menu.builder[i].jittermode)
	settings.pitch = 89


	if mwork then
		ui.set(aa.yawbase,"Local view")
	else
		ui.set(aa.yawbase,"At targets")
	end

	if ui.get(menu.builder[i].Defensive) then
		if ui.get(menu.builder[i].Defensive_breaker) =="Always On" then
			cmd.force_defensive = 1
		else
			cmd.force_defensive = 0
		end

		local tickcountValidation do
            tickcountValidation = globals.tickcount() % 4 == 0
    
            if tickcountValidation then
                settings.switchChoke = not settings.switchChoke
            end
        end

		if  (settings.defensive>1 )  then
			local def_yaw = ui.get(menu.builder[i].Defensive_Yaw_Mod) 
			if def_yaw == "Center" then
				if(globals.chokedcommands() == 0) then
					settings.jitter = not settings.jitter
				end
				settings.yaw = settings.jitter and ui.get(menu.builder[i].center)  / -2 or ui.get(menu.builder[i].center) / 2
			elseif  def_yaw == "Random" then
				settings.yaw = math.random(-180,180)
			elseif def_yaw== "Spin" then
				if globals.realtime() - globals.realtime() < 1 then
					settings.def_yaw = settings.def_yaw + ui.get(menu.builder[i].spin)
					if settings.def_yaw >= 180 then
						settings.def_yaw = -180
					end
				end

				settings.yaw = settings.def_yaw
			elseif def_yaw== "Circular" then
				if globals.realtime() - globals.realtime() < 1 then
					settings.def_yaw = settings.def_yaw + ui.get(menu.builder[i].spin)
					if settings.def_yaw >= 90 then
						settings.def_yaw = -90
					end
				end

				settings.yaw = settings.def_yaw
			elseif def_yaw== "Down" then
				settings.yaw = math.random(-180,-145)
			elseif def_yaw== "Without" then

			elseif def_yaw == "Switch Left" then
				settings.yaw =settings.switchChoke and 90 or 0
			elseif def_yaw == "Switch Right" then
				settings.yaw =settings.switchChoke and 0 or 90
			elseif def_yaw == "Free Sway" then
				settings.yaw =settings.switchChoke and math.random(0, 168) or math.random(-168, -31)
			end
			local pitch =ui.get(menu.builder[i].Defensive_Pitch)
			if pitch == "Custom" then
				settings.pitch =  ui.get(menu.builder[i].Custom_pitch)
			elseif pitch == "Random" then
				settings.pitch = math.random(-89, 89)
			elseif pitch == "Paketa" then
				local paketa = math.random(1,3)
				if  paketa == 3 then
					settings.pitch = -45 
				elseif paketa == 2 then
					settings.pitch = 0
				elseif paketa == 1 then
					settings.pitch = 89
				end
			elseif pitch == "Switch Up" then
				settings.pitch = settings.switchChoke and 0 or -89
			elseif pitch == "Switch Down" then
				settings.pitch = settings.switchChoke and 0 or 89
			elseif pitch == "Increase Up" then
				settings.pitch = settings.switchChoke and -89 or 89
			end
		end
	end
	local mwork = ui.get(menu.manual_state) ~= 0 
	if mwork then
		settings.yaw = ui.get(menu.manual_state) == 1 and -85 or ui.get(menu.manual_state) == 2 and 87 or ui.get(menu.manual_state) == 4 and 180  or settings.yaw
	end

	ui.set(aa.pitch[1],"custom")
	ui.set(aa.pitch[2],settings.pitch)
	ui.set(aa.yaw[1],settings.yawmod)
	ui.set(aa.yaw[2],settings.yaw)
	ui.set(aa.yawjitter[1],settings.jitter_mod)
	ui.set(aa.yawjitter[2],settings.jitter)
	ui.set(aa.bodyyaw[1],settings.body)
	ui.set(aa.bodyyaw[2],settings.byaw)


end


handle_aa.tickbase = function()

	if not entity.is_alive(entity.get_local_player()) then
		return
	end
	local tickbase = entity.get_prop(entity.get_local_player(), "m_nTickBase")
	settings.defensive = math.abs(tickbase - settings.checker) 
	settings.checker = math.max(tickbase, settings.checker or 0)

end
client.set_event_callback("setup_command", function(cmd)
	handle_aa.set_antiaim(cmd)
end)

client.set_event_callback("paint_ui", function()
	if not entity.get_local_player() then
		settings.defensive = 0
		settings.checker = 0
	end
	menu.hide_builder()
	handle_aa.tickbase()
end )



