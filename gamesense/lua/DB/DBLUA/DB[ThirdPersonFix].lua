local ui_get = ui.get
local ui_set = ui.set
local client_set_event_callback = client.set_event_callback

local new_button = ui.new_checkbox("VISUALS", "Effects", "Disable collision")
local collision = cvar["cam_collision"]

    ui.set_callback(new_button, function()
        client.set_event_callback("paint", function()
        collision:set_raw_int(ui.get(new_button) and 0 or 1)
    end)
end)