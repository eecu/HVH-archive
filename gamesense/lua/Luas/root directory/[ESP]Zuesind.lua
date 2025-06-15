local function havoc_zeus_war()
--- Havoc Zeus Warning 1.1.0
---
--- @author Kessie
--- @credits Aviarita
--- @credits Norway (for being AFK for 9 hours)
--- @credits kRex (for being AFK for 2 hours)
--- @credits JarJar (for being AFK for 2 hours)
--- @credits SysAdmin (for being AFK for 45 minutes)
--- @credits Squishy (for being AFK for 45 minutes)
--- @credits Spezz (for being AFK for 15 minutes)
--- @version 1.1.0
--- @requires havoc-color v1.1.0
--- @requires havoc-timer v2.0.0

--region setup/config
local config_load_success, config = pcall(require, "havoc_zeus_warning_config")

if (config_load_success ~= true) then
	config = {}
end

-- Location in the Lua tab of the Announcer menu.
local script_menu_location = config.script_menu_location or "a"

-- Fail check to prevent users setting an invalid UI location.
if (script_menu_location ~= "a" and script_menu_location ~= "b") then
	script_menu_location = "a"
end
--endregion

--region api
-- GameSense Lua API functions.
-- https://github.com/simpleavaster/gslua/blob/master/authors/sapphyrus/generate_api.lua
local client_latency, client_log, client_draw_rectangle, client_draw_circle_outline, client_userid_to_entindex, client_draw_indicator, client_draw_gradient, client_set_event_callback, client_screen_size, client_eye_position = client.latency, client.log, client.draw_rectangle, client.draw_circle_outline, client.userid_to_entindex, client.draw_indicator, client.draw_gradient, client.set_event_callback, client.screen_size, client.eye_position
local client_draw_circle, client_color_log, client_delay_call, client_draw_text, client_visible, client_exec, client_trace_line, client_set_cvar = client.draw_circle, client.color_log, client.delay_call, client.draw_text, client.visible, client.exec, client.trace_line, client.set_cvar
local client_world_to_screen, client_draw_hitboxes, client_get_cvar, client_draw_line, client_camera_angles, client_draw_debug_text, client_random_int, client_random_float = client.world_to_screen, client.draw_hitboxes, client.get_cvar, client.draw_line, client.camera_angles, client.draw_debug_text, client.random_int, client.random_float
local entity_get_local_player, entity_is_enemy, entity_hitbox_position, entity_get_player_name, entity_get_steam64, entity_get_bounding_box, entity_get_all, entity_set_prop = entity.get_local_player, entity.is_enemy, entity.hitbox_position, entity.get_player_name, entity.get_steam64, entity.get_bounding_box, entity.get_all, entity.set_prop
local entity_is_alive, entity_get_player_weapon, entity_get_prop, entity_get_players, entity_get_classname = entity.is_alive, entity.get_player_weapon, entity.get_prop, entity.get_players, entity.get_classname
local globals_realtime, globals_absoluteframetime, globals_tickcount, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.tickcount, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers
local ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_is_menu_open, ui_new_color_picker, ui_set_callback, ui_set, ui_new_checkbox, ui_new_hotkey, ui_new_button, ui_new_multiselect, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.is_menu_open, ui.new_color_picker, ui.set_callback, ui.set, ui.new_checkbox, ui.new_hotkey, ui.new_button, ui.new_multiselect, ui.get
local math_ceil, math_tan, math_log10, math_randomseed, math_cos, math_sinh, math_random, math_huge, math_pi, math_max, math_atan2, math_ldexp, math_floor, math_sqrt, math_deg, math_atan, math_fmod = math.ceil, math.tan, math.log10, math.randomseed, math.cos, math.sinh, math.random, math.huge, math.pi, math.max, math.atan2, math.ldexp, math.floor, math.sqrt, math.deg, math.atan, math.fmod
local math_acos, math_pow, math_abs, math_min, math_sin, math_frexp, math_log, math_tanh, math_exp, math_modf, math_cosh, math_asin, math_rad = math.acos, math.pow, math.abs, math.min, math.sin, math.frexp, math.log, math.tanh, math.exp, math.modf, math.cosh, math.asin, math.rad
local table_maxn, table_foreach, table_sort, table_remove, table_foreachi, table_move, table_getn, table_concat, table_insert = table.maxn, table.foreach, table.sort, table.remove, table.foreachi, table.move, table.getn, table.concat, table.insert
--endregion

--region dependency: havoc_color
--region helpers
--- Convert HSL to RGB.
---
--- Original function by EmmanuelOga:
--- https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua
---
--- @param color Color
local function update_rgb_space(color)
	local r, g, b

	if (color.s == 0) then
		r, g, b = color.l, color.l, color.l
	else
		function hue_to_rgb(p, q, t)
			if t < 0   then t = t + 1 end
			if t > 1   then t = t - 1 end
			if t < 1/6 then return p + (q - p) * 6 * t end
			if t < 1/2 then return q end
			if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end

			return p
		end

		local q = 0

		if (color.l < 0.5) then
			q = color.l * (1 + color.s)
		else
			q = color.l + color.s - color.l * color.s
		end

		local p = 2 * color.l - q

		r = hue_to_rgb(p, q, color.h + 1/3)
		g = hue_to_rgb(p, q, color.h)
		b = hue_to_rgb(p, q, color.h - 1/3)
	end

	color.r = r * 255
	color.g = g * 255
	color.b = b * 255
end

--- Convert RGB to HSL.
---
--- Original function by EmmanuelOga:
--- https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua
---
--- @param color Color
local function update_hsl_space(color)
	local r, g, b = color.r / 255, color.g / 255, color.b / 255
	local max, min = math_max(r, g, b), math_min(r, g, b)
	local h, s, l

	l = (max + min) / 2

	if (max == min) then
		h, s = 0, 0
	else
		local d = max - min

		if (l > 0.5) then
			s = d / (2 - max - min)
		else
			s = d / (max + min)
		end

		if (max == r) then
			h = (g - b) / d

			if (g < b) then
				h = h + 6
			end
		elseif (max == g) then
			h = (b - r) / d + 2
		elseif (max == b) then
			h = (r - g) / d + 4
		end

		h = h / 6
	end

	color.h, color.s, color.l = h, s, l or 255
end

--- Validate the RGB+A space and clamp errors.
---
--- @param color Color
local function validate_rgba(color)
	if (color.r < 0) then
		color.r = 0
	elseif (color.r > 255) then
		color.r = 255
	end

	if (color.g < 0) then
		color.g = 0
	elseif (color.g > 255) then
		color.g = 255
	end

	if (color.b < 0) then
		color.b = 0
	elseif (color.b > 255) then
		color.b = 255
	end

	if (color.a < 0) then
		color.a = 0
	elseif (color.a > 255) then
		color.a = 255
	end
end

--- Validate the HSL+A space and clamp errors.
---
--- @param color Color
local function validate_hsla(color)
	if (color.h < 0) then
		color.h = 0
	elseif (color.h > 1) then
		color.h = 1
	end

	if (color.s < 0) then
		color.s = 0
	elseif (color.s > 1) then
		color.s = 1
	end

	if (color.l < 0) then
		color.l = 0
	elseif (color.l > 1) then
		color.l = 1
	end

	if (color.a < 0) then
		color.a = 0
	elseif (color.a > 255) then
		color.a = 255
	end
end
--endregion

--region class.color
local Color = {}

--- Color metatable.
local color_mt = {
	__index = Color,
	__call = function(tbl, ...) return Color.new_rgba(...) end
}

--- Create new color object in using the RGB+A space.
---
--- @param r int
--- @param g int
--- @param b int
--- @param a int
--- @return Color
function Color.new_rgba(r, g, b, a)
	if (a == nil) then
		a = 255
	end

	local object = setmetatable({r = r, g = g, b = b, a = a, h = 0, s = 0, l = 0}, color_mt)

	validate_rgba(object)
	update_hsl_space(object)

	return object
end

--- Create new color object in using the HSL+A space.
---
--- @param self Color
--- @param h int
--- @param s int
--- @param l int
--- @param a int
--- @return Color
function Color.new_hsla(h, s, l, a)
	if (a == nil) then
		a = 255
	end

	local object = setmetatable({r = 0, g = 0, b = 0, a = a, h = h, s = s, l = l}, color_mt)

	validate_hsla(object)
	update_rgb_space(object)

	return object
end

--- Create a color from a UI reference.
---
--- @param ui_reference ui_reference
--- @since 1.1.0-release
function Color.new_from_ui_color_picker(ui_reference)
	return Color.new_rgba(unpack(ui_get(ui_reference)))
end

--- Overwrite current color using RGB+A space.
---
--- @param self Color
--- @param r int
--- @param g int
--- @param b int
--- @param a int
function Color.set_rgba(self, r, g, b, a)
	if (a == nil) then
		a = 255
	end

	self.r, self.g, self.b, self.a = r, g, b, a

	validate_rgba(self)
	update_hsl_space(self)
end

--- Overwrite current color using HSL+A space.
---
--- @param self Color
--- @param h int
--- @param s int
--- @param l int
--- @param a int
function Color.set_hsla(self, h, s, l, a)
	if (a == nil) then
		a = 255
	end

	self.h, self.s, self.l, self.a = h, s, l, a

	validate_hsla(self)
	update_rgb_space(self)
end

--- Overwrite current color using a UI reference.
---
--- @param ui_reference ui_reference
--- @since 1.1.0-release
function Color.set_from_ui_color_picker(ui_reference)
	return Color.set_rgba(unpack(ui_get(ui_reference)))
end

--- Unpack RGB+A space.
---
--- @param self Color
function Color.unpack_rgba(self)
	return self.r, self.g, self.b, self.a
end

--- Unpack HSL+A space.
---
--- @param self Color
function Color.unpack_hsla(self)
	return self.h, self.s, self.l, self.a
end

--- Unpack RGB, HSL, and A space.
---
--- @param self Color
--- @since 1.1.0-release
function Color.unpack_all(self)
	return self.r, self.g, self.b, self.h, self.s, self.l, self.a
end

--- Selects a color contrast.
---
--- Determines whether a colour is most visible against white or black, and returns white for 0, and 1 for black.
---
--- @param self Color
--- @return int
function Color.select_contrast(self)
	local contrast = self.r * 0.213 + self.g * 0.715 + self.b * 0.072

	if (contrast < 150) then
		return 0
	end

	return 1
end

--- Generates a color contrast.
---
--- Determines whether a colour is most visible against white or black, and returns a new color object for the one chosen.
---
--- @param self Color
--- @return Color
function Color.generate_contrast(self)
	local contrast = self:select_contrast()

	if (contrast == 0) then
		return Color.new_rgba(255, 255, 255)
	end

	return Color.new_rgba(0, 0, 0)
end

--- Set the hue of the color.
---
--- @param self Color
--- @param h float
function Color.set_hue(self, h)
	if (h < 0) then
		h = 0
	elseif (h > 1) then
		h = 1
	end

	self.h = h

	update_rgb_space(self)
end

--- Shift the hue of the color by a given amount.
---
--- Use negative numbers go to down the spectrum.
---
--- @param self Color
--- @param amount float
function Color.shift_hue(self, amount)
	local h = self.h + amount

	h = h % 1

	self.h = h

	update_rgb_space(self)
end

--- Shift the hue of the color by a given amount, but do not loop the spectrum.
---
--- Use negative numbers go to down the spectrum.
---
--- @param self Color
--- @param amount float
function Color.shift_hue_clamped(self, amount)
	local h = math_min(1, math_max(0, self.h + amount))

	self.h = h

	update_rgb_space(self)
end

--- Shift the hue of the color by a given amount, but keep within an upper and lower hue bound.
---
--- Use negative numbers go to down the spectrum.
---
--- @param self Color
--- @param amount float
--- @param lower_bound float
--- @param upper_bound float
function Color.shift_hue_within(self, amount, lower_bound, upper_bound)
	local h = self.h + amount

	if (h < lower_bound) then
		h = lower_bound
	elseif (h > upper_bound) then
		h = upper_bound
	end

	self.h = h

	update_rgb_space(self)
end

--- Returns true if hue is below or equal to a given hue.
---
--- @param self Color
--- @param h float
function Color.hue_is_below(self, h)
	return self.h <= h
end

--- Returns true if hue is above or equal to a given hue.
---
--- @param self Color
--- @param h float
function Color.hue_is_above(self, h)
	return self.h >= h
end

--- Returns true if hue is betwen two given hues.
---
--- @param self Color
--- @param lower_bound float
--- @param upper_bound float
function Color.hue_is_between(self, lower_bound, upper_bound)
	return self.h >= lower_bound and self.h <= upper_bound
end

--- Set the saturation of the color.
---
--- @param self Color
--- @param s float
function Color.set_saturation(self, s)
	if (s < 0) then
		s = 0
	elseif (s > 1) then
		s = 1
	end

	self.s = s

	update_rgb_space(self)
end

--- Shift the saturation of the color by a given amount.
---
--- Use negative numbers to decrease saturation.
---
--- @param self Color
--- @param amount float
function Color.shift_saturation(self, amount)
	local s = math_min(1, math_max(0, self.s + amount))

	self.s = s

	update_rgb_space(self)
end

--- Shift the saturation of the color by a given amount, but keep within an upper and lower saturation bound.
---
--- Use negative numbers to decrease saturation.
---
--- @param self Color
--- @param amount float
function Color.shift_saturation_within(self, amount, lower_bound, upper_bound)
	local s = self.s + amount

	if (s < lower_bound) then
		s = lower_bound
	elseif (s > upper_bound) then
		s = upper_bound
	end

	self.s = s

	update_rgb_space(self)
end

--- Returns true if saturation is below or equal to a given saturation.
---
--- @param self Color
--- @param s float
function Color.saturation_is_below(self, s)
	return self.s <= s
end

--- Returns true if saturation is above or equal to a given saturation.
---
--- @param self Color
--- @param s float
function Color.saturation_is_above(self, s)
	return self.s >= s
end

--- Returns true if saturation is betwen two given saturations.
---
--- @param self Color
--- @param lower_bound float
--- @param upper_bound float
function Color.saturation_is_between(self, lower_bound, upper_bound)
	return self.s >= lower_bound and self.s <= upper_bound
end

--- Set the lightness of the color.
---
--- @param self Color
--- @param l float
function Color.set_lightness(self, l)
	if (l < 0) then
		l = 0
	elseif (l > 1) then
		l = 1
	end

	self.l = l

	update_rgb_space(self)
end

--- Shift the lightness of the color within a given amount.
---
--- Use negative numbers to decrease lightness.
---
--- @param self Color
--- @param amount float
function Color.shift_lightness(self, amount)
	local l = math_min(1, math_max(0, self.l + amount))

	self.l = l

	update_rgb_space(self)
end

--- Shift the lightness of the color by a given amount, but keep within an upper and lower lightness bound.
-----
----- Use negative numbers to decrease lightness.
---
--- @param self Color
--- @param amount float
function Color.shift_lightness_within(self, amount, lower_bound, upper_bound)
	local l = self.l + amount

	if (l < lower_bound) then
		l = lower_bound
	elseif (l > upper_bound) then
		l = upper_bound
	end

	self.l = l

	update_rgb_space(self)
end

--- Returns true if lightness is below or equal to a given lightness.
---
--- @param self Color
--- @param l float
function Color.lightness_is_below(self, l)
	return self.l <= l
end

--- Returns true if lightness is above or equal to a given lightness.
---
--- @param self Color
--- @param l float
function Color.lightness_is_above(self, l)
	return self.l >= l
end

--- Returns true if lightness is betwen two given lightnesses.
---
--- @param self Color
--- @param lower_bound float
--- @param upper_bound float
function Color.lightness_is_between(self, lower_bound, upper_bound)
	return self.l >= lower_bound and self.l <= upper_bound
end

--- Sets the alpha of the color.
---
--- @param self Color
--- @param alpha int
--- @since 1.1.0-release
function Color.set_alpha(self, alpha)
	self.a = alpha

	validate_rgba(self)
end

--- Returns true if the color is truely invisible (0 alpha).
---
--- @param self Color
function Color.is_invisible(self)
	return self.a == 0
end

--- Returns true if the color is invisible to within a given tolerance (0-255 alpha).
---
--- @param self Color
--- @param tolerance int
function Color.is_invisible_within(self, tolerance)
	return self.a <= 0 + tolerance
end

--- Returns true if the color is truely visible (255 alpha).
---
--- @param self Color
function Color.is_visible(self)
	return self.a == 255
end

--- Returns true if the color is visible to within a given tolerance (0-255 alpha).
---
--- @param self Color
--- @param tolerance int
function Color.is_visible_within(self, tolerance)
	return self.a >= 255 - tolerance
end

--- Increase the alpha of the color by a given amount.
---
--- @param self Color
--- @param amount int
function Color.fade_in(self, amount)
	if (self.a == 255) then
		return
	end

	self.a = self.a + amount

	if (self.a > 255) then
		self.a = 255
	end
end

--- Decrease the alpha of the color by a given amount.
---
--- @param self Color
--- @param amount int
function Color.fade_out(self, amount)
	if (self.a == 0) then
		return
	end

	self.a = self.a - amount

	if (self.a < 0) then
		self.a = 0
	end
end
--endregion
--endregion

--region dependency: havoc_timer
--region class.timer
--- @field seconds float
--- @field tick_count int
--- @field current_tick int
--- @field tickrate int
--- @field is_counting boolean
local Timer = {}

--- Shader metatable.
local Timer_mt = {
	__index = Timer,
	__call = function(tbl, ...) return Timer.new(...) end
}

--- Create a new timer.
---
--- @param use_curtime boolean: if true then the timer will use globals.curtime. If false, the timer will use globals.realtime.
function Timer.new(use_curtime)
	local object = setmetatable(
		{
			current_time = use_curtime and globals_curtime or globals_realtime,
			clock_started_at = nil,
			clock_paused_at = nil,
		},
		Timer_mt
	)

	return object
end

--- Get the elapsed time of the timer.
---
--- @param self Timer
function Timer.get_elapsed_time(self)
	if (self:has_started() == false) then
		return 0
	end

	if (self.clock_paused_at ~= nil) then
		return self.clock_paused_at - self.clock_started_at
	end

	return self.current_time() - self.clock_started_at
end

--- Get the elapsed time of the timer and then stop the timer.
---
--- @param self Timer
function Timer.get_elapsed_time_and_stop(self)
	local elapsed_time = self:get_elapsed_time()

	self:stop()

	return elapsed_time
end

--- Start the timer.
---
--- @param self Timer
function Timer.start(self)
	if (self:has_started() == true) then
		return
	end

	self.clock_started_at = self.current_time()
end

--- Stop the timer. Resetting the elapsed time to 0.
---
--- @param self Timer
function Timer.stop(self)
	self.clock_paused_at = nil
	self.clock_started_at = nil
end

--- Stop the timer, and then start it again immediately.
---
--- @param self Timer
function Timer.restart(self)
	self:stop()
	self:start()
end

--- Pause the timer. Will not reset the elapsed time. Unpause using `Timer.unpause`.
---
--- @param self Timer
function Timer.pause(self)
	if (self:has_started() == false) then
		return
	end

	self.clock_paused_at = self.current_time()
end

--- Unpause the timer.
---
--- @param self Timer
function Timer.unpause(self)
	if (self:has_started() == false) then
		return
	end

	if (self:is_paused() == false) then
		return
	end

	local clock_paused_for = self.current_time() - self.clock_paused_at

	self.clock_started_at = self.clock_started_at + clock_paused_for
	self.clock_paused_at = nil
end

--- Toggle between paused and unpaused.
---
--- @param self Timer
function Timer.toggle_pause(self)
	if (self:is_paused() == true) then
		self:unpause()
	else
		self:pause()
	end
end

--- Returns true if the timer is currently paused. False if not.
---
--- @param self Timer
function Timer.is_paused(self)
	return self.clock_paused_at ~= nil
end

--- Returns true if the timer has been started (regardless of pause state). Returns false if the timer has not been started.
---
--- @param self Timer
function Timer.has_started(self)
	return self.clock_started_at ~= nil
end
--endregion
--endregion

--region globals
-- User set warning distance.
local enemy_player_threat_user_distance = false

-- Fatal warning distance.
local enemy_player_threat_fatal_distance = false

-- Zeus warning sound timer.
local zeus_warning_sound_timer = Timer.new()

-- Start timer.
zeus_warning_sound_timer:start()

-- Zeus indicator color.
local zeus_warning_indicator_color = Color.new_hsla(0, 0.8, 0.5, 255)

-- Zeus indicator border color.
local zeus_warning_indicator_color_border = Color.new_hsla(0, 0.8, 0.5, 255)

-- Alpha of the indicators. Used for flashing indicators.
local indicator_alpha = 255
--endregion

--region ui
local ui_checkbox_enable_plugin = ui_new_checkbox(
	"lua",
	script_menu_location,
	"Enable Havoc Zeus Warning"
)

local ui_color_warning_icon = ui_new_color_picker(
	"lua",
	script_menu_location,
	"|   Warning Indicator Color",
	zeus_warning_indicator_color:unpack_rgba()
)

local ui_checkbox_flashing_indicator = ui_new_checkbox(
	"lua",
	script_menu_location,
	"Enable Flashing Indicator"
)

local ui_slider_standing_warning_distance = ui_new_slider(
	"lua",
	script_menu_location,
	"|   Standing Warning Distance",
	20,
	60,
	30,
	true,
	"ft"
)

local ui_slider_moving_warning_distance = ui_new_slider(
	"lua",
	script_menu_location,
	"|   Running/Bhop Warning Distance",
	20,
	60,
	60,
	true,
	"ft"
)

local ui_checkbox_enable_indicator = ui_new_checkbox(
	"lua",
	script_menu_location,
	"|   Enable Indicator Icons"
)

local ui_checkbox_enable_sound = ui_new_checkbox(
	"lua",
	script_menu_location,
	"|   Enable Warning Sound"
)

local ui_slider_sound_volume = ui_new_slider(
	"lua",
	script_menu_location,
	"|      Warning Sound Volume",
	0,
	100,
	100,
	true,
	"%"
)

ui_set_visible(ui_checkbox_flashing_indicator, false)
ui_set_visible(ui_slider_standing_warning_distance, false)
ui_set_visible(ui_slider_moving_warning_distance, false)
ui_set_visible(ui_checkbox_enable_indicator, false)
ui_set_visible(ui_checkbox_enable_sound, false)
ui_set_visible(ui_slider_sound_volume, false)

ui_set(ui_checkbox_flashing_indicator, true)
ui_set(ui_checkbox_enable_indicator, true)
ui_set(ui_checkbox_enable_sound, true)
--endregion

--region helpers
--- Play a sound from the CS:GO sound folder.
--- @since 1.0.0-beta
local function play_sound(sound_name)
	client_exec(string.format("playvol %s%s %s", "havoc_zeus_warning/", sound_name, ui_get(ui_slider_sound_volume) / 100))
end

--- Calculate unit distance between two world coordinates.
--- @param x2 float
--- @param y2 float
--- @param z2 float
--- @param x1 float
--- @param y1 float
--- @param z1 float
--- @return float
--- @since 1.0.0-beta
local function distance_ft(x2, y2, z2, x1, y1, z1)
	return math_sqrt(
		math_pow(x2 - x1, 2) +
		math_pow(y2 - y1, 2) +
		math_pow(z2 - z1, 2)
	) * 0.0254 / 0.3048
end

--- Calculate the speed of an entity.
--- @param x float
--- @param y float
--- @param z float
--- @since 1.0.0-beta
local function speed(x, y, z)
	return math_sqrt(
		math_pow(x, 2) +
		math_pow(y, 2) +
		math_pow(z, 2)
	)
end
--endregion

--region paint
--- Zeus warning (sound).
--- @since 1.0.0-beta
local function warning_sound()
	if (ui_get(ui_checkbox_enable_sound) == false) then
		return
	end

	-- Play warning sound.
	if (enemy_player_threat_fatal_distance == true and zeus_warning_sound_timer:get_elapsed_time() > 0.65) then
		zeus_warning_sound_timer:restart()
		play_sound("zeus_warning_fatal.wav")
	elseif (enemy_player_threat_user_distance == true and zeus_warning_sound_timer:get_elapsed_time() > 1.1) then
		zeus_warning_sound_timer:restart()
		play_sound("zeus_warning.wav")
	end
end

--- Zeus warning (indicator).
--- @since 1.0.0-beta
local function warning_indicator(player, is_individual_in_fatal_distance)
	if (ui_get(ui_checkbox_enable_indicator) == false) then
		return
	end

	local box_top_x, box_top_y, box_bottom_x, box_bottom_y, box_alpha = entity_get_bounding_box(player)

	if (box_top_x == nil or box_top_y == nil or box_alpha == 0) then
		return
	end

	local center_x = box_top_x / 2 + box_bottom_x / 2

	local r, g, b, a = zeus_warning_indicator_color:unpack_rgba()
	local rb, gb, bb, ab = zeus_warning_indicator_color_border:unpack_rgba()
	local y_offset = -40
	local indicator_text = "!"
	local indicator_border_width = 19

	if (is_individual_in_fatal_distance == true) then
		indicator_border_width = 20
		indicator_text = "F"
	end

	renderer.circle(center_x, box_top_y + y_offset, rb, gb, bb, indicator_alpha, indicator_border_width, 0, 1)
	renderer.circle(center_x, box_top_y + y_offset, r, g, b, indicator_alpha, 18, 0, 1)
	renderer.text(center_x, box_top_y + y_offset, rb, gb, bb, indicator_alpha, "c+", 0, indicator_text)
end

--- On paint callback.
--- @since 1.0.0-beta
local function on_paint()
	enemy_player_threat_user_distance = false
	enemy_player_threat_fatal_distance = false

	if (ui_get(ui_checkbox_enable_plugin) == false) then
		return
	end

	local local_player = entity_get_local_player()
	local life_state = entity_get_prop(local_player, "m_lifeState")

	-- Do not run if the player is not alive.
	if (life_state ~= 0) then
		return
	end

	local lp_x, lp_y, lp_z = entity_get_prop(local_player, "m_vecOrigin")
	local active_players = entity_get_players(true)

	for i = 1, #active_players do
		local enemy_player_is_threat = true
		local enemy_player = active_players[i]
		local ep_x, ep_y, ep_z = entity_get_prop(enemy_player, "m_vecOrigin")
		local eps_x, eps_y, eps_z = entity_get_prop(enemy_player, "m_vecVelocity")
		local distance_to_enemy = distance_ft(ep_x, ep_y, ep_z, lp_x, lp_y, lp_z)
		local warning_distance
		local enemy_speed = speed(eps_x, eps_y, eps_z)
		local weapon = entity_get_classname(entity_get_player_weapon(enemy_player))

		if (weapon ~= "CWeaponTaser") then
			enemy_player_is_threat = false
		end

		if (enemy_speed > 200) then
			warning_distance = ui_get(ui_slider_moving_warning_distance)
		else
			warning_distance = ui_get(ui_slider_standing_warning_distance)
		end

		local is_individual_in_fatal_distance = false

		if (distance_to_enemy < 14 and enemy_player_is_threat == true) then
			enemy_player_threat_fatal_distance = true
			is_individual_in_fatal_distance = true
		elseif (distance_to_enemy > 14 and distance_to_enemy <= warning_distance and enemy_player_is_threat == true) then
			enemy_player_threat_user_distance = true
		else
			enemy_player_is_threat = false
		end

		if (ui_get(ui_checkbox_flashing_indicator) == true) then
			indicator_alpha = zeus_warning_sound_timer:get_elapsed_time() % 1 % 255 * 512
		end

		if (enemy_player_is_threat == true) then
			warning_indicator(enemy_player, is_individual_in_fatal_distance)
		end
	end

	warning_sound()
end
--endregion

--region ui callback
--- UI visibility: enable sound.
--- @since 1.0.0-beta
local function on_ui_checkbox_enable_sound()
	local enabled_state = ui_get(ui_checkbox_enable_sound) and ui_get(ui_checkbox_enable_plugin)

	ui_set_visible(ui_slider_sound_volume, enabled_state)
end

--- UI color: warning icon.
--- @since 1.0.0-beta
local function on_ui_color_warning_icon()
	local r, g, b, a = ui_get(ui_color_warning_icon)

	zeus_warning_indicator_color:set_rgba(r, g, b, a)
	zeus_warning_indicator_color_border:set_rgba(r, g, b, a)

	local shift_direction = zeus_warning_indicator_color:select_contrast()

	if (shift_direction == 0) then
		shift_direction = 0.5
	else
		shift_direction = -0.5
	end

	zeus_warning_indicator_color_border:shift_lightness(shift_direction)
end

--- UI visibility: enable plugin.
--- @since 1.0.0-beta
local function on_ui_checkbox_enable_plugin()
	local enabled_state = ui_get(ui_checkbox_enable_plugin)

	ui_set_visible(ui_checkbox_flashing_indicator, enabled_state)
	ui_set_visible(ui_slider_standing_warning_distance, enabled_state)
	ui_set_visible(ui_slider_moving_warning_distance, enabled_state)

	ui_set_visible(ui_checkbox_enable_indicator, enabled_state)
	ui_set_visible(ui_checkbox_enable_sound, enabled_state)
	on_ui_checkbox_enable_sound()
end

--- Reset indicator alpha when not in use.
local function on_ui_checkbox_flashing_indicator()
	local enabled_state = ui_get(ui_checkbox_flashing_indicator)

	if (enabled_state == false) then
		indicator_alpha = 255
	end
end
--endregion

--region player_spawn
--- On player spawn callback.
--- @since 1.0.0-beta
local function on_player_spawn()
	zeus_warning_sound_timer:restart()
end
--endregion

--region hooks
client_set_event_callback('paint', on_paint)
client_set_event_callback('player_spawn', on_player_spawn)
ui_set_callback(ui_checkbox_enable_plugin, on_ui_checkbox_enable_plugin)
ui_set_callback(ui_checkbox_enable_sound, on_ui_checkbox_enable_sound)
ui_set_callback(ui_color_warning_icon, on_ui_color_warning_icon)
ui_set_callback(ui_checkbox_flashing_indicator, on_ui_checkbox_flashing_indicator)
--endregion

--region overrides
on_ui_color_warning_icon()
--endregion

end

havoc_zeus_war()