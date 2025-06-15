local main_switch = ui.new_checkbox("LUA", "B", "Anti server crasher")
local fullupdate_key = ui.new_hotkey("LUA", "B", "FULL UPDATE", true)
	
local function antikick()
	if ui.get(main_switch) then
		cvar.cl_timeout:set_raw_float(-1)
	end
	
	if ui.get(fullupdate_key) then
		cvar.cl_fullupdate:invoke_callback(1)
	end
end
client.set_event_callback("paint", antikick)