--------------------------------------------------------------------------------
-- Caching common functions
--------------------------------------------------------------------------------
local client_exec, client_set_event_callback, table_sort, ui_get, ui_new_checkbox, ui_new_combobox, ui_new_multiselect, ui_set_callback, ui_set_visible, pairs = client.exec, client.set_event_callback, table.sort, ui.get, ui.new_checkbox, ui.new_combobox, ui.new_multiselect, ui.set_callback, ui.set_visible, pairs

--------------------------------------------------------------------------------
-- Utility functions
--------------------------------------------------------------------------------
local function collect_keys(tbl, init)
    local keys = init or {}
    for k in pairs(tbl) do
        keys[#keys + 1] = k
    end
    table_sort(keys)
    return keys
end

--------------------------------------------------------------------------------
-- Constants and variables
--------------------------------------------------------------------------------
local primary_console = {
    ["Auto"]    = "scar20",
    ["Scout"]   = "ssg08",
    ["Awp"]     = "awp",
    ["Rifle"]   = "ak47",
    ["Scoped"]  = "sg556",
    ["Negev"]   = "negev",
}

local secondary_console = {
    ["Default pistol"]  = "glock",
    ["P250"]            = "p250",
    ["Elites"]          = "elite",
    ["Light pistol"]    = "tec9",
    ["Heavy pistol"]    = "deagle",
}

local utility_console = {
    ["Armor"]   = "vesthelm",
    ["Zeus"]    = "taser",
    ["Kit"]     = "defuser",
    ["Molotov"] = "molotov",
    ["Decoy"]   = "decoy",
    ["Flash"]   = "flashbang",
    ["Grenade"] = "hegrenade",
    ["Smoke"]   = "smokegrenade",
}

--------------------------------------------------------------------------------
-- Menu
--------------------------------------------------------------------------------
local buy_bot   = ui_new_checkbox("LUA", "B", "Buy bot")
local primary   = ui_new_combobox("LUA", "B", "Primary weapon", collect_keys(primary_console, {"-"}))
local secondary = ui_new_combobox("LUA", "B", "Secondary weapon", collect_keys(secondary_console, {"-"}))
local utility   = ui_new_multiselect("LUA", "B", "Utility", collect_keys(utility_console))

local function handle_menu()
    local state = ui_get(buy_bot)
    ui_set_visible(primary, state)
    ui_set_visible(secondary, state)
    ui_set_visible(utility, state)
end

handle_menu()
ui_set_callback(buy_bot, handle_menu)

--------------------------------------------------------------------------------
-- Game event handling
--------------------------------------------------------------------------------
local function round_end_upload_stats()
    local localPlayerMoney = entity.get_prop(entity.get_local_player(), "m_iAccount")

    if not ui.get(buy_bot) or localPlayerMoney <= 800 then
        return
    end

    local buy = ""
    local util = ui_get(utility)
    local primary = ui_get(primary)
    local secondary = ui_get(secondary)

    buy = primary == "-" and buy or buy .. "buy " .. primary_console[primary] .. "; "
    buy = secondary == "-" and buy or buy .. "buy " .. secondary_console[secondary] .. "; "
    for i=1, #util do
        local item = utility_console[util[i]]
        buy = buy .. "buy " .. item .. "; "
    end
    if buy == "" then
        return
    end
    client_exec(buy)
end

client_set_event_callback("round_end_upload_stats", round_end_upload_stats)