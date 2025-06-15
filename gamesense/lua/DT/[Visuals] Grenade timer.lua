local Vector = require('vector')
local MultiCombo = ui.new_multiselect('VISUALS', 'Other ESP', 'Grenades: Timer', 'Text' ,'Bar')
local Fire = ui.new_checkbox('VISUALS', 'Other ESP', 'Grenades: Molotov radius')
local FireColorPicker = ui.new_color_picker('VISUALS', 'Other ESP', 'Grenades: Molotov radius', 245, 126, 66)
local Smoke = ui.new_checkbox('VISUALS', 'Other ESP', 'Grenades: Smoke radius')
local SmokeColorPicker = ui.new_color_picker('VISUALS', 'Other ESP', 'Grenades: Smoke radius', 201, 201, 201)



local SmokeLife = 17.55
local FireLife = 7
local TicksToFadeSmoke = 15
local TicksToFadeFire = 64

local ScreenSize = Vector(client.screen_size())
local RadianPI = math.pi * 2

local function GetDist(Point1, Point2)
	return math.sqrt((Point2.x - Point1.x) ^ 2 + (Point2.y - Point1.y) ^ 2 + (Point2.z - Point1.z) ^ 2)
end

local function Clamp(V, Min, Max)
	if V < Min then
		return Min
	elseif V > Max then
		return Max
	end
	return V
end

local function MultiSelectCompare(MultiSelect, Value)
	for i, v in pairs(MultiSelect) do
		if v == Value then 
		return true end
	end
	return false
end
local MultiSelect = ui.get(MultiCombo)
local UseBar = MultiSelectCompare(MultiSelect, 'Bar')
local UseText = MultiSelectCompare(MultiSelect, 'Text')
local LocalPlayer = entity.get_local_player()
local function SmokeCircle(Radius, Length, Angle, Color, Index)
	local Increment = 0.1
	local StartLoop = Angle
	local EndLoop = Angle + Length
	local HasStarted = entity.get_prop(Index, 'm_bDidSmokeEffect') == 1
	if not HasStarted then 
		return end
	local TableOrgin = {entity.get_prop(Index, 'm_vecOrigin')}
	local Orgin = Vector(TableOrgin[1], TableOrgin[2], TableOrgin[3])
	local OrginX, OrginY = renderer.world_to_screen(Orgin.x, Orgin.y, Orgin.z)
	local TimeStarted = entity.get_prop(Index, 'm_nSmokeEffectTickBegin')
	local Delta = (globals.tickcount() - TimeStarted)
	local CurtimeDelta = globals.tickinterval() * Delta
	local FadeIn = ((Delta < TicksToFadeSmoke and Delta or TicksToFadeSmoke) / TicksToFadeSmoke)
	local FadeOut = Clamp((1 - CurtimeDelta / SmokeLife), 0, 1)
	if FadeIn ~= 1 then Radius = Radius * FadeIn end
	for i = StartLoop, EndLoop, Increment do
		local NextAngle = (i + Increment) > EndLoop and EndLoop or (i + Increment)
		local FirstPos = Vector(Orgin.x + Radius * math.cos(i), Orgin.y + Radius * math.sin(i))
		local SecondPos = Vector(Orgin.x + Radius * math.cos(NextAngle), Orgin.y + Radius * math.sin(NextAngle))
		local X1, Y1 = renderer.world_to_screen(FirstPos.x, FirstPos.y, Orgin.z)
		local X2, Y2 = renderer.world_to_screen(SecondPos.x, SecondPos.y, Orgin.z)
		if not (X1 == nil or X2 == nil) then
			local Alpha = 255
			if FadeIn ~= 1 then Alpha = 255 * FadeIn end
			if FadeOut < 0.2 then Alpha = 255 * (FadeOut + FadeOut * 4) end
			renderer.line(X1, Y1, X2,Y2, Color[1], Color[2], Color[3], Alpha)
		end
	end
	if Color[4] > 1 then
		for i = 0, RadianPI, Increment do
			local NextAngle = (i + Increment) > RadianPI and 0 or (i + Increment)
			local FirstPos = Vector(Orgin.x + Radius * math.cos(i), Orgin.y + Radius * math.sin(i))
			local SecondPos = Vector(Orgin.x + Radius * math.cos(NextAngle), Orgin.y + Radius * math.sin(NextAngle))
			local X1, Y1 = renderer.world_to_screen(FirstPos.x, FirstPos.y, Orgin.z)
			local X2, Y2 = renderer.world_to_screen(SecondPos.x, SecondPos.y, Orgin.z)
			if not (X1 == nil or X2 == nil or OrginX == nil) then
				local Alpha = Color[4]
				if FadeIn ~= 1 then Alpha = Color[4] * FadeIn end
				if FadeOut < 0.2 then Alpha = Color[4] * (FadeOut + FadeOut * 4) end
				renderer.triangle(X1, Y1, X2, Y2, OrginX, OrginY, Color[1], Color[2], Color[3], Alpha)
			end
		end
	end
	if OrginX ~= nil and (SmokeLife - CurtimeDelta) > 0 then
		local FadePercent = 1
		if FadeOut < 0.2 then FadePercent = (FadeOut + FadeOut * 4) end
		if UseBar then
			local Width = 26;
			local X = (OrginX - Width / 2) + 2
			local Percent = Clamp((1 - (CurtimeDelta / SmokeLife)), 0, 1)
			renderer.rectangle(X, OrginY + 17, Width, 4, 0, 0, 0, 150 * FadePercent)
			renderer.rectangle(X + 1, OrginY + 18, Clamp((Width * Percent) - 2, 0, Width), 2, Color[1], Color[2], Color[3], 255)
		end
		if UseText then
			renderer.text(OrginX, OrginY + (UseBar and 25 or 20), 255, 255, 255, 200 * FadePercent, 'c-', 0, string.format('%.1f', SmokeLife - CurtimeDelta))
		end
	end
end

local function MollyCircle(Orgin, Radius, Length, Angle, Color, Index)
	local Increment = 0.1
	local StartLoop = Angle
	local EndLoop = Angle + Length
	local TimeStarted = entity.get_prop(Index, 'm_nFireEffectTickBegin')
	local Delta = (globals.tickcount() - TimeStarted)
	local CurtimeDelta = globals.tickinterval() * Delta
	local FadeIn = ((Delta < TicksToFadeFire and Delta or TicksToFadeFire) / TicksToFadeFire)
	local FadeOut = Clamp((1 - CurtimeDelta / FireLife), 0, 1)
	for i = StartLoop, EndLoop, Increment do
		local NextAngle = (i + Increment) > EndLoop and EndLoop or (i + Increment)
		local FirstPos = Vector(Orgin.x + Radius * math.cos(i), Orgin.y + Radius * math.sin(i))
		local SecondPos = Vector(Orgin.x + Radius * math.cos(NextAngle), Orgin.y + Radius * math.sin(NextAngle))
		local X1, Y1 = renderer.world_to_screen(FirstPos.x, FirstPos.y, Orgin.z)
		local X2, Y2 = renderer.world_to_screen(SecondPos.x, SecondPos.y, Orgin.z)
		if (X1 ~= nil and X2 ~= nil) then
			local Alpha = 255
			if FadeIn ~= 1 then Alpha = 255 * FadeIn end
			if FadeOut < 0.2 then Alpha = 255 * (FadeOut + FadeOut * 4) end
			renderer.line(X1, Y1, X2,Y2, Color[1], Color[2], Color[3], Alpha)
		end
	end
	local OrginX, OrginY = renderer.world_to_screen(Orgin.x, Orgin.y, Orgin.z)
	if Color[4] > 1 then
		for i = 0, RadianPI, Increment do
			local NextAngle = (i + Increment) > RadianPI and 0 or (i + Increment)
			local FirstPos = Vector(Orgin.x + Radius * math.cos(i), Orgin.y + Radius * math.sin(i))
			local SecondPos = Vector(Orgin.x + Radius * math.cos(NextAngle), Orgin.y + Radius * math.sin(NextAngle))
			local X1, Y1 = renderer.world_to_screen(FirstPos.x, FirstPos.y, Orgin.z)
			local X2, Y2 = renderer.world_to_screen(SecondPos.x, SecondPos.y, Orgin.z)
			if not (X1 == nil or X2 == nil or OrginX == nil) then
				local Alpha = Color[4]
				if FadeIn ~= 1 then Alpha = Color[4] * FadeIn end
				if FadeOut < 0.2 then Alpha = Color[4] * (FadeOut + FadeOut * 4) end
				renderer.triangle(X1, Y1, X2, Y2, OrginX, OrginY, Color[1], Color[2], Color[3], Alpha)
			end
		end
	end
    local OriginTable = {entity.get_prop(Index, 'm_vecOrigin')}
	local RealOrgin = Vector(OriginTable[1], OriginTable[2], OriginTable[3])
	OrginX, OrginY = renderer.world_to_screen(RealOrgin.x, RealOrgin.y, RealOrgin.z)
	if OrginX ~= nil and (FireLife - CurtimeDelta) > 0 then
		local FadePercent = 1
		if FadeOut < 0.2 then FadePercent = (FadeOut + FadeOut * 4) end
		if UseBar then
			local Width = 26;
			local X = (OrginX - Width / 2) + 2
			local Percent = Clamp((1 - (CurtimeDelta / FireLife)), 0, 1)
			renderer.rectangle(X, OrginY + 17, Width, 4, 0, 0, 0, 150 * FadePercent)
			renderer.rectangle(X + 1, OrginY + 18, Clamp((Width * Percent) - 2, 0, Width), 2, Color[1], Color[2], Color[3], 255)
		end
		if UseText then
			renderer.text(OrginX, OrginY + (UseBar and 25 or 20), 255, 255, 255, 200 * FadePercent, 'c-', 0, string.format('%.1f', FireLife - CurtimeDelta))
		end
		local Owner = entity.get_prop(Index, 'm_hOwnerEntity')
		local IsTeamate = entity.get_prop(Owner, 'm_iTeamNum') == entity.get_prop(LocalPlayer, 'm_iTeamNum') and Owner ~= LocalPlayer
		local TeamColor = {153, 255, 0}
		local EnemyColor = {255, 60, 0}
		local Color = IsTeamate and TeamColor or EnemyColor
		renderer.text(OrginX, OrginY + 4, Color[1], Color[2], Color[3], 200 * FadePercent, 'c-', 0, 'SAFE')
	end
end


local Angle = 0
client.set_event_callback('paint', function ()
	MultiSelect = ui.get(MultiCombo)
	UseBar = MultiSelectCompare(MultiSelect, 'Bar')
	UseText = MultiSelectCompare(MultiSelect, 'Text')
	LocalPlayer = entity.get_local_player()

	Angle = Angle + ((RadianPI / 1.25) * globals.frametime()) 	if Angle > RadianPI then Angle = 0 end

	if ui.get(Smoke) then
		local SmokeColor = {ui.get(SmokeColorPicker)}
		for I, Index in pairs(entity.get_all('CSmokeGrenadeProjectile')) do
			SmokeCircle(125, RadianPI * 0.5, Angle, SmokeColor, Index)
		end
	end
	if ui.get(Fire) then
		local FireColor = {ui.get(FireColorPicker)}
		for V, Index in pairs(entity.get_all('CInferno')) do
			local OriginTable = {entity.get_prop(Index, 'm_vecOrigin')}
			local Origin = Vector(OriginTable[1], OriginTable[2], OriginTable[3])
			local Points = {}
			for i = 1, 20 do
				local Delta = Vector(entity.get_prop(Index, "m_fireXDelta", i), entity.get_prop(Index, "m_fireYDelta", i), entity.get_prop(Index, "m_fireZDelta", i))
				local Point = Delta + Origin
				Points[i] = Point
			end
			local I1, I2 = 1, 1
			local BestDist = 0
			for i = 1, #Points do
				local CPoint = Points[i]
                CPoint.z = OriginTable[3]
				for j = 1, #Points do
					local NPoint = Points[j]
                    NPoint.z = OriginTable[3]
					local Dist = GetDist(CPoint, NPoint)
					if Dist > BestDist then
						BestDist = Dist
						I1, I2 = i, j
					end
				end
			end
			local FarthestPoint = Points[I1]
			local SecondFarthestPoint = Points[I2]
			local MidPoint = Vector((FarthestPoint.x + SecondFarthestPoint.x) / 2, (FarthestPoint.y + SecondFarthestPoint.y) / 2, (FarthestPoint.z + SecondFarthestPoint.z) / 2)
			MollyCircle(MidPoint, BestDist * 0.65, RadianPI * 0.25, Angle, FireColor, Index)
		end
	end
end)
