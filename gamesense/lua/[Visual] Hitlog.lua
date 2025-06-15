local fakelag_limit = ui.reference("AA", "Fake lag", "Limit")
local force_safe = ui.reference("Rage", "Aimbot", "Force safe point")
local neverlose_hitlog = ui.new_multiselect("Misc", "Settings", "Neverlose Hitlog", {"Hits Log", "Misseds Log"})
local hits_color_label = ui.new_label("Misc", "Settings", "Hit Log Colors")
local hits_color_c = ui.new_color_picker("Misc", "Settings", "\n Hit Log Color_C", 255, 255, 255, 255)
local missed_color_label = ui.new_label("Misc", "Settings", "Missed Log Colors")
local missed_color_c = ui.new_color_picker("Misc", "Settings", "\n Missed Log Color_C", 255, 255, 255, 255)
local hit_Font = ui.new_label("Misc", "Settings", "Hit Font Colors")
local hit_Font_color = ui.new_color_picker("Misc", "Settings", "\n Hit Font Color_C", 255, 255, 255, 255)
local Miss_Font = ui.new_label("Misc", "Settings", "Miss Font Colors")
local Miss_Font_color = ui.new_color_picker("Misc", "Settings", "\n Miss Font Color_C", 255, 255, 255, 255)

local notify = {}
notify.__index = notify
local aimbot_data_count = {}
local global_hit_numbers = 0
local fired_attack_bullet_id = 0
local global_missed_numbers = 0
local lag_chokedcommad = ui.get(fakelag_limit)
local surface = require "gamesense/surface"
local Font_size = surface.create_font("BestKim", 13, 400, {0x200})
local tickbase_data = {tick_shifted = false, tick_base = 0}
local hitboxer_names = {"身體", "頭", "胸", "胃", "左臂", "右臂", "左腳", "右腳", "脖子", "?", "gear"}
local function multi_select(search_table, search_value)
	for _, table_value in pairs(search_table) do
		if (search_value == table_value) then
			return true
		end
	end

	return false
end

local calculate_flags = function(function_data, fired_data_count)
	if not entity.is_alive(entity.get_local_player()) then
		return "cb+"
	end

	local m_ntickbase = entity.get_prop(entity.get_local_player(), "m_nTickBase")
	if m_ntickbase ~= nil and tickbase_data.tick_base ~= m_ntickbase then
		tickbase_data.tick_shifted = tickbase_data.tick_base ~= 0 and (m_ntickbase + 1) < tickbase_data.tick_base
		tickbase_data.tick_base = m_ntickbase
	end

	return function_data.refined and "R" or function_data.expired and "X" or function_data.noaccept and "N" or tickbase_data.tick_shifted and "S" or fired_data_count.boosted and "B" or fired_data_count.teleported and "T" or fired_data_count.interpolated and "I" or fired_data_count.extrapolated and "E" or fired_data_count.high_priority and "H" or ""
end

client.set_event_callback("paint_ui", function()
	if entity.is_alive(entity.get_local_player()) then
		notify:listener()
	end

	ui.set_visible(hits_color_c, multi_select(ui.get(neverlose_hitlog), "Hits Log"))
	ui.set_visible(hits_color_label, multi_select(ui.get(neverlose_hitlog), "Hits Log"))
	ui.set_visible(missed_color_c, multi_select(ui.get(neverlose_hitlog), "Misseds Log"))
	ui.set_visible(missed_color_label, multi_select(ui.get(neverlose_hitlog), "Misseds Log"))
	ui.set_visible(hit_Font, multi_select(ui.get(neverlose_hitlog), "Misseds Log"))
	ui.set_visible(hit_Font_color, multi_select(ui.get(neverlose_hitlog), "Misseds Log"))
	ui.set_visible(Miss_Font, multi_select(ui.get(neverlose_hitlog), "Misseds Log"))
	ui.set_visible(Miss_Font_color, multi_select(ui.get(neverlose_hitlog), "Misseds Log"))
end)

client.set_event_callback("setup_command", function(cmd)
	if #ui.get(neverlose_hitlog) == 0 or not entity.is_alive(entity.get_local_player()) then
		return
	end

	lag_chokedcommad = cmd.chokedcommands
end)

client.set_event_callback("aim_fire", function(e)
	if #ui.get(neverlose_hitlog) == 0 or not entity.is_alive(entity.get_local_player()) then
		return
	end

	fired_attack_bullet_id = e.id
	aimbot_data_count[fired_attack_bullet_id] = e
end)

notify.invoke_callback = function(timeout)
	return setmetatable({active = false, delay = 0, laycoffset = -11, layboffset = -11}, notify)
end

notify.setup_color = function(color, sec_color)
	if type(color) ~= 'table' then
		notify:setup()
		return
	end

	if notify.color == nil then
		notify:setup()
	end

	if color ~= nil then
		notify.color[1] = color
	end

	if sec_color ~= nil then
		notify.color[2] = sec_color
	end
end

notify.add = function(time, is_right, ...)
	if notify.color == nil then
		notify:setup()
	end

	table.insert(notify.__list, {
		["tick"] = globals.tickcount(),
		["invoke"] = notify.invoke_callback(),
		["text"] = { ... },
		["time"] = time,
		["color"] = notify.color,
		["right"] = is_right,
		["first"] = false
	})
end

function notify:setup()
	notify.color = {{150, 185, 1},{0, 0, 0}}
	if notify.__list == nil then
		notify.__list = {}
	end
end

function notify:listener()
	local old_tick = 0
	local count_left = 0
	local count_right = 0
	if notify.__list == nil then
		notify:setup()
	end

	for i = 1, #notify.__list do
		local layer = notify.__list[i]
		if layer.tick ~= old_tick then
			notify:setup()
		end

		if layer.right == true then
			layer.invoke:show_right(count_right, layer.color, layer.text)
			if layer.invoke.active then
				count_right = count_right + 1
			end
		else
			layer.invoke:show(count_left, layer.color, layer.text)
			if layer.invoke.active then
				count_left = count_left + 1
			end
		end

		if layer.first == false then
			layer.invoke:start(layer.time)
			notify.__list[i]["first"] = true
		end

		old_tick = layer.tick
	end
end

function notify:start(timeout)
	self.active = true
	self.delay = globals.realtime() + timeout
end

function notify:get_text_size(lines_combo)
	local x_offset_text = 0
	for i = 1, #lines_combo do
		local r, g, b, message = unpack(lines_combo[i])
		local width, height = renderer.measure_text("", message)
		x_offset_text = x_offset_text + width
	end

	return x_offset_text
end

function notify:string_ends_with(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

function notify:multicolor_text(x, y, flags, lines_combo)
	local y_offset = 0
	local x_offset_text = 0
	local line_height_temp = 0
	for i = 1, #lines_combo do
		local r, g, b, message = unpack(lines_combo[i])
		message = message .. "\0"
		surface.draw_text(x + x_offset_text, y + y_offset, r, g, b, 255, Font_size, message)
		if self:string_ends_with(message, "\0") then
			local width, height = surface.get_text_size(Font_size, message)
			x_offset_text = x_offset_text + width
		else
			x_offset_text = 0
			y_offset = y_offset + line_height_temp
		end
	end
end
function notify:show(count, color, text)
	if self.active ~= true then
		return
	end

	local y = 50 + (27 * count)
	local text_w, text_h = self:get_text_size(text)
	local screen_x, screen_y = client.screen_size()
	local max_width = text_w < 150 and 150 or text_w
	if color == nil then
		color = self.color
	end

	local real_x, real_y = 0, 0
	local factor = 150 / 2 * globals.frametime()
	if globals.realtime() < self.delay then
		if self.laycoffset < max_width then
			self.laycoffset = self.laycoffset + (max_width - self.laycoffset) * factor
		end

		if self.laycoffset > max_width then
			self.laycoffset = max_width
		end

		if self.laycoffset > max_width / 1.09 then
			if self.layboffset < max_width -  6 then
				self.layboffset = self.layboffset + ((max_width - 6) - self.layboffset) * factor
			end
		end

		if self.layboffset > max_width - 6 then
			self.layboffset = max_width - 6
		end
	else
		if self.layboffset > -11 then
			self.layboffset = self.layboffset - (((max_width-5)-self.layboffset) * factor) + 0.01
		end

		if self.layboffset < (max_width - 11) and self.laycoffset >= 0 then
			self.laycoffset = self.laycoffset - (((max_width + 1) - self.laycoffset) * factor) + 0.01
		end

		if self.laycoffset < 0 then 
			self.active = false
		end
	end

	if ui.get(neverlose_hitlog) then
		real_x, real_y = (self.layboffset - max_width + 880), (y - (y * 0.3) + 750)
	end

	self:multicolor_text(real_x, real_y, "", text)
end

local function neverlose_hit_function(e)
	local attacker_id = client.userid_to_entindex(e.attacker)
	if not multi_select(ui.get(neverlose_hitlog), "Hits Log") or attacker_id == nil or attacker_id ~= entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then
		return
	end

	local r, g, b = ui.get(hits_color_c)
	local r2, g2, b2 = ui.get(hit_Font_color)
	local target_id = client.userid_to_entindex(e.userid)
	local group = hitboxer_names[e.hitgroup + 1] or "?"
	local target_name = entity.get_player_name(target_id)
	local breaking_pos = entity.get_prop(target_id, "m_flPoseParameter", 11) or 0
	local breaking_angle = math.max(- 60, math.min(60, breaking_pos * 120 - 60 + 0.5)) or "Unknown"
	notify.setup_color({r, g, b})
	notify.add(5, false,
		{r, g, b, "✔ "},
		{r2, g2, b2, "擊中 " .. string.lower(target_name) .. " 的 " .. group .. " 造成 " .. (e.dmg_health == nil and 0 or e.dmg_health) .. " 傷害"}
	)
end

local function neverlose_missed_function(e)
	if not multi_select(ui.get(neverlose_hitlog), "Misseds Log") or e == nil or not entity.is_alive(entity.get_local_player()) then
		return
	end

	local r, g, b = ui.get(missed_color_c)
	local r3, g3, b3 = ui.get(Miss_Font_color)
	local group = hitboxer_names[e.hitgroup + 1] or "?"
	local target_name = entity.get_player_name(e.target)
	global_missed_numbers = global_missed_numbers + 1
	local reason = e.reason == "?" and "resolver" or e.reason
	local breaking_pos = entity.get_prop(e.target, "m_flPoseParameter", 11) or 0
	local breaking_angle = math.max(- 60, math.min(60, breaking_pos * 120 - 60 + 0.5)) or "Unknown"
	local safe_point_state = ui.get(force_safe) and "force" or (plist.get(e.target, "Override safe point") == "-" and "false" or plist.get(e.target, "Override safe point"))
	local flags_state = calculate_flags(e, aimbot_data_count[fired_attack_bullet_id])
	notify.setup_color({r, g, b})
	notify.add(5, false,
		{r, g, b, "✘ "},
		{r3, g3, b3, "未擊中 " .. string.lower(target_name) .. " 的 " .. group .. " 原因 " .. reason .. ""}
	)
end

client.set_event_callback("player_hurt", neverlose_hit_function)
client.set_event_callback("aim_miss", neverlose_missed_function)