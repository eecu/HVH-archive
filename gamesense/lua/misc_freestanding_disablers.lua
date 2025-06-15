--[[
    Disable freestanding on conditions
    - This allows you to disable freestanding on certain conditions.
]]

local tab, container = 'AA', 'Anti-aimbot angles'

local function contains(b,c)for d,e in pairs(b)do if e==c then return true end end;return false end -- credits to whoever made this ily

local freestanding, freestanding_hotkey = ui.reference(tab, container, 'Freestanding')
local duck_peek_assist_hotkey = ui.reference('RAGE', 'Other', 'Duck peek assist')
local slow_motion, slow_motion_key = ui.reference(tab, 'Other', 'Slow motion')
local freestanding_disablers = ui.new_multiselect(tab, container, 'Freestanding disablers', 'Jumping', 'Crouching', 'Moving', 'Slow motion', 'Duck peek assist')

local function get_player_state()
    if entity.get_local_player() == nil then return end

    local vx, vy = entity.get_prop(entity.get_local_player(), 'm_vecVelocity')
    local player_standing = math.sqrt(vx ^ 2 + vy ^ 2) < 2
	local player_jumping = bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0
    local player_duck_peek_assist = ui.get(duck_peek_assist_hotkey)
    local player_crouching = entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.5 and not player_duck_peek_assist
    local player_slow_motion = ui.get(slow_motion) and ui.get(slow_motion_key)


    if player_duck_peek_assist then
        return 'fakeduck'
    elseif player_slow_motion then
        return 'slowmotion'
    elseif player_crouching then
        return 'crouch'
    elseif player_jumping then
        return 'jump'
    elseif player_standing then
        return 'stand'
    elseif not player_standing then
        return 'move'
    end
end

client.set_event_callback('run_command', function()
    if entity.get_local_player() == nil then return end
    
    ui.set(freestanding, 'Default')

    if contains(ui.get(freestanding_disablers), 'Jumping') then
        if get_player_state() == 'jump' then
            ui.set(freestanding, '-')
        end
    end

    if contains(ui.get(freestanding_disablers), 'Crouching') then
        if get_player_state() == 'crouch' then
            ui.set(freestanding, '-')
        end
    end

    if contains(ui.get(freestanding_disablers), 'Moving') then
        if get_player_state() == 'move' then
            ui.set(freestanding, '-')
        end
    end

    if contains(ui.get(freestanding_disablers), 'Slow motion') then
        if get_player_state() == 'slowmotion' then
            ui.set(freestanding, '-')
        end
    end

    if contains(ui.get(freestanding_disablers), 'Duck peek assist') then
        if get_player_state() == 'fakeduck' then
            ui.set(freestanding, '-')
        end
    end
end)