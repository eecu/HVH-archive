local ent = require("gamesense/entity")
local bit = require("bit")
local bitband = bit.band
local refs = {
    minimum_damage = ui.reference("RAGE", "Aimbot", "Minimum damage"),
    dt = {ui.reference("RAGE", "Other", "Double tap")},
    baim = ui.reference("RAGE", "Other", "Force body aim"),
    safepoint = ui.reference("RAGE", "Aimbot", "Force safe point"),
    dt2 = ui.reference("RAGE", "Other", "Double tap mode"),
    fd = ui.reference("RAGE", "Other", "Duck peek assist"),
    qp = {ui.reference("RAGE", "Other", "Quick peek assist")},
    os = {ui.reference("AA", "Other", "On shot anti-aim")},
    ping = {ui.reference("MISC", "Miscellaneous", "Ping spike")},
    slow = { ui.reference("AA", "Other", "Slow motion") },
}
indicatorscolorLABEL = ui.new_label("LUA", "B", "Ambani color")
indicatorscolor = ui.new_color_picker("LUA", "B", "Ambani color", 255,255,255,255)

lerp = function(a, b, t)
    return a + (b - a) * t
end

function doubletap_charged()
    if not ui.get(refs.dt[1]) or not ui.get(refs.dt[2]) or ui.get(refs.fd) then return false end
    if not entity.is_alive(entity.get_local_player()) or entity.get_local_player() == nil then return end
    local weapon = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")
    if weapon == nil then return false end
    local next_attack = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.25
	local checkcheck = entity.get_prop(weapon, "m_flNextPrimaryAttack")
	if checkcheck == nil then return end
    local next_primary_attack = checkcheck + 0.15
    if next_attack == nil or next_primary_attack == nil then return false end
    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end
p_state = 0 
function Condition()
	local vx, vy, vz = entity.get_prop(entity.get_local_player(), "m_vecVelocity")
	local p_still = math.sqrt(vx ^ 2 + vy ^ 2) < 2
	local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1
    local crouching = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1 and bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 4) == 4
    local air_crouch = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 0 and bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 4) == 4
	local p_slow = ui.get(refs.slow[1]) and ui.get(refs.slow[2])

    if p_still == true and on_ground == true then
	    p_state = 1
    end
    if p_still == false and on_ground == true then
	    p_state = 2
    end
    if on_ground == false then
	    p_state = 3
    end
    if air_crouch == true then
	    p_state = 4
    end
    if crouching == true then
	    p_state = 5
    end
    if p_slow == true then
	    p_state = 6
    end
end

RGBAtoHEX = function(redArg, greenArg, blueArg, alphaArg)
    return string.format('%.2x%.2x%.2x%.2x', redArg, greenArg, blueArg, alphaArg)
end

main_text = 0
main_condition = 0
main_condition_value = 0
main_condition_value2 = 0
main_space = 0
DTind = 0
DTind2 = 0
OSind = 0
BAIMind = 0
SAFEind = 0

DT_lerp = 0
DT_lerp2 = 0
OS_lerp = 0
BAIM_lerp = 0
SAFE_lerp = 0

DTtimer = 0
local main_condition_text = "JACA"
local function indicators()
    
    local rx,gx,bx = ui.get(indicatorscolor)

    local function create_color_array(r, g, b)
        local colorsx = {}
        for i = 0, 9 do
            local colorx = {rx, gx , bx, 255 * math.abs(1 * math.cos(2 * math.pi * globals.curtime() / 4 - i * 5 / 30))}
            table.insert(colorsx, colorx)
        end
        return colorsx
    end

    local aA = create_color_array(rx, gx, bx)

    if not entity.is_alive(entity.get_local_player()) then return end
    if doubletap_charged() == true then
        DTtimer = DTtimer + 1
    else
        DTtimer = 0
    end
    main_space = 0
    if p_state == 1 then
        main_condition_value = 25
        main_condition_text = "-  STANDING  -"
        main_condition_value2 = 1.997
    elseif p_state == 2 then
        main_condition_value = 21
        main_condition_text = "/  MOVING  /"
        main_condition_value2 = 2
    elseif p_state == 3 then
        main_condition_value = 13
        main_condition_text = "^  AIR  ^"
        main_condition_value2 = 1.995
    elseif p_state == 4 then
        main_condition_value = 19
        main_condition_text = "^  AIR+C  ^"
        main_condition_value2 = 2
    elseif p_state == 5 then
        main_condition_value = 23
        main_condition_text = "×  CROUCH  ×"
        main_condition_value2 = 1.997
    elseif p_state == 6 then
        main_condition_value = 18
        main_condition_text = "·  SLOW  ·"
        main_condition_value2 = 2
    end
    local player_inverter = entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11) * 120 - 60 <= 0 and true or false
    local alpha = math.min(math.floor(math.sin((globals.curtime()%3) * 5) * 175 + 200), 255)
    local X,Y = client.screen_size()
    local scoped = entity.get_prop(entity.get_local_player(), "m_bIsScoped") == 1
    local color_out = {ui.get(indicatorscolor)} 

    if scoped == true then
        main_text = lerp(main_text,33,globals.frametime() * 15)
        main_condition = lerp(main_condition,main_condition_value,globals.frametime() * 15)
        DT_lerp = lerp(DT_lerp,21,globals.frametime() * 15)
        DT_lerp2 = lerp(DT_lerp2,28,globals.frametime() * 15)
        OS_lerp = lerp(OS_lerp,19,globals.frametime() * 15)
        BAIM_lerp = lerp(BAIM_lerp,14,globals.frametime() * 15)
        SAFE_lerp = lerp(SAFE_lerp,14,globals.frametime() * 15)
    else 
        main_text = lerp(main_text,0,globals.frametime() * 15)
        main_condition = lerp(main_condition,-3,globals.frametime() * 15)
        DT_lerp = lerp(DT_lerp,-2,globals.frametime() * 15)
        DT_lerp2 = lerp(DT_lerp2,0,globals.frametime() * 15)
        OS_lerp = lerp(OS_lerp,-2,globals.frametime() * 15)
        BAIM_lerp = lerp(BAIM_lerp,-2,globals.frametime() * 15)
        SAFE_lerp = lerp(SAFE_lerp,-2,globals.frametime() * 15)
    end


    renderer.text(X/2 + main_text, Y/1.89, 255, 255, 255, 255, "cb", 0, string.format("\a%sa\a%sm\a%sb\a%sa\a%sn\a%si\a%sy\a%sa\a%sw", RGBAtoHEX(unpack(aA[1])), RGBAtoHEX(unpack(aA[2])), RGBAtoHEX(unpack(aA[3])), RGBAtoHEX(unpack(aA[4])), RGBAtoHEX(unpack(aA[5])), RGBAtoHEX(unpack(aA[6])), RGBAtoHEX(unpack(aA[7])), RGBAtoHEX(unpack(aA[8])), RGBAtoHEX(unpack(aA[9]))))
    

    renderer.text(X/main_condition_value2 + main_condition, Y/1.855, 255, 255, 255, 255, "-c", 0, main_condition_text)
    if ui.get(refs.dt[2]) then
        DTind = lerp(DTind,main_space,globals.frametime() * 15)
        if DTtimer == 0 then
            renderer.text(X/2.002 + DT_lerp2, Y/1.822 - DTind, 255, 255, 255, 255, "-c", 0, "DT \aFF00005E CHARGING")
        else
            if (p_state == 3 or p_state == 4) then
                renderer.text(X/2.002 + DT_lerp, Y/1.822 - DTind, 255, 255, 255, 255, "-c", (DTtimer + 16), "DT  \aB5E362FFACTIVE")
            else
                renderer.text(X/2.002 + DT_lerp, Y/1.822 - DTind, 255, 255, 255, 255, "-c", (DTtimer + 16), "DT \aB5E362FF READY")
            end
        end
        main_space = main_space - 10
    else
        DTind = lerp(DTind,main_space + 10,globals.frametime() * 15)
    end
    if ui.get(refs.os[2]) then
        OSind = lerp(OSind,main_space,globals.frametime() * 15)
        renderer.text(X/2.003 + OS_lerp, Y/1.822 - OSind, 255, 255, 255, 255, "-c", 0, "ONSHOT")
        main_space = main_space - 10
    else
        OSind = lerp(OSind,main_space + 10,globals.frametime() * 15)
        main_space = main_space - 10
    end

    if ui.get(refs.baim) then
        BAIMind = lerp(BAIMind,main_space,globals.frametime() * 15)
        renderer.text(X/2.003 + BAIM_lerp, Y/1.822 - BAIMind, 255, 255, 255, 255, "-c", 0, "BAIM")
        main_space = main_space - 10
    else
        BAIMind = lerp(BAIMind,main_space + 10,globals.frametime() * 15)
        main_space = main_space - 10
    end

    if ui.get(refs.safepoint) then
        SAFEind = lerp(SAFEind,main_space,globals.frametime() * 15)
        renderer.text(X/2.003 + SAFE_lerp, Y/1.822 - SAFEind, 255, 255, 255, 255, "-c", 0, "SAFE")
        main_space = main_space - 10
    else
        SAFEind = lerp(SAFEind,main_space + 10,globals.frametime() * 15)
        main_space = main_space - 10
    end

end

client.set_event_callback("paint", function()
    indicators()
    Condition()
end)