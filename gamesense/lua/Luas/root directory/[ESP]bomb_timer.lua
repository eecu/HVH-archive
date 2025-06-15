local vec = require "vector"
local images = require "gamesense/images"
local csgo_weapons = require "gamesense/csgo_weapons"

-- >> local variables
local mvar = {
    enabled = ui.new_checkbox("visuals", "other esp", "Bomb timer"),
    clr = ui.new_color_picker("visuals", "other esp", "bt_clr_SSSSSSSSSSSSSSSSSSSSS", 147, 195, 13, 255),
    type = ui.new_combobox("visuals", "other esp", "\n", "Original", "Old", "Custom")
}
local w, h = client.screen_size()
local vars = { timer, fortcalc, timer_max, c4_time_frozen, c4_defuse_frozen }

-- >> local functions
local function draw_container(x, y, w, h)
    renderer.rectangle(x-w/2, y, w, h, 30, 30, 30, 150)
    renderer.rectangle(x-25, y-15, 50, 15, 30, 30, 30, 150)
    renderer.rectangle(x-15, y+h, 30, 15, 30, 30, 30, 150)
end

local function get_c4_time(ent)
    local c4_time = entity.get_prop(ent, "m_flC4Blow") - globals.curtime()
    return c4_time ~= nil and c4_time > 0 and c4_time or 0
end

local function isnt_defusable(ent)
    local c4_time, has_defuser = get_c4_time(ent), entity.get_prop(ent, "m_hBombDefuser")
    if has_defuser == 1 then 
        if vars.c4_time_frozen < entity.get_prop(ent, "m_flDefuseCountDown") - globals.curtime() then return true end
    else
        if c4_time < 6 then return true end
    end
    return false
end

local function get_c4_damage(ent)
    local lp_orig, c4_orig = vec(entity.get_origin(entity.get_local_player())), vec(entity.get_origin(ent))
    local dist_lp_c4 = lp_orig:dist(c4_orig)
    local get_armor = entity.get_prop(entity.get_local_player(), "m_ArmorValue")
    local a, b, c = 450.7, 75.68, 789.2
    local d = (dist_lp_c4 - b)/c
    local dmg = a * math.exp(-d * d)
    local damage = dmg

    if get_armor > 0 then
        local new = dmg*0.5
        local armor = (dmg-new)*0.5

        if armor > get_armor then
            armor = get_armor * (1 / 0.5)
            new = dmg - armor
        end
        damage = new
    end
    return damage
end

-- >> callbacks
local function on_paint()
    if ui.get(mvar.enabled) ~= true then return end
    local r, g, b, a = ui.get(mvar.clr)
    local c4 = entity.get_all("CPlantedC4")[1]
    if c4 == nil or entity.get_prop(c4, "m_bBombDefused") == 1 or entity.get_local_player == nil then return end
    local cont = { x=w/2, y=70, w=250, h=50 }
    local c4ico = images.get_weapon_icon("weapon_c4")
    local def_timer = entity.get_prop(c4, "m_flDefuseCountDown") - globals.curtime()
    vars.timer, vars.fortcalc, vars.timer_max = math.ceil(get_c4_time(c4) * 10 ^ 1 - 0.5)/10 ^ 1 - 0.5, get_c4_time(c4), client.get_cvar("mp_c4timer")
    if entity.get_prop(c4, "m_hBombDefuser") == 1 then 
        vars.timer = math.ceil(def_timer * 10 ^ 1 - 0.5)/10 ^ 1 - 0.5
        vars.fortcalc = def_timer
        vars.timer_max = 10
        r, g, b = 0, 120, 180
    end
    vars.timer = vars.timer > 0 and vars.timer or 0
    local timer_calc = (math.max(0, math.min(vars.timer_max, vars.fortcalc))) / vars.timer_max
    if vars.timer <= 0 then return end
    local dmg = math.floor(get_c4_damage(c4)+0.5)
    local dmg_text = "-" .. dmg .. " HP"
    dmg_text = dmg >= entity.get_prop(entity.get_local_player(), "m_iHealth") and "FATAL" or dmg_text
    local site = entity.get_prop(c4, "m_nBombSite")
    site = site == 0 and "A" or site == 1 and "B" or "?"
    if entity.get_prop(c4, "m_hBombDefuser") ~= 1 and vars.timer <= 10 then r, g, b = 255, 255, 0 end
    if isnt_defusable(c4) then r, g, b = 255, 0, 0 end

    if ui.get(mvar.type) == "Old" then
        renderer.text(5, 5, r, g, b, 255, "+", 0, site, " - ", vars.timer, "s")
        renderer.text(5, 25, 255, dmg >= entity.get_prop(entity.get_local_player(), "m_iHealth") and 0 or 255, dmg >= entity.get_prop(entity.get_local_player(), "m_iHealth") and 0 or 255, 255, "+", 0, dmg_text)
    elseif ui.get(mvar.type) == "Custom" then
        draw_container(cont.x, cont.y, cont.w, cont.h)
        c4ico:draw(cont.x-13, cont.y-14, nil, 40, 255, 255, 255, 255)
        renderer.text(cont.x, cont.y+cont.h+5, 255, 255, 255, 255, "c", 0, vars.timer)
        renderer.text(cont.x-25-renderer.measure_text("", dmg_text), cont.y+7, 255, dmg >= entity.get_prop(entity.get_local_player(), "m_iHealth") and 0 or 255, dmg >= entity.get_prop(entity.get_local_player(), "m_iHealth") and 0 or 255, 255, "", 0, dmg_text)
        renderer.text(cont.x+26, cont.y+7, 255, 255, 255, 255, "", 0, site, " site")
        renderer.rectangle(cont.x-111, cont.y+29, cont.w-29, 10, 0, 0, 0, 80)
        renderer.rectangle(cont.x-110, cont.y+30, (cont.w-30)*timer_calc, 8, r, g, b, a)
        renderer.rectangle(cont.x-109, cont.y+31, (cont.w-31)*timer_calc, 6, 0, 0, 0, 120)
    end
end
client.set_event_callback("paint", on_paint)
client.set_event_callback("bomb_begindefuse", function() 
    vars.c4_time_frozen = math.ceil(get_c4_time(entity.get_all("CPlantedC4")[1]) * 10 ^ 1 - 0.5)/10 ^ 1 - 0.5
end)

local function menu_handling()
    ui.set(ui.reference("visuals", "other esp", "bomb"),true)
end
ui.set_callback(mvar.enabled, menu_handling)
ui.set_callback(mvar.type, menu_handling)
menu_handling()
