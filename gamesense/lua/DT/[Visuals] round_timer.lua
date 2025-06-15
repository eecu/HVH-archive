local function get_c4_time(ent)
    local c4_time = entity.get_prop(ent, "m_flC4Blow") - globals.curtime()
    return c4_time ~= nil and c4_time > 0 and c4_time or 0
end

local screen = {client.screen_size()}
local center = {screen[1]/2, screen[2]/2}

client.set_event_callback("paint_ui", function()
	if entity.get_local_player() == nil or not entity.is_alive(entity.get_local_player()) then return end
	
	local total_time = entity.get_prop(71, "m_iRoundTime")
	local time_left = entity.get_prop(71, "m_fRoundStartTime")
	local c4 = entity.get_all("CPlantedC4")[1]
	
	if c4 ~= nil then
		ass = math.ceil(get_c4_time(c4) * 10 ^ 1 - 0.5)/10 ^ 1 - 0.5
	else
		ass = (total_time + time_left) - globals.curtime()
	end
	
	ass2 = string.format("%.2f", ass)
	
	local text4 = string.format("TIME REMAINING: ", ass2)
	local width = renderer.measure_text(nil, text4) + 105
	
	if ass < 20 and ass > 0 then
		renderer.text(center[1] - width, center[2] - 402, 255, 0, 0, 255, "c+", 0, "⚠️")
		renderer.text(center[1] , center[2] - 400, 255, 0, 0, 255, "c+", 0, "PRESMOKE NOW PRESMOKE NOW: ")
		renderer.text(center[1] + 200, center[2] - 400, 0, 255, 0, 255, "c+", 0, ass2)
	elseif ass < 0 then
		renderer.text(center[1] - width, center[2] - 402, 255, 0, 0, 255, "c+", 0, "⚠️")
		renderer.text(center[1] , center[2] - 400, 255, 0, 0, 255, "c+", 0, "PRESMOKE NOW PRESMOKE NOW:")
		renderer.text(center[1] + 200, center[2] - 400, 0, 255, 0, 255, "c+", 0, " 0.00")
	end
end)