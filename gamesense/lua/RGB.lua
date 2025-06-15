local width, height = client.screen_size()

local function hsv_to_rgb(h, s, v, a)
    local r, g, b

    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return r * 255, g * 255, b * 255, a * 255
end

local function func_rgb_rainbowize(frequency, rgb_split_ratio)
    local r, g, b, a = hsv_to_rgb(globals.realtime() * frequency, 1, 1, 1)

    r = r * rgb_split_ratio
    g = g * rgb_split_ratio
    b = b * rgb_split_ratio

    return r, g, b
end

local function on_paint(ctx)
	
local r, g, b = func_rgb_rainbowize(0.1, 1)

		renderer.gradient(0, 0, width, 4, r, g, b, 255, r, b, g, 255, true)
		renderer.gradient(width - 4, 0, 4, height, r, b, g, 255, g, b, r, 255, false)
		renderer.gradient(0, height - 4, width, 4, g, r, b, 255, g, b, r, 255, true)
		renderer.gradient(0, 0, 4, height, r, g, b, 255, g, r, b, 255, false)
	
end

client.set_event_callback("paint", on_paint)