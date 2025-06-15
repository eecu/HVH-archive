-- Cache common functions
local bit_band, client_set_event_callback, entity_get_bounding_box, entity_get_local_player, entity_get_players, entity_get_prop, entity_hitbox_position, entity_is_alive, math_ceil, math_pow, math_sqrt, renderer_line, renderer_text, renderer_world_to_screen, ui_get, ui_new_checkbox = bit.band, client.set_event_callback, entity.get_bounding_box, entity.get_local_player, entity.get_players, entity.get_prop, entity.hitbox_position, entity.is_alive, math.ceil, math.pow, math.sqrt, renderer.line, renderer.text, renderer.world_to_screen, ui.get, ui.new_checkbox

local trails = ui.new_checkbox("lua", "a", "Trails")
local trailscolor = ui.new_color_picker("lua", "a", "Trails color")
local third_check, third  = ui.reference("Visuals", "Effects", "Force Third Person (alive)")
local function Vector(x,y,z) 
	return {x=x or 0,y=y or 0,z=z or 0} 
end

local function Distance(from_x,from_y,from_z,to_x,to_y,to_z)  
  return math_ceil(math_sqrt(math_pow(from_x - to_x, 2) + math_pow(from_y - to_y, 2) + math_pow(from_z - to_z, 2)))
end

local function paint()
	if not ui_get(trails) then return end
	local lp = entity_get_local_player()
	if lp == nil then return end
	if not entity_is_alive(lp) then return end
	
    local players = entity_get_players(true)
	if #players == nil or #players == 0 then
		return
	end
	
	local threat = client.current_threat()

	for i = 1, #players do
		local entindex = players[i]	
		if (entindex ~= nil and entindex ~= entity_get_local_player() and entindex == threat) then
			local line_start = Vector(entity_hitbox_position(entindex, 3))
			local line_stop = Vector(entity_hitbox_position(lp, 3))
			local x1, y1 = renderer_world_to_screen(line_start.x,line_start.y,line_start.z)
			local thrid_x, thrid_y = renderer_world_to_screen(line_stop.x,line_stop.y,line_stop.z)
			local screen_x, screen_y = client.screen_size()
			local x2 = (screen_x / 2)
			local y2 = screen_y
			local trailsclr = {ui.get(trailscolor)}
			if x1 ~= nil and x2 ~= nil and y1 ~= nil and y2 ~= nil then
				renderer_line(x1, y1, x2, y2, trailsclr[1], trailsclr[2], trailsclr[3], trailsclr[4])
			end
		end
	end
	
end

local function setup_callback(i)
    if ui.get(i) then
        client.set_event_callback("paint", paint)
    else
        client.unset_event_callback("paint", paint)
    end
end

ui.set_callback(trails, setup_callback)