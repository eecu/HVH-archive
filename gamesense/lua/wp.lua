ui_reference = ui.reference
local o_ui_reference = ui.reference
ui.reference = function(tab, container, name)
  local matches = {
    ['slow motion type'] = { type = 'combobox', category = 'Other', values = { 'Favor high speed', 'Favor anti-aim' } },
    ['fake yaw limit'] = { type = 'slider', category = 'Other', min = -90, max = 90, default = 0, step = 1 },
    ['sv_maxusrcmdprocessticks'] = { type = 'slider', category = container, min = 0, max = 16, default = 15, step = 1 },
    ['sv_maxunlag'] = { type = 'slider', category = container, min = 0, max = 1, default = 0.2, step = 0.05 },
    ['anti-aim correction override'] = { type = 'combobox', category = 'Other', values = { 'Favor high speed', 'Favor anti-aim' } },
    
  }

  local match = matches[name:lower()]
  if match then
    local bypass
    if match.type == 'slider' then
      bypass = ui.new_slider(tab, match.category, name, match.min, match.max, match.default, false, '', match.step)
    else
      bypass = ui.new_combobox(tab, match.category, name, match.values)
    end
    ui.set_visible(bypass, false)
    return bypass
  end
  
  if name:lower() == 'double tap' 
  or name:lower() == 'double tap hit chance' 
  or name:lower() == 'quick stop' 
  or name:lower() == 'prefer body aim' 
  or name:lower() == 'prefer body aim disablers' 
  or name:lower() == 'double tap quick stop' 
  or name:lower() == 'double tap fake lag limit' 
  or name:lower() == 'force body aim' then

    
    return o_ui_reference(tab, 'Aimbot', name)
  elseif name:lower() == 'double tap mode' then
    return select(3, o_ui_reference(tab, 'Aimbot', 'Double tap'))
elseif name:lower() == 'quick stop options' then
    return select(2, o_ui_reference(tab, 'Aimbot', 'quick stop'))
  end

  if name:lower() == 'automatic fire' 
  or name:lower() == 'automatic penetration' 
  or name:lower() == 'silent aim' 
  or name:lower() == 'reduce aim step' 
  or name:lower() == 'maximum fov' 
  or name:lower() == 'log misses due to spread' 
  or name:lower() == 'low fps mitigations' 
  or name:lower() == 'automatic fire' 
  or name:lower() == 'automatic fire' 
  or name:lower() == 'automatic fire' 
  or name:lower() == 'automatic fire' 
  or name:lower() == 'automatic fire' 
  
  
  
  
  then
    return o_ui_reference(tab, 'Other', name)
end

  return o_ui_reference(tab, container, name)
end





local c_ui_reference = ui_reference
ui_reference = function(tab, container, name)
  local matches = {
    ['slow motion type'] = { type = 'combobox', category = 'Other', values = { 'Favor high speed', 'Favor anti-aim' } },
    ['fake yaw limit'] = { type = 'slider', category = 'Other', min = -90, max = 90, default = 0, step = 1 },
    ['sv_maxusrcmdprocessticks'] = { type = 'slider', category = container, min = 0, max = 16, default = 15, step = 1 },
    ['sv_maxunlag'] = { type = 'slider', category = container, min = 0, max = 1, default = 0.2, step = 0.05 },
    ['anti-aim correction override'] = { type = 'combobox', category = 'Other', values = { 'Favor high speed', 'Favor anti-aim' } },
    
  }

  local match = matches[name:lower()]
  if match then
    local bypass
    if match.type == 'slider' then
      bypass = ui.new_slider(tab, match.category, name, match.min, match.max, match.default, false, '', match.step)
    else
      bypass = ui.new_combobox(tab, match.category, name, match.values)
    end
    ui.set_visible(bypass, false)
    return bypass
  end
  
  if name:lower() == 'double tap' 
  or name:lower() == 'double tap hit chance' 
  or name:lower() == 'quick stop' 
  or name:lower() == 'prefer body aim' 
  or name:lower() == 'prefer body aim disablers' 
  or name:lower() == 'double tap quick stop' 
  or name:lower() == 'double tap fake lag limit' 
  or name:lower() == 'force body aim' then

    
    return c_ui_reference(tab, 'Aimbot', name)
  elseif name:lower() == 'double tap mode' then
    return select(3, c_ui_reference(tab, 'Aimbot', 'Double tap'))
elseif name:lower() == 'quick stop options' then
    return select(2, c_ui_reference(tab, 'Aimbot', 'quick stop'))
  end

  if name:lower() == 'automatic fire' 
  or name:lower() == 'automatic penetration' 
  or name:lower() == 'silent aim' 
  or name:lower() == 'reduce aim step' 
  or name:lower() == 'maximum fov' 
  or name:lower() == 'log misses due to spread' 
  or name:lower() == 'low fps mitigations' 
  or name:lower() == 'automatic fire' 
  or name:lower() == 'automatic fire' 
  or name:lower() == 'automatic fire' 
  or name:lower() == 'automatic fire' 
  or name:lower() == 'automatic fire' 
  
  
  
  
  then
    return c_ui_reference(tab, 'Other', name)
end

  return c_ui_reference(tab, container, name)
end










local a,
    b,
    c,
    d,
    e,
    f,
    g,
    h,
    i,
    j,
    k,
    l,
    m,
    n,
    o,
    p,
    q,
    r,
    s,
    t,
    u,
    v,
    w,
    x,
    y,
    z,
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    J,
    K,
    L,
    M,
    N,
    O,
    P,
    Q,
    R,
    S,
    setmetatable,
    pairs,
    error,
    T,
    U,
    V,
    W,
    X,
    Y,
    Z,
    type,
    pcall,
    _,
    a0,
    a1,
    a2,
    a3,
    tostring,
    a4,
    a5,
    a6,
    a7,
    a8,
    a9,
    aa,
    ab,
    ac,
    unpack,
    tonumber =
    bit.band,
    bit.lshift,
    client.color_log,
    client.create_interface,
    client.delay_call,
    client.find_signature,
    client.key_state,
    client.reload_active_scripts,
    client.screen_size,
    client.set_event_callback,
    client.system_time,
    client.timestamp,
    client.unset_event_callback,
    database.read,
    database.write,
    entity.get_classname,
    entity.get_local_player,
    entity.get_origin,
    entity.get_player_name,
    entity.get_prop,
    entity.get_steam64,
    entity.is_alive,
    globals.framecount,
    globals.realtime,
    math.ceil,
    math.floor,
    math.max,
    math.min,
    panorama.loadstring,
    renderer.gradient,
    renderer.line,
    renderer.rectangle,
    table.concat,
    table.insert,
    table.remove,
    table.sort,
    ui.get,
    ui.is_menu_open,
    ui.mouse_position,
    ui.new_checkbox,
    ui.new_color_picker,
    ui.new_combobox,
    ui.new_slider,
    ui.set,
    ui.set_visible,
    setmetatable,
    pairs,
    error,
    globals.absoluteframetime,
    globals.curtime,
    globals.frametime,
    globals.maxplayers,
    globals.tickcount,
    globals.tickinterval,
    math.abs,
    type,
    pcall,
    renderer.circle_outline,
    renderer.load_rgba,
    renderer.measure_text,
    renderer.text,
    renderer.texture,
    tostring,
    ui.name,
    ui.new_button,
    ui.new_hotkey,
    ui.new_label,
    ui.new_listbox,
    ui.new_textbox,
    ui.reference,
    ui.set_callback,
    ui.update,
    unpack,
    tonumber
local ad, ae, af, y, ag, ah, ai, unpack, tostring, pairs =
    client.register_esp_flag,
    client.visible,
    entity.hitbox_position,
    math.ceil,
    math.pow,
    math.sqrt,
    renderer.indicator,
    unpack,
    tostring,
    pairs
local a5, O, a7, aa, N, P, a6, aj, Q, R, K, ab, S =
    ui.new_button,
    ui.new_color_picker,
    ui.new_label,
    ui.reference,
    ui.new_checkbox,
    ui.new_combobox,
    ui.new_hotkey,
    ui.new_multiselect,
    ui.new_slider,
    ui.set,
    ui.get,
    ui.set_callback,
    ui.set_visible
local i, ak, al, c, j, m =
    client.screen_size,
    client.set_cvar,
    client.log,
    client.color_log,
    client.set_event_callback,
    client.unset_event_callback
local s, q, am, t, an, v =
    entity.get_player_name,
    entity.get_local_player,
    entity.get_player_weapon,
    entity.get_prop,
    entity.get_players,
    entity.is_alive
local X, U, x, V = globals.tickcount, globals.curtime, globals.realtime, globals.frametime
local ao, a2, F, D = renderer.triangle, renderer.text, renderer.rectangle, renderer.gradient
local ap = client.exec
local aq = {"RAGE", "Aimbot", "LUA", "B", "Other"}
local ar, as, at, au, av = {}, {}, {}, {}, {}
local aw = "-> "
local ax = 1
local ay =
    (function()
    local az = {
        callback_registered = false,
        maximum_count = 7,
        data = {},
        svg_texture = [[<svg xmlns="http://www.w3.org/2000/svg" width="30.093" height="28.944"><path fill-rule="evenodd" clip-rule="evenodd" fill="#FFF" d="M11.443,8.821c0.219,1.083,0.241,2.045,0.064,2.887 c-0.177,0.843-0.336,1.433-0.479,1.771c0.133-0.249,0.324-0.531,0.572-0.848c0.708-0.906,1.706-1.641,2.993-2.201 c0.661-0.29,1.171-0.501,1.527-0.635c1.144-0.434,1.763-0.995,1.859-1.687c0.082-0.563,0.043-1.144-0.118-1.74 c-0.155-0.586-0.193-1.108-0.117-1.567c0.099-0.591,0.483-1.083,1.153-1.478c0.258-0.152,0.51-0.269,0.757-0.35 c-0.037,0.022-0.114,0.263-0.229,0.722c-0.115,0.458-0.038,1.018,0.234,1.676c0.271,0.658,0.472,1.133,0.604,1.42 c0.132,0.29,0.241,0.853,0.324,1.689c0.084,0.838-0.127,1.822-0.629,2.952c-0.502,1.132-1.12,1.89-1.854,2.275 c-0.732,0.386-1.145,0.786-1.237,1.203c-0.092,0.419,0.087,0.755,0.535,1.013s0.927,0.282,1.436,0.074 c0.577-0.238,0.921-0.741,1.031-1.508c0.108-0.751,0.423-1.421,0.945-2.009c0.393-0.438,0.943-0.873,1.654-1.3 c0.24-0.143,0.532-0.285,0.879-0.43c0.192-0.078,0.47-0.191,0.835-0.338c0.622-0.276,1.075-0.65,1.358-1.123 c0.298-0.491,0.465-1.19,0.505-2.096c0.011-0.284,0.009-0.571-0.004-0.862c0.446,0.265,0.796,0.788,1.048,1.568 c0.251,0.782,0.32,1.457,0.206,2.025c-0.113,0.568-0.318,1.059-0.611,1.472c-0.295,0.412-0.695,0.901-1.201,1.469 c-0.519,0.578-0.864,0.985-1.04,1.222c-0.318,0.425-0.503,0.795-0.557,1.109c-0.044,0.269-0.05,0.763-0.016,1.481 c0.05,1.016,0.075,1.695,0.075,2.037c0,1.836-0.334,3.184-1.004,4.045c-0.874,1.123-1.731,1.902-2.568,2.336 c-0.955,0.49-2.228,0.736-3.813,0.736c-1.717,0-3.154-0.246-4.313-0.736c-1.237-0.525-2.083-1.303-2.541-2.336 c-0.394-0.885-0.668-1.938-0.827-3.158c-0.05-0.385-0.083-0.76-0.103-1.127c-0.49-0.092-0.916,0.209-1.278,0.904 c-0.36,0.693-0.522,1.348-0.484,1.957c0.039,0.611,0.246,1.471,0.625,2.578c0.131,0.449,0.185,0.801,0.161,1.051 c-0.031,0.311-0.184,0.521-0.456,0.631c-0.321,0.129-0.688,0.178-1.1,0.146c-0.463-0.037-0.902-0.174-1.319-0.41 c-1.062-0.604-1.706-1.781-1.937-3.531c-0.229-1.75-0.301-3.033-0.214-3.85c0.086-0.814,0.342-1.613,0.77-2.398 c0.428-0.783,0.832-1.344,1.213-1.681c0.382-0.338,0.893-0.712,1.532-1.122c0.64-0.408,1.108-0.745,1.405-1.008 c0.438-0.383,0.715-0.807,0.83-1.271C8.824,9.292,8.52,7.952,7.613,6.456C7.33,5.988,7.005,5.532,6.637,5.087 c0.837,0.111,1.791,0.49,2.865,1.138C10.576,6.872,11.223,7.737,11.443,8.821z"/></svg>]]
    }
    local aA = {w = 20, h = 20}
    local aB = renderer.load_svg(az.svg_texture, aA.w, aA.h)
    function az:register_callback()
        if self.callback_registered then
            return
        end
        j(
            "paint_ui",
            function()
                local aC = {i()}
                local aD = {15, 15, 15}
                local aE = 5
                local aF = self.data
                for aG = #aF, 1, -1 do
                    aF[aG].time = aF[aG].time - globals.frametime()
                    local aH, aI = 255, 0
                    local aJ = aF[aG]
                    if aJ.time < 0 then
                        table.remove(aF, aG)
                    else
                        local aK = aJ.def_time - aJ.time
                        local aK = aK > 1 and 1 or aK
                        if aJ.time < 0.5 or aK < 0.5 then
                            aI = (aK < 1 and aK or aJ.time) / 0.5
                            aH = aI * 255
                            if aI < 0.2 then
                                aE = aE + 15 * (1.0 - aI / 0.2)
                            end
                        end
                        local aL = {renderer.measure_text("dc", aJ.draw)}
                        local aM = {aC[1] / 2 - aL[1] / 2 + 3, aC[2] - aC[2] / 100 * 17.4 + aE}
                        renderer.rectangle(aM[1] - 30, aM[2] - 22, aL[1] + 60, 2, 255, 192, 203, aH)
                        renderer.rectangle(
                            aM[1] - 29,
                            aM[2] - 20,
                            aL[1] + 58,
                            29,
                            aD[1],
                            aD[2],
                            aD[3],
                            aH <= 135 and aH or 135
                        )
                        renderer.line(
                            aM[1] - 30,
                            aM[2] - 22,
                            aM[1] - 30,
                            aM[2] - 20 + 30,
                            83,
                            126,
                            242,
                            aH <= 50 and aH or 50
                        )
                        renderer.line(
                            aM[1] - 30 + aL[1] + 60,
                            aM[2] - 22,
                            aM[1] - 30 + aL[1] + 60,
                            aM[2] - 20 + 30,
                            83,
                            126,
                            242,
                            aH <= 50 and aH or 50
                        )
                        renderer.line(
                            aM[1] - 30,
                            aM[2] - 20 + 30,
                            aM[1] - 30 + aL[1] + 60,
                            aM[2] - 20 + 30,
                            83,
                            126,
                            242,
                            aH <= 50 and aH or 50
                        )
                        renderer.text(aM[1] + aL[1] / 2 + 10, aM[2] - 5, 255, 255, 255, aH, "dc", nil, aJ.draw)
                        renderer.texture(aB, aM[1] - aA.w / 2 - 5, aM[2] - aA.h / 2 - 5, aA.w, aA.h, 255, 255, 255, aH)
                        aE = aE - 50
                    end
                end
                self.callback_registered = true
            end
        )
    end
    function az:paint(aN, aO)
        local aP = tonumber(aN) + 1
        for aG = self.maximum_count, 2, -1 do
            self.data[aG] = self.data[aG - 1]
        end
        self.data[1] = {time = aP, def_time = aP, draw = aO}
        self:register_callback()
    end
    return az
end)()
local aQ = (function()
    local aA = {}
    local aB = function(aR, aS, aC, aD, aE, aF, aG, aH, aI)
        renderer.rectangle(aR + aE, aS, aC - aE * 2, aE, aF, aG, aH, aI)
        renderer.rectangle(aR, aS + aE, aE, aD - aE * 2, aF, aG, aH, aI)
        renderer.rectangle(aR + aE, aS + aD - aE, aC - aE * 2, aE, aF, aG, aH, aI)
        renderer.rectangle(aR + aC - aE, aS + aE, aE, aD - aE * 2, aF, aG, aH, aI)
        renderer.rectangle(aR + aE, aS + aE, aC - aE * 2, aD - aE * 2, aF, aG, aH, aI)
        renderer.circle(aR + aE, aS + aE, aF, aG, aH, aI, aE, 180, 0.25)
        renderer.circle(aR + aC - aE, aS + aE, aF, aG, aH, aI, aE, 90, 0.25)
        renderer.circle(aR + aE, aS + aD - aE, aF, aG, aH, aI, aE, 270, 0.25)
        renderer.circle(aR + aC - aE, aS + aD - aE, aF, aG, aH, aI, aE, 0, 0.25)
    end
    local aJ = 4
    local aK = aJ + 2
    local aL = 45
    local aM = 20
    local aN = function(aR, aS, aO, aP, aE, aF, aG, aH, aI)
        renderer.rectangle(aR + 2, aS + aE + aK, 1, aP - aK * 2 - aE * 2, aF, aG, aH, aI)
        renderer.rectangle(aR + aO - 3, aS + aE + aK, 1, aP - aK * 2 - aE * 2, aF, aG, aH, aI)
        renderer.rectangle(aR + aE + aK, aS + 2, aO - aK * 2 - aE * 2, 1, aF, aG, aH, aI)
        renderer.rectangle(aR + aE + aK, aS + aP - 3, aO - aK * 2 - aE * 2, 1, aF, aG, aH, aI)
        renderer.circle_outline(aR + aE + aK, aS + aE + aK, aF, aG, aH, aI, aE + aJ, 180, 0.25, 1)
        renderer.circle_outline(aR + aO - aE - aK, aS + aE + aK, aF, aG, aH, aI, aE + aJ, 270, 0.25, 1)
        renderer.circle_outline(aR + aE + aK, aS + aP - aE - aK, aF, aG, aH, aI, aE + aJ, 90, 0.25, 1)
        renderer.circle_outline(aR + aO - aE - aK, aS + aP - aE - aK, aF, aG, aH, aI, aE + aJ, 0, 0.25, 1)
    end
    local aT = function(aR, aS, aO, aP, aE, aF, aG, aH, aI, aU)
        local aL = aI / 255 * aL
        renderer.rectangle(aR + aE, aS, aO - aE * 2, 1, aF, aG, aH, aI)
        renderer.circle_outline(aR + aE, aS + aE, aF, aG, aH, aI, aE, 180, 0.25, 1)
        renderer.circle_outline(aR + aO - aE, aS + aE, aF, aG, aH, aI, aE, 270, 0.25, 1)
        renderer.gradient(aR, aS + aE, 1, aP - aE * 2, aF, aG, aH, aI, aF, aG, aH, aL, false)
        renderer.gradient(aR + aO - 1, aS + aE, 1, aP - aE * 2, aF, aG, aH, aI, aF, aG, aH, aL, false)
        renderer.circle_outline(aR + aE, aS + aP - aE, aF, aG, aH, aL, aE, 90, 0.25, 1)
        renderer.circle_outline(aR + aO - aE, aS + aP - aE, aF, aG, aH, aL, aE, 0, 0.25, 1)
        renderer.rectangle(aR + aE, aS + aP - 1, aO - aE * 2, 1, aF, aG, aH, aL)
        local aV = true
        if aV then
            for aE = 4, aU do
                local aE = aE / 2
                aN(aR - aE, aS - aE, aO + aE * 2, aP + aE * 2, aE, aF, aG, aH, aU - aE * 2)
            end
        end
    end
    local aW = function(aR, aS, aO, aP, aE, aF, aG, aH, aI, aU, aX, aY, aZ, a_)
        local aL = aI / 255 * aL
        renderer.rectangle(aR, aS + aE, 1, aP - aE * 2, aF, aG, aH, aI)
        renderer.circle_outline(aR + aE, aS + aE, aF, aG, aH, aI, aE, 180, 0.25, 1)
        renderer.circle_outline(aR + aE, aS + aP - aE, aF, aG, aH, aI, aE, 90, 0.25, 1)
        renderer.gradient(aR + aE, aS, aO / 3.5 - aE * 2, 1, aF, aG, aH, aI, 0, 0, 0, aL / 0, true)
        renderer.gradient(aR + aE, aS + aP - 1, aO / 3.5 - aE * 2, 1, aF, aG, aH, aI, 0, 0, 0, aL / 0, true)
        renderer.rectangle(aR + aE, aS + aP - 1, aO - aE * 2, 1, aX, aY, aZ, aL)
        renderer.rectangle(aR + aE, aS, aO - aE * 2, 1, aX, aY, aZ, aL)
        renderer.circle_outline(aR + aO - aE, aS + aE, aX, aY, aZ, aL, aE, -90, 0.25, 1)
        renderer.circle_outline(aR + aO - aE, aS + aP - aE, aX, aY, aZ, aL, aE, 0, 0.25, 1)
        renderer.rectangle(aR + aO - 1, aS + aE, 1, aP - aE * 2, aX, aY, aZ, aL)
        if a_ then
            for aE = 4, aU do
                local aE = aE / 2
                aN(aR - aE, aS - aE, aO + aE * 2, aP + aE * 2, aE, aX, aY, aZ, aU - aE * 2)
            end
        end
    end
    local b0 = function(aR, aS, aO, aP, aE, aF, aG, aH, aI, aU, aX, aY, aZ)
        local aL = aI / 255 * aL
        renderer.rectangle(aR + aE, aS, aO - aE * 2, 1, aF, aG, aH, aL)
        renderer.circle_outline(aR + aE, aS + aE, aF, aG, aH, aL, aE, 180, 0.25, 1)
        renderer.circle_outline(aR + aO - aE, aS + aE, aF, aG, aH, aL, aE, 270, 0.25, 1)
        renderer.rectangle(aR, aS + aE, 1, aP - aE * 2, aF, aG, aH, aL)
        renderer.rectangle(aR + aO - 1, aS + aE, 1, aP - aE * 2, aF, aG, aH, aL)
        renderer.circle_outline(aR + aE, aS + aP - aE, aF, aG, aH, aL, aE, 90, 0.25, 1)
        renderer.circle_outline(aR + aO - aE, aS + aP - aE, aF, aG, aH, aL, aE, 0, 0.25, 1)
        renderer.rectangle(aR + aE, aS + aP - 1, aO - aE * 2, 1, aF, aG, aH, aL)
        if K(config.glow_enabled) then
            for aE = 4, aU do
                local aE = aE / 2
                aN(aR - aE, aS - aE, aO + aE * 2, aP + aE * 2, aE, aX, aY, aZ, aU - aE * 2)
            end
        end
    end
    aA.linear_interpolation = function(b1, b2, b3)
        return (b2 - b1) * b3 + b1
    end
    aA.clamp = function(b4, b5, b6)
        if b5 > b6 then
            return math.min(math.max(b4, b6), b5)
        else
            return math.min(math.max(b4, b5), b6)
        end
    end
    aA.lerp = function(b1, b2, b3)
        b3 = b3 or 0.005
        b3 = aA.clamp(globals.frametime() * b3 * 175.0, 0.01, 1.0)
        local aI = aA.linear_interpolation(b1, b2, b3)
        if b2 == 0.0 and aI < 0.01 and aI > -0.01 then
            aI = 0.0
        elseif b2 == 1.0 and aI < 1.01 and aI > 0.99 then
            aI = 1.0
        end
        return aI
    end
    aA.container = function(aR, aS, aO, aP, aF, aG, aH, aI, b7, b8, b9, ba, bb, bc)
        if b7 * 255 > 0 then
            renderer.blur(aR, aS, aO, aP)
        end
        aB(aR, aS, aO, aP, aJ, b8, b9, ba, bb)
        aT(aR, aS, aO, aP, aJ, aF, aG, aH, aI, b7 * aM)
        if not bc then
            return
        end
        bc(aR + aJ, aS + aJ, aO - aJ * 2, aP - aJ * 2.0)
    end
    aA.horizontal_container = function(aR, aS, aO, aP, aF, aG, aH, aI, b7, aX, aY, aZ, bc)
        if b7 * 255 > 0 then
            renderer.blur(aR, aS, aO, aP)
        end
        aB(aR, aS, aO, aP, aJ, 17, 17, 17, aI)
        aW(aR, aS, aO, aP, aJ, aF, aG, aH, b7 * 255, b7 * aM, aX, aY, aZ)
        if not bc then
            return
        end
        bc(aR + aJ, aS + aJ, aO - aJ * 2, aP - aJ * 2.0)
    end
    aA.container_glow = function(aR, aS, aO, aP, aF, aG, aH, aI, b7, aX, aY, aZ, bc)
        if b7 * 255 > 0 then
            renderer.blur(aR, aS, aO, aP)
        end
        aB(aR, aS, aO, aP, aJ, 17, 17, 17, aI)
        b0(aR, aS, aO, aP, aJ, aF, aG, aH, b7 * 255, b7 * aM, aX, aY, aZ)
        if not bc then
            return
        end
        bc(aR + aJ, aS + aJ, aO - aJ * 2, aP - aJ * 2.0)
    end
    aA.measure_multitext = function(bd, be)
        local aI = 0
        for aH, bf in pairs(be) do
            bf.flags = bf.flags or ""
            aI = aI + renderer.measure_text(bf.flags, bf.text)
        end
        return aI
    end
    aA.multitext = function(aR, aS, be)
        for aI, aH in pairs(be) do
            aH.flags = aH.flags or ""
            aH.limit = aH.limit or 0
            aH.color = aH.color or {255, 255, 255, 255}
            aH.color[4] = aH.color[4] or 255
            renderer.text(aR, aS, aH.color[1], aH.color[2], aH.color[3], aH.color[4], aH.flags, aH.limit, aH.text)
            aR = aR + renderer.measure_text(aH.flags, aH.text)
        end
    end
    return aA
end)()
local bg = function(aA, aB, aC)
    return (function()
        local aD = {}
        local aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO, aP, aT, aU
        local aV = {__index = {drag = function(self, ...)
                    local aW, aX = self:get()
                    local aY, aR, aP = aD.drag(aW, aX, ...)
                    if aW ~= aY or aX ~= aR then
                        self:set(aY, aR)
                    end
                    return aY, aR, aP
                end, status = function(self, ...)
                    local aY, aR = self:get()
                    local aS, aZ = aD.status(aY, aR, ...)
                    return aS
                end, set = function(self, aW, aX)
                    local aM, aN = i()
                    R(self.x_reference, aW / aM * self.res)
                    R(self.y_reference, aX / aN * self.res)
                end, get = function(self)
                    local aM, aN = i()
                    return K(self.x_reference) / self.res * aM, K(self.y_reference) / self.res * aN
                end}}
        function aD.new(aS, aZ, a_, b0)
            b0 = b0 or 10000
            local aM, aN = i()
            local b1 = Q("LUA", "A", aS .. " window position", 0, b0, aZ / aM * b0)
            local b2 = Q("LUA", "A", "\n" .. aS .. " window position y", 0, b0, a_ / aN * b0)
            S(b1, false)
            S(b2, false)
            return setmetatable({name = aS, x_reference = b1, y_reference = b2, res = b0}, aV)
        end
        function aD.drag(aW, aX, b3, b4, b5, b6, b7)
            local aV = "n"
            if w() ~= aE then
                aF = L()
                aI, aJ = aG, aH
                aG, aH = M()
                aL = aK
                aK = g(0x01) == true
                aP = aO
                aO = {}
                aU = aT
                aT = false
                aM, aN = i()
            end
            if aF and aL ~= nil then
                if (not aL or aU) and aK and aI > aW and aJ > aX and aI < aW + b3 and aJ < aX + b4 then
                    aT = true
                    aW, aX = aW + aG - aI, aX + aH - aJ
                    if not b6 then
                        aW = A(0, B(aM - b3, aW))
                        aX = A(0, B(aN - b4, aX))
                    end
                end
            end
            if aF and aL ~= nil then
                if aI > aW and aJ > aX and aI < aW + b3 and aJ < aX + b4 then
                    if aK then
                        aV = "c"
                    else
                        aV = "o"
                    end
                end
            end
            H(aO, {aW, aX, b3, b4})
            return aW, aX, aV, b3, b4
        end
        function aD.status(aW, aX, b3, b4, b5, b6, b7)
            if w() ~= aE then
                aF = L()
                aI, aJ = aG, aH
                aG, aH = M()
                aL = aK
                aK = true
                aP = aO
                aO = {}
                aU = aT
                aT = false
                aM, aN = i()
            end
            if aF and aL ~= nil then
                if aI > aW and aJ > aX and aI < aW + b3 and aJ < aX + b4 then
                    return true
                end
            end
            return false
        end
        return aD
    end)().new(aA, aB, aC)
end
local function bh(bi, bj, bk)
    return bi + (bj - bi) * bk
end
local bl = function(aR, aS, aY, aG, aV, aT, aF, aA, az)
    renderer.rectangle(aR, aS, aY, aV, aT, aF, aA, az)
    renderer.rectangle(aR, aS, aV, aG, aT, aF, aA, az)
    renderer.rectangle(aR, aS + aG - aV, aY, aV, aT, aF, aA, az)
    renderer.rectangle(aR + aY - aV, aS, aV, aG, aT, aF, aA, az)
end
local bm = {
    weapons = {"Global", "Taser", "Revolver", "Pistol", "Auto", "Scout", "AWP", "Rifle", "SMG", "Shotgun", "Deagle"},
    menu_index = {
        "In-Built Weapon",
        "Global",
        "Taser",
        "Revolver",
        "Pistol",
        "Auto",
        "Scout",
        "AWP",
        "Rifle",
        "SMG",
        "Shotgun",
        "Deagle"
    },
    index_wpn = {
        [1] = 11,
        [2] = 4,
        [3] = 4,
        [4] = 4,
        [7] = 8,
        [8] = 8,
        [9] = 7,
        [10] = 8,
        [11] = 5,
        [13] = 8,
        [14] = 8,
        [16] = 8,
        [17] = 9,
        [19] = 9,
        [23] = 9,
        [24] = 9,
        [25] = 10,
        [26] = 9,
        [27] = 10,
        [28] = 8,
        [29] = 10,
        [30] = 4,
        [31] = 2,
        [32] = 4,
        [33] = 9,
        [34] = 9,
        [35] = 10,
        [36] = 4,
        [38] = 5,
        [39] = 8,
        [40] = 6,
        [60] = 8,
        [61] = 4,
        [63] = 4,
        [64] = 3,
        [0] = 1
    },
    index_dmg = {
        [0] = "Auto",
        [101] = "HP + 1",
        [102] = "HP + 2",
        [103] = "HP + 3",
        [104] = "HP + 4",
        [105] = "HP + 5",
        [106] = "HP + 6",
        [107] = "HP + 7",
        [108] = "HP + 8",
        [109] = "HP + 9",
        [110] = "HP + 10",
        [111] = "HP + 11",
        [112] = "HP + 12",
        [113] = "HP + 13",
        [114] = "HP + 14",
        [115] = "HP + 15",
        [116] = "HP + 16",
        [117] = "HP + 17",
        [118] = "HP + 18",
        [119] = "HP + 19",
        [120] = "HP + 20",
        [121] = "HP + 21",
        [122] = "HP + 22",
        [123] = "HP + 23",
        [124] = "HP + 24",
        [125] = "HP + 25",
        [126] = "HP + 26"
    },
    quickstop = {"Early", "Slow motion", "Duck", "Fake duck", "Move between shots", "Ignore molotov", "Taser"},
    preferbaim = {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot"},
    hitgroup = {"Head", "Chest", "Arms", "Stomach", "Legs", "Feet"},
    backtrack = {"Low", "Medium", "High", "Maximum"}
}
local bn = function(ax, type)
    local bo = "\aFFC0CBFF"
    if type == nil then
        return bo .. bm.weapons[ax] .. ": \affffffff"
    end
    if ax == nil then
        return bo .. type .. ": \affffffff"
    end
    if type == "Hide" then
        return "\n" .. bm.weapons[ax] .. "\n\ae09db6ff" .. type .. ": \affffffff"
    end
    return bo .. type .. ": \affffffff\n" .. bm.weapons[ax]
end
local bp = function(ax)
    return "\n" .. bm.weapons[ax]
end
local bq = {
    get_weapon = function()
        local br = entity.get_local_player()
        local bs = am(br)
        local bt = t(bs, "m_iItemDefinitionIndex")
        local bm = bm.index_wpn[bt]
        if bm == nil then
            return 1
        end
        return bm
    end,
    is_key_down = function(bu)
        return K(bu)
    end,
    is_in_air = function()
        return bit.band(t(q(), "m_fFlags"), 1) == 0
    end,
    is_double_tapping = function()
        local bv = {ui.reference("RAGE", "Other", "Double Tap")}
        return K(bv[2])
    end,
    is_scoped = function()
        local bw = t(am(q()), "m_zoomLevel")
        if bw == nil then
            bw = 0
        end
        return bw >= 1
    end,
    contains = function(table, bx)
        if #table > 0 then
            for aH = 1, #table do
                if table[aH] == bx then
                    return true
                end
            end
        end
        return false
    end,
    enemy_visible = function()
        for aH = 0, 8 do
            local by = client.current_threat()
            local bz, bA, bB = af(by, aH)
            if ae(bz, bA, bB) then
                return true
            end
        end
        return false
    end,
    replace = function(bC, bD)
        R(bC, bD)
    end,
    fill_table = function(bE, bD)
        if #K(bE) == 0 then
            R(bE, bD)
        end
    end,
    config_export = function()
        local bF = {}
        local bG = require("gamesense/clipboard")
        local bH = require("gamesense/base64")
        for bI, bJ in pairs(bm.weapons) do
            bF[tostring(bJ)] = {}
            for aJ, aX in pairs(ar[bI]) do
                bF[bJ][aJ] = K(aX)
            end
        end
        bG.set(bH.encode(json.stringify(bF)))
        ay:paint(4, "[Config] Exported from clipborad!")
    end,
    config_import = function()
        local bG = require("gamesense/clipboard")
        local bH = require("gamesense/base64")
        if bG.get() == nil then
            ay:paint(4, "Importation failure")
            return
        end
        local bF = json.parse(bH.decode(bG.get()))
        for bI, bJ in pairs(bm.weapons) do
            for aJ, aX in pairs(ar[bI]) do
                local bK = bF[bJ][aJ]
                if bK ~= nil then
                    R(aX, bK)
                end
            end
        end
        ay:paint(4, "[Config] Imported from clipborad!")
    end,
    config_download = function()
        local bL = require "gamesense/http"
        local bH = require("gamesense/base64")
        bL.get(
            "https://raw.githubusercontent.com/MLCluanchar/config/main/config.txt",
            function(bM, bN)
                if not bM or bN.status ~= 200 then
                    ay:paint(4, "[Config] Connection Failure")
                end
                local bF = json.parse(bH.decode(bN.body))
                for bI, bJ in pairs(bm.weapons) do
                    for aJ, aX in pairs(ar[bI]) do
                        print(ar[bI])
                        local bK = bF[bJ][aJ]
                        if bK ~= nil then
                            R(aX, bK)
                        end
                    end
                end
                ay:paint(4, "[Config] Downloaded Config from Server!")
            end
        )
    end
}
local bO = {
    target_selection = aa(aq[1], aq[2], "Target selection"),
    target_hitbox = aa(aq[1], aq[2], "Target hitbox"),
    multipoint = aa(aq[1], aq[2], "Multi-point"),
    multipoint_scale = aa(aq[1], aq[2], "Multi-point scale"),
    prefer_safe_point = aa(aq[1], aq[2], "Prefer safe point"),
    force_safepoint = aa(aq[1], aq[2], "Force safe point"),
    unsafe = aa(aq[1], aq[2], "Avoid unsafe hitboxes"),
    automatic_fire = aa(aq[1], aq[2], "Automatic fire"),
    automatic_penetration = aa(aq[1], aq[2], "Automatic penetration"),
    silent_aim = aa(aq[1], aq[2], "Silent aim"),
    hitchance = aa(aq[1], aq[2], "Minimum hit chance"),
    mindamage = aa(aq[1], aq[2], "Minimum damage"),
    automatic_scope = aa(aq[1], aq[2], "Automatic scope"),
    reduce_aimstep = aa(aq[1], aq[2], "Reduce aim step"),
    log_spread = aa(aq[1], aq[2], "Log misses due to spread"),
    low_fps_mitigations = aa(aq[1], aq[2], "Low FPS mitigations"),
    Maximum_FOV = aa(aq[1], aq[2], "Maximum FOV"),
    accuracy_boost = aa(aq[1], aq[5], "Accuracy boost"),
    quickstop = aa(aq[1], aq[5], "Quick stop"),
    quickstop_option = aa(aq[1], aq[5], "Quick stop options"),
    delay_shot = aa(aq[1], aq[5], "Delay shot"),
    prefer_bodyaim = aa("RAGE", "Other", "Prefer body aim"),
    prefer_bodyaim_disabler = aa("RAGE", "Other", "Prefer body aim disablers")
}
local bP = {
    main = function()
        as = {
            enable = N(aq[3], aq[4], "Enable", false),
            tab = P(aq[3], aq[4], bn(nil, "General") .. "Weapon Selection", bm.menu_index),
            current = a7(aq[3], aq[4], bn(nil, "Current Config:") .. ""),
            tab_2 = P(aq[3], aq[4], bn(nil, "General") .. "Tab Selection", "Aimbot", "Other", "Indicators")
        }
    end,
    config_1 = function()
        au.current_labels = a7(aq[3], aq[4], "\n")
        au.hitbox_mod = a7(aq[3], aq[4], bn(nil, "         Hitscan \aFFFFFFFFModificator"))
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].target_selection =
                P(
                aq[3],
                aq[4],
                bn(nil, "Targets") .. "Selection" .. bp(aH),
                {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Best hit chance"}
            )
            ar[aH].target_hitbox = aj(aq[3], aq[4], bn(nil, "Targets") .. "Hitboxes" .. bp(aH), bm.hitgroup)
            ar[aH].enable_hitbox = N(aq[3], aq[4], bn(nil, "Override") .. "Hitbox Override" .. bp(aH))
            ar[aH].custom_hitbox =
                aj(
                aq[3],
                aq[4],
                bn(aH, "Hide") .. "\nHitbox Option",
                {"On-key", "On-key 2", "In-Air", "Double tap", "Force Body Aim"}
            )
        end
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].hitbox_ovr = aj(aq[3], aq[4], bn(nil, "On-Key #1") .. "Hitbox" .. bp(aH), bm.hitgroup)
        end
        at.hitbox_key = a6(aq[3], aq[4], bn(nil, "Key #1") .. "Hitbox Override", true)
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].hitbox_ovr2 = aj(aq[3], aq[4], bn(nil, "On-Key #2") .. "Hitbox" .. bp(aH), bm.hitgroup)
        end
        at.hitbox_key2 = a6(aq[3], aq[4], bn(nil, "Key #2") .. "Hitbox Override", true)
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].hitbox_air = aj(aq[3], aq[4], bn(nil, "In Air") .. "Hitbox" .. bp(aH), bm.hitgroup)
            ar[aH].hitbox_dt = aj(aq[3], aq[4], bn(nil, "DT") .. "Hitbox" .. bp(aH), bm.hitgroup)
            ar[aH].multipoint = aj(aq[3], aq[4], bn(nil, "Targets") .. "Multi-point" .. bp(aH), bm.hitgroup)
            ar[aH].multipoint_scale =
                Q(aq[3], aq[4], bn(aH) .. "Multi-point scale", 24, 100, 60, true, "%", 1, {[24] = "Auto"})
            ar[aH].enable_multipoint = N(aq[3], aq[4], bn(nil, "Override") .. "Multi-point Override" .. bp(aH))
            ar[aH].custom_multipoint =
                aj(
                aq[3],
                aq[4],
                bn(aH, "Hide") .. "\nMultipoint Option",
                {"On-key", "On-key 2", "Damage Override", "In-Air", "Double tap"}
            )
        end
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].multipoint_ovr =
                Q(
                aq[3],
                aq[4],
                bn(nil, "On-Key #1") .. "Multi-point scale" .. bp(aH),
                24,
                100,
                50,
                true,
                "%",
                1,
                {[24] = "Auto"}
            )
        end
        at.multipoint_key = a6(aq[3], aq[4], bn(nil, "On-Key #2") .. "Multi-point Override", true)
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].multipoint_ovr2 =
                Q(
                aq[3],
                aq[4],
                bn(nil, "On-Key #2") .. "Multi-point scale" .. bp(aH),
                24,
                100,
                50,
                true,
                "%",
                1,
                {[24] = "Auto"}
            )
        end
        at.multipoint_key2 = a6(aq[3], aq[4], "Multi-point Override [On Key 2]", true)
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].multipoint_ovr3 =
                Q(
                aq[3],
                aq[4],
                bn(nil, "Damage") .. "Multi-point scale" .. bp(aH),
                24,
                100,
                50,
                true,
                "%",
                1,
                {[24] = "Auto"}
            )
            ar[aH].multipoint_air =
                Q(
                aq[3],
                aq[4],
                bn(nil, "In Air") .. "Multi-point scale" .. bp(aH),
                24,
                100,
                50,
                true,
                "%",
                1,
                {[24] = "Auto"}
            )
            ar[aH].multipoint_dt =
                Q(
                aq[3],
                aq[4],
                bn(nil, "DT") .. "Multi-point scale" .. bp(aH),
                24,
                100,
                50,
                true,
                "%",
                1,
                {[24] = "Auto"}
            )
        end
        au.hide_label_dm = a7(aq[3], aq[4], "\n")
        au.dm_mod = a7(aq[3], aq[4], bn(nil, "         Accuracy \aFFFFFFFFModificator"))
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].hitchance =
                Q(aq[3], aq[4], bn(nil, "Accuracy") .. "Hitchance" .. bp(aH), 0, 100, 50, true, "%", 1, {"Off"})
            ar[aH].enable_hitchance = N(aq[3], aq[4], bn(nil, "Override") .. "Hitchance Override" .. bp(aH))
            ar[aH].custom_hitchance =
                aj(
                aq[3],
                aq[4],
                bn(aH, "Hide") .. "\nHitchance Option",
                {"On-key", "On-key 2", "In-Air", "Double tap", "No Scope"}
            )
        end
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].hitchance_ovr =
                Q(aq[3], aq[4], bn(nil, "On-Key #1") .. "Hitchance" .. bp(aH), 0, 100, 50, true, "%", 1, {"Off"})
        end
        at.hitchance_key = a6(aq[3], aq[4], "Hitchance Override [On-key]", true)
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].hitchance_ovr2 =
                Q(aq[3], aq[4], bn(nil, "On-Key #2") .. "Hitchance" .. bp(aH), 0, 100, 50, true, "%", 1, {"Off"})
        end
        at.hitchance_key2 = a6(aq[3], aq[4], "Hitchance Override [On-key 2]", true)
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].hitchance_air =
                Q(aq[3], aq[4], bn(nil, "In Air") .. "Hitchance" .. bp(aH), 0, 100, 50, true, "%", 1, {"Off"})
            ar[aH].hitchance_dt =
                Q(aq[3], aq[4], bn(nil, "DT") .. "Hitchance" .. bp(aH), 0, 100, 50, true, "%", 1, {"Off"})
            ar[aH].hitchance_ns =
                Q(aq[3], aq[4], bn(nil, "No Scope") .. "Hitchance" .. bp(aH), 0, 100, 50, true, "%", 1, {"Off"})
            ar[aH].min_damage =
                Q(aq[3], aq[4], bn(nil, "Accuracy") .. "Damage" .. bp(aH), 0, 126, 20, true, nil, 1, bm.index_dmg)
            ar[aH].enable_damage = N(aq[3], aq[4], bn(nil, "Override") .. "Damage Override" .. bp(aH))
            ar[aH].custom_damage =
                aj(
                aq[3],
                aq[4],
                bn(aH, "Hide") .. "\nDamage Option",
                {"On-key", "On-key 2", "Visible", "In-Air", "No Scope", "Double tap"}
            )
        end
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].ovr_min_damage =
                Q(aq[3], aq[4], bn(nil, "On-Key #1") .. "Damage" .. bp(aH), 0, 126, 20, true, nil, 1, bm.index_dmg)
        end
        at.damage_key = a6(aq[3], aq[4], "Damage Override [On-key]", true)
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].ovr_min_damage2 =
                Q(aq[3], aq[4], bn(nil, "On-Key #2") .. "Damage" .. bp(aH), 0, 126, 1, true, nil, 1, bm.index_dmg)
        end
        at.damage_key2 = a6(aq[3], aq[4], "Damage Override [On-key 2]", true)
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].vis_min_damage =
                Q(aq[3], aq[4], bn(nil, "Visible") .. "Damage" .. bp(aH), 0, 126, 20, true, nil, 1, bm.index_dmg)
            ar[aH].nc_min_damage =
                Q(aq[3], aq[4], bn(nil, "No Scope") .. "Damage" .. bp(aH), 0, 126, 20, true, nil, 1, bm.index_dmg)
            ar[aH].air_min_damage =
                Q(aq[3], aq[4], bn(nil, "In Air") .. "Damage" .. bp(aH), 0, 126, 20, true, nil, 1, bm.index_dmg)
            ar[aH].dt_min_damage =
                Q(aq[3], aq[4], bn(nil, "DT") .. "Damage" .. bp(aH), 0, 126, 20, true, nil, 1, bm.index_dmg)
        end
        au.hide_label_ut = a7(aq[3], aq[4], "\n")
        au.utiles_mod = a7(aq[3], aq[4], bn(nil, "         Utiles \aFFFFFFFFModificator"))
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].prefer_safe_point = N(aq[3], aq[4], bn(aH) .. "Prefer safe point")
            ar[aH].unsafe = aj(aq[3], aq[4], bn(aH) .. "Avoid unsafe hitboxes", bm.hitgroup)
            ar[aH].automatic_fire = N(aq[3], aq[4], bn(aH) .. "Automatic fire")
            ar[aH].automatic_penetration = N(aq[3], aq[4], bn(aH) .. "Automatic penetration")
            ar[aH].automatic_scope = N(aq[3], aq[4], bn(aH) .. "Automatic scope")
            ar[aH].silent_aim = N(aq[3], aq[4], bn(aH) .. "Silent aim")
        end
    end,
    config_2 = function()
        au.hide_label_misc = a7(aq[3], aq[4], "\n")
        au.misc_mod = a7(aq[3], aq[4], bn(nil, "           Misc \aFFFFFFFFModificator"))
        for aH = 1, #bm.weapons do
            if not ar[aH] then
                ar[aH] = {}
            end
            ar[aH].accuracy = P(aq[3], aq[4], bn(aH) .. "Accuracy Boost", bm.backtrack)
            ar[aH].delayshot = N(aq[3], aq[4], bn(aH) .. "Delay shot")
            ar[aH].quickstop = N(aq[3], aq[4], bn(aH) .. "Quick stop")
            ar[aH].quickstop_mode = aj(aq[3], aq[4], bn(aH, "Hide") .. "\nQuick stop options", bm.quickstop)
            ar[aH].preferbaim = N(aq[3], aq[4], bn(aH) .. "Prefer Body Aim")
            ar[aH].prefer_bodyaim_disabler = aj(aq[3], aq[4], bn(aH, "Hide") .. "\n", bm.preferbaim)
            ar[aH].ping_spike = N(aq[3], aq[4], bn(aH) .. "Ping spike")
            ar[aH].ping_spike_bar = Q(aq[3], aq[4], bn(aH, "Hide") .. "\nPing Spike [Bar]", 1, 200, 0, true, "ms")
        end
        au.hide_label_config = a7(aq[3], aq[4], "\n")
        au.config_mod = a7(aq[3], aq[4], bn(nil, "         Config \aFFFFFFFFModificator"))
        at.deafult = a5(aq[3], aq[4], bn(nil, "Config") .. "Download Preset", bq.config_download)
        at.import = a5(aq[3], aq[4], bn(nil, "Config") .. "Import", bq.config_import)
        at.export = a5(aq[3], aq[4], bn(nil, "Config") .. "Export", bq.config_export)
    end,
    configs_3 = function()
        av.hide_label_indicator = a7(aq[3], aq[4], "\n")
        av.config_ind = a7(aq[3], aq[4], bn(nil, "         Index \aFFFFFFFFModificator"))
        av.crosshair = N(aq[3], aq[4], bn(nil, "Index") .. "Cross Hair Indicators")
        av.crosshair_tbl = aj(aq[3], aq[4], "\n", {"Damage", "Hitchance", "Multipoint", "Hitbox state"})
        av.feature = N(aq[3], aq[4], bn(nil, "Index") .. "Feature Indicators")
        av.feature_tbl =
            aj(
            aq[3],
            aq[4],
            "\n",
            {
                "Prefer Safe Point",
                "Automatic Fire",
                "Automatic Penetration",
                "Automatic Scope",
                "Silent Aim",
                "Delay Shot",
                "Quick Stop",
                "Ping Spike"
            }
        )
    end
}
local bQ = {weapon = function()
        for aH = 1, #bm.weapons do
            bq.fill_table(ar[aH].target_hitbox, "Head")
            bq.fill_table(ar[aH].hitbox_ovr, "Head")
            bq.fill_table(ar[aH].hitbox_ovr2, "Head")
            bq.fill_table(ar[aH].hitbox_air, "Head")
            bq.fill_table(ar[aH].hitbox_dt, "Head")
            local bR = K(as.tab_2) == "Aimbot"
            local bS = K(as.tab) == "In-Built Weapon"
            local bK = bm.weapons[aH] == (bS and bm.weapons[bq.get_weapon()] or K(as.tab))
            local bT = bK and bR
            if bS then
                R(as.current, "\aFFC0CBFF        Current Config: " .. "\aFFFFFFFF" .. bm.weapons[bq.get_weapon()])
            end
            S(as.current, bS)
            if bm.weapons[aH] == K(as.tab) then
                ax = aH
            elseif bS then
                ax = bq.get_weapon()
            end
            S(ar[aH].multipoint, bT)
            S(ar[aH].prefer_safe_point, bT)
            S(ar[aH].unsafe, bT)
            S(ar[aH].automatic_fire, bT)
            S(ar[aH].automatic_penetration, bT)
            S(ar[aH].automatic_scope, bT)
            S(ar[aH].silent_aim, bT)
            S(ar[aH].target_selection, bT)
            S(ar[aH].target_hitbox, bT)
            S(ar[aH].multipoint_scale, bT)
            S(ar[aH].hitchance, bT)
            S(ar[aH].min_damage, bT)
            local bU = K(ar[aH].enable_hitbox)
            local bV = bq.contains(K(ar[aH].custom_hitbox), "On-key") and bK and bU and bR
            local bW = bq.contains(K(ar[aH].custom_hitbox), "On-key 2") and bK and bU and bR
            local bX = bq.contains(K(ar[aH].custom_hitbox), "In-Air") and bK and bU and bR
            local bY = bq.contains(K(ar[aH].custom_hitbox), "Double tap") and bK and bU and bR
            S(ar[aH].enable_hitbox, bT)
            S(ar[aH].custom_hitbox, bT and bU)
            S(ar[aH].hitbox_ovr, bV)
            S(at.hitbox_key, bV)
            S(ar[aH].hitbox_ovr2, bW)
            S(at.hitbox_key2, bW)
            S(ar[aH].hitbox_air, bX)
            S(ar[aH].hitbox_dt, bY)
            local bZ = K(ar[aH].enable_multipoint)
            local b_ = bq.contains(K(ar[aH].custom_multipoint), "On-key") and bK and bZ and bR
            local c0 = bq.contains(K(ar[aH].custom_multipoint), "On-key 2") and bK and bZ and bR
            local c1 = bq.contains(K(ar[aH].custom_multipoint), "Damage Override") and bK and bZ and bR
            local c2 = bq.contains(K(ar[aH].custom_multipoint), "In-Air") and bK and bZ and bR
            local c3 = bq.contains(K(ar[aH].custom_multipoint), "Double tap") and bK and bZ and bR
            S(ar[aH].enable_multipoint, bT)
            S(ar[aH].custom_multipoint, bT and bZ)
            S(ar[aH].multipoint_ovr, b_)
            S(ar[aH].multipoint_ovr2, c0)
            S(ar[aH].multipoint_ovr3, c1)
            S(ar[aH].multipoint_air, c2)
            S(ar[aH].multipoint_dt, c3)
            local c4 = K(ar[aH].enable_hitchance)
            local c5 = bq.contains(K(ar[aH].custom_hitchance), "On-key") and bK and c4 and bR
            local c6 = bq.contains(K(ar[aH].custom_hitchance), "On-key 2") and bK and c4 and bR
            local c7 = bq.contains(K(ar[aH].custom_hitchance), "In-Air") and bK and c4 and bR
            local c8 = bq.contains(K(ar[aH].custom_hitchance), "Double tap") and bK and c4 and bR
            local c9 = bq.contains(K(ar[aH].custom_hitchance), "No Scope") and bK and c4 and bR
            S(ar[aH].enable_hitchance, bT)
            S(ar[aH].custom_hitchance, bT and c4)
            S(ar[aH].hitchance_ovr, c5)
            S(ar[aH].hitchance_ovr2, c6)
            S(ar[aH].hitchance_air, c7)
            S(ar[aH].hitchance_dt, c8)
            S(ar[aH].hitchance_ns, c9)
            local ca = K(ar[aH].enable_damage)
            local cb = bq.contains(K(ar[aH].custom_damage), "On-key") and bK and ca and bR
            local cc = bq.contains(K(ar[aH].custom_damage), "On-key 2") and bK and ca and bR
            local cd = bq.contains(K(ar[aH].custom_damage), "Visible") and bK and ca and bR
            local ce = bq.contains(K(ar[aH].custom_damage), "No Scope") and bK and ca and bR
            local cf = bq.contains(K(ar[aH].custom_damage), "In-Air") and bK and ca and bR
            local cg = bq.contains(K(ar[aH].custom_damage), "Double tap") and bK and ca and bR
            S(ar[aH].enable_damage, bT)
            S(ar[aH].custom_damage, bT and ca)
            S(ar[aH].ovr_min_damage, cb)
            S(ar[aH].ovr_min_damage2, cc)
            S(ar[aH].vis_min_damage, cd)
            S(ar[aH].nc_min_damage, ce)
            S(ar[aH].air_min_damage, cf)
            S(ar[aH].dt_min_damage, cg)
            local ch = K(as.tab_2) == "Other"
            local ci = bK and ch
            S(ar[aH].accuracy, ci)
            S(ar[aH].delayshot, ci)
            local cj = K(ar[aH].quickstop)
            S(ar[aH].quickstop, ci)
            S(ar[aH].quickstop_mode, ci and cj)
            local ck = K(ar[aH].ping_spike)
            S(ar[aH].ping_spike, ci)
            S(ar[aH].ping_spike_bar, ci and ck)
            local cl = K(ar[aH].preferbaim) and ci
            S(ar[aH].preferbaim, ci)
            S(ar[aH].prefer_bodyaim_disabler, cl)
        end
    end, labels = function()
        local bT = K(as.tab_2) == "Aimbot"
        local ci = K(as.tab_2) == "Other"
        S(au.current_labels, bT)
        S(au.hitbox_mod, bT)
        S(au.hide_label_dm, bT)
        S(au.dm_mod, bT)
        S(au.hide_label_ut, bT)
        S(au.utiles_mod, bT)
        S(au.hide_label_misc, ci)
        S(au.misc_mod, ci)
        S(au.hide_label_config, ci)
        S(au.config_mod, ci)
    end, indicators = function()
        local cm = K(as.tab_2) == "Indicators"
        local cn = K(av.crosshair) and cm
        local co = K(av.feature) and cm
        S(av.hide_label_indicator, cm)
        S(av.config_ind, cm)
        S(av.crosshair, cm)
        S(av.crosshair_tbl, cn)
        S(av.feature, cm)
        S(av.feature_tbl, co)
    end, keybinds = function()
        local bR = K(as.tab_2) == "Aimbot"
        local bU = K(ar[ax].enable_hitbox) and bR
        local bV = bq.contains(K(ar[ax].custom_hitbox), "On-key") and bU
        local bW = bq.contains(K(ar[ax].custom_hitbox), "On-key 2") and bU
        S(at.hitbox_key, bV)
        S(at.hitbox_key2, bW)
        local bZ = K(ar[ax].enable_multipoint) and bR
        local b_ = bq.contains(K(ar[ax].custom_multipoint), "On-key") and bZ
        local c0 = bq.contains(K(ar[ax].custom_multipoint), "On-key 2") and bZ
        S(at.multipoint_key, b_)
        S(at.multipoint_key2, c0)
        local c4 = K(ar[ax].enable_hitchance) and bR
        local c5 = bq.contains(K(ar[ax].custom_hitchance), "On-key") and c4
        local c6 = bq.contains(K(ar[ax].custom_hitchance), "On-key 2") and c4
        S(at.hitchance_key, c5)
        S(at.hitchance_key2, c6)
        local ca = K(ar[ax].enable_damage) and bR
        local cb = bq.contains(K(ar[ax].custom_damage), "On-key") and ca
        local cc = bq.contains(K(ar[ax].custom_damage), "On-key 2") and ca
        S(at.damage_key, cb)
        S(at.damage_key2, cc)
        local ci = K(as.tab_2) == "Other"
        S(at.deafult, ci)
        S(at.import, ci)
        S(at.export, ci)
    end}
local cp = {target_hitbox = function(ax)
        local cq = K(ar[ax].enable_hitbox)
        local cr = bq.contains(K(ar[ax].custom_hitbox), "On-key") and cq
        local cs = bq.contains(K(ar[ax].custom_hitbox), "On-key 2") and cq
        local ct = bq.contains(K(ar[ax].custom_hitbox), "In-Air") and cq
        local cu = bq.contains(K(ar[ax].custom_hitbox), "Double tap") and cq
        local cv = K(ar[ax].target_hitbox)
        if cr and bq.is_key_down(at.hitbox_key) then
            return K(ar[ax].hitbox_ovr)
        elseif cs and bq.is_key_down(at.hitbox_key2) then
            return K(ar[ax].hitbox_ovr2)
        elseif ct and bq.is_in_air() then
            return K(ar[ax].hitbox_air)
        elseif cu and bq.is_double_tapping() then
            return K(ar[ax].hitbox_dt)
        else
            return cv
        end
    end, multipoint_scale = function(ax)
        local cw = K(ar[ax].enable_multipoint)
        local cx = bq.contains(K(ar[ax].custom_multipoint), "On-key") and cw
        local cy = bq.contains(K(ar[ax].custom_multipoint), "On-key 2") and cw
        local cz = bq.contains(K(ar[ax].custom_multipoint), "Damage Override") and cw
        local cA = bq.contains(K(ar[ax].custom_multipoint), "Visible") and cw
        local cB = bq.contains(K(ar[ax].custom_multipoint), "In-Air") and cw
        local cC = bq.contains(K(ar[ax].custom_multipoint), "Double tap") and cw
        local cD = K(ar[ax].multipoint_scale)
        if cx and bq.is_key_down(at.multipoint_key) then
            return K(ar[ax].multipoint_ovr)
        elseif cy and bq.is_key_down(at.multipoint_key2) then
            return K(ar[ax].multipoint_ovr2)
        elseif cz and (bq.is_key_down(at.damage_key) or bq.is_key_down(at.damage_key2)) then
            return K(ar[ax].multipoint_ovr3)
        elseif cB and bq.is_in_air() then
            return K(ar[ax].multipoint_air)
        elseif cC and bq.is_double_tapping() then
            return K(ar[ax].multipoint_dt)
        elseif cA and bq.enemy_visible() then
            return K(ar[ax].multipoint_vis)
        else
            return cD
        end
    end, hitchance = function(ax)
        local cE = K(ar[ax].enable_hitchance)
        local cF = bq.contains(K(ar[ax].custom_hitchance), "On-key") and cE
        local cG = bq.contains(K(ar[ax].custom_hitchance), "On-key 2") and cE
        local cH = bq.contains(K(ar[ax].custom_hitchance), "In-Air") and cE
        local cI = bq.contains(K(ar[ax].custom_hitchance), "Double tap") and cE
        local cJ = K(ar[ax].hitchance)
        if cF and bq.is_key_down(at.hitchance_key) then
            return K(ar[ax].hitchance_ovr)
        elseif cG and bq.is_key_down(at.hitchance_key2) then
            return K(ar[ax].hitchance_ovr2)
        elseif cH and bq.is_in_air() then
            return K(ar[ax].hitchance_air)
        elseif cI and bq.is_double_tapping() then
            return K(ar[ax].hitchance_dt)
        else
            return cJ
        end
    end, damage = function(ax)
        local cK = K(ar[ax].enable_damage)
        local cL = bq.contains(K(ar[ax].custom_damage), "On-key") and cK
        local cM = bq.contains(K(ar[ax].custom_damage), "On-key 2") and cK
        local cN = bq.contains(K(ar[ax].custom_damage), "In-Air") and cK
        local cO = bq.contains(K(ar[ax].custom_damage), "No Scope") and cK
        local cP = bq.contains(K(ar[ax].custom_damage), "Double tap") and cK
        local cQ = K(ar[ax].min_damage)
        if cL and bq.is_key_down(at.damage_key) then
            return K(ar[ax].ovr_min_damage)
        elseif cM and bq.is_key_down(at.damage_key2) then
            return K(ar[ax].ovr_min_damage2)
        elseif cN and bq.is_in_air() then
            return K(ar[ax].air_min_damage)
        elseif cP and bq.is_double_tapping() then
            return K(ar[ax].dt_min_damage)
        elseif cO and not bq.is_scoped() then
            return K(ar[ax].nc_min_damage)
        else
            return cQ
        end
    end, multipoint = function(ax)
        return K(ar[ax].multipoint)
    end, target_selection = function(ax)
        return K(ar[ax].target_selection)
    end, prefer_safe_point = function(ax)
        return K(ar[ax].prefer_safe_point)
    end, unsafe = function(ax)
        return K(ar[ax].unsafe)
    end, automatic_fire = function(ax)
        return K(ar[ax].automatic_fire)
    end, automatic_penetration = function(ax)
        return K(ar[ax].automatic_penetration)
    end, automatic_scope = function(ax)
        return K(ar[ax].automatic_scope)
    end, silent_aim = function(ax)
        return K(ar[ax].silent_aim)
    end, accuracy = function(ax)
        return K(ar[ax].accuracy)
    end, delay_shot = function(ax)
        return K(ar[ax].delayshot)
    end, quickstop = function(ax)
        return K(ar[ax].quickstop)
    end, quickstop_mode = function(ax)
        return K(ar[ax].quickstop_mode)
    end, prefer_bodyaim = function(ax)
        return K(ar[ax].preferbaim)
    end, prefer_bodyaim_disabler = function(ax)
        return K(ar[ax].prefer_bodyaim_disabler)
    end}


local ref_quickstop, ref_quickstopkey, ref_quickstop_options = ui_reference("RAGE", "Aimbot", "Quick stop")
local cp = function()
    local aH = bq.get_weapon()
    R(bO.target_selection, cp.target_selection(aH))
    R(bO.target_hitbox, cp.target_hitbox(aH))
    R(bO.prefer_safe_point, cp.prefer_safe_point(aH))
    R(bO.unsafe, cp.unsafe(aH))
    R(bO.automatic_fire, cp.automatic_fire(aH))
    R(bO.automatic_penetration, cp.automatic_penetration(aH))
    R(bO.automatic_scope, cp.automatic_scope(aH))
    R(bO.silent_aim, cp.silent_aim(aH))
    R(bO.multipoint, cp.multipoint(aH))
    R(bO.multipoint_scale, cp.multipoint_scale(aH))
    R(bO.mindamage, cp.damage(aH))
    R(bO.hitchance, cp.hitchance(aH))
    R(bO.accuracy_boost, cp.accuracy(aH))
    R(bO.delay_shot, cp.delay_shot(aH))
    R(bO.quickstop, cp.quickstop(aH))
    ui.set(ref_quickstop_options, cp.quickstop_mode(aH))
    R(bO.prefer_bodyaim, cp.prefer_bodyaim(aH))
    R(bO.prefer_bodyaim_disabler, cp.prefer_bodyaim_disabler(aH))
end
local cR = {
    damage = bg("damage", 600, 600),
    hitchance = bg("hitchance", 650, 600),
    multipoint = bg("multipoint", 700, 600),
    hitbox = bg("hitbox", 750, 600),
    infobox = bg("Container", 100, 600)
}
local cS = {damage = {0, 0}, hitchance = {0, 0}, multipoint = {0, 0}, hitbox = {0, 0, 0, 0, 0}, infobox = {0, 0}}
local cT = {
    damage_cs = function()
        local cU = K(bO.mindamage)
        local cK = cU
        local aR, aS = cR.damage:get()
        local cV, cW = renderer.measure_text("", cK)
        local cX, cX, cY = cR.damage:drag(cV + 3, cW + 3)
        local cZ = cY == "n" and true or false
        local c_ = cY == "c" and true or false
        cS.damage[1] = bh(cS.damage[1], c_ and 150 or 250, 6 * globals.frametime())
        cS.damage[2] = bh(cS.damage[2], cZ and 0 or 250, 3.5 * globals.frametime())
        bl(aR - 3, aS - 3, cV + 6, cW + 6, 2, 255, 255, 255, cS.damage[2])
        a2(aR, aS, 255, 255, 255, cS.damage[1], "", nil, cK)
    end,
    hitchance_cs = function()
        local cU = K(bO.hitchance)
        local cE = cU .. "%"
        local aR, aS = cR.hitchance:get()
        local cV, cW = renderer.measure_text("", cE)
        local cX, cX, cY = cR.hitchance:drag(cV + 3, cW + 3)
        local cZ = cY == "n" and true or false
        local c_ = cY == "c" and true or false
        cS.hitchance[1] = bh(cS.hitchance[1], c_ and 150 or 250, 6 * globals.frametime())
        cS.hitchance[2] = bh(cS.hitchance[2], cZ and 0 or 250, 3.5 * globals.frametime())
        bl(aR - 3, aS - 3, cV + 6, cW + 6, 2, 255, 255, 255, cS.hitchance[2])
        a2(aR, aS, 255, 255, 255, cS.hitchance[1], "", nil, cE)
    end,
    multipoint_cs = function()
        local cU = K(bO.multipoint_scale)
        local cw = cU .. "%"
        local aR, aS = cR.multipoint:get()
        local cV, cW = renderer.measure_text("", cw)
        local cX, cX, cY = cR.multipoint:drag(cV + 3, cW + 3)
        local cZ = cY == "n" and true or false
        local c_ = cY == "c" and true or false
        cS.multipoint[1] = bh(cS.multipoint[1], c_ and 150 or 250, 6 * globals.frametime())
        cS.multipoint[2] = bh(cS.multipoint[2], cZ and 0 or 250, 3.5 * globals.frametime())
        bl(aR - 3, aS - 3, cV + 6, cW + 6, 2, 255, 255, 255, cS.multipoint[2])
        a2(aR, aS, 255, 255, 255, cS.multipoint[1], "", nil, cw)
    end,
    hitbox_cs = function()
        local d0 = K(bO.target_hitbox)
        local d1 = bq.contains(d0, "Head") and #d0 == 1
        local d2 = not bq.contains(d0, "Head")
        local cq = d1 and "HEAD" or d2 and "BODY" or "NONE"
        local aR, aS = cR.hitbox:get()
        local cV, cW = renderer.measure_text("", cq)
        local cX, cX, cY = cR.hitbox:drag(cV + 3, cW + 3)
        local cZ = cY == "n" and true or false
        local c_ = cY == "c" and true or false
        cS.hitbox[1] = bh(cS.hitbox[1], c_ and 150 or 250, 6 * globals.frametime())
        cS.hitbox[2] = bh(cS.hitbox[2], cZ and 0 or 250, 3.5 * globals.frametime())
        cS.hitbox[3] = bh(cS.hitbox[3], d1 and 255 or d2 and 0 or 250, 3.5 * globals.frametime())
        cS.hitbox[4] = bh(cS.hitbox[4], d1 and 180 or d2 and 255 or 250, 3.5 * globals.frametime())
        cS.hitbox[5] = bh(cS.hitbox[5], d1 and 180 or d2 and 0 or 250, 3.5 * globals.frametime())
        bl(aR - 3, aS - 3, cV + 6, cW + 6, 2, 255, 255, 255, cS.hitbox[2])
        a2(aR, aS, cS.hitbox[3], cS.hitbox[4], cS.hitbox[5], cS.hitbox[1], "", nil, cq)
    end,
    infobox = function()
        local aR, aS = cR.infobox:get()
        local cX, cX, cY = cR.infobox:drag(68, 25 + 5)
        local cZ = cY ~= "n" and true or false
        local c_ = cY == "o" and true or false
        cS.infobox[1] = bh(cS.infobox[1], c_ and 180 or 250, 6 * globals.frametime())
        cS.infobox[2] = bh(cS.infobox[2], cZ and 2.3 or 1.1, 3.5 * globals.frametime())
        aQ.container(aR, aS, 68, 25 + 5, 184, 187, 230, 230, cS.infobox[2], 134, 137, 180, 80)
    end,
    vanilla = function()
        local d3 = {
            FOV = bq.contains(K(lotus.visuals.vanilla_ind), "Fov") and K(bO.fov),
            AW = bq.contains(K(lotus.visuals.vanilla_ind), "Auto wall") and K(bO.autowall),
            TM = bq.contains(K(lotus.visuals.vanilla_ind), "Automatic fire") and K(bO.autofire)
        }
        local d4, d5, d6, d7 = K(lotus.color_vnl.vnl_ind)
        local bo = {d4, d5, d6, d7}
        for cX, d8 in pairs(d3) do
            if d8 then
                renderer.indicator(bo[1], bo[2], bo[3], bo[4], cX)
            end
        end
    end
}
local d9 = {call = function()
        bP.main()
        bP.config_1()
        bP.config_2()
        bP.configs_3()
        local da = function()
            bQ.weapon()
            bQ.keybinds()
            bQ.labels()
            bQ.indicators()
        end
        local db = function()
            cp()
        end
        local dc = function()
            local dd = bq.contains(K(av.crosshair_tbl), "Damage")
            if dd then
                cT.damage_cs()
            end
            local de = bq.contains(K(av.crosshair_tbl), "Hitchance")
            if de then
                cT.hitchance_cs()
            end
            local df = bq.contains(K(av.crosshair_tbl), "Multipoint")
            if df then
                cT.multipoint_cs()
            end
            local dg = bq.contains(K(av.crosshair_tbl), "Hitbox state")
            if dg then
                cT.hitbox_cs()
            end
            cT.infobox()
        end
        local dh = function()
            da()
            db()
            local di = K(av.crosshair) and true or false
            if di then
                dc()
            end
        end
        client.set_event_callback("paint_ui", dh)
    end}
d9.call()
