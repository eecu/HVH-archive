local panorama_disable_blur = cvar["@panorama_disable_blur"]
local menuElement = ui.new_checkbox("VISUALS", "Effects", "Disable panorama blur")

local function cvarSet()
    panorama_disable_blur:set_raw_int(ui.get(menuElement) and 1 or 0)
end
ui.set_callback(menuElement, cvarSet)