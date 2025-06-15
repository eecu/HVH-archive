-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_delay_call, client_exec, client_set_event_callback, ui_get, ui_new_checkbox, ui_new_slider, ui_set_callback = client.delay_call, client.exec, client.set_event_callback, ui.get, ui.new_checkbox, ui.new_slider, ui.set_callback

-- Create UI elements
local interface = {
	tpdistanceslider = ui_new_slider("VISUALS", "EFFECTS", "Thirdperson Distance", 30, 200, 150),
	force_third_round_check = ui_new_checkbox("VISUALS", "EFFECTS", "Force distance at Round Start"),
	force_third_connect_check = ui_new_checkbox("VISUALS", "EFFECTS", "Force distance on Connect"),
	force_third_delay = ui_new_slider("VISUALS", "EFFECTS", "Force distance Delay", 0, 10, 2, true, "s", 0.1),
}

-- Function to change third-person camera distance
local function change_distance()
	local distance = ui_get(interface.tpdistanceslider)
	client_exec("cam_idealdist ", distance)
end

-- Set callback for the slider
ui_set_callback(interface.tpdistanceslider, change_distance)

-- Function to handle round_start event
local function on_round_start()
	if not ui_get(interface.force_third_round_check) then return end
	client_delay_call(ui_get(interface.force_third_delay), change_distance)
end

-- Function to handle player_connect_full event
local function on_player_connect_full()
	if not ui_get(interface.force_third_connect_check) then return end
	client_delay_call(ui_get(interface.force_third_delay), change_distance)
end

-- Set event callbacks
client_set_event_callback("round_start", on_round_start)
client_set_event_callback("player_connect_full", on_player_connect_full)