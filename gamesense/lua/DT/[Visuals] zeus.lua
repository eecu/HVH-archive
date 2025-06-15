local image = nil
local http = require "gamesense/http" or error("Missing gamesense/http")
local images = require "gamesense/images" or error("Missing gamesense/images")
local function GetDistanceInMeter(a_x, a_y, a_z, b_x, b_y, b_z)
	return math.ceil(math.sqrt(math.pow(a_x - b_x, 2) + math.pow(a_y - b_y, 2) + math.pow(a_z - b_z, 2)) * 0.0254)
end

http.get("https://i.imgur.com/VwCS4rn.png", function(success, response)
	if success and response.status == 200 then
		image = images.load(response.body)
	end  
end)

client.set_event_callback("paint", function()
	local local_player = entity.get_local_player()
	if not entity.is_alive(local_player) then
		return
	end

	client.update_player_list()
	local targets = entity.get_players(true)
	for i = 1, #targets do
		local player = targets[i]
		local et_x, et_y, et_z = entity.get_prop(player, "m_vecOrigin")
		local lp_x, lp_y, lp_z = entity.get_prop(local_player, "m_vecOrigin")
		if image ~= nil and GetDistanceInMeter(lp_x, lp_y, lp_z, et_x, et_y, et_z) <= 5 then
			local x1, y1, x2, y2 , mult = entity.get_bounding_box(player)
			if x1 ~= nil and mult > 0 then
				local y_different = y1 - 125
				local x_different = x1 + ((x2 - x1) / 2) - 35
				image:draw(x_different, y_different, 80, 80, 255, 255, 255, 255)
			end
		end
	end
end)