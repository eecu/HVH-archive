--[[credits: 

	Aviarita for the source

	Bacalhauz for the fix and maxdmg

]]
local sin, cos, rad = math.sin, math.cos, math.rad
local ui_get = ui.get
local camera_angles, eye_position = client.camera_angles, client.eye_position
local trace_line, trace_bullet = client.trace_line, client.trace_bullet
local screen_size = client.screen_size
local draw_text = renderer.text
local hp_check = ui.new_checkbox("LUA", "B", "HP Reticle")
local color = ui.new_color_picker("LUA", "B", "HP Reticle", "0", "115", "255", "255")
local hc_check = ui.new_checkbox("LUA", "B", "HP Critical")
local c_color = ui.new_color_picker("LUA", "B", "HP Critical", "242", "152", "64", "255")

local screen_x, screen_y = client.screen_size()
local locationx = ui.new_slider("LUA", "B", "x offset", 0, screen_x, screen_x / 2)
local locationy = ui.new_slider("LUA", "B", "y offset", 0, screen_y, screen_y / 2)

local weapons_ignored = {
    "CKnife",
    "CWeaponTaser",
    "CC4",
    "CHEGrenade",
    "CSmokeGrenade",
    "CMolotovGrenade",
    "CSensorGrenade",
    "CFlashbang",
    "CDecoyGrenade",
    "CIncendiaryGrenade"
}

local function contains(table, item)
    for i=1, #table do
        if table[i] == item then
            return true
        end
    end
    return false
end

client.set_event_callback("paint", function(ctx)

    local get_lp, get_wpn, get_classname = entity.get_local_player, entity.get_player_weapon, entity.get_classname
    if not ui_get(hp_check) then return end
    local me = get_lp()

    local weapon = get_wpn(me)
    if weapon == nil or contains(weapons_ignored, get_classname(weapon)) then
        return
    end
    
    local pitch, yaw, roll = camera_angles()
    local sin_pitch = sin( rad( pitch ))
    local cos_pitch = cos( rad( pitch ))
    local sin_yaw   = sin( rad( yaw ))
    local cos_yaw   = cos( rad( yaw ))

    r_pitch = cos_pitch * cos_yaw
    r_yaw = cos_pitch * sin_yaw
    r_roll = -sin_pitch

    local start_pos = { eye_position() }
    local fraction = trace_line(me, 
    start_pos[1],
    start_pos[2],
    start_pos[3],
    start_pos[1] + (r_pitch * 8192),
    start_pos[2] + (r_yaw * 8192),
    start_pos[3] + (r_roll * 8192))

    if fraction < 1 then 
        local end_pos = {
            start_pos[1] + (r_pitch * (8192 * fraction + 128)),
            start_pos[2] + (r_yaw * (8192 * fraction + 128)),
            start_pos[3] + (r_roll * (8192 * fraction + 128)),
        }

        local _, dmg = trace_bullet(me, start_pos[1], start_pos[2], start_pos[3], end_pos[1], end_pos[2], end_pos[3])
        local maxdmg = 2*(dmg + dmg % 400)
        if ui_get(hc_check) then
	        if maxdmg > 0 and maxdmg < 100 then
	        	r,g,b,a = ui_get(color)
	        else
	        	r,g,b,a = ui_get(c_color)
	        end
	    else
	    	r,g,b,a = ui_get(color)
	    end
        local screen_width, screen_height = screen_size()
        if dmg > 0 then
        	draw_text(ui.get(locationx), ui.get(locationy), r, g, b, a,"b", 0, tostring(dmg))
        end
    end
end)