
---@author: nonterminal(fourm id:shriekz7) 2023-01-02 22:28:51

--TODO: optimal -  reduce the use of the stacker
--TODO: optimal -  adaptability to vanilla menus
    
local __DEBUG = false

local clipboard = require("gamesense/clipboard") or error("clipboard lib cant be found")

--[[
    experimental adaptive weapon fast builder.lua   
    MIT License:
        Copyright (c) 2023 nonterminal
        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:
        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
]]
local weapon, switch, location, exporter, importer = (function()
    local ex_weapon = {}

    local refs = {
        target_selection =              ui.reference("RAGE", "Aimbot", "Target selection"),
        target_hitbox =                 ui.reference("RAGE", "Aimbot", "Target hitbox"),
        multipoint =                {   ui.reference("RAGE", "Aimbot", "Multi-point")   },
        multipoint_scale =              ui.reference("RAGE", "Aimbot", "Multi-point scale"),
        prefer_safepoint =              ui.reference("RAGE", "Aimbot", "Prefer safe point"),
        unsafe =                        ui.reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"),
        automatic_fire =                ui.reference("RAGE", "Aimbot", "Automatic fire"),
        automatic_penetration =         ui.reference("RAGE", "Aimbot", "Automatic penetration"),
        silent_aim =                    ui.reference("RAGE", "Aimbot", "Silent aim"),
        hitchance =                     ui.reference("RAGE", "Aimbot", "Minimum hit chance"),
        mindamage =                     ui.reference("RAGE", "Aimbot", "Minimum damage"),
        automatic_scope =               ui.reference("RAGE", "Aimbot", "Automatic scope"),
        fov =                           ui.reference("RAGE", "Aimbot", "Maximum FOV"),
        accuracy_boost =                ui.reference("RAGE", "Other", "Accuracy boost"),
        delay_shot =                    ui.reference("RAGE", "Other", "Delay shot"),
        quickstop =                 {   ui.reference("RAGE", "Other", "Quick stop")  },
        quickstop_options =             ui.reference("RAGE", "Other", "Quick stop options"),
        prefer_bodyaim =                ui.reference("RAGE", "Other", "Prefer body aim"),
        prefer_bodyaim_disablers =      ui.reference("RAGE", "Other", "Prefer body aim disablers"),
        doubletap_hc =                  ui.reference("RAGE", "Other", "Double tap hit chance"),
        doubletap_stop =                ui.reference("RAGE", "Other", "Double tap quick stop"),
    }

    local refs_idx_to_name = {
        [1] = 'target_selection',
        [2] = 'target_hitbox',
        [3] = 'multipoint',
        [4] = 'multipoint_scale',
        [5] = 'prefer_safepoint',
        [6] = 'unsafe',
        [7] = 'automatic_fire',
        [8] = 'automatic_penetration',
        [9] = 'silent_aim',
        [10] = 'hitchance',
        [11] = 'mindamage',
        [12] = 'automatic_scope',
        [13] = 'fov',
        [14] = 'accuracy_boost',
        [15] = 'delay_shot',
        [16] = 'quickstop',
        [17] = 'quickstop_options',
        [18] = 'prefer_bodyaim',
        [19] = 'prefer_bodyaim_disablers',
        [20] = 'doubletap_hc',
        [21] = 'doubletap_stop',
    }

    local ui_set_callback = ui.set_callback

    function ui.set_callback(callback, func, init, ...)
        if init then
            func(...)
        end

        ui_set_callback(callback, func, ...)
    end

    -- weapon determination from @sigma adaptive

        local name_to_num = { ["Global"] = 1, ["Taser"] = 2, ["Revolver"] = 3, ["Pistol"] = 4, ["Auto"] = 5, ["Scout"] = 6, ["AWP"] = 7, ["Rifle"] = 8, ["SMG"] = 9, ["Shotgun"] = 10, ["Deagle"] = 11 }
        local weapon_idx_list = { [1] = 11, [2] = 4,[3] = 4,[4] = 4,[7] = 8,[8] = 8,[9] = 7,[10] = 8,[11] = 5,[13] = 8,[14] = 8,[16] = 8,[17] = 9,[19] = 9,[23] = 9,[24] = 9,[25] = 10,[26] = 9,[27] = 10,[28] = 8,[29] = 10,[30] = 4,[31] = 2,  [32] = 4,[33] = 9,[34] = 9,[35] = 10,[36] = 4,[38] = 5,[39] = 8,[40] = 6,[60] = 8,[61] = 4,[63] = 4,[64] = 3}
        local damage_idx = { [0] = "Auto", [101] = "HP + 1", [102] = "HP + 2", [103] = "HP + 3", [104] = "HP + 4", [105] = "HP + 5", [106] = "HP + 6", [107] = "HP + 7", [108] = "HP + 8", [109] = "HP + 9", [110] = "HP + 10", [111] = "HP + 11", [112] = "HP + 12", [113] = "HP + 13", [114] = "HP + 14", [115] = "HP + 15", [116] = "HP + 16", [117] = "HP + 17", [118] = "HP + 18", [119] = "HP + 19", [120] = "HP + 20", [121] = "HP + 21", [122] = "HP + 22", [123] = "HP + 23", [124] = "HP + 24", [125] = "HP + 25", [126] = "HP + 26" }
        local weapon_name = { "Global", "Taser", "Revolver", "Pistol", "Auto", "Scout", "AWP", "Rifle", "SMG", "Shotgun", "Deagle" }

        local function get_weapon_idx()
            local local_player = entity.get_local_player()
            if local_player == nil then return nil end
            local weapon_ent = entity.get_player_weapon(local_player)
            if weapon_ent == nil then return nil end
            local weapon_idx = bit.band(entity.get_prop(weapon_ent, "m_iItemDefinitionIndex"), 0xFFFF)
            if weapon_idx == nil then return nil end
            local get_idx = weapon_idx_list[weapon_idx] ~= nil and weapon_idx_list[weapon_idx] or 1
            return get_idx
        end

        local scoped_wpn = { "Scout", "Auto", "AWP" }

    --

    local config_selection = ui.new_combobox('CONFIG', 'Presets', 'Adaptive weapon location', {'LUA', 'RAGE'})

    local lua_ui_location = database.read('lua_location') or 'LUA'

    local AIMBOT = lua_ui_location == 'RAGE' and {'RAGE', 'Aimbot'} or (lua_ui_location == 'LUA' and {'LUA', 'A'} or error('unaccepted location'))
    local OTHER = lua_ui_location == 'RAGE' and {'RAGE', 'Aimbot'} or (lua_ui_location == 'LUA' and {'LUA', 'A'} or error('unaccepted location'))

    local player_holder = function()
        ui.new_label(AIMBOT[1], AIMBOT[2], '\n')
        ui.new_label(OTHER[1], OTHER[2], '\n')
        client.delay_call(0.06, function()
            ui.new_label(AIMBOT[1], AIMBOT[2], '\n')
            ui.new_label(OTHER[1], OTHER[2], '\n')
        end)
    end

    -- if lua_ui_location == 'RAGE' then   
    --     player_holder()
    -- end

    local weapon_switch    = ui.new_checkbox(AIMBOT[1], AIMBOT[2], 'Enable experimental weapon builder')
    local weapon_selection = ui.new_combobox(AIMBOT[1], AIMBOT[2], '\nWeapon Selection', weapon_name)
    local update_weapon    = ui.new_checkbox(AIMBOT[1], AIMBOT[2], 'Update menu when ui invisible')

    local __init = {
        ['new_checkbox'] = {
            { refs.prefer_safepoint, nil, AIMBOT},
            { refs.automatic_fire, nil, AIMBOT} ,
            { refs.automatic_penetration, nil, AIMBOT},
            { refs.automatic_scope, nil, AIMBOT},
            { refs.silent_aim, nil, AIMBOT},
            -- { refs.reduce_aimstep, nil, AIMBOT},
            { refs.delay_shot, nil, OTHER},
            { refs.quickstop[1], nil, OTHER},
            { refs.prefer_bodyaim, nil, OTHER},
        },
        ['new_slider'] = {
            { refs.fov, {1, 180, 180, true, "��", 1}, AIMBOT}, 
            { refs.multipoint_scale, {24, 100, 60, true, "%", 1, { [24] = "Auto" }}, AIMBOT, function()
                return 'multipoint[1]', function(aim) return #ui.get(aim) > 0 end
            end},
            { refs.hitchance, {0, 100, 60, true, "%", 1, { [0] = "Off" }}, AIMBOT},
            { refs.mindamage, {0, 126, 60, true, nil, 1, damage_idx}, AIMBOT},
            { refs.doubletap_hc, {0, 100, 0, true, "%", 1}, OTHER}
        },
        ['new_combobox'] = {
            { refs.target_selection, {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Lowest ping", "Best K/D ratio", "Best hit chance"}, AIMBOT},
            { refs.accuracy_boost, {'Low', 'Medium', 'High', 'Maximum'}, OTHER},
        },
        ['new_multiselect'] = {
            { refs.target_hitbox, { "Head", "Chest", "Arms", "Stomach", "Legs", "Feet" }, AIMBOT },
            { refs.multipoint[1], { "Head", "Chest", "Arms", "Stomach", "Legs", "Feet" }, AIMBOT },
            { refs.unsafe, { "Head", "Chest", "Arms", "Stomach", "Legs", "Feet" }, AIMBOT },
            -- { refs.low_fps_mitigations, {'Force low accuracy boost','Disable multipoint: feet','Disable multipoint: arms','Disable multipoint: legs','Disable hitbox: feet','Lower hit chance precision','Limit targets per tick'}, AIMBOT},
            { refs.quickstop_options, {'Early','Slow motion','Duck','Fake duck','Move between shots','Ignore molotov','Taser'}, OTHER , function()
                return 'quickstop[1]', function(aim) return ui.get(aim) end
            end},
            { refs.prefer_bodyaim_disablers, {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot"}, OTHER , function()
                return 'prefer_bodyaim', function(aim) return ui.get(aim) end
            end},
            { refs.doubletap_stop, { "Slow motion", "Duck", "Move between shots" }, OTHER },
        }
    }

    local function clone(object, deep)
        local copy = {}
        for k, v in pairs(object) do
            if deep and type(v) == "table" then
                v = clone(v, deep)
            end
            copy[k] = v
        end

        return setmetatable(copy, getmetatable(object))
    end

    local pather = function(tbl, var)
        for k, v in pairs(tbl) do 
            if v == var then 
                return true 
            end 
        end

        return false
    end 

    local restring_rgba = function(tbl)
        return ('\a%02x%02x%02x%02x'):format(tbl[1], tbl[2], tbl[3], tbl[4])
    end 

    local contains = function(table, value)
        for i = 0, #table do
        if table[i] == value then
            return true
        end
        end

        return false
    end

    local compare_max = function(tbl)
        local max_value = 0
        for i = 1, #tbl do 
            local priority = tbl[i].priority
            max_value = math.max(priority, max_value)
        end

        return max_value
    end

    local str_to_func = function(str)
        return assert(loadstring(str))
    end

    local wipeout_same_priority = function(tbl, priority) 
        local illegal = {}
        local to_search
        for k, v in pairs(tbl) do 
            if v.priority == priority then 
                to_search = 1
                table.insert(illegal, tbl[k])
            elseif v.priority > priority then 
                table.insert(illegal, tbl[k])
            end
        end 

        if to_search then 
            for i = 1, #illegal do 
                illegal[i].priority = illegal[i].priority + 1
            end
        end
    end

    ex_weapon.relevant = {}
    ex_weapon.relavant_extended_ui_callback = {}
    ex_weapon.enabler = {}

    for k, v in pairs(weapon_name) do 
        ex_weapon.enabler[k] = ui.new_checkbox(AIMBOT[1], AIMBOT[2], 'Enable ' .. v .. ' config')
    end 

    ex_weapon.__builder = function(name, ref)

        local parameter, func, loc, ext, main_code
        local lists, configs, existed = {}, {}, {}
        local update_functions, extend_ui_callbacks = {}, {}
        local exporter = {}
        local cur_logic = 'default'

        for i, o in pairs(__init) do 
            for k, v in pairs(o) do 
                if ref == v[1] then 
                    parameter = v[2]
                    func = i
                    loc = v[3]
                    ext = v[4]
                end
            end 
        end

        if not parameter and func ~= 'new_checkbox' then 
            return
        end

        local origin_name = ui.name(ref)
        local cache = ui.new_string('__wpwp__' .. name)

        local last_state = '["Global","default"]'
        local state = '["Global","default"]'

        local state_debugger = ui.new_label('LUA', 'A', 'name:' .. name .. ' | '.. state)

        ui.set_visible(state_debugger, __DEBUG)

        client.set_event_callback('paint_ui', function()
            if not ex_weapon.relevant[name] then 
                return 
            end 
            ui.set(state_debugger, 'name:' .. name .. ' | '.. ex_weapon.relevant[name].ui_state)
        end)

        local function creater(E, CLR, ...)
            local single = {}

            local names = origin_name
            local loc_1, loc_2 = unpack(loc)

            if E then 
                if CLR and type(CLR) == 'table' then 
                    names = '[' .. restring_rgba(CLR) .. E .. restring_rgba({220, 220, 220, 255}) .. '] ' .. names
                elseif string.find(E, '\a') then 
                    names = '[' .. E .. restring_rgba({220, 220, 220, 255}) .. '] ' .. names
                else 
                    names = '[' .. E .. '] ' .. names
                end

                loc_1, loc_2 = unpack(OTHER)
            end

            for k, v in pairs(weapon_name) do 
                local list_ac = #lists+1
                if not lists[list_ac] then lists[list_ac] = {} end
                if not lists[list_ac][v] then lists[list_ac][v] = {} end 
                local created = ui[func](loc_1, loc_2, names .. '\n' .. v, ...)


                table.insert(exporter, created)
                table.insert(lists[list_ac][v], created)
                table.insert(single, created)
            end

            return single
        end

        if func == 'new_checkbox' then
            main_code = creater(nil, nil)
        else 
            main_code = creater(nil, nil, unpack(parameter))
        end
        
        local function add_logic(logic_name, priority, paper, created)
            local max_priority = compare_max(configs)
            wipeout_same_priority(configs, priority)

            if priority > max_priority then 
                priority = max_priority + 1
            end

            table.insert(configs, {name = logic_name, func = paper, ref = created, priority = priority})
            table.insert(existed, logic_name)
        end

        local function new_logic(logic_name, priority, paper, alias_clr, adaptive)
            if pather(existed, logic_name) or logic_name == 'default' then 
                print('[error] logic name existed'); return
            end

            if adaptive then 
                add_logic(logic_name, priority, paper, nil)
                return 
            end

            if type(paper) == 'function' then 
                local new_create
                if func == 'new_checkbox' then
                    new_create = creater(logic_name, alias_clr)
                else 
                    new_create = creater(logic_name, alias_clr, unpack(parameter))
                end

                add_logic(logic_name, priority, paper, new_create)
            elseif type(paper) == 'string' then
                if pcall(str_to_func, paper) then 
                    local new_create
                    if func == 'new_checkbox' then
                        new_create = creater(logic_name, alias_clr)
                    else 
                        new_create = creater(logic_name, alias_clr, unpack(parameter))
                    end

                    add_logic(logic_name, priority, str_to_func(paper), new_create)
                else 
                    print('[error] illegal function')
                end
            else
                print('[error] illegal type')
            end
        end

        local function delete_logic(logic_name, renewing)
            local illegal = {}
            local to_search
            for k, v in pairs(configs) do 
                if v.name == logic_name then 
                    to_search = v.priority

                    table.remove(ex_weapon.relevant[name].configs, k)
                end
            end 
        
            if to_search then 
                for k, v in pairs(configs) do 
                    if v.priority > to_search then 
                        ex_weapon.relevant[name].configs[k].priority = ex_weapon.relevant[name].configs[k].priority - 1
                    end 
                end 
            else
                print('[error] cant find logic ', logic_name)
            end
        end

        local function renew_priority(logic_name, new_priority)
            local pathe
            for k,v in pairs(configs) do 
                if v.name == logic_name then 
                    pathe = configs[k]
                end
            end 

            if not pathe then 
                print('[error] cant find logic ', logic_name); return
            end

            local old_priority = clone(pathe, true)

            delete_logic(logic_name)

            add_logic(logic_name, new_priority, old_priority.func, old_priority.ref)
        end

        local function list_logic()
            print('listing ' .. origin_name .. ' logic')
            local configs_copy = clone(configs, true)
            table.sort(configs_copy, function(a, b) return a.priority > b.priority end)
            for k, v in pairs(configs_copy) do 
                print('priority: ', v.priority, ' name: ', v.name)
            end 
        end

        local function get_logic_refs(logic_name)
            for k=1, #configs do 
                if configs[k].name == logic_name then 
                    return configs[k].ref 
                end
            end
        end

        local function callback()
            -- print(ex_weapon.relevant[name].ui_state)
            local resort = json.parse(ex_weapon.relevant[name].ui_state)
            if resort ~= json.parse(last_state) or resort[3] then 
                local weapon, logic, adaptive = resort[1], resort[2], resort[3]

                if ex_weapon.relevant[name] then
                    ex_weapon.relevant[name].cur_logic = logic
                end

                if adaptive then 
                    if pcall(json.parse, adaptive) and type(json.parse(adaptive)) == 'table' then 
                        adaptive = json.parse(adaptive)
                    end 

                    if type(json.parse(adaptive)) == 'number' then 
                        adaptive = tonumber(adaptive)
                    end

                    ui.set(ref, adaptive)
                    return
                end 

                local weapon_ref
                if logic == 'default' then 
                    weapon_ref = main_code[name_to_num[weapon]]
                else 
                    weapon_ref = get_logic_refs(logic)[name_to_num[weapon]]
                end
        
                if type(ui.get(weapon_ref)) == 'table' and #ui.get(weapon_ref) == 0 and ui.name(ref) == 'Target hitbox' then 
                    ui.set(ref, {'Head'})
                    return
                end
        
                ui.set(ref, ui.get(weapon_ref))

                last_state = state
            end
        end

        if ext then
            local reason, result = ext()
            
            ex_weapon.relavant_extended_ui_callback[reason] = function()
                local target = search(reason)
                for weap, _ in pairs(target.main_code) do
                    for i ,o in pairs(lists[weap]) do 
                        for m, n in pairs(o) do 
                            ui.set_visible(n, result(target.main_code[weap]) and weapon_name[weap] == ui.get(weapon_selection))
                        end 
                    end
                end
            end
        end

        client.delay_call(0.05, function()
            local allextra_modes = {}

            local update_ui = {}

            for k, v in pairs(configs) do 
                table.insert(allextra_modes, v.name)
            end

            if #allextra_modes > 0 then
                for k, v in pairs(weapon_name) do
                    local uix = ui.new_multiselect(OTHER[1], OTHER[2], origin_name ..' Tweaks' .. '\n' .. v, allextra_modes)

                    table.insert(exporter, uix)

                    if not pcall(json.parse, ui.get(cache)) then
                        ui.set(cache, [[{"Deagle":{},"Revolver":{},"Taser":{},"AWP":{},"Rifle":{},"Global":{},"Pistol":{},"SMG":{},"Scout":{},"Auto":{},"Shotgun":{}}]])
                    end 

                    local parsed = json.parse(ui.get(cache))


                    if parsed and parsed[v] and type(parsed[v]) == 'string' then
                        ui.set(uix, json.parse(parsed[v]))
                    end

                    table.insert(update_ui, uix)

                    local uis_func = function(val)
                        local to_str = json.parse(ui.get(cache))
                        if not to_str[v] then 
                            to_str[v] = ''
                        end

                        to_str[v] = json.stringify(ui.get(uix))

                        ui.set(cache, json.stringify(to_str))

                        for i, o in pairs(configs) do 
                            if o.ref then
                                ui.set_visible(o.ref[k], contains(ui.get(uix), o.name))
                            end
                        end
                    end

                    ui.set_callback(uix, uis_func, true)

                    table.insert(update_functions, uis_func)

                    local weapon_name = ui.get(weapon_selection)

                    if v ~= weapon_name then 
                        ui.set_visible(uix, false) 
                    end
                end
            end

            ex_weapon.relevant[name].update = update_ui
        end)

        local function collecter()
            local uis = {}
            for m, n in pairs(lists) do
                for k, v in pairs(n) do
                    for i, o in pairs(v) do 
                        table.insert(uis, o)
                    end
                end
            end
        
            for k, v in pairs(configs) do 
                if v.ref then
                    for i, o in pairs(v.ref) do 
                        table.insert(uis, o)
                    end
                end
            end 
        
            for k, v in pairs(ex_weapon.relevant[name].update) do 
                table.insert(uis, v)
            end

            return uis
        end

        ex_weapon.relevant[name] = {
            cur_logic = cur_logic,
            reference = ref,
            ui_cache = cache,
            ui_list = lists,
            ui_state = state,
            configs = configs,
            new_logic = new_logic,
            list_logic = list_logic,
            renew_priority = renew_priority,
            delete_logic = delete_logic,
            get_logic_refs = get_logic_refs,
            callback = callback,
            collecter = collecter,
            update = {},
            update_functions = update_functions,
            main_code = main_code,
            exporter = exporter
        }
    end

    for i = 1, 21 do 
        local ref_name = refs_idx_to_name[i]
        local _ref = refs[ref_name]

        if type(_ref) == 'table' then 
            for k, v in pairs(_ref) do 
                ex_weapon.__builder(ref_name .. '['..k..']', v)
            end
        else 
            ex_weapon.__builder(ref_name, _ref)
        end
    end

    function search(ref_name)
        return ex_weapon.relevant[ref_name]
    end 

    local collect_uis = function(val, refer)
        --FIXIT:BAD CODE
        local ui_visible, ui_invisible = {}, {}

        for m, n in pairs(refer.ui_list) do
            for k, v in pairs(n) do
                for i, o in pairs(v) do 
                    if k == val then
                        table.insert(ui_visible, o)
                    else 
                        table.insert(ui_invisible, o)
                    end
                end
            end
        end

        for k, v in pairs(refer.configs) do 
            if v.ref then
                for i, o in pairs(v.ref) do 
                    if weapon_name[i] == val then
                        table.insert(ui_visible, o)
                    else 
                        table.insert(ui_invisible, o)
                    end
                end
            end
        end 

        for k, v in pairs(refer.update) do 
            if weapon_name[k] == val then
                table.insert(ui_visible, v)
            else 
                table.insert(ui_invisible, v)
            end
        end

        if ui.name(refer.reference) ~= 'Automatic scope' then
            for k, v in pairs(ui_visible) do 
                ui.set_visible(v, true)
            end
        else 
            for k, v in pairs(ui_visible) do 
                ui.set_visible(v, pather(scoped_wpn, val))
            end
        end
        
        for _, func in pairs(refer.update_functions) do 
            func()
        end

        for k, v in pairs(ui_invisible) do 
            ui.set_visible(v, false)
        end
    end

    local update_func = function()
        local val = ui.get(weapon_selection)
        for k, v in pairs(refs) do 
            if type(v) == 'table' then 
                for i, o in pairs(v) do 
                    local ref = search(k .. '['..i..']')
                    if ref then
                        collect_uis(val, ref)
                    end
                end
            else 
                local ref = search(k)
                if ref then
                    collect_uis(val, ref)
                end
            end
        end

        for k, v in pairs(ex_weapon.enabler) do 
            ui.set_visible(v, k == name_to_num[val])
        end 

        ui.set_visible(ex_weapon.enabler[1], false)

        for k, v in pairs(ex_weapon.relavant_extended_ui_callback) do 
            v(val)
        end
    end

    ui.set_callback(config_selection, function()
        if ui.get(config_selection) ~= lua_ui_location then
            database.write('lua_location', ui.get(config_selection))
            client.reload_active_scripts()
        end
    end, false)

    local init_func = function()
        --FIXIT: BAD CODE
        ui.set_visible(weapon_selection, ui.get(weapon_switch))
        ui.set_visible(update_weapon, ui.get(weapon_switch))
        if ui.get(weapon_switch) then 
            for k, v in pairs(refs) do 
                if type(v) == 'table' then 
                    for i, o in pairs(v) do 
                        local ref = search(k .. '['..i..']')
                        if ref then
                            client.set_event_callback('setup_command', ref.callback)
                            update_func()
                        end
                    end
                else 
                    local ref = search(k)
                    if ref then
                        client.set_event_callback('setup_command', ref.callback)
                        update_func()
                    end
                end
            end
        else 
            for k, v in pairs(refs) do 
                if type(v) == 'table' then 
                    for i, o in pairs(v) do 
                        local ref = search(k .. '['..i..']')
                        if ref then
                            client.unset_event_callback('setup_command', ref.callback)
                            for k, v in pairs(ref.collecter()) do 
                                ui.set_visible(v, false)
                            end
                        end
                    end
                else 
                    local ref = search(k)
                    if ref then
                        client.unset_event_callback('setup_command', ref.callback)
                        for k, v in pairs(ref.collecter()) do 
                            ui.set_visible(v, false)
                        end
                    end
                end
            end

            for k, v in pairs(ex_weapon.enabler) do 
                ui.set_visible(v, false)
            end 
        end
    end

    for target_name, func in pairs(ex_weapon.relavant_extended_ui_callback) do 
        local target_main_code = search(target_name).main_code 
        for k, v in pairs(weapon_name) do 
            ui.set_callback(target_main_code[k], func)
        end 
    end

    ui.set_callback(weapon_selection, update_func, true)
    ui.set_callback(weapon_switch, init_func, true)
    client.delay_call(0.1, init_func)

    local renew_state = function(e, i_weapon_name, prefer, r_name)
        if not prefer then 
            return 
        end 
        
        local modes = prefer.configs
        table.sort(modes, function(a, b) 
            return a.priority > b.priority 
        end)

        local state = prefer.ui_state

        local resort = json.parse(state)
        local weapon, logic = resort[1], resort[2]

        i_weapon_name = weapon_name[i_weapon_name]

        if #modes ~= 0 then
            state = json.stringify({i_weapon_name, 'default'})
            for idx = 1, #modes do
                local mode = modes[idx]
                if #prefer.update > 0 then
                    local running, adaptive = mode.func(e)
                    local mode_should_run = running and contains(ui.get(prefer.update[name_to_num[weapon]]), mode.name)
                    if mode_should_run then
                        if adaptive then
                            state = json.stringify({i_weapon_name, mode.name, adaptive})
                        else 
                            state = json.stringify({i_weapon_name, mode.name})
                        end 
                    end
                end
            end
        else 
            if i_weapon_name ~= weapon then 
                state = json.stringify({i_weapon_name, 'default'})
            end
        end

        ex_weapon.relevant[r_name].ui_state = state
    end


    client.set_event_callback("setup_command", function(e)
        local weapon_idx = get_weapon_idx()
        if not ui.get(ex_weapon.enabler[weapon_idx]) then 
            weapon_idx = 1 
        end

        for k, v in pairs(refs) do 
            if type(v) == 'table' then 
                for i, o in pairs(v) do
                    renew_state(e, weapon_idx, search(k .. '['..i..']'), k .. '['..i..']')
                end
            else 
                renew_state(e, weapon_idx, search(k), k)
            end
        end

        if ui.get(update_weapon) and not ui.is_menu_open() then 
            ui.set(weapon_selection, weapon_name[weapon_idx])
        end
    end)

    client.set_event_callback("paint_ui", function()
        for k, v in pairs(refs) do 
            if type(v) == 'table' then 
                for i, o in pairs(v) do
                    ui.set_visible(o, __DEBUG)
                end
            else 
                ui.set_visible(v, __DEBUG)
            end
        end
    end)

    local function export_json()
        local tbl = {}
        for k, v in pairs(refs) do 
            if type(v) == 'table' then 
                for i, o in pairs(v) do 
                    local ref = search(k .. '['..i..']')
                    if ref then
                        for k, v in pairs(ref.exporter) do 
                            tbl[ui.name(v)] = ui.get(v)
                        end 
                    end
                end
            else 
                local ref = search(k)
                if ref then
                    for k, v in pairs(ref.exporter) do 
                        tbl[ui.name(v)] = ui.get(v)
                    end 
                end
            end
        end

        clipboard.set(json.stringify(tbl))
    end

    local function import_json()
        local tbl = json.parse(clipboard.get())
        for k, v in pairs(refs) do 
            if type(v) == 'table' then 
                for i, o in pairs(v) do 
                    local ref = search(k .. '['..i..']')
                    if ref then
                        for k, v in pairs(ref.exporter) do 
                            ui.set(v, tbl[ui.name(v)])
                        end 
                    end
                end
            else 
                local ref = search(k)
                if ref then
                    for k, v in pairs(ref.exporter) do 
                        ui.set(v, tbl[ui.name(v)])
                    end 
                end
            end
        end
    end

    return search, weapon_switch, AIMBOT, export_json, import_json
end)()


-- example:
    local hitchance = weapon('hitchance')
    local damage = weapon('mindamage')

    local dmg_on_key = ui.new_hotkey(location[1], location[2], 'override damage on key', false, 0x00)
    local hc_on_key = ui.new_hotkey(location[1], location[2], 'override hitchance on key', false, 0x00)

    client.set_event_callback('paint_ui', function()
        ui.set_visible(dmg_on_key, ui.get(switch))
        ui.set_visible(hc_on_key, ui.get(switch))
    end)

    hitchance.new_logic('In Air', 2, function()
        return bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0
    end, {255, 255, 0, 255}) 

    hitchance.new_logic('On Key', 1, function()
        return ui.get(hc_on_key)
    end, {255, 255, 0, 255}) 

    hitchance.list_logic() 

    hitchance.renew_priority('On Key', 5)

    hitchance.list_logic() 

    damage.new_logic('On Key', 1, function()
        return ui.get(dmg_on_key)
    end)
-- 

client.delay_call(0.5, function()
    local export = ui.new_button('LUA', 'A', 'export to clipboard', exporter)
    local import = ui.new_button('LUA', 'A', 'import from clipboard', importer)

    client.set_event_callback('paint_ui', function()
        ui.set_visible(export, ui.get(switch))
        ui.set_visible(import, ui.get(switch))
    end)
end)