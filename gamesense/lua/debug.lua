-- References

local pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local yaw, yawslider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local yawjitter, yawyjitterslider = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local bodyyaw, bodyyawslider = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local freestandingbodyyaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local fakeyawlimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")

local privbot = ui.new_checkbox("AA", "Anti-aimbot angles", "Debug this shit")
local minvalfyaw = 60
local maxvalfyaw = 0
local minvalyawjitter = 60
local maxvalyawjitter = 0
local minbodyyaw = 180
local maxbodyyaw = -180

local function on_paint()
    local width, height = client.screen_size()
	
	if minvalfyaw >= ui.get(fakeyawlimit) then
		minvalfyaw = ui.get(fakeyawlimit)
	end
	
	if maxvalfyaw <= ui.get(fakeyawlimit) then
		maxvalfyaw = ui.get(fakeyawlimit)
	end
	
	if minvalyawjitter >= ui.get(yawyjitterslider) then
		minvalyawjitter = ui.get(yawyjitterslider)
	end
	
	if maxvalyawjitter <= ui.get(yawyjitterslider) then
		maxvalyawjitter = ui.get(yawyjitterslider)
	end
	
	if minbodyyaw >= ui.get(bodyyawslider) then
		minbodyyaw = ui.get(bodyyawslider)
	end
	
	if maxbodyyaw <= ui.get(bodyyawslider) then
		maxbodyyaw = ui.get(bodyyawslider)
	end
	
	if ui.get(privbot) then
		renderer.text(100, 100, 255, 255, 255, 255, 'b', 0, "Pitch: ")
		renderer.text(100 + 140, 100, 255, 255, 255, 255, 'b', 0, ui.get(pitch))
		renderer.text(100, 120, 255, 255, 255, 255, 'b', 0, "Yaw base: ")
		renderer.text(100 + 140, 120, 255, 255, 255, 255, 'b', 0, ui.get(yawbase))
		renderer.text(100, 140, 255, 255, 255, 255, 'b', 0, "Yaw: ")
		renderer.text(100 + 140, 140, 255, 255, 255, 255, 'b', 0, ui.get(yaw))
		renderer.text(100, 160, 255, 255, 255, 255, 'b', 0, "Yaw Slider: ")
		renderer.text(100 + 140, 160, 255, 255, 255, 255, 'b', 0, ui.get(yawslider))
		renderer.text(100, 180, 255, 255, 255, 255, 'b', 0, "Yaw jitter: ")
		renderer.text(100 + 140, 180, 255, 255, 255, 255, 'b', 0, ui.get(yawjitter))
		renderer.text(100, 200, 255, 255, 255, 255, 'b', 0, "Yaw jitter slider: ")
		renderer.text(100 + 140, 200, 255, 255, 255, 255, 'b', 0, ui.get(yawyjitterslider))
		renderer.text(100 + 220, 200, 255, 255, 255, 255, 'b', 0, "Yaw jitter min limit: ")
		renderer.text(100 + 360, 200, 255, 255, 255, 255, 'b', 0, minvalyawjitter)
		renderer.text(100 + 440, 200, 255, 255, 255, 255, 'b', 0, "Yaw jitter max limit: ")
		renderer.text(100 + 580, 200, 255, 255, 255, 255, 'b', 0, maxvalyawjitter)
		renderer.text(100, 220, 255, 255, 255, 255, 'b', 0, "Bodyyaw: ")
		renderer.text(100 + 140, 220, 255, 255, 255, 255, 'b', 0, ui.get(bodyyaw))
		renderer.text(100, 240, 255, 255, 255, 255, 'b', 0, "Bodyyaw slider: ")
		renderer.text(100 + 140, 240, 255, 255, 255, 255, 'b', 0, ui.get(bodyyawslider))
		renderer.text(100 + 220, 240, 255, 255, 255, 255, 'b', 0, "Bodyyaw min limit: ")
		renderer.text(100 + 360, 240, 255, 255, 255, 255, 'b', 0, minbodyyaw)
		renderer.text(100 + 440, 240, 255, 255, 255, 255, 'b', 0, "Bodyyaw max limit: ")
		renderer.text(100 + 580, 240, 255, 255, 255, 255, 'b', 0, maxbodyyaw)
		renderer.text(100, 260, 255, 255, 255, 255, 'b', 0, "Freestanding bodyyaw: ")
		renderer.text(100 + 140, 260, 255, 255, 255, 255, 'b', 0, ui.get(freestandingbodyyaw))
		renderer.text(100, 280, 255, 255, 255, 255, 'b', 0, "Fakeyaw limit: ")
		renderer.text(100 + 140, 280, 255, 255, 255, 255, 'b', 0, ui.get(fakeyawlimit))
		renderer.text(100 + 220, 280, 255, 255, 255, 255, 'b', 0, "Fakeyaw min limit: ")
		renderer.text(100 + 360, 280, 255, 255, 255, 255, 'b', 0, minvalfyaw)
		renderer.text(100 + 440, 280, 255, 255, 255, 255, 'b', 0, "Fakeyaw max limit: ")
		renderer.text(100 + 580, 280, 255, 255, 255, 255, 'b', 0, maxvalfyaw)
		renderer.text(100, 300, 255, 255, 255, 255, 'b', 0, "Edge Yaw: ")
		renderer.text(100 + 140, 300, 255, 255, 255, 255, 'b', 0, ui.get(edge_yaw))
	end
end
client.set_event_callback('paint', on_paint)