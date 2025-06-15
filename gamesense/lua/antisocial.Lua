-- CHANGE ME
local script_build = "2023/03/18"
-- CHANGE ME
local adminstate = true
-- CHANGE ME
local default_cfg = [[
    MjgwfDgwfDE1MHwxNDJ8MjA0fDE0MnwxOTJ8MjI5fDIwOHwyMDV8MTgxfDI1NXwyNTV8MjU1fDI1NXwxODN8MTgzfDI1NXwxMHwxMHwyfDB8MHwwfDB8MHwwfDB8MHwwfDB8NjB8NjB8NjB8NjB8MHwwfDB8MHwwfDB8NzR8MHwwfDB8NjB8NjB8NjB8NjB8LTV8OHwwfDB8MHwwfDY0fDB8MHwwfDYwfDYwfDYwfDYwfDB8NHwwfDB8MHwwfDg0fDB8MHwwfDYwfDYwfDYwfDYwfDV8MTl8MHwwfDB8MHw3MnwwfDB8MHw2MHw2MHw2MHw2MHw2fDh8MHwwfDB8MHw3OHwwfDB8MHw2MHw2MHw2MHw2MHwyfDJ8MHwwfDB8MHw2OHwwfDB8MHw2MHw2MHw2MHw2MHwzfDE2fDB8MHwwfDB8NjN8MHwwfDB8NjB8NjB8NjB8NjB8MHwwfDB8MHwwfDB8NjR8MHwwfDB8NjB8NjB8NjB8NjB8B2ZiZmZhYmZmUmFnZXxNYW51YWx8ZGV2ZWxlcG9yfFsrXXxbK118TWluaW1hbHxBdCB0YXJnZXRzfE9mZnxbTC9SXXxPZmZ8T2ZmfFtML1JdfE1pbmltYWx8QXQgdGFyZ2V0c3wxODB8W0wvUl18Q2VudGVyfEppdHRlcnxbTC9SXXxNaW5pbWFsfEF0IHRhcmdldHN8MTgwfFtML1JdfENlbnRlcnxKaXR0ZXJ8W0wvUl18TWluaW1hbHxBdCB0YXJnZXRzfDE4MHxbTC9SXXxDZW50ZXJ8Sml0dGVyfFtML1JdfE1pbmltYWx8QXQgdGFyZ2V0c3wxODB8W0wvUl18Q2VudGVyfEppdHRlcnxbTC9SXXxNaW5pbWFsfEF0IHRhcmdldHN8MTgwfFtML1JdfENlbnRlcnxKaXR0ZXJ8W0wvUl18TWluaW1hbHxBdCB0YXJnZXRzfDE4MHxbTC9SXXxDZW50ZXJ8Sml0dGVyfFtML1JdfE1pbmltYWx8QXQgdGFyZ2V0c3wxODB8W0wvUl18Q2VudGVyfEppdHRlcnxbTC9SXXxNaW5pbWFsfEF0IHRhcmdldHN8MTgwfFtML1JdfENlbnRlcnxKaXR0ZXJ8W0wvUl18dHJ1ZXx0cnVlfGZhbHNlfGZhbHNlfGZhbHNlfGZhbHNlfGZhbHNlfHRydWV8ZmFsc2V8dHJ1ZXxmYWxzZXx0cnVlfGZhbHNlfHRydWV8ZmFsc2V8dHJ1ZXxmYWxzZXx0cnVlfGZhbHNlfHRydWV8ZmFsc2V8dHJ1ZXxmYWxzZXxMZWZ0LFJpZ2h0fAdCNkI2NjVGRkZha2VsYWcgRGlzYWJsZXJzBzhlOGU4ZWZmLEZha2VsYWcgQnJlYWtlcixMZWdpdCBBQSAvIEJvbWJzaXRlIEZpeCxGcmVlc3RhbmRpbmcgb24gS2V5LEVkZ2UgWWF3IFNldHRpbmdzLERpc2FibGUgRlMvRVkgb24gTWFudWFsLEFudGkgQmFja3N0YWJ8B0I2QjY2NUZGT24gc2hvdCBhbnRpLWFpbQdjMWMxYzFmZixTdGFuZGluZyxDcm91Y2hpbmd8RWRnZSBZYXcgb24gRmFrZWR1Y2tpbmd8V2F0ZXJtYXJrLEFpbWJvdCBTdGF0c3xBaW1ib3QgTWlzcyBMb2dzLFNob290IFVuZGVyIERhbWFnZSAoOTgrKSxNaXNzZWQgZHVlIHRvIFVucmVnaXN0ZXJlZHxBbmltYXRpb24gZWZmZWN0LEx1YSBOYW1lLFBsYXllciBJbmZvLEFkZGl0aW9uYWwgQmFyLERvdWJsZSB0YXAsT24gc2hvdCBhbnRpLWFpbSxCb2R5IGFpbSxTYWZlIHBvaW50fAdENDAwMDBGRkRUIFNldHRpbmdzB2MxYzFjMWZmLEtpbGxzYXksQ2xhbnRhZyxGaWx0ZXIgQ29uc29sZSAocmVsb2FkKXwtfEFkYXB0aXZlIERUIFNwZWVkLER5bmFtaWMgRFQgTW9kZXw=
]]
local is_mm_state = 0
local crosshair_logo_color1_1 = {"Fsocie7y.", "Fsocie7y.", "Fsocie7y.", "Fsocie7y", "Fsocie7", "Fsocie", "Fsoci",
                                 "Fsoc", "Fso", "Fs", "F", ""}
local crosshair_logo_color2 = {"", "", "", ".", "y", "7", "e", "i", "c", "o", "s", "F"}
local crosshair_logo_color1_2 = {"", "", "", "", ".", "y.", "7y.", "e7y.", "ie7y.", "cie7y.", "ocie7y.", "socie7y."}
local csgo_weapons = require 'gamesense/csgo_weapons' or error("https://gamesense.pub/forums/viewtopic.php?id=18807")
local antiaim_funcs = require 'gamesense/antiaim_funcs' or error("https://gamesense.pub/forums/viewtopic.php?id=29665")
local surface = require 'gamesense/surface' or error("https://gamesense.pub/forums/viewtopic.php?id=18793")
local gif_decoder = require "gamesense/gif_decoder" or error("https://gamesense.pub/forums/viewtopic.php?id=18493")
local base64 = require 'gamesense/base64' or error("https://gamesense.pub/forums/viewtopic.php?id=21619")
local clipboard = require('gamesense/clipboard') or error("https://gamesense.pub/forums/viewtopic.php?id=28678")
local bit = require "bit" or error("bit")
local images = require 'gamesense/images' or error("https://gamesense.pub/forums/viewtopic.php?id=22917")
local http = require "gamesense/http"
local ent = require("gamesense/entity")
local ffi = require 'ffi'
local gamerules_ptr = client.find_signature("client.dll", "\x83\x3D\xCC\xCC\xCC\xCC\xCC\x74\x2A\xA1")
local gamerules = ffi.cast("intptr_t**", ffi.cast("intptr_t", gamerules_ptr) + 2)[0]
local loaded = false
local module_loadedimgs = 0
local logo_img
local logo_url = "https://luayanzheng.oss-cn-hongkong.aliyuncs.com/ACtest.png"
local banner_img
local banner_url = "https://luayanzheng.oss-cn-hongkong.aliyuncs.com/ACCBtest.png"
local lua_info_img
local lua_info_img_url = "https://luayanzheng.oss-cn-hongkong.aliyuncs.com/thattest.png"
http.get(logo_url, function(s, r)
    if s and r.status == 200 then
        logo_img = images.load(r.body)
        module_loadedimgs = module_loadedimgs + 1
    else
        error("Failed to load logo")
    end
end)
-- http.get(lua_info_img_url, function(s, r)
--     if s and r.status == 200 then
--         lua_info_img = images.load(r.body)
--         module_loadedimgs = module_loadedimgs + 1
--     else
--         error("Failed to load info image")
--     end
-- end)
http.get(banner_url, function(s, r)
    if s and r.status == 200 then
        banner_img = images.load(r.body)
        module_loadedimgs = module_loadedimgs + 1
    else
        error("Failed to load banner")
    end
end)
global_color = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0
}

local fakelag_limit = 14

local hitgroup_names = {"body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck",
                        "?"}
local is_rage_mode = false
local refs = {
    quickpeek = {ui.reference("RAGE", "Other", "Quick peek assist")},
    fakepeek = ui.reference("AA", "Other", "Fake peek"),
    aa_enable = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
    aa_pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
    aa_yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
    aa_yaw = {ui.reference("AA", "Anti-aimbot angles", "Yaw")},
    aa_yawjitter = {ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")},
    aa_bodyyaw = {ui.reference("AA", "Anti-aimbot angles", "Body yaw")},
    aa_freestandingbodyyaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
    aa_edgeyaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    aa_freestanding = {ui.reference("AA", "Anti-aimbot angles", "Freestanding")},
    aa_roll = ui.reference("AA", "Anti-aimbot angles", "roll"),
    aa_slowmotion = {ui.reference("AA", "Other", "Slow motion")},
    aa_os = {ui.reference("AA", "Other", "On shot anti-aim")},
    rage_dt = {ui.reference("RAGE", "Aimbot", "Double tap")},
    aa_fl_enable = {ui.reference("AA", "Fake lag", "Enabled")},
    aa_fl_amount = ui.reference("AA", "Fake lag", "Amount"),
    aa_fl_var = ui.reference("AA", "Fake lag", "Variance"),
    aa_fl_limit = ui.reference("AA", "Fake lag", "Limit"),
    rage_fakeduck = ui.reference("RAGE", "Other", "Duck peek assist"),
    visual_bomb = {ui.reference("VISUALS", "Other ESP", "Bomb")},
    aa_legmovement = ui.reference("AA", "other", "leg movement"),
    rage_baim = ui.reference("RAGE", "Aimbot", "Force body aim"),
    rage_safe = ui.reference("RAGE", "Aimbot", "Force safe point"),
    rage_mindmg = ui.reference("RAGE", "Aimbot", "Minimum damage")
}
aimbotstats = {
    total = 0,
    hit = 0,
    miss = 0,
    hitrate = 0,
    hs = 0,
    hsrate = 0,
    underdmg = 0,
    spread = 0,
    prediction = 0,
    death = 0,
    resolver = 0,
    unregistered = 0
}
local antiaim_enabled = false
local inverter
local isfs = false
local isey = false
local isfl_off = false
local math_clamp = function(default, min, max)
    if default > min and default < max then
        return default
    elseif default > max then
        return max
    elseif default < min then
        return min
    end
end
local localplayer = nil
local function rgba_to_hex(r, g, b, a)
    -- %02x: 0 means replace " "s with "0"s, 2 is width, x means hex
    return string.format("%02x%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b), math.floor(a))
end
local function rgb_to_hex(r, g, b)
    -- %02x: 0 means replace " "s with "0"s, 2 is width, x means hex
    return string.format("%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end
local function a_to_hex(a)
    return string.format("%02x", math.floor(a))
end
local function alpha_to_textformat(num, texttable, colortable, alpha)
    local text
    local content = {}
    for i = 0, num, 1 do
        content[i] = {}
        content[i].txt = texttable[i]
        content[i].a = colortable[i] .. alpha
    end
    -- 50iq
    if num == 0 then
        return "\a" .. content[0].a .. content[0].txt
    elseif num == 1 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt
    elseif num == 2 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt
    elseif num == 3 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt
    elseif num == 4 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt
    elseif num == 5 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt
    elseif num == 6 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt,
            "\a" .. content[6].a .. content[6].txt
    elseif num == 7 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt,
            "\a" .. content[6].a .. content[6].txt, "\a" .. content[7].a .. content[7].txt
    elseif num == 8 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt,
            "\a" .. content[6].a .. content[6].txt, "\a" .. content[7].a .. content[7].txt,
            "\a" .. content[8].a .. content[8].txt
    elseif num == 9 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt,
            "\a" .. content[6].a .. content[6].txt, "\a" .. content[7].a .. content[7].txt,
            "\a" .. content[8].a .. content[8].txt, "\a" .. content[9].a .. content[9].txt
    elseif num == 10 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt,
            "\a" .. content[6].a .. content[6].txt, "\a" .. content[7].a .. content[7].txt,
            "\a" .. content[8].a .. content[8].txt, "\a" .. content[9].a .. content[9].txt,
            "\a" .. content[10].a .. content[10].txt
    elseif num == 11 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt,
            "\a" .. content[6].a .. content[6].txt, "\a" .. content[7].a .. content[7].txt,
            "\a" .. content[8].a .. content[8].txt, "\a" .. content[9].a .. content[9].txt,
            "\a" .. content[10].a .. content[10].txt, "\a" .. content[11].a .. content[11].txt
    elseif num == 12 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt,
            "\a" .. content[6].a .. content[6].txt, "\a" .. content[7].a .. content[7].txt,
            "\a" .. content[8].a .. content[8].txt, "\a" .. content[9].a .. content[9].txt,
            "\a" .. content[10].a .. content[10].txt, "\a" .. content[11].a .. content[11].txt,
            "\a" .. content[12].a .. content[12].txt
    elseif num == 13 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt,
            "\a" .. content[6].a .. content[6].txt, "\a" .. content[7].a .. content[7].txt,
            "\a" .. content[8].a .. content[8].txt, "\a" .. content[9].a .. content[9].txt,
            "\a" .. content[10].a .. content[10].txt, "\a" .. content[11].a .. content[11].txt,
            "\a" .. content[12].a .. content[12].txt, "\a" .. content[13].a .. content[13].txt
    elseif num == 14 then
        return "\a" .. content[0].a .. content[0].txt, "\a" .. content[1].a .. content[1].txt,
            "\a" .. content[2].a .. content[2].txt, "\a" .. content[3].a .. content[3].txt,
            "\a" .. content[4].a .. content[4].txt, "\a" .. content[5].a .. content[5].txt,
            "\a" .. content[6].a .. content[6].txt, "\a" .. content[7].a .. content[7].txt,
            "\a" .. content[8].a .. content[8].txt, "\a" .. content[9].a .. content[9].txt,
            "\a" .. content[10].a .. content[10].txt, "\a" .. content[11].a .. content[11].txt,
            "\a" .. content[12].a .. content[12].txt, "\a" .. content[13].a .. content[13].txt,
            "\a" .. content[14].a .. content[14].txt
    else
        return "chinkchingchongchinaman"
    end
end
local frametimes = {}
local fps_prev = 0
local last_update_time = 0
local function num_round(x, n)
    n = math.pow(10, n or 0);
    x = x * n
    x = x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
    return x / n
end
local function AccumulateFps()
    local ft = globals.absoluteframetime()
    if ft > 0 then
        table.insert(frametimes, 1, ft)
    end
    local count = #frametimes
    if count == 0 then
        return 0
    end
    local i, accum = 0, 0
    while accum < 0.5 do
        i = i + 1
        accum = accum + frametimes[i]
        if i >= count then
            break
        end
    end
    accum = accum / i
    while i < count do
        i = i + 1
        table.remove(frametimes)
    end
    local fps = 1 / accum
    local rt = globals.realtime()
    if math.abs(fps - fps_prev) > 4 or rt - last_update_time > 2 then
        fps_prev = fps
        last_update_time = rt
    else
        fps = fps_prev
    end
    return math.floor(fps + 0.5)
end
local function set_AA_menu_boolean(bool)
    ui.set_visible(refs.aa_enable, bool)
    ui.set_visible(refs.aa_pitch, bool)
    ui.set_visible(refs.aa_yawbase, bool)
    ui.set_visible(refs.aa_yaw[1], bool)
    ui.set_visible(refs.aa_yaw[2], bool)
    ui.set_visible(refs.aa_yawjitter[1], bool)
    ui.set_visible(refs.aa_yawjitter[2], bool)
    ui.set_visible(refs.aa_bodyyaw[1], bool)
    ui.set_visible(refs.aa_bodyyaw[2], bool)
    ui.set_visible(refs.aa_freestandingbodyyaw, bool)
    ui.set_visible(refs.aa_edgeyaw, bool)
    ui.set_visible(refs.aa_freestanding[1], bool)
    ui.set_visible(refs.aa_freestanding[2], bool)
    ui.set_visible(refs.aa_roll, bool)
end
local function get_table_length(data)
    if type(data) ~= 'table' then
        return 0
    end
    local count = 0
    for _ in pairs(data) do
        count = count + 1
    end
    return count
end
local function client_exec(commandbaim)
    client.exec(commandbaim)
end
local function time_to_ticks(time)
    return math.floor(time / globals.tickinterval() + .5)
end
local function gamesense_anim(text, indices)
    local text_anim = "               " .. text .. "                      "
    local tickinterval = globals.tickinterval()
    local tickcount = globals.tickcount() + time_to_ticks(client.latency())
    local i = tickcount / time_to_ticks(0.3)
    i = math.floor(i % #indices)
    i = indices[i + 1] + 1

    return string.sub(text_anim, i, i + 15)
end
local function doubletap_charged()
    if not ui.get(refs.rage_dt[1]) or not ui.get(refs.rage_dt[2]) or ui.get(refs.rage_fakeduck) then
        return false
    end
    if not entity.is_alive(localplayer) then
        return
    end
    local weapon = entity.get_prop(localplayer, "m_hActiveWeapon")
    if weapon == nil then
        return false
    end
    local next_attack = entity.get_prop(localplayer, "m_flNextAttack") + 0.2 -- 开枪后
    local jewfag = entity.get_prop(weapon, "m_flNextPrimaryAttack")

    if jewfag == nil then
        return
    end
    local next_primary_attack = jewfag - 0.1
    if next_attack == nil or next_primary_attack == nil then
        return false
    end
    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end
local function includes(table, value)
    for _, v in ipairs(ui.get(table)) do
        if v == value then
            return true
        end
    end
    return false
end
local function gradient_text(r1, g1, b1, a1, r2, g2, b2, a2, text)
    local output = ''

    local len = #text - 1

    local rinc = (r2 - r1) / len
    local ginc = (g2 - g1) / len
    local binc = (b2 - b1) / len
    local ainc = (a2 - a1) / len
    for i = 1, len + 1 do

        output = output .. ('\a%02x%02x%02x%02x%s'):format(r1, g1, b1, a1, text:sub(i, i))
        r1 = r1 + rinc
        g1 = g1 + ginc
        b1 = b1 + binc
        a1 = a1 + ainc

    end

    return output
end
local debugpanel_text = "Fsocie7y.beta - build " .. script_build .. " [beta]"
debugpanel_text = gradient_text(147, 173, 255, 255, 254, 204, 145, 255, debugpanel_text)
local function gradient_text_2(r1, g1, b1, a1, r2, g2, b2, a2, text, alpha)
    local output = ''

    local len = #text - 1

    local rinc = (r2 - r1) / len
    local ginc = (g2 - g1) / len
    local binc = (b2 - b1) / len
    local ainc = (a2 - a1) / len
    for i = 1, len + 1 do
        local char = text:sub(i, i)
        if char ~= "/" and char ~= "\\" then
            output = output .. ('\a%02x%02x%02x%02x%s'):format(r1, g1, b1, a1, text:sub(i, i))
            r1 = r1 + rinc
            g1 = g1 + ginc
            b1 = b1 + binc
            a1 = a1 + ainc
        else
            output = output .. ('  \a%02x%02x%02x%02x%s  '):format(r1, g1, b1, alpha, text:sub(i, i))
            r1 = r1 + rinc
            g1 = g1 + ginc
            b1 = b1 + binc
            a1 = a1 + ainc
        end

    end

    return output
end
local function get_velocity()
    local x, y = entity.get_prop(localplayer, "m_vecVelocity")
    if x == nil then
        return
    end
    return math.sqrt(x ^ 2 + y ^ 2)
end
local function get_distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
end
local function distance3d(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1))
end
local function entity_has_c4(ent)
    local bomb = entity.get_all("CC4")[1]
    return bomb ~= nil and entity.get_prop(bomb, "m_hOwnerEntity") == ent
end
local real_fl, toDraw4, toDraw3, toDraw2, toDraw1, toDraw0 = 0, 0, 0, 0, 0, 0
local random = {
    [1] = "Dynamic",
    [2] = "Maximum",
    [3] = "Fluctuate"
}
local fl_to_renderer = {
    [0] = 0,
    [1] = 3,
    [2] = 6,
    [3] = 9,
    [4] = 12,
    [5] = 15,
    [6] = 18,
    [7] = 21,
    [8] = 24,
    [9] = 27,
    [10] = 30,
    [11] = 33,
    [12] = 36,
    [13] = 39,
    [14] = 42,
    [15] = 42,
    [16] = 42,
    [17] = 42,
    [18] = 42,
    [19] = 42
}
local state_to_renderer = {
    ["Global"] = "BASIC",
    ["Standing"] = "STAND",
    ["Moving"] = "MOVE",
    ["Slowwalking"] = "SLOWWALK",
    ["CT Crouching"] = "CT-CROUCH",
    ["T Crouching"] = "T-CROUCH",
    ["Jumping"] = "AIR",
    ["Crouching Air"] = "AIR-CROUCH",
    ["Fakelag"] = "FAKELAG",
    ["Not Connected"] = "Not-Connected"
}
local ui = ui
local renderer = renderer
local globals = globals
local math = math
local string = string
local version = "Beta"
local loadername = "02topgas"
local user = adminstate and "admin" or database.read(loadername .. "_cert").username_2
local global_alpha = 255
local alphastate = 0
local clan_tag_prev = ""
local screen_X, screen_Y = client.screen_size()
local center_X, center_Y = screen_X / 2, screen_Y / 2
Center = {
    x = screen_X / 2,
    y = screen_Y / 2
}
local killsay_delayed_table = {"stop hvhing go play legit ahhahahaaha", "why are you so weak my dog?",
                               "i sell your mom on darkweb", "sit kid ╭∩╮", "mad? input *disconnect*",
                               "you are so bad retarded", "nice tactic bro", "by Fsocie7y.club beta",
                               "Fsocie7y.club - one step ahead of the game",
                               "i play 666ms i dont care because FSOCIE7Y.BETA LOADED", "nice ssg-08 config retarded",
                               "owned by Fsocie7y.beta script", "nice iq son of a whore",
                               "all dogs stand on their knees and begging for Fsocie7y.lua"}
local killsay_baimtable = {"i murdered your family now its your turn", "by Fsocie7y.gang",
                           'next chance to kill me in 50 year',
                           "𝐲𝐨𝐮 𝐜𝐚𝐧 𝐛𝐮𝐲 𝐚𝐧 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐛𝐮𝐭 𝐲𝐨𝐮 𝐜𝐚𝐧𝐭 𝐛𝐮𝐲 𝐚 𝐰𝐢𝐧",
                           '𝐭𝐡𝐢𝐬 𝐝𝐨𝐠 𝐭𝐡𝐢𝐧𝐤 𝐡𝐞 𝐜𝐚𝐧 𝐛𝐞 𝐛𝐞𝐬𝐭 𝐩𝐥𝐚𝐲𝐞𝐫 𝐛𝐮𝐭 𝐭𝐡𝐞𝐫𝐞 𝐦𝐞',
                           'ａｌｌ ｓｋｉｌｌ ＄', 'Jetzt bin ich - Stewie2k (◣◢)',
                           "ℝ𝔸ℙ𝔼𝔻 𝔹𝕐 𝔸ℕ𝕋𝕀𝕊𝕆ℂ𝕀𝔸𝕃.ℂ𝕃𝕌𝔹",
                           "l2p bot",
                           "𝗘𝗭𝗠𝗔𝗣𝗔 𝗕𝗬 𝗔𝗡𝗧𝗜𝗦𝗢𝗖𝗜𝗔𝗟.𝗖𝗟𝗨𝗕",
                           "Not much fun anymore?",
                           "𝙾𝚠𝙽𝚎𝙳 𝙱𝚘𝚃 𝙱𝚈 𝙰𝙽𝚃𝙸𝚂𝙾𝙲𝙸𝙰𝙻.𝙲𝙻𝚄𝙱 𝚃𝙴𝙲𝙷𝙽𝙾𝙻𝙾𝙶𝙸𝙴𝚂",
                           "0 iq",
                           "✞ ꜱᴘᴏɴꜱᴏʀ ᴏꜰ ʏᴏᴜʀ ᴅᴇᴀᴛʜ »»» ᴀɴᴛɪꜱᴏᴄɪᴀʟ.ᴄʟᴜʙ[ʙᴇᴛᴀ] ✞",
                           "iq? HAHAHA", "After this he dont believe in god anymore",
                           "by Fsocie7y.beta пидарас", 'I came with his head in my hand',
                           "Fsocie7y.beta owning me and all", 'Dogs blood on my jeans',
                           'go depression my dog HAHahAHaAHahAHAAH',
                           'ｂｏｔ ｎｅｅｄ ｈｖｈ ｌｅｓｓｏｎｓ',
                           'ɪᴄʜ ɢɪᴇʙᴇ ᴍᴇᴘʜᴇᴅʀᴏɴ ᴀᴜꜰ ɪʜʀᴇɴ ᴀʀsᴄʜ',
                           'ᴛʜᴇ ᴇɴᴇᴍʏ ᴡᴇʀᴇ ᴛʀʏɪɴɢ ᴛᴏ ʙᴇ ʜᴇʀᴏ, ʙᴜᴛ ᴛʜᴇ ᴘᴏᴡᴇʀ ᴏꜰ ᴛʜᴇ ꜱᴋᴇᴇᴛ ᴄᴏᴜʟᴅ ɴᴏᴛ ʙᴇ ᴜɴᴅᴏɴᴇ.',
                           "ｓｋｅｅｔ ｄｏｎｔ ｎｅｅｄ ｕｐｄａｔｅ (◣_◢)",
                           "ＡＮＴＩＳＯＣＩＡＬ．ＣＬＵＢ - 𝙿𝚛𝚎𝚖𝚒𝚞𝚖 𝚜𝚌𝚛𝚒𝚙𝚝"}
local killsay_hstable = {"i murdered your family now its your turn", "by Fsocie7y.gang",
                         'next chance to kill me in 50 year',
                         "𝐲𝐨𝐮 𝐜𝐚𝐧 𝐛𝐮𝐲 𝐚𝐧 𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐛𝐮𝐭 𝐲𝐨𝐮 𝐜𝐚𝐧𝐭 𝐛𝐮𝐲 𝐚 𝐰𝐢𝐧",
                         '𝐭𝐡𝐢𝐬 𝐝𝐨𝐠 𝐭𝐡𝐢𝐧𝐤 𝐡𝐞 𝐜𝐚𝐧 𝐛𝐞 𝐛𝐞𝐬𝐭 𝐩𝐥𝐚𝐲𝐞𝐫 𝐛𝐮𝐭 𝐭𝐡𝐞𝐫𝐞 𝐦𝐞',
                         'ａｌｌ ｓｋｉｌｌ ＄', 'Jetzt bin ich - Stewie2k (◣◢)',
                         "ℝ𝔸ℙ𝔼𝔻 𝔹𝕐 𝔸ℕ𝕋𝕀𝕊𝕆ℂ𝕀𝔸𝕃.ℂ𝕃𝕌𝔹",
                         "l2p bot",
                         "𝗘𝗭𝗠𝗔𝗣𝗔 𝗕𝗬 𝗔𝗡𝗧𝗜𝗦𝗢𝗖𝗜𝗔𝗟.𝗖𝗟𝗨𝗕",
                         "Not much fun anymore?",
                         "𝙾𝚠𝙽𝚎𝙳 𝙱𝚘𝚃 𝙱𝚈 𝙰𝙽𝚃𝙸𝚂𝙾𝙲𝙸𝙰𝙻.𝙲𝙻𝚄𝙱 𝚃𝙴𝙲𝙷𝙽𝙾𝙻𝙾𝙶𝙸𝙴𝚂",
                         "0 iq",
                         "✞ ꜱᴘᴏɴꜱᴏʀ ᴏꜰ ʏᴏᴜʀ ᴅᴇᴀᴛʜ »»» ᴀɴᴛɪꜱᴏᴄɪᴀʟ.ᴄʟᴜʙ[ʙᴇᴛᴀ] ✞",
                         "iq? HAHAHA", "After this he dont believe in god anymore", "by Fsocie7y.beta пидарас",
                         'I came with his head in my hand', "Fsocie7y.beta owning me and all",
                         'Dogs blood on my jeans', 'go depression my dog HAHahAHaAHahAHAAH',
                         'ｂｏｔ ｎｅｅｄ ｈｖｈ ｌｅｓｓｏｎｓ',
                         'ɪᴄʜ ɢɪᴇʙᴇ ᴍᴇᴘʜᴇᴅʀᴏɴ ᴀᴜꜰ ɪʜʀᴇɴ ᴀʀsᴄʜ',
                         'ᴛʜᴇ ᴇɴᴇᴍʏ ᴡᴇʀᴇ ᴛʀʏɪɴɢ ᴛᴏ ʙᴇ ʜᴇʀᴏ, ʙᴜᴛ ᴛʜᴇ ᴘᴏᴡᴇʀ ᴏꜰ ᴛʜᴇ ꜱᴋᴇᴇᴛ ᴄᴏᴜʟᴅ ɴᴏᴛ ʙᴇ ᴜɴᴅᴏɴᴇ.',
                         "ｓｋｅｅｔ ｄｏｎｔ ｎｅｅｄ ｕｐｄａｔｅ (◣_◢)",
                         "ＡＮＴＩＳＯＣＩＡＬ．ＣＬＵＢ - 𝙿𝚛𝚎𝚖𝚒𝚞𝚖 𝚜𝚌𝚛𝚒𝚙𝚝",
                         'stay depression and enjoy the HS my dog',
                         '𝗰𝘆@𝗵𝘁𝘁𝗽𝘀://𝗴𝗮𝗺𝗲𝘀𝗲𝗻𝘀𝗲.𝗽𝘂𝗯/𝗳𝗼𝗿𝘂𝗺𝘀/𝘃𝗶𝗲𝘄𝗳𝗼𝗿𝘂𝗺.𝗽𝗵𝗽?𝗶𝗱=𝟲',
                         'stay calm and enjoy the ✖ 1 ❤',
                         '𝕀𝔽 𝕀 𝕆ℙ𝔼ℕ 𝕊ℙ𝕀ℕ𝔹𝕆𝕋 𝔸𝕃𝕃 𝔻𝕆𝔾𝕊 𝔻𝕀𝔼',
                         "[gamesense] Hit braindead player, hb: head  dmg: 666  bt: 0 tks  rhp: 0 (DEAD)",
                         "by FSOCIE7Y.RESOLVER",
                         '𝙸 𝚠𝚒𝚕𝚕 𝚋𝚎𝚌𝚘𝚖𝚎 𝚕𝚎𝚐𝚎𝚗𝚍 𝚝𝚘 𝚖𝚢 𝚏𝚊𝚖𝚒𝚕𝚢',
                         "nice antiaim retarded"}
local num_quotes_baim = get_table_length(killsay_baimtable)
local num_quotes_hs = get_table_length(killsay_hstable)
local num_quotes_delay = get_table_length(killsay_delayed_table)
local anim_t = {
    atleast_1_keybind_to_1 = 0,
    Crosshair_offset_X = 0,
    Crosshair_offset_Y = 0,
    scoped_alpha = 0,
    scoped_alpha_2 = 0,
    scoped_alpha255 = 0,
    scoped_x_name = 0,
    scoped_x_bar = 0,
    logo_alpha_1 = 0,
    info_alpha_1 = 0,
    bar_alpha_1 = 0,
    dt_alpha_1 = 0,
    os_alpha_1 = 0,
    ba_alpha_1 = 0,
    sp_alpha_1 = 0,
    dt_circle_addx = 0,
    KMH_width = 0,
    FL_width = 0,
    unscoped_alpha255 = 0,
    dt_or_os_to1 = 0,
    dt_alpha255 = 0,
    dtcolor_r = 0,
    dtcolor_g = 0,
    dtcolor_b = 0,
    exploit_r = 0,
    exploit_g = 0,
    exploit_b = 0,
    exploit_a = 0,
    real_dt_r = 0,
    real_dt_g = 0,
    real_dt_b = 0,
    real_os_r = 0,
    real_os_g = 0,
    real_os_b = 0,
    draw_dtcircle = 0,
    dt_x_anim = 0,
    os_alpha255 = 0,
    os_x_anim = 0,
    y1 = 0,
    y2 = 0,
    y3 = 0,
    y4 = 0,
    y5 = 0,
    y6 = 0,
    y7 = 0,
    state_alpha_legit = 0,
    state_alpha_basic = 0,
    state_alpha_stand = 0,
    state_alpha_move = 0,
    state_alpha_slowwalk = 0,
    state_alpha_ctcrouch = 0,
    state_alpha_tcrouch = 0,
    state_alpha_air = 0,
    state_alpha_aircrouch = 0,
    state_alpha_fakelag = 0,
    ba_alpha255 = 0,
    ba_x_anim = 0,
    sp_alpha255 = 0,
    sp_x_anim = 0,
    menu_open_255 = 0,
    manualL255 = 0,
    manualR255 = 0,
    manualF255 = 0
}
local state = ""
local state_array = {
    ["Fakelag"] = 9,
    ["CT Crouching"] = 5,
    ["T Crouching"] = 6,
    ["Crouching Air"] = 8,
    ["Jumping"] = 7,
    ["Slowwalking"] = 4,
    ["Standing"] = 2,
    ["Moving"] = 3,
    ["Global"] = 1
}
local aa_states = {"Global", "Standing", "Moving", "Slowwalking", "CT Crouching", "T Crouching", "Jumping",
                   "Crouching Air", "Fake lag"}
local aa_states2 = {"G", "S", "M", "SW", "CT", "T", "J", "CA", "FL"}
local aa_states3 = {
    ["Global"] = 1,
    ["Standing"] = 2,
    ["Moving"] = 3,
    ["Slowwalking"] = 4,
    ["CT Crouching"] = 5,
    ["T Crouching"] = 6,
    ["Jumping"] = 7,
    ["Crouching Air"] = 8,
    ["Fake lag"] = 9
}
local classnames = {"CWorld", "CCSPlayer", "CFuncBrush"}
local ground_ticks, end_time = 1, 0
local whydoidothis = 0
-- local function hsv_to_rgb(h, s, v, a)
--     local r, g, b
--     local i = math.floor(h * 6);
--     local f = h * 6 - i;
--     local p = v * (1 - s);
--     local q = v * (1 - f * s);
--     local t = v * (1 - (1 - f) * s);
--     i = i % 6
--     if i == 0 then
--         r, g, b = v, t, p
--     elseif i == 1 then
--         r, g, b = q, v, p
--     elseif i == 2 then
--         r, g, b = p, v, t
--     elseif i == 3 then
--         r, g, b = p, q, v
--     elseif i == 4 then
--         r, g, b = t, p, v
--     elseif i == 5 then
--         r, g, b = v, p, q
--     end
--     return r * 255, g * 255, b * 255, a * 255
-- end
-- local function func_rgb_rainbowize(frequency, rgb_split_ratio)
--     local r, g, b, a = hsv_to_rgb(globals.realtime() * frequency, 1, 1, 1)
--     r = r * rgb_split_ratio
--     g = g * rgb_split_ratio
--     b = b * rgb_split_ratio
--     return r, g, b
-- end
local function draw_container(ctx, x, y, w, h, alpha, perf)
    client.draw_rectangle(ctx, x, y + 6, w, h, 10, 10, 10, perf)
    client.draw_rectangle(ctx, x + 1, y + 7, w - 2, h - 2, 60, 60, 60, perf)
    client.draw_rectangle(ctx, x + 2, y + 8, w - 4, h - 4, 40, 40, 40, perf)
    client.draw_rectangle(ctx, x + 3, y + 9, w - 6, h - 6, 40, 40, 40, perf)
    client.draw_rectangle(ctx, x + 4, y + 10, w - 8, h - 8, 40, 40, 40, perf)
    client.draw_rectangle(ctx, x + 5, y + 11, w - 10, h - 10, 60, 60, 60, perf)
    client.draw_rectangle(ctx, x + 6, y + 12, w - 12, h - 12, 20, 20, 20, perf)
    local half_w = w / 2
    local half_h = h / 2

    renderer.gradient(x + 6, y + 12, half_w - 6, 2, 221, 227, 78, perf, 202, 70, 205, perf, true)
    renderer.gradient(x + half_w, y + 12, half_w - 7, 2, 202, 70, 205, perf, 59, 175, 222, perf, true)
    renderer.gradient(x + 6, y + 12, 2, half_h, 221, 227, 78, perf, 202, 70, 205, perf, false)
    renderer.gradient(x + 6, y + h / 2 + 1, 2, half_h, 202, 70, 205, perf, 59, 175, 222, perf, false)
    renderer.gradient(x + w - 8, y + 12, 2, half_h, 59, 175, 222, perf, 202, 70, 205, perf, false)
    renderer.gradient(x + w - 8, y + h / 2 + 2, 2, half_h, 202, 70, 205, perf, 221, 227, 78, perf, false)

    -- local r,g,b = func_rgb_rainbowize(0.15,1)
    -- renderer.gradient(x + 6, y + 6,w - 12, 2, r,g,b,255*alpha,r,b,g,255*alpha, true)
    -- renderer.gradient(x + w-8, y + 6,2, h-12, r,b,g,255*alpha,g,b,r,255*alpha, false)
    -- renderer.gradient(x + 6, y + h-8,w - 12, 2,  g, r, b,255*alpha,g,b,r,255*alpha, true)
    -- renderer.gradient(x +6, y + 6,2, h-12,  r, g, b,255*alpha,g,r,b,255*alpha, false)
end
local FORWARD = false
local RIGHT = false
local LEFT = false
local clr_skeet = "\aBFEA4BFF"
local clr_main = "\aD7D2FFFF"
local clr_red = "\aFF9292D8"
local clr_white = "\aFFFFFFFF"
local clr_antiaim = "\aFBFFA8FF"
local clr_yellow = "\aB6B665FF"
to_export_aa = {
    ['number'] = {},
    ['string'] = {},
    ['boolean'] = {},
    ['table'] = {}
}
to_export_global = {
    ['number'] = {},
    ['string'] = {},
    ['boolean'] = {},
    ['table'] = {}
}
local function createElement(element, boolean_aa, boolean_global, ...)
    local elem = element
    if boolean_aa then
        if type(elem) == 'number' then
            table.insert(to_export_aa[type(ui.get(elem))], elem)
        end
    end
    if boolean_global then
        if type(elem) == 'number' then
            table.insert(to_export_global[type(ui.get(elem))], elem)
        end
    end
    return elem
end
local function arr_to_string(arr)
    arr = ui.get(arr)
    local str = ""
    for i = 1, #arr do
        str = str .. arr[i] .. (i == #arr and "" or ",")
    end

    if str == "" then
        str = "-"
    end

    return str
end
local function str_to_sub(input, sep)
    local t = {}
    for str in string.gmatch(input, "([^" .. sep .. "]+)") do
        t[#t + 1] = string.gsub(str, "\n", "")
    end
    return t
end
local function to_boolean(str)
    if str == "true" or str == "false" then
        return (str == "true")
    else
        return str
    end
end
local function import_antiaim()
    if not loaded then
        return
    end
    local table_ = str_to_sub(base64.decode(clipboard.get(), 'base64'), "|")
    local p = 1

    for i, o in pairs(to_export_aa['number']) do
        ui.set(o, table_[p])
        p = p + 1
    end
    for i, o in pairs(to_export_aa['string']) do
        ui.set(o, (table_[p]))
        p = p + 1
    end
    for i, o in pairs(to_export_aa['boolean']) do
        ui.set(o, to_boolean(table_[p]))
        p = p + 1
    end
    for i, o in pairs(to_export_aa['table']) do
        ui.set(o, str_to_sub(table_[p], ','))
        p = p + 1
    end
    _G.Notify_push:paint(5, "Imported Anti-aim settings from clipboard", true, "%s%s%s", 2, {
        [0] = "Imported ",
        [1] = "Anti-aim settings",
        [2] = " from clipboard"
    }, {
        [0] = "ffffff",
        [1] = "FBFFA8",
        [2] = "ffffff"
    })

end
local function export_antiaim()
    if not loaded then
        return
    end
    local str = ""
    for i, o in pairs(to_export_aa['number']) do
        str = str .. tostring(ui.get(o)) .. '|'
    end
    for i, o in pairs(to_export_aa['string']) do
        -- print(ui.get(o))
        str = str .. ui.get(o) .. '|'
    end
    for i, o in pairs(to_export_aa['boolean']) do
        str = str .. tostring(ui.get(o)) .. '|'
    end
    for i, o in pairs(to_export_aa['table']) do
        str = str .. arr_to_string(o) .. '|'
    end
    clipboard.set(base64.encode(str, 'base64'))
    _G.Notify_push:paint(5, "Exported Anti-aim settings to clipboard", true, "%s%s%s", 2, {
        [0] = "Exported ",
        [1] = "Anti-aim settings",
        [2] = " to clipboard"
    }, {
        [0] = "ffffff",
        [1] = "FBFFA8",
        [2] = "ffffff"
    })
end
local manual_state = ui.new_slider("AA", "anti-aimbot angles", "\n", 0, 4, 0)
ui.set_visible(manual_state, false)
ui.new_label("AA", "anti-aimbot angles", "\n\n")
ui.new_label("AA", "anti-aimbot angles",
    "╔══ ══ ══ ══ ══ ══ ══ ══ ══ ══ ══ ══ ══╗")
local space = ""
for i = 1, 19 - #user / 2, 1 do
    space = space .. " "
end
local maincclr = {}
local secondcclr = {}
if database.read("accent_color") == nil then
    maincclr = {245, 105, 147, 255}
else
    maincclr = database.read("accent_color")
end
if database.read("second_color") == nil then
    secondcclr = {255, 215, 146, 255}
else
    secondcclr = database.read("second_color")
end
local l0go = "                \affc83dff♛ " .. "\aa6a6a6ff「" .. "\affffffffFsocie7y." ..
                 "\a6cc312ffclub\aa6a6a6ff」" .. "\affc83dff ♛"
ui.new_label("AA", "anti-aimbot angles", l0go)
ui.new_label("AA", "anti-aimbot angles", space .. "Welcome back, " .. clr_skeet .. user .. "\acdcdcdff!")
ui.new_label("AA", "anti-aimbot angles",
    "        Version: " .. clr_skeet .. script_build .. "\acdcdcdff, Build: " .. clr_skeet .. version)
ui.new_label("AA", "anti-aimbot angles",
    "╚══ ══ ══ ══ ══ ══ ══ ══ ══ ══ ══ ══ ══╝")
ui.new_label("AA", "anti-aimbot angles", "\n")
local LUA_ENABLED = createElement(ui.new_checkbox("AA", "Anti-aimbot angles",
    "\a31d2f7ff♦ \affffffffStart Fsocie7y.\a6cc312ffclub\acdcdcdff ~ \a95c8edffPRIV3 \a9fa6ffffScript\a31d2f7ff ♦"),
    false, true)
local tab = ui.new_combobox("AA", "Anti-aimbot angles",
    gradient_text(maincclr[1], maincclr[2], maincclr[3], 255, secondcclr[1], secondcclr[2], secondcclr[3], 255,
        "Modules ") .. " \affffffff☁",
    "9febffffA9fe1ffffn9fd7fffft9fcdffffi9fc4ffff-9fbaffffA9fb0ffffi9fa6ffffm",
    "9febffffV9fdfffffi9fd4ffffs9fc8ffffu9fbdffffa9fb2ffffl9fa6ffffs",
    "9febffffM9fe5ffffi9fdfffffs9fdaffffc9fd4ffffe9fceffffl9fc9ffffl9fc3ffffa9fbdffffn9fb8ffffe9fb2ffffo9facffffu9fa7ffffs")
local uis = {
    aa = {
        AA_Direction_tab = createElement(ui.new_multiselect("AA", "Anti-aimbot angles", "Anti-Aim Direction",
            "Backward", "Left", "Right", "Forward"), false, true),
        AA_Direction_mode_tab = createElement(ui.new_combobox("AA", "Anti-aimbot angles", "Anti-Aim Direction Mode",
            "Normal", "Roll"), false, true),
        Manual_Backward = ui.new_hotkey("AA", "Anti-aimbot angles", "Backward"),
        Manual_Left = ui.new_hotkey("AA", "Anti-aimbot angles", "Left"),
        Manual_Right = ui.new_hotkey("AA", "Anti-aimbot angles", "Right"),
        Manual_Forward = ui.new_hotkey("AA", "Anti-aimbot angles", "Forward"),
        function_tab = createElement(ui.new_multiselect("AA", "Anti-aimbot angles", "Functions",
            "\aB6B665FFFakelag Disablers\a8e8e8eff", "Fakelag Breaker", "Random Anti-Aim in Warm-up",
            "Legit AA / Bombsite Fix", "Freestanding on Key", "Edge Yaw Settings", "Disable FS/EY on Manual",
            "Anti Backstab"), false, true),
        Fakelag_Disablers = createElement(ui.new_multiselect("AA", "Anti-aimbot angles",
            clr_yellow .. "Fakelag Disablers", "\aB6B665FFOn shot anti-aim\ac1c1c1ff", "Standing", "Slow motion",
            "Crouching"), false, true),
        Freestanding = ui.new_hotkey("AA", "Anti-aimbot angles", "Freestanding on Key"),
        Edge_Yaw_Settings = createElement(ui.new_multiselect("AA", "Anti-aimbot angles", "Edge Yaw Settings",
            "Edge Yaw on Key", "Edge Yaw on Fakeducking"), false, true),
        Edge_Yaw_on_Key = ui.new_hotkey("AA", "Anti-aimbot angles", "Edge Yaw on Key"),
        Anti_Backstab_Range = createElement(ui.new_slider("AA", "Anti-aimbot angles", "Anti Backstab Range", 100, 400,
            280, true, "m", 1, {
                [280] = clr_white .. "Perfect"
            }), false, true),
        Builder_Enable = createElement(ui.new_checkbox("AA", "Anti-aimbot angles", clr_main .. "Anti-Aim Builder"),
            false, true),
        aa_mode = createElement(ui.new_combobox("AA", "Anti-aimbot angles",
            "                \afbffa8ff° Anti-Aim Settings °", "\afbffabffRage", "\ac1c1c1ffLegit"), true, true),
        legit_inverter = createElement(ui.new_combobox("AA", "Anti-aimbot angles", "Inverter Mode", "Manual", "Auto"),
            true, true),
        legit_inverter_key = ui.new_hotkey("AA", "Anti-aimbot angles", "Inverter Key"),
        legit_fs_key = ui.new_hotkey("AA", "Anti-aimbot angles", "Freestanding"),
        legit_roll = createElement(ui.new_checkbox("AA", "Anti-aimbot angles", "Lower Body yaw Fix"), true, true),
        legit_inverter_indicator = createElement(ui.new_checkbox("AA", "Anti-aimbot angles", "Inverter Indicator"),
            true, true),
        legit_inverter_indicator_offset = createElement(
            ui.new_slider("AA", "Anti-aimbot angles", "X offset", 0, 150, 80), true, true),
        condition_select = ui.new_combobox("AA", "Anti-aimbot angles", "\aFFFFFFFFPlayer State", "Global", "Standing",
            "Moving", "Slowwalking", "CT Crouching", "T Crouching", "Jumping", "Crouching Air", "Fake lag"),
        Custom_AA = {},
        Custom_AA_uicreate = function(retard)
            for q, w in pairs(aa_states2) do
                retard[q] = {}
                if q ~= 1 then
                    retard[q] = {
                        condition_enabled = createElement(ui.new_checkbox("AA", "Anti-aimbot angles", clr_white ..
                            "Enable " .. clr_main .. "[" .. aa_states[q] .. "]"), true, true)
                    }
                end
                retard[q].Pitch = createElement(ui.new_combobox("AA", "Anti-aimbot angles",
                    clr_main .. "[" .. w .. "]" .. clr_white .. " Pitch", "Off", "Default", "Up", "Down", "Minimal", "Random"), true, true)
                retard[q].Yaw_base = createElement(ui.new_combobox("AA", "Anti-aimbot angles", clr_main .. "[" .. w ..
                    "]" .. clr_white .. " Yaw base", "At targets", "Local view"), true, true)
                retard[q].Yaw = createElement(ui.new_combobox("AA", "Anti-aimbot angles",
                    clr_main .. "[" .. w .. "]" .. clr_white .. " Yaw", "Off", "180", "Static"), true, true)
                retard[q].Yaw_add_mode = createElement(ui.new_combobox("AA", "Anti-aimbot angles", "\n", "[L/R]",
                    "\aB6B665FF[Random]"), true, true)
                retard[q].Yaw_add_left = createElement(ui.new_slider("AA", "Anti-aimbot angles",
                    clr_main .. "[" .. w .. "] " .. clr_white .. "Yaw add left", -180, 180, 0, true, "°"), true, true)
                retard[q].Yaw_add_right = createElement(ui.new_slider("AA", "Anti-aimbot angles",
                    clr_main .. "[" .. w .. "] " .. clr_white .. "Yaw add right", -180, 180, 0, true, "°"), true, true)
                retard[q].Yaw_add_left_1 = createElement(ui.new_slider("AA", "Anti-aimbot angles",
                    "\aB6B665FFYaw add left [1]", -180, 180, 0, true, "°"), true, true)
                retard[q].Yaw_add_left_2 = createElement(ui.new_slider("AA", "Anti-aimbot angles",
                    "\aB6B665FFYaw add left [2]", -180, 180, 0, true, "°"), true, true)
                retard[q].Yaw_add_right_1 = createElement(ui.new_slider("AA", "Anti-aimbot angles",
                    "\aB6B665FFYaw add right [1]", -180, 180, 0, true, "°"), true, true)
                retard[q].Yaw_add_right_2 = createElement(ui.new_slider("AA", "Anti-aimbot angles",
                    "\aB6B665FFYaw add right [2]", -180, 180, 0, true, "°"), true, true)
                retard[q].Yaw_jitter = createElement(ui.new_combobox("AA", "Anti-aimbot angles",
                    clr_main .. "[" .. w .. "] " .. clr_white .. "Yaw jitter", "Off", "Offset", "Center",
                    "Center\aB6B665FF [L/R]", "Center\aB6B665FF [Random]", "Random","Skitter"), true, true)
                retard[q].Yaw_jitter_slider = createElement(ui.new_slider("AA", "Anti-aimbot angles",
                    clr_main .. "[" .. w .. "] " .. clr_white .. "Yaw jitter add", -180, 180, 0, true, "°"), true, true)
                retard[q].Yaw_jitter_slider_custom_1 = createElement(
                    ui.new_slider("AA", "Anti-aimbot angles", "[" .. w .. "] " .. clr_yellow .. "Yaw jitter add [1]",
                        -180, 180, 0, true, "°"), true, true)
                retard[q].Yaw_jitter_slider_custom_2 = createElement(
                    ui.new_slider("AA", "Anti-aimbot angles", "[" .. w .. "] " .. clr_yellow .. "Yaw jitter add [2]",
                        -180, 180, 0, true, "°"), true, true)
                retard[q].Yaw_bodyyaw = createElement(ui.new_combobox("AA", "Anti-aimbot angles",
                    clr_main .. "[" .. w .. "]" .. clr_white .. " Body yaw", "Off", "Opposite", "Jitter", "Static"),
                    true, true)
                retard[q].Yaw_bodyyaw_slider = createElement(
                    ui.new_slider("AA", "Anti-aimbot angles",
                        clr_main .. "[" .. w .. "] " .. clr_white .. "Body yaw add", -180, 180, 0, true, "°"), true,
                    true)
                retard[q].aa_freestandingbodyyaw = createElement(
                    ui.new_checkbox("AA", "Anti-aimbot angles",
                        clr_main .. "[" .. w .. "] " .. clr_white .. "Freestanding body yaw"), true, true)
                retard[q].Roll_Enable = createElement(
                    ui.new_checkbox("AA", "Anti-aimbot angles",
                        clr_main .. "[" .. w .. "] " .. clr_white .. "\aB6B665FFRoll"), true,
                    true)
                retard[q].Roll_slider = createElement(
                        ui.new_slider("AA", "Anti-aimbot angles",
                        clr_main .. "[" .. w .. "] " .. clr_white .. "Roll", -50, 50, 0, true, "°"), true,
                        true)
            end

        end,

        ui_handle = function(menuAA)
            local AA_tab = ui.get(tab) ==
                               "9febffffA9fe1ffffn9fd7fffft9fcdffffi9fc4ffff-9fbaffffA9fb0ffffi9fa6ffffm"
            local enabled_lua = ui.get(LUA_ENABLED)
            local Builder = ui.get(menuAA.Builder_Enable)
            is_rage_mode = ui.get(menuAA.aa_mode) == "\afbffabffRage"
            local K = AA_tab and enabled_lua
            local All_K = K and Builder
            local rage_settings = All_K and is_rage_mode
            local legit_settings = All_K and not is_rage_mode
            local legit_inverter_enable = ui.get(menuAA.legit_inverter_indicator) and legit_settings
            ui.set_visible(menuAA.legit_inverter, legit_settings)
            ui.set_visible(menuAA.legit_inverter_key, legit_settings and ui.get(menuAA.legit_inverter) == "Manual")
            ui.set_visible(menuAA.legit_fs_key, legit_settings)
            ui.set_visible(menuAA.legit_inverter_indicator, legit_settings)
            ui.set_visible(menuAA.legit_inverter_indicator_offset, legit_inverter_enable)
            ui.set_visible(menuAA.legit_roll, legit_settings)
            ui.set_visible(menuAA.AA_Direction_tab, K)
            ui.set_visible(menuAA.AA_Direction_mode_tab, K)
            ui.set_visible(menuAA.Freestanding, K and includes(menuAA.function_tab, "Freestanding on Key"))
            ui.set_visible(menuAA.Manual_Backward, K and includes(menuAA.AA_Direction_tab, "Backward"))
            ui.set_visible(menuAA.Manual_Left, K and includes(menuAA.AA_Direction_tab, "Left"))
            ui.set_visible(menuAA.Manual_Right, K and includes(menuAA.AA_Direction_tab, "Right"))
            ui.set_visible(menuAA.Manual_Forward, K and includes(menuAA.AA_Direction_tab, "Forward"))

            ui.set_visible(menuAA.function_tab, K)
            ui.set_visible(menuAA.Fakelag_Disablers,
                K and includes(menuAA.function_tab, "\aB6B665FFFakelag Disablers\a8e8e8eff"))
            local include_edge = includes(menuAA.function_tab, "Edge Yaw Settings")
            ui.set_visible(menuAA.Edge_Yaw_Settings, K and include_edge)
            ui.set_visible(menuAA.Edge_Yaw_on_Key,
                K and include_edge and includes(menuAA.Edge_Yaw_Settings, "Edge Yaw on Key"))
            ui.set_visible(menuAA.Anti_Backstab_Range, K and includes(menuAA.function_tab, "Anti Backstab"))

            ui.set_visible(menuAA.Builder_Enable, K)
            ui.set_visible(menuAA.aa_mode, All_K)
            ui.set_visible(menuAA.condition_select, rage_settings)
            for q, w in pairs(aa_states2) do
                local center_modE = ui.get(menuAA.Custom_AA[q].Yaw_jitter) == "Center\aB6B665FF [L/R]" or
                                        ui.get(menuAA.Custom_AA[q].Yaw_jitter) == "Center\aB6B665FF [Random]"
                local condition_selected = q == aa_states3[ui.get(menuAA.condition_select)]
                local OK = rage_settings and condition_selected
                if q ~= 1 then
                    local condition_enabled = ui.get(menuAA.Custom_AA[q].condition_enabled)
                    local O_Correct = OK and condition_enabled
                    local yawaddmode_is_random = ui.get(menuAA.Custom_AA[q].Yaw_add_mode) == "\aB6B665FF[Random]"
                    local uwu = ui.get(menuAA.Custom_AA[q].Yaw) ~= "Off"
                    ui.set_visible(menuAA.Custom_AA[q].Roll_Enable, O_Correct)
                    ui.set_visible(menuAA.Custom_AA[q].Roll_slider, O_Correct and ui.get(menuAA.Custom_AA[q].Roll_Enable))
                    ui.set_visible(menuAA.Custom_AA[q].condition_enabled, OK)
                    ui.set_visible(menuAA.Custom_AA[q].Pitch, O_Correct)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_base, O_Correct)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw, O_Correct)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_mode, O_Correct and uwu)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_left, O_Correct and uwu and not yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_left_1, O_Correct and uwu and yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_left_2, O_Correct and uwu and yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_right, O_Correct and uwu and not yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_right_1, O_Correct and uwu and yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_right_2, O_Correct and uwu and yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_jitter, O_Correct)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_jitter_slider,
                        O_Correct and ui.get(menuAA.Custom_AA[q].Yaw_jitter) ~= "Off" and not center_modE)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_jitter_slider_custom_1, O_Correct and center_modE)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_jitter_slider_custom_2, O_Correct and center_modE)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_bodyyaw, O_Correct)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_bodyyaw_slider,
                        O_Correct and ui.get(menuAA.Custom_AA[q].Yaw_bodyyaw) ~= "Off")
                    ui.set_visible(menuAA.Custom_AA[q].aa_freestandingbodyyaw, O_Correct)
                else
                    local yawaddmode_is_random = ui.get(menuAA.Custom_AA[q].Yaw_add_mode) == "\aB6B665FF[Random]"
                    local off = ui.get(menuAA.Custom_AA[q].Yaw) ~= "Off"
                    ui.set_visible(menuAA.Custom_AA[q].Roll_Enable, OK)
                    ui.set_visible(menuAA.Custom_AA[q].Roll_slider, OK and ui.get(menuAA.Custom_AA[q].Roll_Enable))
                    ui.set_visible(menuAA.Custom_AA[q].Pitch, OK)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_base, OK)
                    ui.set_visible(menuAA.Custom_AA[q].aa_freestandingbodyyaw, OK)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw, OK)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_mode, OK and off)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_left, OK and off and not yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_left_1, OK and off and yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_left_2, OK and off and yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_right, OK and off and not yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_right_1, OK and off and yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_add_right_2, OK and off and yawaddmode_is_random)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_jitter, OK)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_jitter_slider,
                        OK and ui.get(menuAA.Custom_AA[q].Yaw_jitter) ~= "Off" and not center_modE)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_jitter_slider_custom_1, OK and center_modE)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_jitter_slider_custom_2, OK and center_modE)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_bodyyaw, OK)
                    ui.set_visible(menuAA.Custom_AA[q].Yaw_bodyyaw_slider,
                        OK and ui.get(menuAA.Custom_AA[q].Yaw_bodyyaw) ~= "Off")
                end

            end
            ui.set_visible(menuAA.Import_Button, All_K)
            ui.set_visible(menuAA.Export_Button, All_K)
        end
    },
    visual = {
        custom_color = ui.new_combobox("AA", "Anti-aimbot angles", "Settings", "Global animation speed", "Basic",
            "Crosshair [+] Exploit-Based Colors", "Crosshair [+] Player State", "Crosshair [+] Gradient Bar",
            "Crosshair [+] DOUBLE TAP", "Crosshair [+] ON-SHOT", "Crosshair [+] BODY-AIM", "Crosshair [+] SAFE-POINT",
            "Manual Antiaim", "Notify Color", "Notify [Aimbot Logs] Hit Color", "Notify [Aimbot Logs] Miss Color"),
        Animation_speed = createElement(ui.new_slider("AA", "Anti-aimbot angles", "Animation speed", 1, 200, 100, true,
            "%"), false, true),
        Accent_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Accent Color"),
        Accent_Color = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "uselessname", 243, 105, 147, 255),
            false, true),
        Second_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Second Color"),
        Second_Color = createElement(
            ui.new_color_picker("AA", "Anti-aimbot angles", "uselessname2", 255, 215, 146, 255), false, true),
        Exploit_Default_text = ui.new_label("AA", "Anti-aimbot angles", "Default"),
        Exploit_Default = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "asdggdfg", 255, 134, 158, 255),
            false, true),
        Gradient_Bar_text = ui.new_label("AA", "Anti-aimbot angles", "Gradient Bar"),
        Gradient_Bar = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "asdaetdfhfghfgh", 255, 176, 146,
            255), false, true),
        Exploit_DT_text = ui.new_label("AA", "Anti-aimbot angles", "Double Tap"),
        Exploit_DT = createElement(
            ui.new_color_picker("AA", "Anti-aimbot angles", "asdggadfgasdad", 146, 150, 255, 255), false, true),
        Exploit_OS_text = ui.new_label("AA", "Anti-aimbot angles", "On-shot Antiaim"),
        Exploit_OS = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "asdggdawafg", 208, 255, 127, 255),
            false, true),
        State_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Crosshair [+] Player State"),
        State_Color = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "useles", 255, 176, 146, 255),
            false, true),
        DT_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Crosshair [+] DOUBLE TAP"),
        DT_Color = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "uselessasadfsa", 176, 255, 35, 255),
            false, true),
        Onshot_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Crosshair [+] ON-SHOT"),
        Onshot_Color = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "uselesss", 255, 255, 255, 255),
            false, true),
        BA_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Crosshair [+] BODY-AIM"),
        BA_Color = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "uselessss", 255, 217, 100, 255),
            false, true),
        SP_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Crosshair [+] SAFE-POINT"),
        SP_Color = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "uselesssss", 255, 217, 100, 255),
            false, true),
        Manual_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Manual Antiaim"),
        Manual_Color = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "usellesse", 255, 255, 255, 255),
            false, true),
        Notify_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Notify Color"),
        Notify_Color = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "Notify Coloraataaaa", 255, 163,
            191, 255), false, true),
        Aimbot_Logs_Hit_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Notify [Aimbot Logs] Hit Color"),
        Aimbot_Logs_Hit_Color = createElement(ui.new_color_picker("AA", "Anti-aimbot angles", "uselessasssa", 183, 244,
            73, 255), false, true),
        Aimbot_Logs_Miss_Color_text = ui.new_label("AA", "Anti-aimbot angles", "Notify [Aimbot Logs] Miss Color"),
        Aimbot_Logs_Miss_Color = createElement(
            ui.new_color_picker("AA", "Anti-aimbot angles", "useleswssssaa", 255, 42, 42, 255), false, true),
        UIs = createElement(ui.new_multiselect("AA", "Anti-aimbot angles", "\aD7D2FFFFUIs\aCDCDCDff", "Watermark",
            "Debug Panel", "Lua Info", "Aimbot Stats"), false, true),
        pos_lock = createElement(ui.new_checkbox("AA", "Anti-aimbot angles", "Lock Position"), false, false),
        Watermark_username_enable = createElement(ui.new_checkbox("AA", "Anti-aimbot angles", "Username "), false, true),
        Watermark_username = createElement(ui.new_textbox("AA", "Anti-aimbot angles", "Username"), false, true),

        Notifys = createElement(ui.new_multiselect("AA", "Anti-aimbot angles", "\aD7D2FFFFNotifys\aCDCDCDff",
            "Aimbot Hit Logs", "Aimbot Miss Logs", "Shoot Under Damage (98+)", "Missed due to Unregistered"), false,
            true),
        Crosshair_Indicator = createElement(
            ui.new_combobox("AA", "Anti-aimbot angles", "\aD7D2FFFFCrosshair\aCDCDCDff", "Off", "[+]"), false, true),
        Crosshair_Indicator_Settings = createElement(ui.new_multiselect("AA", "Anti-aimbot angles",
            "Crosshair [+] Settings", "Animation effect", "Render Position Offset", "Exploit-Based Color", "Lua Name",
            "Player Info", "Additional Bar", "Double tap", "On shot anti-aim", "Body aim", "Safe point"), false, true),
        Crosshair_offset_X = createElement(ui.new_slider("AA", "Anti-aimbot angles", "\n           ", -150, 150, 0,
            true, "", 1, {
                [0] = "X Default"
            }), false, true),
        Crosshair_offset_Y = createElement(
            ui.new_slider("AA", "Anti-aimbot angles", "Y offset", -150, 150, 0, true, "", 1, {
                [0] = "Y Default"
            }), false, true),
        Manual_Indicator = createElement(ui.new_combobox("AA", "Anti-aimbot angles", "\aD7D2FFFFManual AA\aCDCDCDff",
            "Off", "[+]"), false, true),
        ui_handle = function(menuVISUAL)
            local enabled_lua = ui.get(LUA_ENABLED)
            local visual_tab = ui.get(tab) == "9febffffV9fdfffffi9fd4ffffs9fc8ffffu9fbdffffa9fb2ffffl9fa6ffffs"
            local All_K = enabled_lua and visual_tab
            local colorcombo = ui.get(menuVISUAL.custom_color)
            local crosshair_settings = menuVISUAL.Crosshair_Indicator_Settings
            local crosshairOffset = All_K and includes(crosshair_settings, "Render Position Offset") and
                                        ui.get(menuVISUAL.Crosshair_Indicator) == "[+]"
            local animspeed = All_K and colorcombo == "Global animation speed"
            local color_basic = All_K and colorcombo == "Basic"
            local color_exploit = All_K and colorcombo == "Crosshair [+] Exploit-Based Colors"
            local gradientbar = All_K and colorcombo == "Crosshair [+] Gradient Bar"
            local lpstate = All_K and colorcombo == "Crosshair [+] Player State"
            local dtxyz = All_K and colorcombo == "Crosshair [+] DOUBLE TAP"
            local osxyz = All_K and colorcombo == "Crosshair [+] ON-SHOT"
            local baxyz = All_K and colorcombo == "Crosshair [+] BODY-AIM"
            local spxyz = All_K and colorcombo == "Crosshair [+] SAFE-POINT"
            local maxyz = All_K and colorcombo == "Manual Antiaim"
            local notifycolorxyz = All_K and colorcombo == "Notify Color"
            local hittcolor = All_K and colorcombo == "Notify [Aimbot Logs] Hit Color"
            local missscolor = All_K and colorcombo == "Notify [Aimbot Logs] Miss Color"
            local watermarkkk = includes(menuVISUAL.UIs, "Watermark")
            local infooo = includes(menuVISUAL.UIs, "Lua Info")
            local aimbotstatssss = includes(menuVISUAL.UIs, "Aimbot Stats")
            local debugpanelll = includes(menuVISUAL.UIs, "Debug Panel")
            local bigdick = All_K and watermarkkk
            ui.set_visible(menuVISUAL.Crosshair_offset_X, crosshairOffset)
            ui.set_visible(menuVISUAL.Crosshair_offset_Y, crosshairOffset)
            ui.set_visible(menuVISUAL.custom_color, All_K)
            ui.set_visible(menuVISUAL.Accent_Color_text, color_basic)
            ui.set_visible(menuVISUAL.Animation_speed, animspeed)
            ui.set_visible(menuVISUAL.Accent_Color, color_basic)
            ui.set_visible(menuVISUAL.Second_Color_text, color_basic)
            ui.set_visible(menuVISUAL.Second_Color, color_basic)
            ui.set_visible(menuVISUAL.Exploit_Default_text, color_exploit)
            ui.set_visible(menuVISUAL.Exploit_Default, color_exploit)
            ui.set_visible(menuVISUAL.Exploit_DT_text, color_exploit)
            ui.set_visible(menuVISUAL.Exploit_DT, color_exploit)
            ui.set_visible(menuVISUAL.Gradient_Bar_text, gradientbar)
            ui.set_visible(menuVISUAL.Gradient_Bar, gradientbar)
            ui.set_visible(menuVISUAL.Exploit_OS_text, color_exploit)
            ui.set_visible(menuVISUAL.Exploit_OS, color_exploit)
            ui.set_visible(menuVISUAL.State_Color_text, lpstate)
            ui.set_visible(menuVISUAL.State_Color, lpstate)
            ui.set_visible(menuVISUAL.DT_Color_text, dtxyz)
            ui.set_visible(menuVISUAL.Onshot_Color_text, osxyz)
            ui.set_visible(menuVISUAL.BA_Color_text, baxyz)
            ui.set_visible(menuVISUAL.SP_Color_text, spxyz)
            ui.set_visible(menuVISUAL.Onshot_Color, osxyz)
            ui.set_visible(menuVISUAL.BA_Color, baxyz)
            ui.set_visible(menuVISUAL.DT_Color, dtxyz)
            ui.set_visible(menuVISUAL.SP_Color, spxyz)
            ui.set_visible(menuVISUAL.Manual_Color_text, maxyz)
            ui.set_visible(menuVISUAL.Manual_Color, maxyz)
            ui.set_visible(menuVISUAL.Notify_Color_text, notifycolorxyz)
            ui.set_visible(menuVISUAL.Notify_Color, notifycolorxyz)
            ui.set_visible(menuVISUAL.Aimbot_Logs_Hit_Color_text, hittcolor)
            ui.set_visible(menuVISUAL.Aimbot_Logs_Hit_Color, hittcolor)
            ui.set_visible(menuVISUAL.Aimbot_Logs_Miss_Color_text, missscolor)
            ui.set_visible(menuVISUAL.Aimbot_Logs_Miss_Color, missscolor)
            ui.set_visible(menuVISUAL.Notifys, All_K)
            ui.set_visible(menuVISUAL.Watermark_username_enable, bigdick)
            ui.set_visible(menuVISUAL.pos_lock, All_K and (aimbotstatssss or infooo or debugpanelll))
            ui.set_visible(menuVISUAL.Watermark_username, bigdick and ui.get(menuVISUAL.Watermark_username_enable))
            ui.set_visible(menuVISUAL.UIs, All_K)
            ui.set_visible(menuVISUAL.Crosshair_Indicator, All_K)
            ui.set_visible(menuVISUAL.Crosshair_Indicator_Settings,
                All_K and ui.get(menuVISUAL.Crosshair_Indicator) == "[+]")
            ui.set_visible(menuVISUAL.Manual_Indicator, All_K)
        end
    },
    misc = {
        Functions = createElement(ui.new_multiselect("AA", "Anti-aimbot angles", clr_main .. "Functions  ",
            "\aB6B665FFAnimation Breaker\ac1c1c1ff", "\aD40000FFEXP Settings\ac1c1c1ff", "Killsay", "Clantag",
            "Filter Console (reload)"), false, true),
        Animation_Breaker = createElement(ui.new_multiselect("AA", "Anti-aimbot angles",
            clr_yellow .. "Animation Breaker", "Falling", "Pitch 0 on Land", "Leg Fucker","Moon Walk"), false, true),
        Exp_Settings = createElement(ui.new_multiselect("AA", "Anti-aimbot angles", "\aD40000FFExp Settings",
            "Pitch Up", "Force Defensive [WIP]"), false, true),
        pitchup_time = createElement(ui.new_slider("AA", "Anti-aimbot angles", 
            "Time", 1, 27, 12), false, true),
        Killsay_delay = createElement(ui.new_slider("AA", "Anti-aimbot angles", "Killsay Delay (s)", 0, 3, 1, true, "",
            1, {
                [0] = "Instant"
            }), false, true),
        ui_handle = function(menuMISC)
            local enabled_lua = ui.get(LUA_ENABLED)
            local visual_tab = ui.get(tab) ==
                                   "9febffffM9fe5ffffi9fdfffffs9fdaffffc9fd4ffffe9fceffffl9fc9ffffl9fc3ffffa9fbdffffn9fb8ffffe9fb2ffffo9facffffu9fa7ffffs"
            local trashpc = includes(menuMISC.Functions, "\aD40000FFEXP Settings\ac1c1c1ff")
            local All_K = enabled_lua and visual_tab
            ui.set_visible(menuMISC.Functions, All_K)
            ui.set_visible(menuMISC.Animation_Breaker,
                All_K and includes(menuMISC.Functions, "\aB6B665FFAnimation Breaker\ac1c1c1ff"))
            ui.set_visible(menuMISC.pitchup_time,
                All_K and trashpc and includes(menuMISC.Exp_Settings, "Pitch Up"))
            ui.set_visible(menuMISC.Killsay_delay, All_K and includes(menuMISC.Functions, "Killsay"))
            ui.set_visible(menuMISC.Exp_Settings, All_K and trashpc)

        end
    }
}
uis.aa.Custom_AA_uicreate(uis.aa.Custom_AA)
uis.aa.Import_Button = ui.new_button("AA", "Anti-aimbot angles",
    clr_main .. "Import " .. clr_antiaim .. "Anti-Aim Settings", import_antiaim)
uis.aa.Export_Button = ui.new_button("AA", "Anti-aimbot angles",
    clr_main .. "Export " .. clr_antiaim .. "Anti-Aim Settings", export_antiaim)
local function import_global()
    local table_ = str_to_sub(base64.decode(clipboard.get(), 'base64'), "|")
    local p = 1
    for i, o in pairs(to_export_global['number']) do
        ui.set(o, table_[p])
        p = p + 1
    end
    for i, o in pairs(to_export_global['string']) do
        ui.set(o, (table_[p]))
        p = p + 1
    end
    for i, o in pairs(to_export_global['boolean']) do
        ui.set(o, to_boolean(table_[p]))
        p = p + 1
    end
    for i, o in pairs(to_export_global['table']) do
        ui.set(o, str_to_sub(table_[p], ','))
        p = p + 1
    end
    _G.Notify_push:paint(5, "Imported Global settings from clipboard", true, "%s%s%s", 2, {
        [0] = "Imported ",
        [1] = "Global settings",
        [2] = " from clipboard"
    }, {
        [0] = "ffffff",
        [1] = "A0DD35",
        [2] = "ffffff"
    })
end
local function export_global()
    local str = ""
    for i, o in pairs(to_export_global['number']) do
        str = str .. tostring(ui.get(o)) .. '|'
    end
    for i, o in pairs(to_export_global['string']) do
        -- print(ui.get(o))
        str = str .. ui.get(o) .. '|'
    end
    for i, o in pairs(to_export_global['boolean']) do
        str = str .. tostring(ui.get(o)) .. '|'
    end
    for i, o in pairs(to_export_global['table']) do
        str = str .. arr_to_string(o) .. '|'
    end
    clipboard.set(base64.encode(str, 'base64'))
    _G.Notify_push:paint(5, "Exported Global settings to clipboard", true, "%s%s%s", 2, {
        [0] = "Exported ",
        [1] = "Global settings",
        [2] = " to clipboard"
    }, {
        [0] = "ffffff",
        [1] = "A0DD35",
        [2] = "ffffff"
    })
end
local function default_global()
    local table_ = str_to_sub(base64.decode(default_cfg, 'base64'), "|")
    local p = 1
    for i, o in pairs(to_export_global['number']) do
        ui.set(o, table_[p])
        p = p + 1
    end
    for i, o in pairs(to_export_global['string']) do
        ui.set(o, (table_[p]))
        p = p + 1
    end
    for i, o in pairs(to_export_global['boolean']) do
        ui.set(o, to_boolean(table_[p]))
        p = p + 1
    end
    for i, o in pairs(to_export_global['table']) do
        ui.set(o, str_to_sub(table_[p], ','))
        p = p + 1
    end
    _G.Notify_push:paint(5, "Default config loaded", true, "%s%s", 1, {
        [0] = "Default config",
        [1] = " loaded"
    }, {
        [0] = "A0DD35",
        [1] = "ffffff"
    })
end
local global_export_button = ui.new_button("AA", "Other", "Import " .. "\aA0DD35FFGlobal Settings", import_global)
local global_export_button = ui.new_button("AA", "Other", "Export " .. "\aA0DD35FFGlobal Settings", export_global)
local global_default_button = ui.new_button("AA", "Other", "Load " .. "\aA0DD35FFDefault Config", default_global)
_G.Notify_push = (function()
    _G.Notify_notify_cache = {}
    local a = {
        callback_registered = false,
        maximum_count = 15
    }
    local b = ui.reference("Misc", "Settings", "Menu color")
    function a:register_callback()
        if self.callback_registered then
            return
        end
        client.set_event_callback("paint_ui", function()
            local c = {client.screen_size()}
            local d = {0, 0, 0}
            local e = 1;
            local f = _G.Notify_notify_cache;
            for g = #f, 1, -1 do
                local j = f[g]
                if j.type == false then
                    j.time = j.time - globals.frametime()
                    local h, i = 255, 0;
                    local i2 = 0;
                    local lerpy = 150;
                    local lerp_circ = 0.5;
                    if j.time < 0 then
                        table.remove(_G.Notify_notify_cache, g)
                    else
                        local k = j.def_time - j.time;
                        local k = k > 1 and 1 or k;
                        if j.time < 1 or k < 1 then
                            i = (k < 1 and k or j.time) / 1;
                            i2 = (k < 1 and k or j.time) / 1;
                            h = i * 255;
                            lerpy = i * 150;
                            lerp_circ = i * 0.5
                            if i < 0.2 then
                                e = e + 8 * (1.0 - i / 0.2)
                            end
                        end

                        local l = {ui.get(b)}
                        local m = {math.floor(renderer.measure_text(nil, "[Fsocie7y.beta]  " .. j.text_calc) * 1.03)}
                        local n = {renderer.measure_text(nil, "[Fsocie7y.beta]  ")}
                        local o = {renderer.measure_text(nil, j.text_calc)}
                        local p = {c[1] / 2 - m[1] / 2 + 3, c[2] - c[2] / 100 * 13.4 + e + 30}
                        local notifycolor = {ui.get(uis.visual.Notify_Color)}
                        local mainc = {ui.get(uis.visual.Accent_Color)}
                        local secondc = {ui.get(uis.visual.Second_Color)}
                        local c1, c2, c3, c4 = notifycolor[1], notifycolor[2], notifycolor[3], notifycolor[4]
                        local x, y = client.screen_size()
                        local alpha = h > 255 and 255 or h
                        renderer.rectangle(p[1] - 1, p[2] - 20, m[1] + 2, 22, 18, 7, 8, alpha)
                        renderer.circle(p[1] - 1, p[2] - 8, 18, 7, 8, alpha, 12, 180, 0.5)
                        renderer.circle(p[1] + m[1] + 1, p[2] - 8, 18, 7, 8, alpha, 12, 0, 0.5)
                        renderer.circle_outline(p[1] - 1, p[2] - 9, c1, c2, c3, h > 200 and 200 or h, 13, 90, lerp_circ,
                            2)
                        renderer.circle_outline(p[1] + m[1] + 1, p[2] - 9, c1, c2, c3, h > 200 and 200 or h, 13, -90,
                            lerp_circ, 2)
                        renderer.line(p[1] + m[1] + 1, p[2] + 3, p[1] + 149 - lerpy, p[2] + 3, c1, c2, c3, alpha)
                        renderer.line(p[1] + m[1] + 1, p[2] + 3, p[1] + 149 - lerpy, p[2] + 3, c1, c2, c3, alpha)
                        renderer.line(p[1] - 1, p[2] - 21, p[1] - 149 + m[1] + lerpy, p[2] - 21, c1, c2, c3, alpha)
                        renderer.line(p[1] - 1, p[2] - 21, p[1] - 149 + m[1] + lerpy, p[2] - 21, c1, c2, c3, alpha)
                        -- local logotext = gradient_text(mainc[1], mainc[2], mainc[3], h, secondc[1], secondc[2],
                        --     secondc[3], h, "[Fsocie7y.beta]  ")

                        local logotext = "\a" .. rgba_to_hex(c1, c2, c3, alpha) .. "[Fsocie7y.beta]  "
                        renderer.text(p[1] + m[1] / 2 - o[1] / 2, p[2] - 9, c1, c2, c3, h, "c", nil, logotext)
                        renderer.text(p[1] + m[1] / 2 + n[1] / 2, p[2] - 9, 255, 255, 255, h, "c", nil, j.text_calc)
                        e = e - 33
                    end
                else
                    j.time = j.time - globals.frametime()
                    local h, i = 255, 0;
                    local i2 = 0;
                    local lerpy = 150;
                    local lerp_circ = 0.5;
                    if j.time < 0 then
                        table.remove(_G.Notify_notify_cache, g)
                    else
                        local k = j.def_time - j.time;
                        local k = k > 1 and 1 or k;
                        if j.time < 1 or k < 1 then
                            i = (k < 1 and k or j.time) / 1;
                            i2 = (k < 1 and k or j.time) / 1;
                            h = i * 255;
                            lerpy = i * 150;
                            lerp_circ = i * 0.5
                            if i < 0.2 then
                                e = e + 8 * (1.0 - i / 0.2)
                            end
                        end
                        local alpha = h > 255 and 255 or h
                        local l = {ui.get(b)}
                        local m = {math.floor(renderer.measure_text(nil, "[Fsocie7y.beta]  " .. j.text_calc) * 1.03)}
                        local n = {renderer.measure_text(nil, "[Fsocie7y.beta]  ")}
                        local o = {renderer.measure_text(nil, j.text_calc)}
                        local p = {c[1] / 2 - m[1] / 2 + 3, c[2] - c[2] / 100 * 13.4 + e + 30}
                        local notifycolor = {ui.get(uis.visual.Notify_Color)}
                        local mainc = {ui.get(uis.visual.Accent_Color)}
                        local secondc = {ui.get(uis.visual.Second_Color)}
                        local c1, c2, c3, c4 = notifycolor[1], notifycolor[2], notifycolor[3], notifycolor[4]
                        local x, y = client.screen_size()
                        renderer.rectangle(p[1] - 1, p[2] - 20, m[1] + 2, 22, 18, 7, 8, alpha)
                        renderer.circle(p[1] - 1, p[2] - 8, 18, 7, 8, alpha, 12, 180, 0.5)
                        renderer.circle(p[1] + m[1] + 1, p[2] - 8, 18, 7, 8, alpha, 12, 0, 0.5)
                        renderer.circle_outline(p[1] - 1, p[2] - 9, c1, c2, c3, h > 200 and 200 or h, 13, 90, lerp_circ,
                            2)
                        renderer.circle_outline(p[1] + m[1] + 1, p[2] - 9, c1, c2, c3, h > 200 and 200 or h, 13, -90,
                            lerp_circ, 2)
                        renderer.line(p[1] + m[1] + 1, p[2] + 3, p[1] + 149 - lerpy, p[2] + 3, c1, c2, c3, alpha)
                        renderer.line(p[1] + m[1] + 1, p[2] + 3, p[1] + 149 - lerpy, p[2] + 3, c1, c2, c3, alpha)
                        renderer.line(p[1] - 1, p[2] - 21, p[1] - 149 + m[1] + lerpy, p[2] - 21, c1, c2, c3, alpha)
                        renderer.line(p[1] - 1, p[2] - 21, p[1] - 149 + m[1] + lerpy, p[2] - 21, c1, c2, c3, alpha)
                        local logotext = gradient_text(mainc[1], mainc[2], mainc[3], h, secondc[1], secondc[2],
                            secondc[3], h, "[Fsocie7y.beta]  ")
                        renderer.text(p[1] + m[1] / 2 - o[1] / 2, p[2] - 9, c1, c2, c3, h, "c", nil, logotext)
                        local text_num = j.text_format_num
                        local text_table = j.text_format_text
                        local color_table = j.text_format_color
                        local a_text = a_to_hex(h)
                        local text = string.format(j.text_format,
                            alpha_to_textformat(text_num, text_table, color_table, a_text))
                        renderer.text(p[1] + m[1] / 2 + n[1] / 2, p[2] - 9, 255, 255, 255, h, "c", nil, text)
                        e = e - 33
                    end
                end

            end
            self.callback_registered = true
        end)
    end

    function a:paint(second, text_calc, type, text_format, text_format_num, text_format_text, text_format_color)
        local s = tonumber(second) + 1;
        for g = self.maximum_count, 2, -1 do
            _G.Notify_notify_cache[g] = _G.Notify_notify_cache[g - 1]
        end
        _G.Notify_notify_cache[1] = {
            time = s,
            def_time = s,
            text_calc = text_calc,
            type = type,
            text_format = text_format,
            text_format_num = text_format_num,
            text_format_text = text_format_text,
            text_format_color = text_format_color
        }
        self:register_callback()
    end
    return a
end)()
local function ui_handle()
    local LUA_enabled = not ui.get(LUA_ENABLED)
    ui.set_visible(tab, not LUA_enabled)
    -- set_AA_menu_boolean(true)
    set_AA_menu_boolean(false)
    local set_AA_enable = ui.get(LUA_ENABLED) and ui.get(uis.aa.Builder_Enable)
    ui.set(refs.aa_enable, set_AA_enable)
end
local function get_Player_State(c, menu)
    if not localplayer then
        return "Not Connected"
    end
    local vx, vy, vz = entity.get_prop(localplayer, "m_vecVelocity")
    local localp_still = math.sqrt(vx ^ 2 + vy ^ 2) < 5
    local on_ground = bit.band(entity.get_prop(localplayer, "m_fFlags"), 1) == 1 and c.in_jump == 0
    local is_slow = ui.get(refs.aa_slowmotion[1]) and ui.get(refs.aa_slowmotion[2])
    local is_os = ui.get(refs.aa_os[1]) and ui.get(refs.aa_os[2])
    local is_dt = ui.get(refs.rage_dt[1]) and ui.get(refs.rage_dt[2])
    -- [gamesense] Standing: 2
    -- [gamesense] Moving: 3
    -- [gamesense] Slowwalking: 4
    -- [gamesense] CT Crouching: 5
    -- [gamesense] T Crouching: 6
    -- [gamesense] Jumping: 7
    -- [gamesense] Crouching Air: 8
    -- [gamesense] Fake lag: 9
    local team = entity.get_prop(localplayer, "m_iTeamNum")
    local is_duck = c.in_duck == 1 and true or false
    if not is_slow and not is_os and not is_dt and not localp_still and ui.get(menu[9].condition_enabled) then
        return "Fakelag"
    elseif is_duck and on_ground and team == 3 and ui.get(menu[5].condition_enabled) then
        return "CT Crouching"
    elseif is_duck and on_ground and team == 2 and ui.get(menu[6].condition_enabled) then
        return "T Crouching"
    elseif is_duck and not on_ground and ui.get(menu[8].condition_enabled) then
        return "Crouching Air"
    elseif not on_ground and ui.get(menu[7].condition_enabled) then
        return "Jumping"
    elseif is_slow and ui.get(menu[4].condition_enabled) then
        return "Slowwalking"
    elseif localp_still and ui.get(menu[2].condition_enabled) then
        return "Standing"
    elseif not localp_still and ui.get(menu[3].condition_enabled) then
        return "Moving"
    else
        return "Global"
    end
end
local bind_systeam = {
    left = false,
    right = false,
    back = false,
    forward = false
}
function bind_systeam:update(include_Backward)

    local m_state = ui.get(manual_state)
    local left_state, right_state, backward_state, forward_state = ui.get(uis.aa.Manual_Left),
        ui.get(uis.aa.Manual_Right), ui.get(uis.aa.Manual_Backward), ui.get(uis.aa.Manual_Forward)

    if left_state == self.left and right_state == self.right and backward_state == self.back and forward_state ==
        self.forward then
        return
    end

    self.left, self.right, self.back, self.forward = left_state, right_state, backward_state, forward_state

    if (left_state and m_state == 1) or (right_state and m_state == 2) or
        (include_Backward and (backward_state and m_state == 3) or false) or (forward_state and m_state == 4) then
        ui.set(manual_state, 0)
        return
    end

    if left_state and m_state ~= 1 then
        ui.set(manual_state, 1)
    end
    if right_state and m_state ~= 2 then
        ui.set(manual_state, 2)
    end
    if backward_state and m_state ~= 3 then
        ui.set(manual_state, 3)
    end
    if forward_state and m_state ~= 4 then
        ui.set(manual_state, 4)
    end

end

-- exploit pitch Up
local var_table = {};

local prev_simulation_time = 0

local function time_to_ticks(t)
    return math.floor(0.5 + (t / globals.tickinterval()))
end
local diff_sim = 0
function var_table:sim_diff()
    local current_simulation_time = time_to_ticks(entity.get_prop(entity.get_local_player(), "m_flSimulationTime"))
    local diff = current_simulation_time - prev_simulation_time
    prev_simulation_time = current_simulation_time
    diff_sim = diff
    return diff_sim
end

to_draw = false
to_up = false
to_draw_ticks = 0

pitchup_update = function()
    if not LUA_ENABLED then
        return
    end
    local diff_mmeme = var_table.sim_diff()
    if diff_mmeme <= -1 then
        to_draw = true
        to_up = true
    end
end

pitchup_indicator_paint = function()
    if not localplayer then
        return
    end
    if not entity.is_alive(localplayer) then
        return
    end

    local is_dt = ui.get(refs.rage_dt[1]) and ui.get(refs.rage_dt[2])

    if to_draw and is_dt then
        draw_art = to_draw_ticks * 100 / 52
        renderer.text(Center.x, Center.y - 40, 255, 255, 255, 255, "c", 0, "[exploit]")
        renderer.rectangle(Center.x - 27, Center.y - 31, 54, 4, 50, 50, 50, 255)
        renderer.rectangle(Center.x - 25, Center.y - 30, draw_art, 2, 255, 255, 255, 255)
        to_draw_ticks = to_draw_ticks + 1

        -- default 27
        if to_draw_ticks == ui.get(uis.misc.pitchup_time) then
            to_draw_ticks = 0
            to_draw = false
            to_up = false
        end
    end
end

local function Exp_Settings()
    if not localplayer then
        return
    end

    if not entity.is_alive(localplayer) then
        return
    end
    
    local is_os = ui.get(refs.aa_os[1]) and ui.get(refs.aa_os[2])
    local is_dt = ui.get(refs.rage_dt[1]) and ui.get(refs.rage_dt[2])

    if includes(uis.misc.Functions, "\aD40000FFEXP Settings\ac1c1c1ff") then
        if is_rage_mode then
            if includes(uis.misc.Exp_Settings, "Pitch Up") then
                if to_up == true then
                    if is_os and not is_dt then
                        return
                    end
                    ui.set(refs.aa_pitch, "Up")
            
                    if not is_dt then
                        to_up = false
                    end
                end
            end
        end
    end
end

local function Fakelag_Breaker()
    if includes(uis.aa.function_tab, "Fakelag Breaker") then
        ui.set(refs.aa_fl_amount, random[math.random(1, 3)])
        ui.set(refs.aa_fl_var, math.random(10, 25))
    end
end
local function Fakelag_Disablers()
    local not_fd = not ui.get(refs.rage_fakeduck)
    local ok = 0
    if not_fd and includes(uis.aa.function_tab, "\aB6B665FFFakelag Disablers\a8e8e8eff") then
        ok = 1
        if includes(uis.aa.Fakelag_Disablers, "\aB6B665FFOn shot anti-aim\ac1c1c1ff") and ui.get(refs.aa_os[2]) then
            ui.set(refs.aa_fl_limit, 1)
            ok = 2
        end
        if includes(uis.aa.Fakelag_Disablers, "Standing") and state == "Standing" then
            ui.set(refs.aa_fl_limit, 1)
            ok = 2
        end
        if includes(uis.aa.Fakelag_Disablers, "Slow motion") and state == "Slowwalking" then
            ui.set(refs.aa_fl_limit, 1)
            ok = 2
        end
        if includes(uis.aa.Fakelag_Disablers, "Crouching") and (state == "CT Crouching" or state == "T Crouching") then
            ui.set(refs.aa_fl_limit, 1)
            ok = 2
        end
    end
    isfl_off = ok == 2 and true or false
end
local function warmup_random_settings(c, is_warmup)
    if includes(uis.aa.function_tab, "Random Anti-Aim in Warm-up") and is_warmup == 1 then
        ui.set(refs.aa_pitch, "Minimal")
        ui.set(refs.aa_yawbase, "At targets")
        ui.set(refs.aa_yaw[1], "180")
        if c.chokedcommands == 0 then
            ui.set(refs.aa_yaw[2], 0)
        end
        ui.set(refs.aa_yawjitter[1], "Random")
        ui.set(refs.aa_yawjitter[2], 100)
        ui.set(refs.aa_bodyyaw[1], "Jitter")
        ui.set(refs.aa_bodyyaw[2], math.random(-180, 180))
    end
end
local function backstab()
    if includes(uis.aa.function_tab, "Anti Backstab") then
        local enemies = entity.get_players(true)
        local lx, ly, lz = entity.get_prop(localplayer, "m_vecOrigin")
        for i = 1, #enemies do
            local x, y, z = entity.get_prop(enemies[i], "m_vecOrigin")
            local distance = get_distance(lx, ly, lz, x, y, z)
            local weapon = entity.get_player_weapon(enemies[i])
            local should_anti_knife = (entity.get_classname(weapon) == "CKnife" and distance <= 280)
            return should_anti_knife
        end
    end
end
local function legit_aa(c, E_Key)
    if includes(uis.aa.function_tab, "Legit AA / Bombsite Fix") and E_Key then
        local distance = 100
        local bomb = entity.get_all("CPlantedC4")[1]
        local bomb_x, bomb_y, bomb_z = entity.get_prop(bomb, "m_vecOrigin")
        if bomb_x ~= nil then
            local player_x, player_y, player_z = entity.get_prop(localplayer, "m_vecOrigin")
            distance = distance3d(bomb_x, bomb_y, bomb_z, player_x, player_y, player_z)
        end
        local team_num = entity.get_prop(localplayer, "m_iTeamNum")
        local defusing = team_num == 3 and distance < 62
        local px, py, pz = client.eye_position()
        local pitch, yaw = client.camera_angles()
        local sin_pitch = math.sin(math.rad(pitch))
        local cos_pitch = math.cos(math.rad(pitch))
        local sin_yaw = math.sin(math.rad(yaw))
        local cos_yaw = math.cos(math.rad(yaw))
        local dir_vec = {cos_pitch * cos_yaw, cos_pitch * sin_yaw, -sin_pitch}
        local fraction, entindex = client.trace_line(localplayer, px, py, pz, px + (dir_vec[1] * 8192),
            py + (dir_vec[2] * 8192), pz + (dir_vec[3] * 8192))
        local using = true
        for i = 0, #classnames do
            if entindex ~= -1 then
                if entity.get_classname(entindex) == classnames[i] then
                    using = false
                end
            end
        end
        if not using and not defusing then
            c.in_use = 0
        end
        if defusing then
            return
        end

        ui.set(refs.aa_pitch, "Off")
        ui.set(refs.aa_yawbase, "Local view")
        ui.set(refs.aa_yaw[1], "180")
        if c.chokedcommands == 0 then
            ui.set(refs.aa_yaw[2], 180)
        end
        ui.set(refs.aa_yawjitter[1], "Off")
        ui.set(refs.aa_bodyyaw[1], "Static")
        ui.set(refs.aa_freestandingbodyyaw, true)
        return
    end
end
local function banner(ctx)
    if banner_img == nil or not ui.get(LUA_ENABLED) then
        return
    end
    local menu_x, menu_y = ui.menu_position()
    local menu_width, menu_height = ui.menu_size()
    local half_width, half_height = menu_width / 2, menu_height / 2
    local menu_open = ui.is_menu_open()
    if menu_open then
        if whydoidothis < 1 then
            whydoidothis = math.min(whydoidothis + 0.04, 1)
        else
            whydoidothis = 1
        end
    else
        whydoidothis = 0
    end
    local img_width = half_width * 1.2
    local perf = 255 * whydoidothis
    draw_container(ctx, menu_x, menu_y - 98, menu_width, 98, whydoidothis, perf)
    -- banner_img:draw(menu_x + (menu_width - img_width) / 2-75, menu_y - 84, img_width+150, 84, 255, 255, 255, perf, true, "f")
    banner_img:draw(menu_x + (menu_width - img_width) / 2 - 80, menu_y - 77, img_width + 160, 70, 255, 255, 255, perf,
        true, "f")
end
local function animation_breaker()
    if includes(uis.misc.Functions, "\aB6B665FFAnimation Breaker\ac1c1c1ff") then
        if includes(uis.misc.Animation_Breaker, "Falling") then
            entity.set_prop(localplayer, "m_flPoseParameter", 1, 6)
        end
        if includes(uis.misc.Animation_Breaker, "Pitch 0 on Land") then
            local on_ground = bit.band(entity.get_prop(localplayer, "m_fFlags"), 1)

            if on_ground == 1 then
                ground_ticks = ground_ticks + 1
            else
                ground_ticks = 0
                end_time = globals.curtime() + 1
            end

            if ground_ticks > ui.get(refs.aa_fl_limit) + 1 and end_time > globals.curtime() then
                entity.set_prop(localplayer, "m_flPoseParameter", 0.5, 12)
            end
        end
        if includes(uis.misc.Animation_Breaker, "Leg Fucker") then
            entity.set_prop(localplayer, "m_flPoseParameter", 1, 0)
            local p = math.random(1, 3)
            if p == 1 then
                ui.set(refs.aa_legmovement, "Off")
            elseif p == 2 then
                ui.set(refs.aa_legmovement, "Always slide")
            elseif p == 3 then
                ui.set(refs.aa_legmovement, "Off")
            end
            ui.set_visible(refs.aa_legmovement, false)
        else
            ui.set_visible(refs.aa_legmovement, true)
        end
        if includes(uis.misc.Animation_Breaker, "Moon Walk") then
            if not entity.is_alive(entity.get_local_player()) then return end
            local me = ent.get_local_player()
            local m_fFlags = me:get_prop("m_fFlags");
            local is_onground = bit.band(m_fFlags, 1) ~= 0;
            ui.set(refs.aa_legmovement, "Never slide")
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 7)
            if not is_onground then
                local my_animlayer = me:get_anim_overlay(6);
                my_animlayer.weight = 1;
                entity.set_prop(me, "m_flPoseParameter", 1, 6)
            end
        end
    end
end
local function manual_indicator(color)
    local manualindicator_type = ui.get(uis.visual.Manual_Indicator)
    if manualindicator_type == "Off" or not ui.get(uis.aa.Builder_Enable) then
        return
    end
    local r, g, b, a = color[1], color[2], color[3], color[4]
    local a_left = LEFT and 255 or 0
    local a_right = RIGHT and 255 or 0
    local a_forward = FORWARD and 255 or 0
    -- renderer.text(1100,523,255,255,255,255,"C+",nil,"›‹")
    renderer.text(center_X - 108, center_Y - 16, r, g, b, a_left, "+", nil, "‹")
    renderer.text(center_X + 100, center_Y - 16, r, g, b, a_right, "+", nil, "›")
    renderer.text(center_X - 5, center_Y - 120, r, g, b, a_forward, nil, nil, "▲")
    -- wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
end
local function lerp(start, vend, time)
    return start + (vend - start) * time
end
local function crosshair_indicator(localplayer_scoped, main_c, second_c, inverter_pos_vis)
    local crosshair_type = ui.get(uis.visual.Crosshair_Indicator)
    if crosshair_type == "Off" then
        return
    end
    local main_r, main_g, main_b, main_a = main_c[1], main_c[2], main_c[3], main_c[4]
    local second_r, second_g, second_b, second_a = second_c[1], second_c[2], second_c[3], second_c[4]
    -- local DT = ui.get(refs.rage_dt[1]) and ui.get(refs.rage_dt[2])
    local DT = ui.get(refs.rage_dt[2])
    local OS = ui.get(refs.aa_os[1]) and ui.get(refs.aa_os[2])
    local BA = ui.get(refs.rage_baim)
    local SP = ui.get(refs.rage_safe)
    if crosshair_type == "[+]" then
        local fps = AccumulateFps()
        local is_animation = includes(uis.visual.Crosshair_Indicator_Settings, "Animation effect")
        local animation_speed = ui.get(uis.visual.Animation_speed) / 100
        local time_2_5 = globals.frametime() * 2.5 * animation_speed
        local time_3 = globals.frametime() * 3 * animation_speed
        local time_3_2 = globals.frametime() * 3.2 * animation_speed
        local time_4 = globals.frametime() * 4 * animation_speed
        local time_4_5 = globals.frametime() * 4.5 * animation_speed
        local time_5 = globals.frametime() * 5 * animation_speed
        local time_6 = globals.frametime() * 6 * animation_speed
        local time_7 = globals.frametime() * 7 * animation_speed
        local time_8 = globals.frametime() * 8 * animation_speed
        local time_9 = globals.frametime() * 9 * animation_speed

        local exploit = includes(uis.visual.Crosshair_Indicator_Settings, "Exploit-Based Color")
        local exp_dt = {ui.get(uis.visual.Exploit_DT)}
        local exp_os = {ui.get(uis.visual.Exploit_OS)}
        local exp_def = {ui.get(uis.visual.Exploit_Default)}
        local lua_name = includes(uis.visual.Crosshair_Indicator_Settings, "Lua Name")
        local info = includes(uis.visual.Crosshair_Indicator_Settings, "Player Info")
        local bar = includes(uis.visual.Crosshair_Indicator_Settings, "Additional Bar")
        local bind_dt = includes(uis.visual.Crosshair_Indicator_Settings, "Double tap")
        local bind_os = includes(uis.visual.Crosshair_Indicator_Settings, "On shot anti-aim")
        local bind_ba = includes(uis.visual.Crosshair_Indicator_Settings, "Body aim")
        local bind_sp = includes(uis.visual.Crosshair_Indicator_Settings, "Safe point")

        local vec = math.max(0, (math.floor(get_velocity() + 0.5)) - 1)
        local vec_to_renderer = math.floor(vec * 0.06 + 0.5)
        local vec_renderer = math.min(42, math.floor(vec_to_renderer * 1.9 + 0.5))
        local scoped = localplayer_scoped >= 1

        if scoped then
            anim_t.scoped_alpha255 = lerp(anim_t.scoped_alpha255, 255, time_6)
            anim_t.unscoped_alpha255 = lerp(anim_t.unscoped_alpha255, 0, time_6)
            if bar then
                anim_t.scoped_x_name = is_animation and lerp(anim_t.scoped_x_name, 47.4, time_7) or
                                           lerp(anim_t.scoped_x_name, 0, time_7)
            else
                anim_t.scoped_x_name = is_animation and lerp(anim_t.scoped_x_name, 45.4, time_7) or
                                           lerp(anim_t.scoped_x_name, 0, time_7)
            end
            anim_t.scoped_x_bar = is_animation and lerp(anim_t.scoped_x_bar, 39, time_7) or
                                      lerp(anim_t.scoped_x_bar, 0, time_7)
            if DT or OS then
                anim_t.scoped_alpha = lerp(anim_t.scoped_alpha, 255, time_6)
                anim_t.scoped_alpha_2 = lerp(anim_t.scoped_alpha_2, 0, time_6)
                anim_t.KMH_width = lerp(anim_t.KMH_width, 45, time_4_5)
                anim_t.FL_width = lerp(anim_t.FL_width, 1, time_2_5)
            else
                anim_t.scoped_alpha = lerp(anim_t.scoped_alpha, 0, time_6)
                anim_t.scoped_alpha_2 = lerp(anim_t.scoped_alpha_2, 255, time_6)
                anim_t.KMH_width = lerp(anim_t.KMH_width, 1, time_4_5)
                anim_t.FL_width = lerp(anim_t.FL_width, 58, time_3)
            end
        else
            anim_t.scoped_x_name = lerp(anim_t.scoped_x_name, 0, time_7) 
            anim_t.scoped_alpha = lerp(anim_t.scoped_alpha, 0, time_6)
            anim_t.scoped_alpha_2 = lerp(anim_t.scoped_alpha_2, 0, time_6)
            anim_t.scoped_alpha255 = lerp(anim_t.scoped_alpha255, 0, time_6)
            anim_t.unscoped_alpha255 = lerp(anim_t.unscoped_alpha255, 255, time_6)
            anim_t.scoped_x_bar = lerp(anim_t.scoped_x_bar, 0, time_7)
            anim_t.KMH_width = lerp(anim_t.KMH_width, 1, time_4_5)
            anim_t.FL_width = lerp(anim_t.FL_width, 1, time_2_5)

        end
        if DT then
            anim_t.dt_alpha255 = lerp(anim_t.dt_alpha255, 255, time_6)
        else
            anim_t.dt_alpha255 = lerp(anim_t.dt_alpha255, 0, time_6)

        end

        -- local script_name = gradient_text(main_r, main_g, main_b, 255, second_r, second_g, second_b, global_alpha,
        --     "ihatesocial.")
        anim_t.Crosshair_offset_Y = lerp(anim_t.Crosshair_offset_Y, ui.get(uis.visual.Crosshair_offset_Y), time_5)
        if scoped and is_animation then
            anim_t.Crosshair_offset_X = lerp(anim_t.Crosshair_offset_X, ui.get(uis.visual.Crosshair_offset_X), time_7)
        else
            anim_t.Crosshair_offset_X = lerp(anim_t.Crosshair_offset_X, 0, time_7)
        end
        local x = center_X + anim_t.Crosshair_offset_X - 1
        local y = center_Y + 25 + math.floor(anim_t.Crosshair_offset_Y + 0.5)

        anim_t.exploit_a = 255
        if DT then
            anim_t.exploit_r = lerp(anim_t.exploit_r, exp_dt[1], time_8)
            anim_t.exploit_g = lerp(anim_t.exploit_g, exp_dt[2], time_8)
            anim_t.exploit_b = lerp(anim_t.exploit_b, exp_dt[3], time_8)
        elseif OS then
            anim_t.exploit_r = lerp(anim_t.exploit_r, exp_os[1], time_8)
            anim_t.exploit_g = lerp(anim_t.exploit_g, exp_os[2], time_8)
            anim_t.exploit_b = lerp(anim_t.exploit_b, exp_os[3], time_8)
        else
            anim_t.exploit_r = lerp(anim_t.exploit_r, exp_def[1], time_8)
            anim_t.exploit_g = lerp(anim_t.exploit_g, exp_def[2], time_8)
            anim_t.exploit_b = lerp(anim_t.exploit_b, exp_def[3], time_8)
        end
        if lua_name then
            anim_t.y1 = lerp(anim_t.y1, 9.1, time_8)
        else
            anim_t.y1 = lerp(anim_t.y1, 0, time_8)
        end
        if info then
            anim_t.y2 = lerp(anim_t.y2, 10.1, time_9)
        else
            anim_t.y2 = lerp(anim_t.y2, 0, time_8)
        end
        if not (bind_dt and DT) and not (bind_os and OS) and not (bind_ba and BA) and not (bind_sp and SP) then
            anim_t.atleast_1_keybind_to_1 = lerp(anim_t.atleast_1_keybind_to_1, 0, time_6)
        else
            anim_t.atleast_1_keybind_to_1 = lerp(anim_t.atleast_1_keybind_to_1, 100, time_7)
        end
        local atleast_1_keybind_to_1 = anim_t.atleast_1_keybind_to_1 / 100
        if bar then
            anim_t.y3 = lerp(anim_t.y3, 5, time_8)
        else
            anim_t.y3 = lerp(anim_t.y3, 0, time_8)
        end
        if bind_dt and DT then
            anim_t.y4 = lerp(anim_t.y4, 9.1, time_8)
        else
            anim_t.y4 = lerp(anim_t.y4, 0, time_8)
        end
        if bind_os and OS then
            anim_t.y5 = lerp(anim_t.y5, 9.1, time_8)
        else
            anim_t.y5 = lerp(anim_t.y5, 0, time_8)
        end
        if bind_ba and BA then
            anim_t.y6 = lerp(anim_t.y6, 9.1, time_8)
        else
            anim_t.y6 = lerp(anim_t.y6, 0, time_8)
        end
        if bind_sp and SP then
            anim_t.y7 = lerp(anim_t.y7, 9.1, time_8)
        else
            anim_t.y7 = lerp(anim_t.y7, 0, time_8)
        end
        local first_offset = anim_t.y1
        local second_offset = first_offset + anim_t.y2
        local thrid_offset = second_offset + anim_t.y3
        local fourth_offset = thrid_offset + anim_t.y4
        local fiveth_offset = fourth_offset + anim_t.y5
        local sixth_offset = fiveth_offset + anim_t.y6
        local seventh_offset = sixth_offset + anim_t.y7

        local r1 = exploit and anim_t.exploit_r or main_r
        local g1 = exploit and anim_t.exploit_g or main_g
        local b1 = exploit and anim_t.exploit_b or main_b
        local a1 = exploit and anim_t.exploit_a or main_a
        global_color[1] = exploit and anim_t.exploit_r or second_r
        global_color[2] = exploit and anim_t.exploit_g or second_g
        global_color[3] = exploit and anim_t.exploit_b or second_b
        global_color[4] = exploit and anim_t.exploit_a or second_a
        -- lua name
        if true then
            if lua_name then
                anim_t.logo_alpha_1 = lerp(anim_t.logo_alpha_1, 100, time_4_5)
            else
                anim_t.logo_alpha_1 = math.floor(lerp(anim_t.logo_alpha_1, 0, time_4_5))
            end
            local logo_alpha_100_to_1 = anim_t.logo_alpha_1 / 100
            local add_x_logo = anim_t.scoped_x_name + 2
            -- local script_name = gradient_text(r1, g1, b1, a1 * logo_alpha_100_to_1, global_color[1],
            --     global_color[2], global_color[3], global_color[4] * logo_alpha_100_to_1, "ihatesocial.")

            local mainc_to_hex = rgba_to_hex(r1, g1, b1, a1 * logo_alpha_100_to_1)
            local secondc_to_hex = rgba_to_hex(second_r, second_g, second_b, second_a * logo_alpha_100_to_1)
            local i = math.floor(globals.curtime() * 4.4 % 12) + 1
            local script_name = "\a" .. mainc_to_hex .. "Fsocie7y."
            -- CHANGE ME
            -- local script_name = gradient_text(r1, g1, b1, a1 * logo_alpha_100_to_1, r1, g1, b1,
            --     a1 * logo_alpha_100_to_1, "ihatesocial.")
            renderer.text(x + add_x_logo, y, 255, 255, 255, 255 * logo_alpha_100_to_1, "cb", 0, script_name)
        end

        -- info
        if true then
            if info then
                anim_t.info_alpha_1 = lerp(anim_t.info_alpha_1, 100, time_4_5)
            else
                anim_t.info_alpha_1 = math.floor(lerp(anim_t.info_alpha_1, 0, time_4_5))
            end
            local info_alpha_100_to_1 = anim_t.info_alpha_1 / 100
            local cpu = anim_t.scoped_alpha * info_alpha_100_to_1
            local cpu2 = y + anim_t.y1
            local cpu3 = anim_t.scoped_alpha_2 * info_alpha_100_to_1
            if DT or OS then
                anim_t.dt_or_os_to1 = math.floor(lerp(anim_t.dt_or_os_to1, 0, time_8))
            else
                anim_t.dt_or_os_to1 = lerp(anim_t.dt_or_os_to1, 100, time_8)
            end
            local dt_or_os_to1 = anim_t.dt_or_os_to1 / 100
            local add_x = bar and anim_t.scoped_x_bar * 1.2 or anim_t.scoped_x_bar * 1.145
            renderer.rectangle(x - 19 + add_x, cpu2 - 3, 44, 9, 16, 16, 16, anim_t.scoped_alpha255 * info_alpha_100_to_1)
            renderer.gradient(x - 18 + add_x, cpu2 - 1, vec_renderer, 5, r1, g1, b1,
                anim_t.scoped_alpha * info_alpha_100_to_1, second_r, second_g, second_b, cpu, true)
            local xyz = gradient_text(second_r, second_g, second_b, cpu, r1, g1, b1, cpu, vec .. " KM / H")
            renderer.text(x + 44 + add_x, cpu2 + 1, 255, 255, 255, 255 * info_alpha_100_to_1, "c-", anim_t.KMH_width,
                xyz)
            -- FAKELAG BAR
            renderer.gradient(x - 18 + add_x, cpu2 - 1, fl_to_renderer[real_fl], 5, r1, g1, b1, cpu3, second_r,
                second_g, second_b, cpu3, true)
            local fl_text = string.format('%i-%i-%i-%i-%i', toDraw4, toDraw3, toDraw2, toDraw1, toDraw0)
            renderer.text(x + add_x + 30, cpu2 - 4, r1, g1, b1, cpu3, "-", anim_t.FL_width, fl_text)

            -- [UNSCOPED] --

            -- PLAYER STATE
            local state_text = is_rage_mode and state_to_renderer[state] or "LEGIT"
            local f = {ui.get(uis.visual.State_Color)}
            local state_r = exploit and anim_t.exploit_r or f[1]
            local state_g = exploit and anim_t.exploit_g or f[2]
            local state_b = exploit and anim_t.exploit_b or f[3]
            local final_text = state_text
            local cpu4 = 255 * info_alpha_100_to_1
            local cpu5 = x + anim_t.scoped_x_bar
            local cpu6 = 10 * info_alpha_100_to_1
            -- local before_after_char_alpha = 
            local state_text_y = cpu2 + 1
            if state_text ~= nil and antiaim_enabled then
                if is_rage_mode then
                    if inverter_pos_vis == 2 then
                        final_text = "/" .. state_text .. "/"
                    elseif inverter_pos_vis == 1 then
                        final_text = "\\" .. state_text .. "\\"
                    end
                else
                    local aa = (entity.get_prop(localplayer, "m_flPoseParameter", 11) * 120 - 60)
                    local side = aa < -10 and 1 or (aa > 10 and 2 or 3)
                    if side == 1 then
                        final_text = "/" .. state_text .. "/"
                    elseif side == 2 then
                        final_text = "\\" .. state_text .. "\\"
                    else
                        final_text = "% " .. state_text .. " %"
                    end
                end

                local xaxaax = globals.frametime() * 45
                if is_rage_mode then
                    anim_t.state_alpha_basic = state_text == "BASIC" and
                                                   (math.min(anim_t.state_alpha_basic + xaxaax, 10)) or
                                                   (math.max(anim_t.state_alpha_basic - xaxaax, 0))
                    anim_t.state_alpha_stand = state_text == "STAND" and
                                                   (math.min(anim_t.state_alpha_stand + xaxaax, 10)) or
                                                   (math.max(anim_t.state_alpha_stand - xaxaax, 0))
                    anim_t.state_alpha_move =
                        state_text == "MOVE" and (math.min(anim_t.state_alpha_move + xaxaax, 10)) or
                            (math.max(anim_t.state_alpha_move - xaxaax, 0))
                    anim_t.state_alpha_slowwalk = state_text == "SLOWWALK" and
                                                      (math.min(anim_t.state_alpha_slowwalk + xaxaax, 10)) or
                                                      (math.max(anim_t.state_alpha_slowwalk - xaxaax, 0))
                    anim_t.state_alpha_ctcrouch = state_text == "CT-CROUCH" and
                                                      (math.min(anim_t.state_alpha_ctcrouch + xaxaax, 10)) or
                                                      (math.max(anim_t.state_alpha_ctcrouch - xaxaax, 0))
                    anim_t.state_alpha_tcrouch = state_text == "T-CROUCH" and
                                                     (math.min(anim_t.state_alpha_tcrouch + xaxaax, 10)) or
                                                     (math.max(anim_t.state_alpha_tcrouch - xaxaax, 0))
                    anim_t.state_alpha_air = state_text == "AIR" and (math.min(anim_t.state_alpha_air + xaxaax, 10)) or
                                                 (math.max(anim_t.state_alpha_air - xaxaax, 0))
                    anim_t.state_alpha_aircrouch = state_text == "AIR-CROUCH" and
                                                       (math.min(anim_t.state_alpha_aircrouch + xaxaax, 10)) or
                                                       (math.max(anim_t.state_alpha_aircrouch - xaxaax, 0))
                    anim_t.state_alpha_fakelag = state_text == "FAKELAG" and
                                                     (math.min(anim_t.state_alpha_fakelag + xaxaax, 10)) or
                                                     (math.max(anim_t.state_alpha_fakelag - xaxaax, 0))
                    if state_text == "BASIC" then
                        local a = cpu6 > 0 and math.min(anim_t.state_alpha_basic / cpu6, 1) or 0
                        renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                            gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * a, state_r, state_g,
                                state_b, anim_t.unscoped_alpha255 * a, final_text,
                                anim_t.unscoped_alpha255 * dt_or_os_to1 * a))
                    elseif state_text == "STAND" then
                        local a = cpu6 > 0 and math.min(anim_t.state_alpha_stand / cpu6, 1) or 0

                        renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                            gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * a, state_r, state_g,
                                state_b, anim_t.unscoped_alpha255 * a, final_text,
                                anim_t.unscoped_alpha255 * dt_or_os_to1 * a))
                    elseif state_text == "MOVE" then
                        local a = cpu6 > 0 and math.min(anim_t.state_alpha_move / cpu6, 1) or 0
                        renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                            gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * a, state_r, state_g,
                                state_b, anim_t.unscoped_alpha255 * a, final_text,
                                anim_t.unscoped_alpha255 * dt_or_os_to1 * a))
                    elseif state_text == "SLOWWALK" then
                        local a = cpu6 > 0 and math.min(anim_t.state_alpha_slowwalk / cpu6, 1) or 0
                        renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                            gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * a, state_r, state_g,
                                state_b, anim_t.unscoped_alpha255 * a, final_text,
                                anim_t.unscoped_alpha255 * dt_or_os_to1 * a))
                    elseif state_text == "CT-CROUCH" then
                        local a = cpu6 > 0 and math.min(anim_t.state_alpha_ctcrouch / cpu6, 1) or 0
                        renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                            gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * a, state_r, state_g,
                                state_b * info_alpha_100_to_1, anim_t.state_alpha_ctcrouch * a, final_text,
                                anim_t.unscoped_alpha255 * dt_or_os_to1 * a))
                    elseif state_text == "T-CROUCH" then
                        local a = cpu6 > 0 and math.min(anim_t.state_alpha_tcrouch / cpu6, 1) or 0
                        renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                            gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * a, state_r, state_g,
                                state_b, anim_t.unscoped_alpha255 * a, final_text,
                                anim_t.unscoped_alpha255 * dt_or_os_to1 * a))
                    elseif state_text == "AIR" then
                        local a = cpu6 > 0 and math.min(anim_t.state_alpha_air / cpu6, 1) or 0
                        renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                            gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * a, state_r, state_g,
                                state_b, anim_t.unscoped_alpha255 * a, final_text,
                                anim_t.unscoped_alpha255 * dt_or_os_to1 * a))
                    elseif state_text == "AIR-CROUCH" then
                        local a = cpu6 > 0 and math.min(anim_t.state_alpha_aircrouch / cpu6, 1) or 0
                        renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                            gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * a, state_r, state_g,
                                state_b, anim_t.unscoped_alpha255 * a, final_text,
                                anim_t.unscoped_alpha255 * dt_or_os_to1 * a))
                    elseif state_text == "FAKELAG" then
                        local a = cpu6 > 0 and math.min(anim_t.state_alpha_fakelag / cpu6, 1) or 0
                        renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                            gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * a, state_r, state_g,
                                state_b, anim_t.unscoped_alpha255 * a, final_text,
                                anim_t.unscoped_alpha255 * dt_or_os_to1 * a))
                    end
                elseif info then
                    renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                        gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255, state_r, state_g, state_b,
                            anim_t.unscoped_alpha255, final_text, anim_t.unscoped_alpha255))
                end

            else
                renderer.text(cpu5, state_text_y, 255, 255, 255, cpu4, "c-", 0,
                    gradient_text_2(state_r, state_g, state_b, anim_t.unscoped_alpha255 * info_alpha_100_to_1, state_r,
                        state_g, state_b, anim_t.unscoped_alpha255 * info_alpha_100_to_1, "ANTIAIM  NOT  ENABLED", 0))
            end
        end

        -- bar
        if true then
            if bar then
                anim_t.bar_alpha_1 = lerp(anim_t.bar_alpha_1, 100, time_4_5)
            else
                anim_t.bar_alpha_1 = math.floor(lerp(anim_t.bar_alpha_1, 0, time_4_5))
            end
            local bar_alpha_100_to_1 = anim_t.bar_alpha_1 / 100
            local clr = {ui.get(uis.visual.Gradient_Bar)}
            local bar_r = exploit and anim_t.exploit_r or clr[1]
            local bar_g = exploit and anim_t.exploit_g or clr[2]
            local bar_b = exploit and anim_t.exploit_b or clr[3]
            local bar_a = exploit and anim_t.exploit_a or clr[4]
            local a = scoped and 0 or clr[4]
            local cpu = x + (anim_t.scoped_x_bar) * 1.25 - 28
            local cpu2 = y + anim_t.y2 + first_offset - 1
            local cpu3 = bar_a * bar_alpha_100_to_1 * atleast_1_keybind_to_1
            renderer.gradient(cpu, cpu2, 60, 1, bar_r, bar_g, bar_b, cpu3, bar_r, bar_g, bar_b, cpu3, true)
            renderer.gradient(cpu, cpu2, 1, 10, bar_r, bar_g, bar_b, cpu3, bar_r, bar_g, bar_b, 0, false)
            renderer.gradient(cpu + 59, cpu2, 1, 10, bar_r, bar_g, bar_b, cpu3, bar_r, bar_g, bar_b, 0, false)
        end

        -- dt
        if true then
            if bind_dt then
                anim_t.dt_alpha_1 = lerp(anim_t.dt_alpha_1, 100, time_4_5)
            else
                anim_t.dt_alpha_1 = math.floor(lerp(anim_t.dt_alpha_1, 0, time_4_5))
            end
            local dt_alpha_100_to_1 = anim_t.dt_alpha_1 / 100
            local weapon = entity.get_prop(localplayer, "m_hActiveWeapon")
            local next_attack = entity.get_prop(localplayer, "m_flNextAttack") + 0.25
            local jewfag = entity.get_prop(weapon, "m_flNextPrimaryAttack")
            if jewfag ~= nil then
                local next_primary_attack = jewfag
                local nigaro
                if next_primary_attack - globals.curtime() < 0 and next_attack - globals.curtime() < 0 then
                    nigaro = 0
                else
                    nigaro = next_primary_attack - globals.curtime()
                end
                local jewjewjew = math.abs((nigaro * 10 / 7) - 1)
                local radius = jewjewjew / 0.8
                local is_drawing_radirus = jewjewjew == 1 and 1 or 255
                local dtcolor = {
                    notcharge = {
                        r = 255,
                        g = 0,
                        b = 0
                    },
                    charged = {ui.get(uis.visual.DT_Color)}
                }
                local is_charged
                local draw = false
                if doubletap_charged() then
                    if is_drawing_radirus == 255 and radius < 1.35 then
                        is_charged = false
                    else
                        is_charged = true
                    end
                else
                    if is_drawing_radirus == 255 and radius < 1.35 then
                        is_charged = false
                    else
                        is_charged = true
                    end
                    if radius < 1.35 then
                        draw = true
                    end
                end
                if is_charged then
                    anim_t.dtcolor_r = lerp(anim_t.dtcolor_r, dtcolor.charged[1], time_3_2)
                    anim_t.dtcolor_g = lerp(anim_t.dtcolor_g, dtcolor.charged[2], time_3_2)
                    anim_t.dtcolor_b = lerp(anim_t.dtcolor_b, dtcolor.charged[3], time_3_2)
                else
                    anim_t.dtcolor_r = lerp(anim_t.dtcolor_r, dtcolor.notcharge["r"], time_3_2)
                    anim_t.dtcolor_g = lerp(anim_t.dtcolor_g, dtcolor.notcharge["g"], time_3_2)
                    anim_t.dtcolor_b = lerp(anim_t.dtcolor_b, dtcolor.notcharge["b"], time_3_2)
                end
                if draw and jewjewjew ~= 1 and DT then
                    anim_t.draw_dtcircle = lerp(anim_t.draw_dtcircle, 255, time_4)
                else
                    anim_t.draw_dtcircle = lerp(anim_t.draw_dtcircle, 0, time_4)

                end
                if DT then
                    anim_t.dt_x_anim = lerp(anim_t.dt_x_anim, 0, time_7)
                else
                    anim_t.dt_x_anim = lerp(anim_t.dt_x_anim, -20, time_7)
                end
                local add_x = bar and anim_t.scoped_x_bar * 1.25 or anim_t.scoped_x_bar * 0.96
                local cpu = y + anim_t.y3 + second_offset
                local real_r = exploit and exp_dt[1] or anim_t.dtcolor_r
                local real_g = exploit and exp_dt[2] or anim_t.dtcolor_g
                local real_b = exploit and exp_dt[3] or anim_t.dtcolor_b

                if is_animation then
                    if scoped then
                        -- if bar and (anim_t.draw_dtcircle < 90) or (anim_t.draw_dtcircle < 90) then
                        --     anim_t.dt_circle_addx = lerp(anim_t.dt_circle_addx, 0, globals.frametime() * 10)
                        -- else
                        --     anim_t.dt_circle_addx = lerp(anim_t.dt_circle_addx, -4, time_9)
                        -- end
                        if bar then
                            if (anim_t.draw_dtcircle < 90) or (anim_t.draw_dtcircle < 90) then
                                anim_t.dt_circle_addx = lerp(anim_t.dt_circle_addx, 0, globals.frametime() * 10)
                                 else
                            anim_t.dt_circle_addx = lerp(anim_t.dt_circle_addx, -4, time_9)
                            end
                        else
                            anim_t.dt_circle_addx = lerp(anim_t.dt_circle_addx, -4, globals.frametime() * 10)
                        end
                    else
                        if bar and (anim_t.draw_dtcircle < 90) or (anim_t.draw_dtcircle < 90) then
                            anim_t.dt_circle_addx = lerp(anim_t.dt_circle_addx, 0, globals.frametime() * 10)
                        else
                            anim_t.dt_circle_addx = lerp(anim_t.dt_circle_addx, -4, time_9)
                        end
                    end

                else
                    if bar and (anim_t.draw_dtcircle < 90) or (anim_t.draw_dtcircle < 90) then
                        anim_t.dt_circle_addx = lerp(anim_t.dt_circle_addx, 0, globals.frametime() * 10)
                    else
                        anim_t.dt_circle_addx = lerp(anim_t.dt_circle_addx, -4, time_9)
                    end
                end

                renderer.text(math.floor(x + anim_t.dt_x_anim + anim_t.dt_circle_addx +0.5) + add_x, cpu, real_r,
                    real_g, real_b, anim_t.dt_alpha255 * dt_alpha_100_to_1, "c-", 0, "Double Tap")
                renderer.circle_outline(x + add_x + 18 + anim_t.dt_x_anim + math.floor(anim_t.dt_circle_addx + 0.5),
                    cpu + 1, 0, 0, 0, anim_t.draw_dtcircle, 4, 270, 5, 2)
                renderer.circle_outline(x + add_x + 18 + anim_t.dt_x_anim + math.floor(anim_t.dt_circle_addx + 0.5),
                    cpu + 1, real_r, real_g, real_b, anim_t.draw_dtcircle, 3, 270, radius, 1)

            end
        end

        -- os
        if true then
            if bind_os then
                anim_t.os_alpha_1 = lerp(anim_t.os_alpha_1, 100, time_4_5)
            else
                anim_t.os_alpha_1 = math.floor(lerp(anim_t.os_alpha_1, 0, time_4_5))
            end
            local os_alpha_100_to_1 = anim_t.os_alpha_1 / 100
            if OS then
                anim_t.os_alpha255 = lerp(anim_t.os_alpha255, 255, time_7)
                anim_t.os_x_anim = lerp(anim_t.os_x_anim, 0, time_7)
            else
                anim_t.os_alpha255 = lerp(anim_t.os_alpha255, 0, time_7)
                anim_t.os_x_anim = lerp(anim_t.os_x_anim, -20, time_7)
            end
            local os_clr = {ui.get(uis.visual.Onshot_Color)}
            local add_x = bar and (anim_t.scoped_x_bar) * 1.25 or (anim_t.scoped_x_bar) / 1.09
            local real_r = exploit and exp_os[1] or os_clr[1]
            local real_g = exploit and exp_os[2] or os_clr[2]
            local real_b = exploit and exp_os[3] or os_clr[3]
            renderer.text(x + add_x + anim_t.os_x_anim, y + anim_t.y4 + thrid_offset, real_r, real_g, real_b,
                anim_t.os_alpha255 * os_alpha_100_to_1, "c-", 0, "OS-AA")
        end

        -- baim
        if true then
            if bind_ba then
                anim_t.ba_alpha_1 = lerp(anim_t.ba_alpha_1, 100, time_4_5)
            else
                anim_t.ba_alpha_1 = math.floor(lerp(anim_t.ba_alpha_1, 0, time_4_5))
            end
            local ba_alpha_100_to_1 = anim_t.ba_alpha_1 / 100
            if BA then
                anim_t.ba_alpha255 = lerp(anim_t.ba_alpha255, 255, time_7)
                anim_t.ba_x_anim = lerp(anim_t.ba_x_anim, 0, time_7)
            else
                anim_t.ba_alpha255 = lerp(anim_t.ba_alpha255, 0, time_7)
                anim_t.ba_x_anim = lerp(anim_t.ba_x_anim, -20, time_7)
            end
            local ba_clr = {ui.get(uis.visual.BA_Color)}
            local add_x = bar and (anim_t.scoped_x_bar) * 1.25 or (anim_t.scoped_x_bar) * 0.87
            renderer.text(x + add_x + anim_t.ba_x_anim, y + anim_t.y5 + fourth_offset, ba_clr[1], ba_clr[2], ba_clr[3],
                anim_t.ba_alpha255 * ba_alpha_100_to_1, "c-", 0, "BODY")
        end

        -- sp
        if true then
            if bind_sp then
                anim_t.sp_alpha_1 = lerp(anim_t.sp_alpha_1, 100, time_4_5)
            else
                anim_t.sp_alpha_1 = math.floor(lerp(anim_t.sp_alpha_1, 0, time_4_5))
            end
            local sp_alpha_100_to_1 = anim_t.sp_alpha_1 / 100
            if SP then
                anim_t.sp_alpha255 = lerp(anim_t.sp_alpha255, 255, time_7)
                anim_t.sp_x_anim = lerp(anim_t.sp_x_anim, 0, time_7)
            else
                anim_t.sp_alpha255 = lerp(anim_t.sp_alpha255, 0, time_7)
                anim_t.sp_x_anim = lerp(anim_t.sp_x_anim, -20, time_7)
            end
            local sp_clr = {ui.get(uis.visual.SP_Color)}
            local add_x = bar and (anim_t.scoped_x_bar) * 1.25 or (anim_t.scoped_x_bar) * 0.87
            renderer.text(x + add_x + anim_t.sp_x_anim, y + anim_t.y6 + fiveth_offset, sp_clr[1], sp_clr[2], sp_clr[3],
                anim_t.sp_alpha255 * sp_alpha_100_to_1, "c-", 0, "SAFE")
        end
    end
end
local clantag_text = {"F", "Fs", "Fso", "Fsoc", "Fsoci", "Fsocie", "Fsocie7", "Fsocie7y",
                      "Fsocie7y.", "Fsocie7y.b", "Fsocie7y.be", "Fsocie7y.bet", "Fsocie7y.beta",
                      "Fsocie7y.beta ", "Fsocie7y.beta ", "Fsocie7y.beta ", "Fsocie7y.beta ",
                      "Fsocie7y.beta ", "Fsocie7y.beta ", "Fsocie7y.beta ", "Fsocie7y.beta ",
                      "Fsocie7y.beta ", "Fsocie7y.beta ", "Fsocie7y.beta ", "Fsocie7y.bet", "Fsocie7y.be",
                      "Fsocie7y.b", "Fsocie7y.", "Fsocie7y", "Fsocie7", "Fsocie", "Fsoci", "Fsoc",
                      "Fso", "Fs", "F", " ", " ", " ", " ", " ", " ", " "}
local disabe_clantag = 0
local function clantag()
    if includes(uis.misc.Functions, "Clantag") then
        -- GAMESENSE STYLE
        -- local clan_tag = gamesense_anim("Fsocie7y.beta",
        --     {0, 2, 3, 4, 5, 6, 8, 9, 10, 12, 13, 13, 14, 15, 15, 15, 15, 15, 15, 16, 17, 18, 19, 20, 21, 22, 24, 25, 27,
        --      28, 29, 30, 30, 30})
        -- if clan_tag ~= clan_tag_prev then
        --     client.set_clan_tag(clan_tag)
        -- end
        -- clan_tag_prev = clan_tag
        -- -- else
        -- --     client.set_clan_tag("")

        -- STYLE 2
        local i = math.floor(globals.curtime() * 4.7 % 47) + 1
        client.set_clan_tag(clantag_text[i])
        disabe_clantag = 0
    else
        if disabe_clantag < 1 then
            client.set_clan_tag("")
            disabe_clantag = disabe_clantag + 0.02
        end
    end
end
local function killsay(victim_userid, attacker_userid, e)
    if includes(uis.misc.Functions, "Killsay") then
        if victim_userid == nil or attacker_userid == nil then
            return
        end
        local victim_entindex = client.userid_to_entindex(victim_userid)
        local attacker_entindex = client.userid_to_entindex(attacker_userid)
        if attacker_entindex == localplayer and entity.is_enemy(victim_entindex) then
            local commanddelay = 'say ' .. killsay_delayed_table[math.random(num_quotes_delay)]
            if e.headshot then
                local commandhs = 'say ' .. killsay_hstable[math.random(num_quotes_hs)]
                client.delay_call(ui.get(uis.misc.Killsay_delay) + 0.1, client_exec, commandhs)
            else
                local commandbaim = 'say ' .. killsay_baimtable[math.random(num_quotes_baim)]
                client.delay_call(ui.get(uis.misc.Killsay_delay) + 0.1, client_exec, commandbaim)
            end
            client.delay_call(ui.get(uis.misc.Killsay_delay) + math.random(1, 2), client_exec, commanddelay)
        end
    end
end
ui.set(refs.aa_roll, 0)
local function shutdown()
    client.set_event_callback("setup_command", function(c)
        c.roll = 0
    end)
    ui.set(refs.aa_roll, 0)
    cvar.con_filter_enable:set_int(0)
    cvar.con_filter_text:set_string("")
    set_AA_menu_boolean(true)
    for i = 1, 10, 1 do
        client.set_clan_tag("")
    end

    if globals.mapname() == nil then 
        is_mm_state = 0
        return
    end
    local is_mm_value = ffi.cast("bool*", gamerules[0] + 124)
    if is_mm_value ~= nil then
        if is_mm_value[0] == false and is_mm_state == 1 then
            is_mm_value[0] = 1
            is_mm_state = 0
        end
    end
end
local function filter_console()
    if includes(uis.misc.Functions, "Filter Console (reload)") then
        cvar.developer:set_int(0)
        cvar.con_filter_enable:set_int(1)
        cvar.con_filter_text:set_string("IrWL5106TZZKNFPz4P4Gl3pSN?J370f5hi373ZjPg%VOVh6lN")
    else
        cvar.con_filter_enable:set_int(0)
        cvar.con_filter_text:set_string("")
    end
end
filter_console()
local function renderer_watermark(x, y, h, script, scriptlen, logo, user, userlen, steam_avatar, ping, pinglen, fps,
    fpslen, time, timelen, change_width)
    if logo == nil then
        return
    end
    local w = 208 + change_width
    renderer.circle(x, y + h / 2, 20, 20, 20, 255, h / 2, 180, 0.5)
    renderer.rectangle(x, y, w, h, 20, 20, 20, 255)
    renderer.circle(x + w, y + h / 2, 20, 20, 20, 255, h / 2, 0, 0.5)
    logo:draw(x, y + 2, h - 4, h - 4, 255, 255, 255, 255, true, "f")
    x = x + 33

    renderer.text(x + scriptlen / 2, y + 13, 255, 255, 255, 255, "cb", 0, script .. "\a9CEA4BFF [Beta]")
    x = x + scriptlen + 11
    renderer.line(x, y + 7, x, y + 19, 255, 255, 255, 80)
    x = x + 11
    steam_avatar:draw(x, y + 7, 14, 14, 255, 255, 255, 255, true, "f")
    x = x + 22
    renderer.text(x, y + 7, 217, 231, 255, 255, "b", 0, user)
    x = x + userlen + 10
    renderer.line(x, y + 7, x, y + 19, 255, 255, 255, 80)
    x = x + 10
    renderer.text(x, y + 7, 217, 231, 255, 255, "b", 0, ping)
    x = x + pinglen + 10
    renderer.line(x, y + 7, x, y + 19, 255, 255, 255, 80)
    x = x + 10
    renderer.text(x, y + 7, 217, 231, 255, 255, "b", 0, fps)
    x = x + fpslen + 10
    renderer.line(x, y + 7, x, y + 19, 255, 255, 255, 80)
    x = x + 10
    renderer.text(x, y + 7, 217, 231, 255, 255, "b", 0, time)
end
local function watermark(mainc, secondc)
    local steamid3 = entity.get_steam64(localplayer)
    local steam_avatar = images.get_steam_avatar(steamid3, 14, 14)
    if not includes(uis.visual.UIs, "Watermark") then
        return
    end
    -- local script = "Fsocie7y.beta"
    -- local scriptlen = renderer.measure_text("b", script)
    -- script =
    --     "\a93adffffA\a9daff4ffN\aa8b2e9ffT\ab3b5deffIS\abeb8d3ffO\ac9bbc8ffC\ad3bebdffIA\adec1b2ffL.C\af4c79cffL\affca91ffUB"
    local script = user .. " [beta]"
    local scriptlen = renderer.measure_text("b", script)
    -- script = gradient_text(mainc[1], mainc[2], mainc[3], mainc[4], secondc[1], secondc[2], secondc[3], secondc[4],
    -- user)
    script = "\affffffff" .. user
    local user = ui.get(uis.visual.Watermark_username_enable) and ui.get(uis.visual.Watermark_username) or
                     entity.get_player_name(localplayer)
    local userlen = renderer.measure_text("b", user)
    local ping = math.floor(math.min(1000, client.latency() * 1000)) .. " ms"
    local pinglen = renderer.measure_text("b", ping)
    local fps = AccumulateFps() .. " fps"
    local fpslen = renderer.measure_text("b", fps)
    local hours, minutes, seconds, milliseconds = client.system_time()
    hours, minutes, seconds = string.format("%02d", hours), string.format("%02d", minutes),
        string.format("%02d", seconds)
    local time = hours .. ":" .. minutes .. ":" .. seconds
    local timelen = renderer.measure_text("b", time)
    local change_width = userlen + pinglen + fpslen + timelen
    renderer_watermark(screen_X - 228 - change_width, 3, 28, script, scriptlen, logo_img, user, userlen, steam_avatar,
        ping, pinglen, fps, fpslen, time, timelen, change_width)
end

local is_inside = function(X, Y, x, y, w, h)
    return X >= x and X <= w and Y >= y and Y <= h
end
local pos = database.read("debug_pos") or {110, center_Y - 140}
local oX, oY, _d
local debug_x = pos[1]
local debug_y = pos[2]
local function Debug_panel(alpha255)
    if not includes(uis.visual.UIs, "Debug Panel") then
        return
    end
    local ismenuopen = ui.is_menu_open()
    if not ui.get(uis.visual.pos_lock) and ismenuopen and client.key_state(0x01) then
        local X, Y = ui.mouse_position()
        if not _d then
            local x_, w = debug_x - 20, debug_x + 300
            local y_, h = debug_y - 10, debug_y + 60
            if is_inside(X, Y, x_, y_, w, h) then
                oX, oY, _d = X - debug_x, Y - debug_y, true
            end
        else
            debug_x, debug_y = X - oX, Y - oY
        end
    else
        _d = false
    end
    renderer.line(debug_x - 20, debug_y - 10, debug_x - 20, debug_y + 60, 255, 255, 255, alpha255)
    renderer.line(debug_x + 300, debug_y - 10, debug_x + 300, debug_y + 60, 255, 255, 255, alpha255)
    renderer.line(debug_x - 20, debug_y - 10, debug_x + 300, debug_y - 10, 255, 255, 255, alpha255)
    renderer.line(debug_x - 20, debug_y + 60, debug_x + 300, debug_y + 60, 255, 255, 255, alpha255)
    if not antiaim_enabled then
        renderer.text(debug_x, debug_y, 255, 255, 255, 255, nil, 0, "\aFF4E4EFFANTIAIM NOT ENABLED !")
        return
    end
    -- print(gradient_text(147,173,255,255,255,202,145,255,"Fsocie7y.beta - build "..script_build .. " [beta]"))

    renderer.text(debug_x, debug_y, 255, 255, 255, 255, nil, 0, debugpanel_text)
    local inverter_state = "Off"
    if LEFT or RIGHT or FORWARD then
        inverter_state = LEFT and "  >  [Manual L] " or (RIGHT and "  >  [Manual R] " or "  >  [Manual F] ")
    else
        if inverter ~= nil and inverter then
            inverter_state = "  >  [L] "
        elseif inverter ~= nil and not inverter then
            inverter_state = "  >  [R] "
        end
    end
    local target = client.current_threat()
    local targetname = target ~= nil and entity.get_player_name(target) or "Searching"
    local FS_text = isfs and "\aC3FFCAFFFS\aC3FFCAFF" or "\aFFFFFF8DFS"
    local EY_text = isey and "  \aC3FFCAFFEY\aC3FFCAFF" or "  \aFFFFFF8DEY"
    local FL_off_text = isfl_off and "  \aC3FFCAFFFL_DISABLER\aFFFFFF8D" or "  \aFFFFFF8DFL_DISABLER"
    renderer.text(debug_x, debug_y + 12, 255, 255, 255, 255, nil, 0,
        "\aDDCDFFFF» Player states - [" .. state .. "]" .. inverter_state .. " Target: " .. targetname)
    renderer.text(debug_x, debug_y + 24, 255, 255, 255, 255, nil, 0,
        "\aC3FFCAFF» Functions states - " .. FS_text .. EY_text .. FL_off_text)
    renderer.text(debug_x, debug_y + 36, 255, 255, 255, 255, nil, 0,
        "\aC0EDFFFF» Antiaim values - Yaw add: " .. ui.get(refs.aa_yaw[2]))
    renderer.text(debug_x + 160, debug_y + 36, 255, 255, 255, 255, nil, 0,
        "\aC0EDFFFFYaw jitter: " .. ui.get(refs.aa_yawjitter[2]))
end
lua_info_pos = database.read("lua_info_pos") or {0, center_Y + 100}
lua_info_oX, lua_info_oY, lua_info_d = 0, 0, 0
lua_info_x = lua_info_pos[1]
lua_info_y = lua_info_pos[2]
local function lua_info(alpha255)
    if not includes(uis.visual.UIs, "Lua Info") then
        return
    end
    local ismenuopen = ui.is_menu_open()
    if not ui.get(uis.visual.pos_lock) and ismenuopen and client.key_state(0x01) then
        local lua_info_X, lua_info_Y = ui.mouse_position()
        if not lua_info_d then
            local lua_info_x_, lua_info_w = lua_info_x - 10, lua_info_x + 160
            local lua_info_y_, lua_info_h = lua_info_y - 10, lua_info_y + 30
            if is_inside(lua_info_X, lua_info_Y, lua_info_x_, lua_info_y_, lua_info_w, lua_info_h) then
                lua_info_oX, lua_info_oY, lua_info_d = lua_info_X - lua_info_x, lua_info_Y - lua_info_y, true
            end
        else
            lua_info_x, lua_info_y = lua_info_X - lua_info_oX, lua_info_Y - lua_info_oY
        end
    else
        lua_info_d = false
    end
    local steamid3 = entity.get_steam64(localplayer)
    local steam_avatar = images.get_steam_avatar(steamid3, 32, 48)
    -- if lua_info_img ~= nil then
    --     renderer.line(lua_info_x - 10, lua_info_y - 10, lua_info_x - 10, lua_info_y + 30, 255, 255, 255, alpha255)
    --     renderer.line(lua_info_x + 160, lua_info_y - 10, lua_info_x + 160, lua_info_y + 30, 255, 255, 255, alpha255)
    --     renderer.line(lua_info_x - 10, lua_info_y - 10, lua_info_x + 160, lua_info_y - 10, 255, 255, 255, alpha255)
    --     renderer.line(lua_info_x - 10, lua_info_y + 30, lua_info_x + 160, lua_info_y + 30, 255, 255, 255, alpha255)
    --     lua_info_img:draw(lua_info_x + 0, lua_info_y - 4, 32, 28, 255, 255, 255, 255, true, "f")
    --     renderer.text(lua_info_x + 33, lua_info_y - 3, 255, 255, 255, 255, nil, 0, "Fsocie7y.beta")
    --     renderer.text(lua_info_x + 33, lua_info_y + 10, 255, 255, 255, 255, nil, 0,
    --         "User: " .. user .. " \aB1FF27FF[beta]")
    -- end
    renderer.line(lua_info_x - 10, lua_info_y - 10, lua_info_x - 10, lua_info_y + 30, 255, 255, 255, alpha255)
    renderer.line(lua_info_x + 160, lua_info_y - 10, lua_info_x + 160, lua_info_y + 30, 255, 255, 255, alpha255)
    renderer.line(lua_info_x - 10, lua_info_y - 10, lua_info_x + 160, lua_info_y - 10, 255, 255, 255, alpha255)
    renderer.line(lua_info_x - 10, lua_info_y + 30, lua_info_x + 160, lua_info_y + 30, 255, 255, 255, alpha255)
    -- CHANGE ME
    steam_avatar:draw(lua_info_x + 0, lua_info_y - 4, 32, 28, 255, 255, 255, 255, true, "f")
    renderer.text(lua_info_x + 33, lua_info_y - 3, 255, 255, 255, 255, nil, 0, "Fsocie7y.beta")
    renderer.text(lua_info_x + 33, lua_info_y + 10, 255, 255, 255, 255, nil, 0, "User: " .. user .. " \aB1FF27FF[beta]")
end
local function draw_container2(x, y, w, h, perf)
    renderer.rectangle(x, y + 6, w, h, 10, 10, 10, perf)
    renderer.rectangle(x + 1, y + 7, w - 2, h - 2, 60, 60, 60, perf)
    renderer.rectangle(x + 2, y + 8, w - 4, h - 4, 40, 40, 40, perf)
    renderer.rectangle(x + 3, y + 9, w - 6, h - 6, 40, 40, 40, perf)
    renderer.rectangle(x + 4, y + 10, w - 8, h - 8, 40, 40, 40, perf)
    renderer.rectangle(x + 5, y + 11, w - 10, h - 10, 60, 60, 60, perf)
    renderer.rectangle(x + 6, y + 12, w - 12, h - 12, 20, 20, 20, perf)
    local half_w = w / 2
    local half_h = h / 2
    renderer.gradient(x + 6, y + 12, half_w - 6, 2, 59, 175, 222, perf, 202, 70, 205, perf, true)
    renderer.gradient(x + half_w, y + 12, half_w - 7, 2, 202, 70, 205, perf, 221, 227, 78, perf, true)
end
aimbot_stats_pos = database.read("aimbot_stats_pos") or {center_X, 100}
aimbot_stats_oX, aimbot_stats_oY, aimbot_stats_d = 0, 0, 0
aimbot_stats_x = aimbot_stats_pos[1]
aimbot_stats_y = aimbot_stats_pos[2]
local function Aimbot_stats(keydown, alpha255)
    if not includes(uis.visual.UIs, "Aimbot Stats") then
        return
    end
    local ismenuopen = ui.is_menu_open()
    if not ui.get(uis.visual.pos_lock) and ismenuopen and client.key_state(0x01) then
        local aimbot_stats_X, aimbot_stats_Y = ui.mouse_position()
        if not aimbot_stats_d then
            local aimbot_stats_x_, aimbot_stats_w = aimbot_stats_x - 200, aimbot_stats_x + 200
            local aimbot_stats_y_, aimbot_stats_h = aimbot_stats_y - 3, aimbot_stats_y + 86
            if is_inside(aimbot_stats_X, aimbot_stats_Y, aimbot_stats_x_, aimbot_stats_y_, aimbot_stats_w,
                aimbot_stats_h) then
                aimbot_stats_oX, aimbot_stats_oY, aimbot_stats_d = aimbot_stats_X - aimbot_stats_x,
                    aimbot_stats_Y - aimbot_stats_y, true
            end
        else
            aimbot_stats_x, aimbot_stats_y = aimbot_stats_X - aimbot_stats_oX, aimbot_stats_Y - aimbot_stats_oY
        end
    else
        aimbot_stats_d = false
    end
    renderer.line(aimbot_stats_x - 200, aimbot_stats_y - 3, aimbot_stats_x - 200, aimbot_stats_y + 86, 255, 255, 255,
        alpha255)
    renderer.line(aimbot_stats_x + 200, aimbot_stats_y - 3, aimbot_stats_x + 200, aimbot_stats_y + 86, 255, 255, 255,
        alpha255)
    renderer.line(aimbot_stats_x - 200, aimbot_stats_y - 3, aimbot_stats_x + 200, aimbot_stats_y - 3, 255, 255, 255,
        alpha255)
    renderer.line(aimbot_stats_x - 200, aimbot_stats_y + 86, aimbot_stats_x + 200, aimbot_stats_y + 86, 255, 255, 255,
        alpha255)
    if keydown or ismenuopen then
        draw_container2(aimbot_stats_x - 190, aimbot_stats_y, 380, 72, 255)
        renderer.text(aimbot_stats_x, aimbot_stats_y + 27, 255, 255, 255, 255, "bc+", nil,
            "\affffffff" .. aimbotstats.hit .. "            \aFF2020FF" .. aimbotstats.miss .. "\aFFFFFFFF            " ..
                aimbotstats.hitrate .. "%")
        renderer.text(aimbot_stats_x, aimbot_stats_y + 46, 255, 255, 255, 255, "c", nil,
            "\aFF5858FFHSRATE: " .. aimbotstats.hsrate .. "%  \aFFFFFF75|\aFFE664FF  SHOOT UNDER DAMAGE[98+]: " ..
                aimbotstats.underdmg)
        renderer.text(aimbot_stats_x, aimbot_stats_y + 61, 255, 255, 255, 255, "c", nil,
            "\aFFE97AFFSpread: " .. aimbotstats.spread .. "  \aFFFFFF75|\aFF5A5AFF  Prediction: " ..
                aimbotstats.prediction .. "  \aFFFFFF75|  \aFF0000FFResolver: " .. aimbotstats.resolver ..
                "  \aFFFFFF75|  \aFF0000FFUnregistered: " .. aimbotstats.unregistered ..
                "  \aFFFFFF75|  \aFF0000FFDeath: " .. aimbotstats.death)
    end
end
client.set_event_callback("shutdown", function()
    shutdown()
    database.write("WATERMARK_USERNAME", ui.get(uis.visual.Watermark_username))
    database.write("debug_pos", {debug_x, debug_y})
    database.write("lua_info_pos", {lua_info_x, lua_info_y})
    database.write("aimbot_stats_pos", {aimbot_stats_x, aimbot_stats_y})
    database.write("accent_color", {ui.get(uis.visual.Accent_Color)})
    database.write("second_color", {ui.get(uis.visual.Second_Color)})
end)
local function legit_indicator()
    local offset = ui.get(uis.aa.legit_inverter_indicator_offset)
    renderer.text(center_X + offset, center_Y - 2, 255, 255, 255, 30, 'c+', 0, '›')
    renderer.text(center_X - offset, center_Y - 2, 255, 255, 255, 30, 'c+', 0, '‹')
    local aa = (entity.get_prop(localplayer, "m_flPoseParameter", 11) * 120 - 60)
    local side = aa < -10 and 1 or (aa > 10 and 2 or 3)
    if side == 1 then
        renderer.text(center_X - offset, center_Y - 2, global_color[1], global_color[2], global_color[3],
           255, 'c+', 0, '‹')
    elseif side == 2 then
        renderer.text(center_X + offset, center_Y - 2, global_color[1], global_color[2], global_color[3],
        255, 'c+', 0, '›')
    end
end
client.set_event_callback('paint_ui', function(ctx)
    localplayer = entity.get_local_player()
    uis.aa.ui_handle(uis.aa)
    uis.visual.ui_handle(uis.visual)
    uis.misc.ui_handle(uis.misc)
    ui_handle()
    banner(ctx)
    if not loaded then
        return
    end

    local lua_enabled = ui.get(LUA_ENABLED)
    if not lua_enabled then
        return
    end
    clantag()
    local main_c = {ui.get(uis.visual.Accent_Color)}
    local second_c = {ui.get(uis.visual.Second_Color)}
    if not localplayer then
        return
    end
    local ismenuopen = ui.is_menu_open()
    if ismenuopen then
        anim_t.menu_open_255 = lerp(anim_t.menu_open_255, 255, globals.frametime() * 7)
    else
        anim_t.menu_open_255 = lerp(anim_t.menu_open_255, 0, globals.frametime() * 7)
    end
    watermark(main_c, second_c)
    Debug_panel(anim_t.menu_open_255)
    lua_info(anim_t.menu_open_255)
    Aimbot_stats(client.key_state(0x09), anim_t.menu_open_255)
    if not entity.is_alive(localplayer) or not lua_enabled then
        return
    end
    local inverter_pos_vis = entity.get_prop(localplayer, "m_flPoseParameter", 11) * 120 - 60
    inverter_pos_vis = (inverter_pos_vis > 0 and 1 or (inverter_pos_vis < 0 and 2 or 3))
    local localplayer_scoped = entity.get_prop(entity.get_player_weapon(localplayer), "m_zoomLevel")
    localplayer_scoped = localplayer_scoped == nil and 0 or localplayer_scoped
    crosshair_indicator(localplayer_scoped, main_c, second_c, inverter_pos_vis)
    if is_rage_mode then
        manual_indicator({ui.get(uis.visual.Manual_Color)}, localplayer_scoped)
    elseif ui.get(uis.aa.legit_inverter_indicator) then
        legit_indicator()
        manual_indicator({ui.get(uis.visual.Manual_Color)}, localplayer_scoped) --debug
    end
end)
-- 
local function legitfunc_in_air()
    if (bit.band(entity.get_prop(localplayer, "m_fFlags"), 1) == 0) then
        return true
    end
    if client.key_state(0x20) then
        return true
    end
    return false
end
local function legitfunc_oppositefix(cmd)
    if ui.get(uis.aa.legit_roll) then
        -- local weapon = csgo_weapons[entity.get_prop(entity.get_player_weapon(localplayer), "m_iItemDefinitionIndex")]
        -- local desync_amount = antiaim_funcs.get_desync(2)
        local qp = ui.get(refs.quickpeek[2])
        -- if weapon.type == "grenade" or legitfunc_in_air() or qp or desync_amount == nil then
        --     return
        -- end
        -- if (math.abs(cmd.forwardmove) > 1) or (math.abs(cmd.sidemove) > 1) or cmd.in_jump == 1 then
        --     return
        -- end
        if cmd.chokedcommands == 0 or (math.sqrt(math.pow(entity.get_prop(localplayer, "m_vecVelocity[0]"), 2) +
        math.pow(entity.get_prop(localplayer, "m_vecVelocity[1]"), 2)))>2 or qp  then
            return
        end
        cmd.forwardmove = 0.000000000000000000000000000000001
        cmd.in_forward = 1
    end
end
local function legit_func(c)
    local weapon = csgo_weapons[entity.get_prop(entity.get_player_weapon(localplayer), "m_iItemDefinitionIndex")]
    -- ladder
    if (entity.get_prop(entity.get_local_player(), "m_MoveType") or 0) == 9 then
        return
    end
    if weapon == nil or weapon.type == "grenade" then return end
    if ui.get(uis.aa.legit_roll) then
        legitfunc_oppositefix(c)
    end

    local pitch, yaw = client.camera_angles()
    -- inverter
    local body_side = ui.get(uis.aa.legit_inverter_key) and -63 or 63
    ui.set(refs.aa_freestanding[1], ui.get(uis.aa.legit_fs_key))
    --Desync builder
    if globals.chokedcommands() == 0 and c.in_attack ~= 1 then
        yaw = yaw - body_side
        c.allow_send_packet = false
    end


    local is_valve_ds = ffi.cast('bool*', gamerules[0] + 124) -- 猜测访问是否在服务器     休闲下这个值 不等于 nil      is_valve_ds[0] = 0 --可以把sk的限制设置为 服务器 0为服务器
    -- is_valve_ds[0] = 0
    if is_valve_ds ~= nil then
        if ui.get(uis.aa.legit_roll) then
            ui.set(refs.aa_roll, 0)
            c.roll = ui.get(uis.aa.legit_inverter_key) and -44 or 44
            if is_valve_ds[0] == true then
                is_valve_ds[0] = 0
                is_mm_state = 1
            end
        else
            if is_valve_ds[0] == false and is_mm_state == 1 then
                c.roll = 0
            end
        end
    end


    local inv_manual = ui.get(uis.aa.legit_inverter) == "Manual"
    if inv_manual then
        ui.set(uis.aa.legit_inverter_key, "Toggle")
        if ui.get(uis.aa.legit_inverter_key) then
            -- print("r")
            ui.set(refs.aa_pitch, "Off")
            ui.set(refs.aa_yawbase, "Local view")
            ui.set(refs.aa_yaw[1], "180")
            ui.set(refs.aa_yaw[2], 180)
            ui.set(refs.aa_yawjitter[1], "Off")
            ui.set(refs.aa_bodyyaw[1], "Static")
            ui.set(refs.aa_bodyyaw[2], 60)
            ui.set(refs.aa_freestandingbodyyaw, false)
        else
            -- print("l")
            ui.set(refs.aa_pitch, "Off")
            ui.set(refs.aa_yawbase, "Local view")
            ui.set(refs.aa_yaw[1], "180")
            ui.set(refs.aa_yaw[2], 180)
            ui.set(refs.aa_yawjitter[1], "Off")
            ui.set(refs.aa_bodyyaw[1], "Static")
            ui.set(refs.aa_bodyyaw[2], -60)
            ui.set(refs.aa_freestandingbodyyaw, false)
        end
    else

        ui.set(refs.aa_pitch, "Off")
        ui.set(refs.aa_yawbase, "Local view")
        ui.set(refs.aa_yaw[1], "180")
        ui.set(refs.aa_yaw[2], 180)
        ui.set(refs.aa_yawjitter[1], "Off")
        ui.set(refs.aa_bodyyaw[1], "Static")
        ui.set(refs.aa_bodyyaw[2], 60)
        ui.set(refs.aa_freestandingbodyyaw, true)
    end

    local include_Backward = includes(uis.aa.AA_Direction_tab, "Backward")
    bind_systeam:update(include_Backward)
    local include_Left = includes(uis.aa.AA_Direction_tab, "Left")
    local include_Right = includes(uis.aa.AA_Direction_tab, "Right")
    local include_Forward = includes(uis.aa.AA_Direction_tab, "Forward")
    if include_Backward or include_Left or include_Right or include_Forward then
        ui.set(uis.aa.Manual_Left, "On hotkey")
        ui.set(uis.aa.Manual_Right, "On hotkey")
        ui.set(uis.aa.Manual_Backward, "On hotkey")
        ui.set(uis.aa.Manual_Forward, "On hotkey")

        if not E_Key then
            if ui.get(manual_state) == 0 then
                FORWARD = false
                RIGHT = false
                LEFT = false
            end
            if ui.get(manual_state) == 1 and include_Left then
                LEFT = true
                RIGHT = false
                FORWARD = false
            elseif ui.get(manual_state) == 2 and include_Right then
                RIGHT = true
                LEFT = false
                FORWARD = false
            elseif ui.get(manual_state) == 3 and include_Backward then
                FORWARD = false
                RIGHT = false
                LEFT = false
            elseif ui.get(manual_state) == 4 and include_Forward then
                FORWARD = true
                RIGHT = false
                LEFT = false
            end
        end

    end

    -- MANUAL AA
    if LEFT then
        ui.set(refs.aa_yaw[2], -90)
    elseif RIGHT then
        ui.set(refs.aa_yaw[2], 90)
    elseif FORWARD then
        ui.set(refs.aa_yaw[2], 180)
    end




    c.yaw=yaw

end
client.set_event_callback("setup_command", function(c)
    if not loaded then
        return
    end
    local lua_enabled = ui.get(LUA_ENABLED)
    if not lua_enabled then
        return
    end
    if c.chokedcommands < real_fl then -- sent
        toDraw0 = toDraw1
        toDraw1 = toDraw2
        toDraw2 = toDraw3
        toDraw3 = toDraw4
        toDraw4 = real_fl
    end
    real_fl = c.chokedcommands
    antiaim_enabled = ui.get(uis.aa.Builder_Enable)
    if is_rage_mode then
        -- c.roll = 0
        ui.set(refs.aa_roll, 0)
        ui.set(refs.aa_edgeyaw, false)
        local is_warmup = entity.get_prop(entity.get_game_rules(), "m_bWarmupPeriod")
        local E_Key = client.key_state(0x45)
        local should_anti_knife = false
        local is_ey = true

        state = get_Player_State(c, uis.aa.Custom_AA)
        local alive = entity.is_alive(localplayer)
        local OK = lua_enabled and antiaim_enabled and alive
        if not OK then
            return
        end
        Fakelag_Breaker()
        Fakelag_Disablers()

        -- ANTIAIM MAIN FUNCTION
        inverter = (entity.get_prop(localplayer, "m_flPoseParameter", 11) * 120 - 60) > 0 and true or false
        local q = state_array[state]
        local Pitch = ui.get(uis.aa.Custom_AA[q].Pitch)
        local Yaw_base = ui.get(uis.aa.Custom_AA[q].Yaw_base)
        local aa_freestandingbodyyaw = ui.get(uis.aa.Custom_AA[q].aa_freestandingbodyyaw)
        local Yaw = ui.get(uis.aa.Custom_AA[q].Yaw)
        local Yaw_add_mode = ui.get(uis.aa.Custom_AA[q].Yaw_add_mode)
        local Yaw_add_left = ui.get(uis.aa.Custom_AA[q].Yaw_add_left)
        local Yaw_add_right = ui.get(uis.aa.Custom_AA[q].Yaw_add_right)
        local _cache_Yaw_jitter = ui.get(uis.aa.Custom_AA[q].Yaw_jitter)
        local Yaw_jitter_slider = ui.get(uis.aa.Custom_AA[q].Yaw_jitter_slider)
        local Yaw_jitter_slider_custom_1 = ui.get(uis.aa.Custom_AA[q].Yaw_jitter_slider_custom_1)
        local Yaw_jitter_slider_custom_2 = ui.get(uis.aa.Custom_AA[q].Yaw_jitter_slider_custom_2)
        local Yaw_bodyyaw = ui.get(uis.aa.Custom_AA[q].Yaw_bodyyaw)
        local Yaw_bodyyaw_slider = ui.get(uis.aa.Custom_AA[q].Yaw_bodyyaw_slider)
        local rage_roll = ui.get(uis.aa.Custom_AA[q].Roll_slider)
        local rage_roll_enable = ui.get(uis.aa.Custom_AA[q].Roll_Enable)
        local is_valve_ds = ffi.cast('bool*', gamerules[0] + 124)
        is_valve_ds[0] = 0
        if rage_roll_enable then
            c.roll = rage_roll
        end
        fakelag_limit = is_mm_state and 14 or 6
        ui.set(refs.aa_fl_limit, fakelag_limit)
        should_anti_knife = backstab()
        Pitch = should_anti_knife and "Off" or Pitch
        Yaw = should_anti_knife and "180" or Yaw
        Yaw_base = should_anti_knife and "At targets" or Yaw_base
        local Yawadd = should_anti_knife and 180 or (inverter and Yaw_add_left or Yaw_add_right)
        local Center_L_R = _cache_Yaw_jitter == "CenterB6B665FF [L/R]"
        local Center_Random = _cache_Yaw_jitter == "CenterB6B665FF [Random]"

        ui.set(refs.aa_freestandingbodyyaw, aa_freestandingbodyyaw)
        ui.set(refs.aa_pitch, Pitch)
        ui.set(refs.aa_yawbase, Yaw_base)
        ui.set(refs.aa_yaw[1], Yaw)
        if Yaw_add_mode == "[L/R]" then
            if c.chokedcommands == 0 then
                ui.set(refs.aa_yaw[2], Yawadd)
            end
        else
            local Yaw_add_left1 = ui.get(uis.aa.Custom_AA[q].Yaw_add_left_1)
            local Yaw_add_left2 = ui.get(uis.aa.Custom_AA[q].Yaw_add_left_2)
            local Yaw_add_right1 = ui.get(uis.aa.Custom_AA[q].Yaw_add_right_1)
            local Yaw_add_right2 = ui.get(uis.aa.Custom_AA[q].Yaw_add_right_2)
            Yawadd = should_anti_knife and 180 or
                         (inverter and math.random(Yaw_add_left1, Yaw_add_left2) or
                             math.random(Yaw_add_right1, Yaw_add_right2))
            if c.chokedcommands == 0 then
                ui.set(refs.aa_yaw[2], Yawadd)
            end
        end
        if not Center_L_R and not Center_Random then
            ui.set(refs.aa_yawjitter[1], _cache_Yaw_jitter)
            ui.set(refs.aa_yawjitter[2], Yaw_jitter_slider)
        else
            ui.set(refs.aa_yawjitter[1], "Center")
            if Center_L_R then
                ui.set(refs.aa_yawjitter[2], inverter and Yaw_jitter_slider_custom_1 or Yaw_jitter_slider_custom_2)
            elseif Center_Random then
                ui.set(refs.aa_yawjitter[2], math.random(Yaw_jitter_slider_custom_1, Yaw_jitter_slider_custom_2))
            end
        end
        ui.set(refs.aa_bodyyaw[1], Yaw_bodyyaw)
        ui.set(refs.aa_bodyyaw[2], Yaw_bodyyaw_slider)
        warmup_random_settings(c, is_warmup)
        local include_Backward = includes(uis.aa.AA_Direction_tab, "Backward")
        bind_systeam:update(include_Backward)
        local include_Left = includes(uis.aa.AA_Direction_tab, "Left")
        local include_Right = includes(uis.aa.AA_Direction_tab, "Right")
        local include_Forward = includes(uis.aa.AA_Direction_tab, "Forward")
        if include_Backward or include_Left or include_Right or include_Forward then
            ui.set(uis.aa.Manual_Left, "On hotkey")
            ui.set(uis.aa.Manual_Right, "On hotkey")
            ui.set(uis.aa.Manual_Backward, "On hotkey")
            ui.set(uis.aa.Manual_Forward, "On hotkey")

            if not E_Key then
                if ui.get(manual_state) == 0 then
                    FORWARD = false
                    RIGHT = false
                    LEFT = false
                end
                if ui.get(manual_state) == 1 and include_Left then
                    LEFT = true
                    RIGHT = false
                    FORWARD = false
                elseif ui.get(manual_state) == 2 and include_Right then
                    RIGHT = true
                    LEFT = false
                    FORWARD = false
                elseif ui.get(manual_state) == 3 and include_Backward then
                    FORWARD = false
                    RIGHT = false
                    LEFT = false
                elseif ui.get(manual_state) == 4 and include_Forward then
                    FORWARD = true
                    RIGHT = false
                    LEFT = false
                end
            end

        end
        
        -- MANUAL AA
        if LEFT then
            ui.set(refs.aa_pitch, Pitch)
            ui.set(refs.aa_yawbase, "Local view")
            ui.set(refs.aa_yaw[1], "180")
            ui.set(refs.aa_yaw[2], -90)
            ui.set(refs.aa_yawjitter[1], "Off")
            ui.set(refs.aa_bodyyaw[1], "Static")
            if ui.get(uis.aa.AA_Direction_mode_tab) == "Roll" then
                ui.set(refs.aa_bodyyaw[2], -180)
                c.roll = 44
            else
                ui.set(refs.aa_bodyyaw[2], 60)
                c.roll = 0
            end
        elseif RIGHT then
            ui.set(refs.aa_pitch, Pitch)
            ui.set(refs.aa_yawbase, "Local view")
            ui.set(refs.aa_yaw[1], "180")
            ui.set(refs.aa_yaw[2], 90)
            ui.set(refs.aa_yawjitter[1], "Off")
            ui.set(refs.aa_bodyyaw[1], "Static")
            if ui.get(uis.aa.AA_Direction_mode_tab) == "Roll" then
                ui.set(refs.aa_bodyyaw[2], -180)
                c.roll = 44
            else
                ui.set(refs.aa_bodyyaw[2], 60)
                c.roll = 0
            end
        elseif FORWARD then
            ui.set(refs.aa_pitch, Pitch)
            ui.set(refs.aa_yawbase, "Local view")
            ui.set(refs.aa_yaw[1], "180")
            ui.set(refs.aa_yaw[2], 180)
            ui.set(refs.aa_yawjitter[1], "Off")
            ui.set(refs.aa_bodyyaw[1], "Static")
            if ui.get(uis.aa.AA_Direction_mode_tab) == "Roll" then
                ui.set(refs.aa_bodyyaw[2], -180)
                c.roll = 44
            else
                ui.set(refs.aa_bodyyaw[2], 60)
                c.roll = 0
            end
        end
        -- EDGE / FS
        if includes(uis.aa.function_tab, "Disable FS/EY on Manual") then
            if (LEFT or RIGHT or FORWARD) then
                is_ey = false
            end
        end
        local is_fs = (is_ey and not should_anti_knife and not client.key_state(0x45)) and true or false
        if includes(uis.aa.function_tab, "Freestanding on Key") and ui.get(uis.aa.Freestanding) then
            ui.set(refs.aa_freestanding[1], is_fs)
        else
            ui.set(refs.aa_freestanding[1], false)
        end
        local FD = ui.get(refs.rage_fakeduck)
        if includes(uis.aa.function_tab, "Edge Yaw Settings") then
            if FD and includes(uis.aa.Edge_Yaw_Settings, "Edge Yaw on Fakeducking") then
                ui.set(refs.aa_edgeyaw, is_ey)
                isey = is_ey
            elseif includes(uis.aa.Edge_Yaw_Settings, "Edge Yaw on Key") and ui.get(uis.aa.Edge_Yaw_on_Key) then
                ui.set(refs.aa_edgeyaw, is_ey)
                isey = is_ey
            end
        else
            isey = false
        end

        -- LEGIT
        legit_aa(c, E_Key)
    else
        inverter = (entity.get_prop(localplayer, "m_flPoseParameter", 11) * 120 - 60) > 0 and true or false
        legit_func(c)
    end

    Exp_Settings()
end)
client.set_event_callback('pre_render', function()
    if not loaded then
        return
    end
    if not localplayer or not entity.is_alive(localplayer) then
        return
    end
    animation_breaker()
end)
client.set_event_callback("player_death", function(e)
    if not loaded then
        return
    end
    local victim_userid, attacker_userid = e.userid, e.attacker
    killsay(victim_userid, attacker_userid, e)
end)
local shot_id = 0
stored_shot = {
    before_hp = 0
}
client.set_event_callback("aim_fire", function(e)
    if not loaded then
        return
    end
    aimbotstats.total = aimbotstats.total + 1
    shot_id = shot_id + 1
    if shot_id > 20 then
        shot_id = 1
    end
    stored_shot = {
        wanted_hitchance = math.floor(e.hit_chance + 0.5),
        wanted_hitbox = hitgroup_names[e.hitgroup + 1] or "?",
        wanted_damage = e.damage,
        wanted_teleported = tostring(e.teleported),
        wanted_backtrack = (globals.tickcount() - e.tick),
        before_hp = entity.get_prop(e.target, "m_iHealth"),
        shot_id = tostring(shot_id)
    }
end)
client.set_event_callback('aim_hit', function(e)
    if not loaded then
        return
    end
    local damage = e.damage
    local enemy_health = stored_shot.before_hp - damage
    local cheatmindmg = ui.get(refs.rage_mindmg)
    aimbotstats.hit = aimbotstats.hit + 1
    local hitbox = hitgroup_names[e.hitgroup + 1] or "?"
    if cheatmindmg > 97 and enemy_health > 0 then
        aimbotstats.underdmg = aimbotstats.underdmg + 1
        if includes(uis.visual.Notifys, "Shoot Under Damage (98+)") then
            client.delay_call(0.2, function()
                _G.Notify_push:paint(5, "⚠ Shot under " .. tostring(cheatmindmg) .. " damage", true, "%s", 0, {
                    [0] = "⚠ Shot under " .. tostring(cheatmindmg) .. " damage"
                }, {
                    [0] = "FF0000"
                })
            end)
        end
    end
    if hitbox == "head" or hitbox == "neck" then
        aimbotstats.hs = aimbotstats.hs + 1
    end
    aimbotstats.hitrate = string.format("%.2f", (aimbotstats.hit / aimbotstats.total)) * 100
    aimbotstats.hsrate = string.format("%.2f", (aimbotstats.hs / aimbotstats.hit)) * 100
    if not includes(uis.visual.Notifys, "Aimbot Hit Logs") then
        return
    end
    local shotid = stored_shot.shot_id
    local target_id = e.target
    local target_name = entity.get_player_name(target_id)
    local hitchance = e.hit_chance

    local wanted_hitchance = stored_shot.wanted_hitchance
    local wanted_hitbox = stored_shot.wanted_hitbox
    local wanted_damage = stored_shot.wanted_damage
    local wanted_teleported = stored_shot.wanted_teleported
    local wanted_backtrack = stored_shot.wanted_backtrack

    local color = {ui.get(uis.visual.Aimbot_Logs_Hit_Color)}
    local hitcolor = rgb_to_hex(color[1], color[2], color[3])
    local rem_health_text = (enemy_health <= 0) and "dead" or enemy_health .. " remaining"
    local remainhpcalc = "(" .. rem_health_text .. ")"
    local text_for_calc =
        string.format("[%s] Hit %s's %s for %shp%s", shotid, target_name, hitbox, damage, remainhpcalc)
    _G.Notify_push:paint(5, text_for_calc, true, "%s%s%s %s %s%s%s", 6, {
        [0] = "[" .. shotid .. "] ",
        [1] = "Hit ",
        [2] = target_name .. "'s",
        [3] = hitbox,
        [4] = "for ",
        [5] = damage .. "hp",
        [6] = "(" .. rem_health_text .. ")"
        -- [7] = "[",
        -- [8] = wanted_hitbox,
        -- [9] = "(",
        -- [10] = wanted_hitchance .. "%",
        -- [11] = ") tp: " .. wanted_teleported,
        -- [12] = " bt: " .. tostring(wanted_backtrack) .. "]"
    }, {
        [0] = "ffffff",
        [1] = hitcolor,
        [2] = "ffffff",
        [3] = hitcolor,
        [4] = "ffffff",
        [5] = hitcolor,
        [6] = "ffffff"
        -- [7] = "ffffff",
        -- [8] = "FFF295",
        -- [9] = "ffffff",
        -- [10] = "FFF295",
        -- [11] = "ffffff",
        -- [12] = "ffffff"
    })
end)
client.set_event_callback('aim_miss', function(e)
    if not loaded then
        return
    end
    local reason
    aimbotstats.miss = aimbotstats.miss + 1
    if e.reason == "?" then
        aimbotstats.resolver = aimbotstats.resolver + 1
        reason = "resolver"
    else
        reason = e.reason
        if reason == "spread" then
            aimbotstats.spread = aimbotstats.spread + 1
        elseif reason == "prediction error" then
            aimbotstats.prediction = aimbotstats.prediction + 1
        elseif reason == "death" then
            aimbotstats.death = aimbotstats.death + 1
        else
            if includes(uis.visual.Notifys, "Missed due to Unregistered") then
                client.delay_call(0.2, function()
                    _G.Notify_push:paint(5, "⚠ Missed due to Unregistered", true, "%s", 0, {
                        [0] = "⚠ Missed due to Unregistered"
                    }, {
                        [0] = "FF0000"
                    })
                end)
            end
            aimbotstats.unregistered = aimbotstats.unregistered + 1
        end
    end
    aimbotstats.hitrate = string.format("%.2f", (aimbotstats.hit / aimbotstats.total)) * 100
    if not includes(uis.visual.Notifys, "Aimbot Miss Logs") then
        return
    end
    local hc = stored_shot.wanted_hitchance
    local shot_id = stored_shot.shot_id
    local target_name = entity.get_player_name(e.target)
    local hitbox = hitgroup_names[e.hitgroup + 1]
    local dmg = stored_shot.wanted_damage
    local bt = stored_shot.wanted_backtrack
    local tp = stored_shot.wanted_teleported
    local color = {ui.get(uis.visual.Aimbot_Logs_Miss_Color)}
    local misscolor = rgb_to_hex(color[1], color[2], color[3])
    local text_calc = string.format("[%s] Missed %s's %s due to %s [dmg: %s hc: %s tp: %s bt: %s]", shot_id,
        target_name, hitbox, reason, dmg, hc, tp, bt)
    _G.Notify_push:paint(5, text_calc, true, "%s %s %s %s%s%s%s%s%s%s%s%s%s%s", 13, {
        [0] = "[" .. shot_id .. "] ",
        [1] = "Missed",
        [2] = target_name .. "'s",
        [3] = hitbox,
        [4] = " due to ",
        [5] = reason,
        [6] = " [dmg: ",
        [7] = dmg,
        [8] = " hc: ",
        [9] = hc,
        [10] = " tp: ",
        [11] = tp,
        [12] = " bt: ",
        [13] = bt .. "]"

    }, {
        [0] = "ffffff",
        [1] = misscolor,
        [2] = "ffffff",
        [3] = misscolor,
        [4] = "ffffff",
        [5] = misscolor,
        [6] = "ffffff",
        [7] = "ffffff",
        [8] = "ffffff",
        [9] = "ffffff",
        [10] = "ffffff",
        [11] = "ffffff",
        [12] = "ffffff",
        [13] = "ffffff"

    })
end)
if database.read("WATERMARK_USERNAME") == nil then
    ui.set(uis.visual.Watermark_username, "")
else
    ui.set(uis.visual.Watermark_username, database.read("WATERMARK_USERNAME"))
end
local function check_modules()
    loaded = module_loadedimgs == 2
    if not loaded then
        client.delay_call(2, check_modules)
    else
        _G.Notify_push:paint(7, "All modules loaded successfully!", false)
    end
end
client.delay_call(2, check_modules)
_G.Notify_push:paint(5, "Welcome back, " .. user .. "! build: beta | update: " .. script_build, true, "%s%s%s%s%s", 4,
    {
        [0] = "Welcome back, ",
        [1] = user,
        [2] = "! build: ",
        [3] = "beta",
        [4] = " | update: " .. script_build
    }, {
        [0] = "ffffff",
        [1] = "EA0000",
        [2] = "ffffff",
        [3] = "B1FF27",
        [4] = "ffffff"
    })

client.set_event_callback("setup_command", function(cmd)
    pitchup_update()
end)

client.set_event_callback("paint", function()
    if not LUA_ENABLED then
        return
    end
    pitchup_indicator_paint()
end)