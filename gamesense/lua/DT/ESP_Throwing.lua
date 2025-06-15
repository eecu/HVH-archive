local csgo_weapons = require "gamesense/csgo_weapons"
local ffi = require("ffi")
ffi.cdef[[
	typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);
]]

local animation_layer_t = ffi.typeof([[
	struct {
		char pad_0x0000[0x18];
		uint32_t sequence;
		float prev_cycle;
		float weight;
		float weight_delta_rate;
		float playback_rate;
		float cycle;
		void *entity; char pad_0x0038[0x4];
	} **
]])

local renderer_state = ui.new_checkbox("Visuals", "Player esp", "Renderer Weapon State")
local renderer_ammo = ui.new_checkbox("Visuals", "Player esp", "Renderer Weapon Ammo")
local only_low_apply = ui.new_checkbox("Visuals", "Player ESP", "Only Weapon low")
local entity_list_ptr = ffi.cast("void***", client.create_interface("client.dll", "VClientEntityList003"))
local get_client_entity_fn = ffi.cast("GetClientEntity_4242425_t", entity_list_ptr[0][3])
local get_entity_address = function(ent_index)
	return get_client_entity_fn(entity_list_ptr, ent_index)
end

local get_anim_layer = function(entity, layer_index)
	local ent_ptr = ffi.cast("void***", get_entity_address(entity))
	return ffi.cast(animation_layer_t, ffi.cast("char*", ent_ptr) + 0x2990)[0][layer_index] 
end

local function render_boxer_text(player, text, text_2, text_3, clr, reload)
	local weapon = entity.get_player_weapon(player)
	if weapon == nil then
		return
	end

	local x1, y1, x2, y2, mult = entity.get_bounding_box(player)
	local pos_x, pos_y, pos_z = entity.get_prop(player, "m_vecAbsOrigin")
	local weapon_data = csgo_weapons[entity.get_prop(weapon, "m_iItemDefinitionIndex")]
	if weapon_data == nil then
		return
	end


	local grenade_pinpulled = weapon_data.type == "grenade" and entity.get_prop(weapon, "m_bPinPulled") == 1
	local current_state = grenade_pinpulled and text_3 or reload and text or text_2
	if x1 ~= nil and mult > 0 then
	 local x_center = x1 / 2 + x2 / 2  ------timing
	 local y_additional = name == "" and 0 or 23 
		if  y1 ~= nil and current_state ~= "Ready" and ui.get(renderer_state) then
			local color = clr[current_state]
			renderer.text(x_center, y1 - 20 + y_additional, color[1], color[2], color[3], color[4], "cb", 0, current_state)
		end
	end
end

client.set_event_callback("paint", function()
	local local_player = entity.get_local_player()
	if not entity.is_alive(local_player) then
		return
	end

	local players = entity.get_players(true)
	for i = 1, #players do
		local player_index = players[i]
		if entity.is_alive(player_index) then
			local colors = {
				["[√]Timing"] = {0, 255, 0, 255}, 
				["Ready"] = {255, 0, 0, 255}, 
				["[√]Throwing"] = {0, 255, 255, 255}
			}

			local weapon = entity.get_player_weapon(player_index)
			if weapon == nil then
				return
			end

			local weapon_index = entity.get_prop(weapon, "m_iItemDefinitionIndex")
			local weapon_data = csgo_weapons(entity.get_player_weapon(player_index))
			local box_x1, box_y1, box_x2, box_y2, mult = entity.get_bounding_box(player_index)
			local reload = math.floor(get_anim_layer(player_index, 1).cycle) ~= 1 and math.floor(get_anim_layer(player_index, 1).weight) ~= 0
			render_boxer_text(player_index, "[√]Timing", "Ready", "[√]Throwing", colors, reload)
			if entity.get_prop(weapon, "m_iClip1") > - 1 and box_x1 ~= nil and mult > 0 then
			local box_x_center = box_x1 / 2 + box_x2 / 2  ------武器子弹
			local y_additional2 = name == "" and 0 or -8
				if box_y1 ~= nil and ui.get(renderer_ammo) then
					local weapon_low = (weapon_index == 64 or weapon_index == 40 or weapon_index == 9) and 2 or 4
					local color_red = entity.get_prop(weapon, "m_iClip1") <= weapon_low
					if ui.get(only_low_apply) and color_red then
						renderer.text(box_x_center , box_y1 - 15 + y_additional2 , 255, color_red and 0 or 255, color_red and 0 or 255, 255, "cd", 0, math.max(0, entity.get_prop(weapon, "m_iClip1")) .. "/" .. weapon_data.primary_reserve_ammo_max)
					elseif not ui.get(only_low_apply) then
						renderer.text(box_x_center , box_y1 - 15 + y_additional2 , 255, color_red and 0 or 255, color_red and 0 or 255, 255, "cd", 0, math.max(0, entity.get_prop(weapon, "m_iClip1")) .. "/" .. weapon_data.primary_reserve_ammo_max)
					end
				end
			end
		end
	end
end)