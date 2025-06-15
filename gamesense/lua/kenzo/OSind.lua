local reference = {
    on_shot = {ui.reference('AA', 'Other', 'On shot anti-aim')},
}

local tab, container = 'VISUALS', 'Other ESP'
local interface = {
    enabled = ui.new_checkbox(tab, container, 'On-shot anti-aim indicator'),
    color = ui.new_color_picker(tab, container, 'On-shot anti-aim indicator color', 213, 213, 213, 255),
}

local on_paint = function()
    local player = entity.get_local_player()
    local is_alive = entity.is_alive(player)
    if not player or not is_alive then return end

    local on_shot = ui.get(reference.on_shot[1]) and ui.get(reference.on_shot[2])
    if not on_shot then return end

    local color = {ui.get(interface.color)}
    renderer.indicator(color[1], color[2], color[3], color[4], 'OS')
end

local handle_callbacks = function(self)
    local handle = ui.get(self) and client.set_event_callback or client.unset_event_callback
    handle('paint', on_paint)
end

handle_callbacks(interface.enabled)
ui.set_callback(interface.enabled, handle_callbacks)