-- Dependencies
local vector = require 'vector'

-- Indicators
local slider_limit = ui.reference('aa', 'fake lag', 'limit')

-- Keybinds
local hotkey_force_safe_point = ui.reference('rage', 'aimbot', 'force safe point')
local hotkey_force_body_aim = ui.reference('rage', 'Aimbot', 'force body aim')
local hotkey_duck_peek_assist = ui.reference('rage', 'Other', 'duck peek assist')
local checkbox_double_tap, hotkey_double_tap = ui.reference('rage', 'Aimbot', 'double tap')
local checkbox_force_third_person, hotkey_force_third_person = ui.reference('visuals', 'effects', 'force third person (alive)')

-- Adding new menu elements
local screen_width, screen_height = client.screen_size()

local checkbox_nemesis_indicators_enabled = ui.new_checkbox('lua', 'a', 'Nemesis indicators')
local color_picker_nemesis_indicators = ui.new_color_picker('lua', 'a', '\nNemesis indicators color', 255, 150, 255, 255)
local slider_position_x = ui.new_slider('lua', 'a', '\nx position', 0, screen_width, 15, true, 'px')
local slider_position_y = ui.new_slider('lua', 'a', '\ny position', 0, screen_height, screen_height / 2.3, true, 'px')

-- Utility functions
function renderer.outline_rectangle(x, y, w, h, r, g, b, a)
    renderer.rectangle(x, y, w, 1, r, g, b, a)
    renderer.rectangle(x + w - 1, y, 1, h, r ,g, b, a)
    renderer.rectangle(x, y + h - 1, w, 1, r, g, b, a)
    renderer.rectangle(x, y, 1, h, r, g, b, a)
end

local function draw_window(x, y, r, g, b, a, label, items, keybinds)
    local separator_height = 13
    local start_y = 19
    local line_width = 121

    local test_y = start_y + #items * separator_height

    -- Outline
    renderer.outline_rectangle(x, y, 200, test_y, 0, 0, 0, 255)

    -- Background
    renderer.rectangle(x, y, 200, test_y, 20, 20, 20, 150)

    -- Label
    renderer.gradient(x, y, 200, 17, 30, 30, 30, 255, 15, 15, 15, 255, false)
    renderer.rectangle(x + 1, y + 1, 198, 1, r, g, b, a)
    renderer.text(x + 100, y + 8, 255, 255, 255, 255, 'c-', 0, label)

    if keybinds then
        for key, indicator in pairs(items) do key = key - 1
            local text_y_offset = y + key * separator_height + start_y

            renderer.text(x + 3, text_y_offset, 255, 255, 255, 255, '-', 0, indicator.text)
            renderer.text(x + 193, text_y_offset, 255, 255, 255, 255, 'r-', 0, 'TOGGLED')
        end
    else
        for key, indicator in pairs(items) do key = key - 1
            local text_y_offset = y + key * separator_height + start_y

            renderer.text(x + 3, text_y_offset, 255, 255, 255, 255, '-', 0, indicator.text)
            renderer.rectangle(x + 75, text_y_offset + 2, line_width, 6, 25, 25, 25, 255)
            renderer.rectangle(x + 75, text_y_offset + 2, line_width * indicator.value, 6, r, g, b, a)
        end
    end

    return y + test_y
end

local function map(n, start, stop, new_start, new_stop)
    local value = (n - start) / (stop - start) * (new_stop - new_start) + new_start

    return new_start < new_stop and math.max(math.min(value, new_stop), new_start) or math.max(math.min(value, new_start), new_stop)
end

client.set_event_callback('paint', function()
    if not ui.get(checkbox_nemesis_indicators_enabled) then return end

    local x, y = ui.get(slider_position_x), ui.get(slider_position_y)

    -- Indicators
    local indicators = {}

    local body_yaw = 0
    local speed = 0
    local chokedcommands = globals.chokedcommands()
    local standing_height = 0

    local local_player = entity.get_local_player()
    if entity.is_alive(local_player) then
        local new_body_yaw = entity.get_prop(local_player, 'm_flPoseParameter', 11)
        if new_body_yaw then
            new_body_yaw = math.abs(map(new_body_yaw, 0, 1, -60, 60))
            new_body_yaw = math.max(0, math.min(57, new_body_yaw))
        
            body_yaw = new_body_yaw / 57
        end

        local fake_lag_limit = ui.get(slider_limit)
        if chokedcommands then
            chokedcommands = chokedcommands / fake_lag_limit
        end

        local velocity = vector(entity.get_prop(local_player, 'm_vecVelocity'))

        if velocity then
            speed = math.min(1, velocity:length() / 240)
        end

        local head_position = vector(entity.hitbox_position(local_player, 0))
        local neck_position = vector(entity.hitbox_position(local_player, 1))

        local positions_dif = head_position.z - neck_position.z

        standing_height = map(positions_dif, 2.2, 4, 1, 0)
    end

    table.insert(indicators, {
        text = 'FAKE    YAW',
        value = body_yaw
    })

    table.insert(indicators, {
        text = 'FAKE LAG',
        value = chokedcommands
    })

    table.insert(indicators, {
        text = 'SPEED',
        value = speed
    })

    table.insert(indicators, {
        text = 'STAND     HEIGHT   ',
        value = standing_height
    })

    -- Keybinds
    local keybinds = {}

    local duck_peek_assist = ui.get(hotkey_duck_peek_assist)
    if duck_peek_assist then
        table.insert(keybinds, {
            text = 'FAKE DUCK'
        })
    end

    local double_tap = ui.get(checkbox_double_tap) and ui.get(hotkey_double_tap)
    if double_tap and not duck_peek_assist then
        table.insert(keybinds, {
            text = 'DOUBLE TAP'
        })
    end

    local force_safe_point = ui.get(hotkey_force_safe_point)
    if force_safe_point then
        table.insert(keybinds, {
            text = 'SAFE POINT'
        })
    end

    local force_body_aim = ui.get(hotkey_force_body_aim)
    if force_body_aim then
        table.insert(keybinds, {
            text = 'BODY AIM'
        })
    end

    local force_third_person = ui.get(checkbox_force_third_person) and ui.get(hotkey_force_third_person)
    if force_third_person then
        table.insert(keybinds, {
            text = 'THIRDPERSON'
        })
    end

    local r, g, b, a = ui.get(color_picker_nemesis_indicators)
   
    local indicators_window_y = draw_window(x, y, r, g, b, a, 'INDICATORS', indicators, false) 
    draw_window(x, indicators_window_y + 7, r, g, b, a, 'KEYBINDS', keybinds, true)
end)