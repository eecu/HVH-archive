local base64={}local extract=_G.bit32 and _G.bit32.extract if not extract then if _G.bit then local shl,shr,band=_G.bit.lshift,_G.bit.rshift,_G.bit.band extract=function(v,from,width)return band(shr(v,from),shl(1,width)-1)end elseif _G._VERSION=="Lua 5.1"then extract=function(v,from,width)local w=0 local flag=2^from for i=0,width-1 do local flag2=flag+flag if v%flag2>=flag then w=w+2^i end flag=flag2 end return w end else extract=load[[return function( v, from, width )
	return ( v >> from ) & ((1 << width) - 1)
end]]()end end function base64.makeencoder(s62,s63,spad)local encoder={}for b64code,char in pairs{[0]='A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9',s62 or'+',s63 or'/',spad or'='}do encoder[b64code]=char:byte()end return encoder end function base64.makedecoder(s62,s63,spad)local decoder={}for b64code,charcode in pairs(base64.makeencoder(s62,s63,spad))do decoder[charcode]=b64code end return decoder end local DEFAULT_ENCODER=base64.makeencoder()local DEFAULT_DECODER=base64.makedecoder()local char,concat=string.char,table.concat function base64.encode(str,encoder,usecaching)encoder=encoder or DEFAULT_ENCODER local t,k,n={},1,#str local lastn=n%3 local cache={}for i=1,n-lastn,3 do local a,b,c=str:byte(i,i+2)local v=a*0x10000+b*0x100+c local s if usecaching then s=cache[v]if not s then s=char(encoder[extract(v,18,6)],encoder[extract(v,12,6)],encoder[extract(v,6,6)],encoder[extract(v,0,6)])cache[v]=s end else s=char(encoder[extract(v,18,6)],encoder[extract(v,12,6)],encoder[extract(v,6,6)],encoder[extract(v,0,6)])end t[k]=s k=k+1 end if lastn==2 then local a,b=str:byte(n-1,n)local v=a*0x10000+b*0x100 t[k]=char(encoder[extract(v,18,6)],encoder[extract(v,12,6)],encoder[extract(v,6,6)],encoder[64])elseif lastn==1 then local v=str:byte(n)*0x10000 t[k]=char(encoder[extract(v,18,6)],encoder[extract(v,12,6)],encoder[64],encoder[64])end return concat(t)end function base64.decode(b64,decoder,usecaching)decoder=decoder or DEFAULT_DECODER local pattern='[^%w%+%/%=]'if decoder then local s62,s63 for charcode,b64code in pairs(decoder)do if b64code==62 then s62=charcode elseif b64code==63 then s63=charcode end end pattern=('[^%%w%%%s%%%s%%=]'):format(char(s62),char(s63))end b64=b64:gsub(pattern,'')local cache=usecaching and{}local t,k={},1 local n=#b64 local padding=b64:sub(-2)=='=='and 2 or b64:sub(-1)=='='and 1 or 0 for i=1,padding>0 and n-4 or n,4 do local a,b,c,d=b64:byte(i,i+3)local s if usecaching then local v0=a*0x1000000+b*0x10000+c*0x100+d s=cache[v0]if not s then local v=decoder[a]*0x40000+decoder[b]*0x1000+decoder[c]*0x40+decoder[d]s=char(extract(v,16,8),extract(v,8,8),extract(v,0,8))cache[v0]=s end else local v=decoder[a]*0x40000+decoder[b]*0x1000+decoder[c]*0x40+decoder[d]s=char(extract(v,16,8),extract(v,8,8),extract(v,0,8))end t[k]=s k=k+1 end if padding==1 then local a,b,c=b64:byte(n-3,n-1)local v=decoder[a]*0x40000+decoder[b]*0x1000+decoder[c]*0x40 t[k]=char(extract(v,16,8),extract(v,8,8))elseif padding==2 then local a,b=b64:byte(n-3,n-2)local v=decoder[a]*0x40000+decoder[b]*0x1000 t[k]=char(extract(v,16,8))end return concat(t)end local function ascii_base(s)return s:lower()==s and('a'):byte()or('A'):byte()end local function caesar_cipher(str,key)return(str:gsub('%a',function(s)local base=ascii_base(s)return string.char(((s:byte()-base+key)%26)+base)end))end local function cipher(str,array)return caesar_cipher(str,array)end local function decipher(str,array)return caesar_cipher(str,-array)end local function split(text,chunkSize)local s={}for i=1,#text,chunkSize do s[#s+1]=text:sub(i,i+chunkSize-1)end return s end local function encrypt(inp,offset)a=base64.encode(inp)chunks=split(a,offset)for _,line in ipairs(chunks)do num=math.random(1,9)chunks[_]=cipher(line,num)..num end return table.concat(chunks)end local function decrypt(inp,offset)chunks=split(inp,offset+1)for _,line in ipairs(chunks)do a=string.sub(line,-1)b=line:sub(1,string.len(line)-1)c=decipher(b,a)chunks[_]=c end d=table.concat(chunks)e=base64.decode(d)return(e)end

if (readfile("invlogo.gif") == nil) then
    panorama.open().SteamOverlayAPI.OpenExternalBrowserURL("https://discord.gg/luas")
end

local vector = require("vector")
local ffi = require("ffi")
local bit = require("bit")
local _debug = false
local gif_decoder = nil
local images = nil
local start_time = globals.realtime()

pcall(function ()
    images = require("gamesense/images")
end)
if images == nil then
    error("Please sub to https://gamesense.pub/forums/viewtopic.php?id=22917")
end

pcall(function ()
    gif_decoder = require("gamesense/gif_decoder")
end)
if gif_decoder == nil then
    error("Please sub to https://gamesense.pub/forums/viewtopic.php?id=18493")
end


local function exitlua()

end

local function gethttp(url, options, callback)
    if package.loaded["gamesense/http"] ~= nil then
        for i,v in pairs(package.loaded) do
            if i == "gamesense/http" then
                if v == true then
                    exitlua()
                else
                    a = tostring(v)
                    if a:match("table") == "table" then
                        for x,z in pairs(v) do
                            func = tostring(z)
                            if func ~= "function: NULL" then
                                exitlua()
                            else
                                if x:match("get") == "get" then
                                    return z(url, options, callback)
                                end
                            end
                        end
                    else
                        exitlua()
                    end
                end
            end
        end
    else error("(https://gamesense.pub/forums/viewtopic.php?id=19253) and (https://gamesense.pub/forums/viewtopic.php?id=25394) or (https://gamesense.pub/forums/viewtopic.php?id=19428)") end
end
gif1 = nil


local function getgif()
    gethttp("https://cdn.discordapp.com/attachments/947910292606705664/948292316945322014/asd.txt", function(success, response)
        if not success or response.status ~= 200 then
            return
        end
        gif2 = base64.decode(response.body)
        print(gif2)
        writefile("invlogo.gif", gif2)
        --gif1 = gif_decoder.load_gif(readfile("invlogo.gif") or client.reload_active_scripts())
    end)
end
getgif()
logo = nil
pcall(function ()
    logo = readfile("invlogo.gif")
end)
if logo == nil then
    getgif()
end

ffi.cdef[[
	typedef long(__thiscall* get_file_time_t)(void* this, const char* pFileName, const char* pPathID);
	typedef bool(__thiscall* file_exists_t)(void* this, const char* pFileName, const char* pPathID);
]]

ffi.cdef[[
    struct cusercmd
    {
        struct cusercmd (*cusercmd)();
        int     command_number;
        int     tick_count;
    };
    typedef struct cusercmd*(__thiscall* get_user_cmd_t)(void*, int, int);
]]


local start_time = globals.realtime()

local signature_ginput = base64.decode("uczMzMyLQDj/0ITAD4U=")
local match = client.find_signature("client.dll", signature_ginput) or error("sig1 not found")
local g_input = ffi.cast("void**", ffi.cast("char*", match) + 1)[0] or error("match is nil")
local g_inputclass = ffi.cast("void***", g_input)
local g_inputvtbl = g_inputclass[0]
local rawgetusercmd = g_inputvtbl[8]
local get_user_cmd = ffi.cast("get_user_cmd_t", rawgetusercmd)
local ref = {
    aa = ui.reference('aa', 'Anti-aimbot angles', 'Enabled'),
    pitch = ui.reference('aa', 'Anti-aimbot angles', 'Pitch'),
    yawbase = ui.reference('aa', 'Anti-aimbot angles', 'Yaw base'),
    yaw = { ui.reference('aa', 'Anti-aimbot angles', 'Yaw') },
    yawjitter = { ui.reference('aa', 'Anti-aimbot angles', 'Yaw jitter') },
    bodyyaw = { ui.reference('aa', 'Anti-aimbot angles', 'Body yaw') },
    fsbodyyaw = ui.reference('aa', 'Anti-aimbot angles', 'Freestanding body yaw'),
    limit = ui.reference('aa', 'Anti-aimbot angles', 'Fake yaw limit'),
    edgeyaw = ui.reference('aa', 'Anti-aimbot angles', 'Edge yaw'),
    freestanding = { ui.reference('aa', 'Anti-aimbot angles', 'Freestanding') },
    slowmo = { ui.reference('aa', 'Other', 'Slow motion') },
    slowmo_type = ui.reference('aa', 'Other', 'Slow motion type'),
    legmovement = ui.reference('aa', 'Other', 'Leg movement'),
    onshot = { ui.reference('aa', 'Other', 'On shot anti-aim') },
    roll = ui.reference("aa", "Anti-aimbot angles", "roll");
    baim = ui.reference('rage', 'Other', 'Force body aim'),
    safe = ui.reference('rage', 'Aimbot', 'Force safe point'),
    damage = ui.reference('rage', 'Aimbot', 'Minimum damage'),
    fakelag = ui.reference('aa', 'Fake lag', 'Enabled'),
    sv_maxusrcmds = ui.reference('misc', 'Settings', 'sv_maxusrcmdprocessticks'),
    dthc = ui.reference("rage", "other", "Double tap hit chance"),
    dt = { ui.reference('rage', 'Other', 'Double tap') },
    dtspeed = ui.reference("rage", "other", "Double tap fake lag limit"),
    dtmode = ui.reference("rage", "other", "Double tap mode"),
    dtholdaim = ui.reference("misc", "settings", "sv_maxusrcmdprocessticks_holdaim"),
    fllimit = ui.reference("AA", "Fake lag", "Limit"),
    flamount = ui.reference("aa", "fake lag", "Amount"),
    flvar = ui.reference("aa", "fake lag", "Variance"),
    enable = ui.new_checkbox('aa', 'Anti-aimbot angles', 'Enable Invictus V2'),
}

local items = {
    label = ui.new_label('aa', 'Anti-aimbot angles', 'Invictus V2 - Antiaim = {'),
    dorm = ui.new_combobox('aa', 'Anti-aimbot angles', "    if dormant then", "-", 'Wide jitter', "Small jitter"),
    run = ui.new_combobox('aa', 'Anti-aimbot angles', "    if running then", "-", 'Wide jitter', "Static", "Small jitter", "Synced"),
    slow = ui.new_combobox('aa', 'Anti-aimbot angles', "    if slowwalk then", "-", 'Wide jitter', "Static", "Small jitter", "Synced"),
    stand = ui.new_combobox('aa', 'Anti-aimbot angles', "    if standing then", "-", 'Wide jitter', "Static", "Small jitter", "Synced"),
    air = ui.new_combobox('aa', 'Anti-aimbot angles', "    if inair then", "-", 'Wide jitter', "Static", "Small jitter", "Synced"),
    duck = ui.new_combobox('aa', 'Anti-aimbot angles', "    if ducking then", "-", 'Wide jitter', "Static", "Small jitter", "Synced"),
    invertenem = ui.new_combobox('aa', 'Anti-aimbot angles', "    if enemyshot then", "-", 'Invert'),
    fsb = ui.new_combobox('aa', 'Anti-aimbot angles', "    freestanding base", "Reverse", 'Normal'),
    legs = ui.new_combobox('aa', 'Anti-aimbot angles', "    break leg animation if", "-", "Always", "Slow"),
    enable = ui.new_combobox('aa', 'Anti-aimbot angles', "    Jitter", '-', 'Jitter until peek', "Jitter until peek unless hs"),
    roll = ui.new_checkbox('aa', 'Anti-aimbot angles', '   Roll'),
    laa = ui.new_hotkey('aa', 'Anti-aimbot angles', "   legit aa"),
    labelend = ui.new_label('aa', 'Anti-aimbot angles', '},'),
    labelssss = ui.new_label('aa', 'Anti-aimbot angles', 'Invictus V2 - Other = {'),
    labelend = ui.new_label('aa', 'Anti-aimbot angles', '   Manual AA'),
    left = ui.new_hotkey('aa', 'Anti-aimbot angles', "   Left"),
    right = ui.new_hotkey('aa', 'Anti-aimbot angles', "   Right"),
    dtbrrr = ui.new_checkbox('aa', 'Anti-aimbot angles', '   Manipulate Tickbase'),
    labselend = ui.new_label('aa', 'Anti-aimbot angles', '}'),
}

local aa = {
    dormant = false,
    move = "stand",
    peek = false,
    shots = 0,
    lastfired = 0,
    lastp = nil,
    lastlocal = 0,
    lastmov = 0,
    ignore = false,
    oldhp = 0,
    lastj = 0,
    enem = {},
    lastdt = 0,
    manaa = 0,
    input = 0,
    enemhit = {}
}

local function menu()
    if ui.get(ref.enable) then
        ui.set_visible(ref.aa, false)
        ui.set(ref.aa, ui.get(ref.enable))
        ui.set_visible(ref.yaw[1], false)
        ui.set_visible(ref.yaw[2], false)
        ui.set_visible(ref.yawjitter[1], false)
        ui.set_visible(ref.yawjitter[2], false)
        ui.set_visible(ref.bodyyaw[1], false)
        ui.set_visible(ref.bodyyaw[2], false)
        ui.set_visible(ref.fsbodyyaw, false)
        ui.set_visible(ref.limit, false)
        ui.set_visible(ref.roll, false)
        ui.set_visible(ref.legmovement, false)
        for k, v in pairs(items) do
            ui.set_visible(v, ui.get(ref.enable))
        end
          
    else
        ui.set_visible(ref.roll, true)
        ui.set_visible(ref.aa, true)
        ui.set_visible(ref.yaw[1], true)
        ui.set_visible(ref.yaw[2], true)
        ui.set_visible(ref.yawjitter[1], true)
        ui.set_visible(ref.yawjitter[2], true)
        ui.set_visible(ref.bodyyaw[1], true)
        ui.set_visible(ref.bodyyaw[2], true)
        ui.set_visible(ref.fsbodyyaw, true)
        ui.set_visible(ref.limit, true)
        ui.set_visible(ref.legmovement, true)
        for k, v in pairs(items) do
            ui.set_visible(v, ui.get(ref.enable))
        end
    end
end
menu()

local function closestToCrosshair()
    local enemy_players = entity.get_players(true)
    if #enemy_players ~= 0 then
        local own_x, own_y, own_z = client.eye_position()
        local own_pitch, own_yaw = client.eye_position()
        local closest_enemy = nil
        local closest_distance = 999999999

        for i = 1, #enemy_players do
            local enemy = enemy_players[i]
            local enemy_x, enemy_y, enemy_z = entity.get_prop(enemy, "m_vecOrigin")

            local x = enemy_x - own_x
            local y = enemy_y - own_y
            local z = enemy_z - own_z

            local yaw = ((math.atan2(y, x) * 200 / math.pi))
            local pitch = -(math.atan2(z, math.sqrt(math.pow(x, 2) + math.pow(y, 2))) * 200 / math.pi)

            local yaw_dif = math.abs(own_yaw % 360 - yaw % 360) % 360
            local pitch_dif = math.abs(own_pitch - pitch ) % 360

            if yaw_dif > 180 then yaw_dif = 360 - yaw_dif end
            local real_dif = math.sqrt(math.pow(yaw_dif, 2) + math.pow(pitch_dif, 2))

            if closest_distance > real_dif then
                closest_distance = real_dif
                closest_enemy = enemy
            end
        end

        if closest_enemy ~= nil then
            return closest_enemy, closest_distance
        end
    end

    return nil, nil
end

local csgo_weapons = require 'gamesense/csgo_weapons' -- https://gamesense.pub/forums/viewtopic.php?id=18807

local function get_maximum_speed(ent, wpn)
    if not entity.is_alive(ent) or wpn == nil then
        return nil
    end

    local data = csgo_weapons(wpn)

    if not data then
        return nil
    end

    local m_bScoped = entity.get_prop(ent, 'm_bIsScoped') == 1
    local m_zoomLevel = entity.get_prop(wpn, 'm_zoomLevel') or 0
    local m_bResumeZoom = entity.get_prop(ent, 'm_bResumeZoom') == 1

    if m_bScoped and m_zoomLevel > 0 and not m_bResumeZoom then
        return data.max_player_speed_alt
    end

    return data.max_player_speed
end

local function setSpeed(newSpeed)
	if newSpeed == 245 then
		return
	end
	local vx, vy = entity.get_prop(entity.get_local_player(), "m_vecVelocity")
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))
	local maxvelo = newSpeed
	
	if(velocity<maxvelo) then
		client.set_cvar("cl_sidespeed", maxvelo)
		client.set_cvar("cl_forwardspeed", maxvelo)
		client.set_cvar("cl_backspeed", maxvelo)
	end
	
	if(velocity>=maxvelo) then
		kat=math.atan2(client.get_cvar("cl_forwardspeed"), client.get_cvar("cl_sidespeed"))
		forward=math.cos(kat)*maxvelo;
		side=math.sin(kat)*maxvelo;
		client.set_cvar("cl_sidespeed", side)
		client.set_cvar("cl_forwardspeed", forward)
		client.set_cvar("cl_backspeed", forward)
	end
end

local function GetClosestPoint(A, B, P)
    local a_to_p = { P[1] - A[1], P[2] - A[2] }
    local a_to_b = { B[1] - A[1], B[2] - A[2] }

    local atb2 = a_to_b[1]^2 + a_to_b[2]^2

    local atp_dot_atb = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
    local t = atp_dot_atb / atb2

    return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
end

function math.average(t)
    local sum = 0
    for _,v in pairs(t) do -- Get the sum of all numbers in t
      sum = sum + v
    end
    return sum / #t
  end

  local function gvel(p)
    if p ~= nil then
        local velocity = { entity.get_prop(p, "m_vecVelocity") }
        local velocity2d = math.sqrt(velocity[1]^2+velocity[2]^2)
        return velocity2d
    else
        return 0
    end
end

local function detecddtshot(c)
    if entity.is_alive(entity.get_local_player()) then
        local ent = client.userid_to_entindex(c.userid)
        if ent ~= entity.get_local_player() then
            aa.lastp = c.userid
        end
        if not entity.is_dormant(ent) and entity.is_enemy(ent) then
            local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
            ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
            local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
            local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
            local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
            local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)
            if math.abs(delta_2d) < 220 then
                local lp_health = entity.get_prop(entity.get_local_player(),"m_iHealth")
                if lp_health ~= nil then
                    if lp_health ~= aa.oldhp then
                        -- hit
                        local wep = entity.get_player_weapon(ent)
                        local class = entity.get_classname(wep)
                        local m = ui.get(items.invertenem)
                        if class ~= nil then
                            --if m["Timed jitter"] then
                            --    if class == "CWeaponSSG08" or class == "CWeaponAWP" then
                            --        aa.timer = globals.tickcount() + 50
                            --    else
                            --        aa.timer = globals.tickcount() + 2
                            --    end
                        -- end
                        end
                        aa.lastj = true
                        if m =="Invert" then
                            if aa.enem[ent] == nil then
                                aa.enem[ent] = {shots = 0, time = 0}
                            end
                            local entity_data = aa.enem[ent] or {shots = 0, time = 0}
                            entity_data.shots = entity_data.shots + 1
                            entity_data.time = globals.curtime()
                            aa.enem[ent] = entity_data
                        end
                        aa.oldhp = lp_health
                    else
                        if aa.lastj == true then
                            aa.lastj = false
                        else
                            -- hit
                            local wep = entity.get_player_weapon(ent)
                            local class = entity.get_classname(wep)
                            local m = ui.get(items.invertenem)
                            if class ~= nil then
                                --if m["Timed jitter"] then
                                --    if class == "CWeaponSSG08" or class == "CWeaponAWP" then
                                --        aa.timer = globals.tickcount() + 50
                                --    else
                                --        aa.timer = globals.tickcount() + 2
                                --    end
                            -- end
                            end
                            if m =="Invert" then
                                if aa.enem[ent] == nil then
                                    aa.enem[ent] = {shots = 0, time = 0}
                                end
                                local entity_data = aa.enem[ent] or {shots = 0, time = 0}
                                entity_data.shots = entity_data.shots + 1
                                entity_data.time = globals.curtime()
                                aa.enem[ent] = entity_data
                            end
                        end
                    end
                end
            end
        end
    end
end
local delay = 0
local function detectshot (c)
    if not entity.is_alive(entity.get_local_player()) then
        return
    end
    local ent = client.userid_to_entindex(c.userid)
    if ent ~= entity.get_local_player() then
        aa.lastp = c.userid
    end
    local ent = client.userid_to_entindex(c.userid)
    if ( entity.is_enemy (ent) and not entity.is_dormant (ent) ) then
        local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
        ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
        local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
        local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
        local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
        local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)
        if math.abs(delta_2d) < 20 then


            if ( globals.curtime() > delay ) then
                local m = ui.get(items.invertenem)
                if m =="Invert" then
                    if aa.enem[ent] == nil then
                        aa.enem[ent] = {shots = 0, time = 0}
                    end
                    local entity_data = aa.enem[ent] or {shots = 0, time = 0}
                    entity_data.shots = entity_data.shots + 1
                    entity_data.time = globals.curtime()
                    aa.enem[ent] = entity_data
                end
                delay = globals.curtime () + 0.35

            end
        end
    end
end



local function in_air(player)
    local flags = entity.get_prop(player, "m_fFlags")

    if bit.band(flags, 1) == 0 then
        return true
    end

    return false
end
-- crouching check
local function is_crouching(player)
    local flags = entity.get_prop(player, "m_fFlags")

    if bit.band(flags, 4) == 4 then
        return true
    end

    return false
end




local function exrapolatePos(ent, ticks)
    xpos, ypos, zpos = entity.get_prop(ent, "m_vecAbsOrigin")

    x,y,z = entity.get_prop(ent, "m_vecVelocity")
    if x ~= nil then
        for i=1, ticks do
            xpos = xpos + (x*globals.tickinterval())
            ypos = ypos + (y*globals.tickinterval())

        end

        return xpos, ypos, zpos
    end
end

local function updatepos(ent, targ)
    tpd = 110
    local velocity = { entity.get_prop(ent, "m_vecVelocity") }
    local velocity2d = math.sqrt(velocity[1]^2+velocity[2]^2)
    if (velocity2d < 50) then
        tpd = 200
    elseif (velocity2d >= 50 and velocity2d < 120) then
        tpd = 180
    elseif (velocity2d >= 120 and velocity2d < 190) then
        tpd = 140
    elseif (velocity2d >= 190) then
        tpd = 100
    end
    predPosx, predPosy, predPosz = exrapolatePos(ent, tpd)
    eyeposx, eyeposy, eyeposz = entity.get_prop(ent, "m_vecViewOffset")
    predPosz = predPosz + eyeposz
    for i=0, 19 do
        hitbox, hitboy, hitboz = entity.hitbox_position(targ, i)
        Useless, expdamagee = client.trace_bullet(ent, predPosx, predPosy, predPosz, hitbox, hitboy, hitboz)
        if expdamagee > 1 then
            return true
        else
            return false
        end
    end
end

local function get_damage(plocal, enemy, x, y,z)
	local ex = { }
	local ey = { }
	local ez = { }
	ex[0], ey[0], ez[0] = entity.hitbox_position(enemy, 1)
	ex[1], ey[1], ez[1] = ex[0] + 40, ey[0], ez[0]
	ex[2], ey[2], ez[2] = ex[0], ey[0] + 40, ez[0]
	ex[3], ey[3], ez[3] = ex[0] - 40, ey[0], ez[0]
	ex[4], ey[4], ez[4] = ex[0], ey[0] - 40, ez[0]
	ex[5], ey[5], ez[5] = ex[0], ey[0], ez[0] + 40
	ex[6], ey[6], ez[6] = ex[0], ey[0], ez[0] - 40
	local ent, dmg = 0
	for i=0, 6 do
		if dmg == 0 or dmg == nil then
			ent, dmg = client.trace_bullet(enemy, ex[i], ey[i], ez[i], x, y, z)
		end
	end
	return ent == nil and client.scale_damage(plocal, 1, dmg) or dmg
end


function Angle_Vector(angle_x, angle_y)
    sy = math.sin(math.rad(angle_y));
    cy = math.cos(math.rad(angle_y));
    sp = math.sin(math.rad(angle_x));
    cp = math.cos(math.rad(angle_x));
    return cp * cy, cp * sy, -sp;
end

local function clamp(min, max, value)
    if min < max then
        return math.max(min, math.min(max, value))
    else
        return math.max(max, math.min(min, value))
    end
end

local function normalize_yaw(angle)
    angle = (angle % 360 + 360) % 360
    return angle > 180 and angle - 360 or angle
end


local function angle_forward(angle)
    if angle[1] ~= nil and angle[2] ~= nil then
        angle[1] = math.rad(angle[1])
        angle[2] = math.rad(angle[2])

        local sin_pitch = math.sin(angle[1])
        local sin_yaw = math.sin(angle[2])
        local cos_pitch = math.cos(angle[1])
        local cos_yaw = math.cos(angle[2])

        return {cos_pitch * cos_yaw, cos_pitch * sin_yaw, -sin_pitch}
    end
end

local function extrapolate_angle(camera, angles, limit)
    local forward = angle_forward(angles)
    local trace = {client.trace_line(entity.get_local_player(), camera[1], camera[2], camera[3], forward[1] * (8192), forward[2] * (8192), forward[3] * (8192))}

    return {
        camera[1] + (forward[1] * clamp(0, limit, (8192 * trace[1]))),
        camera[2] + (forward[2] * clamp(0, limit, (8192 * trace[1]))),
        camera[3] + (forward[3] * clamp(0, limit, (8192 * trace[1])))
    }, 8192 * trace[1]
end

function CalcAngle(localplayerxpos, localplayerypos, enemyxpos, enemyypos)
    relativeyaw = math.atan( (localplayerypos - enemyypos) / (localplayerxpos - enemyxpos) )
    return relativeyaw * 180 / math.pi
end



function Angle_Vector(angle_x, angle_y)
    sy = math.sin(math.rad(angle_y));
    cy = math.cos(math.rad(angle_y));
    sp = math.sin(math.rad(angle_x));
    cp = math.cos(math.rad(angle_x));
    return cp * cy, cp * sy, -sp;
end
local lowestdmg = math.huge
function calculateBestAngle(enemy, ...)
    lx, ly, lz = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
    viewangle_x, viewangle_y, roll = client.camera_angles()
    headx, heady, headz = entity.hitbox_position(entity.get_local_player(), 0)
    enemyx, enemyy, enemyz = entity.get_prop(enemy, "m_vecOrigin")
    bestangle = nil
    
    if(entity.is_alive(enemy)) then
        yaw = CalcAngle(lx, ly, enemyx, enemyy)
        for i,v in pairs({...}) do
        
            dir_x, dir_y, dir_z = Angle_Vector(0, (yaw + v))
            end_x = lx + dir_x * 55
            end_y = ly + dir_y * 55
            end_z = lz + 80
            
            index, damage = client.trace_bullet(enemy, enemyx, enemyy, enemyz + 70, end_x, end_y, end_z)
            
            index2, damage2 = client.trace_bullet(enemy, enemyx, enemyy, enemyz + 70, end_x + 12, end_y, end_z) --test
            
            index3, damage3 = client.trace_bullet(enemy, enemyx, enemyy, enemyz + 70, end_x - 12, end_y, end_z) --test
            
            if(damage < lowestdmg) then
                lowestdmg = damage
                if(damage2 > damage) then
                    lowestdmg = damage2
                end
            end
            if(damage3 > damage) then
                lowestdamage = damage3
            end	
            if(lx - enemyx > 0) then --this is very ghetto, but it works so whatever
                bestangle = v
            else
                bestangle = v * -1
            end
            if bestangle > 1 then
                if ui.get(items.fsb) == "Reverse" then
                    return -1
                else
                    return 1
                end
            end
        end
    end
end

function betterfs(enemy, ...)
    local e_x, e_y, e_z = entity.hitbox_position(enemy, 0)
    local lx, ly, lz = client.eye_position()
    local yaw = CalcAngle(lx, ly, e_x, e_y)
    local rdir_x, rdir_y, rdir_z = Angle_Vector(0, (yaw + 90))
    local rend_x = lx + rdir_x * 10
    local rend_y = ly + rdir_y * 10
    
    local ldir_x, ldir_y, ldir_z = Angle_Vector(0, (yaw - 90))
    local lend_x = lx + ldir_x * 10
    local lend_y = ly + ldir_y * 10
    
    local r2dir_x, r2dir_y, r2dir_z = Angle_Vector(0, (yaw + 90))
    local r2end_x = lx + r2dir_x * 100
    local r2end_y = ly + r2dir_y * 100

    local l2dir_x, l2dir_y, l2dir_z = Angle_Vector(0, (yaw - 90))
    local l2end_x = lx + l2dir_x * 100
    local l2end_y = ly + l2dir_y * 100          
    local ldamage = get_damage(entity.get_local_player(), enemy, rend_x, rend_y, lz)
    local rdamage = get_damage(entity.get_local_player(), enemy, lend_x, lend_y, lz)

    local l2damage = get_damage(entity.get_local_player(), enemy, r2end_x, r2end_y, lz)
    local r2damage = get_damage(entity.get_local_player(), enemy, l2end_x, l2end_y, lz)
    if l2damage > r2damage or ldamage > rdamage or l2damage > ldamage then
        return 1
    elseif r2damage > l2damage or rdamage > ldamage or r2damage > rdamage then
        if ui.get(items.fsb) == "Reverse" then
            return -1
        else
            return 1
        end
    else
        return(calculateBestAngle(enemy, -60, 60))
    end
end



local function staticfs(misses, side, cmd)
     local local_player = entity.get_local_player()
     allow = false
    if not in_air(local_player) then
        allow = true
    else
        allow = false
    end
    local velocity = { entity.get_prop(entity.get_local_player(), "m_vecVelocity") }
    local velocity2d = math.sqrt(velocity[1]^2+velocity[2]^2)
    local wep = entity.get_player_weapon(entity.get_local_player())
    local speedmax = get_maximum_speed(entity.get_local_player(), wep)
    local weapon_ent = entity.get_player_weapon(entity.get_local_player())
	local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
	local weapon = csgo_weapons[weapon_idx]

    ui.set(ref.yawjitter[1], "offset")
    ui.set(ref.yawjitter[2], 7)
    local local_player = entity.get_local_player()
    if misses == 0 then
        if side == -1 then
            ui.set(ref.bodyyaw[1], "jitter")
            ui.set(ref.bodyyaw[2], -169)
            if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
                if ui.get(items.roll) then 
                    cmd.roll = math.random(49, 50)
                end
            end
            if ui.get(items.roll) then 
                ui.set(ref.roll, math.random(45, 50))
            end
            ui.set(ref.yaw[2], -13)
            
        elseif side == 1 then
            ui.set(ref.bodyyaw[1], "jitter")
            ui.set(ref.bodyyaw[2], 169)
            if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
                if ui.get(items.roll) then 
                    cmd.roll = math.random(-49, -50)
                end
            end
            ui.set(ref.yaw[2], 25)
            if ui.get(items.roll) then 
                ui.set(ref.roll, math.random(-49, -50))
            end
            velocity2d = gvel(entity.get_local_player())
            
            
        end
    elseif misses == 1 then
        if side == 1 then
            ui.set(ref.bodyyaw[1], "jitter")
            ui.set(ref.bodyyaw[2], -180)
            if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
                if ui.get(items.roll) then 
                    cmd.roll = math.random(49, 50)
                end
            end
            if ui.get(items.roll) then 
                cmd.roll = math.random(49, 50)
            end
            ui.set(ref.yaw[2], -13)
            
        elseif side == -1 then
            ui.set(ref.bodyyaw[1], "jitter")
            ui.set(ref.bodyyaw[2], 180)
            if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
                if ui.get(items.roll) then 
                    cmd.roll = math.random(-49, -50)
                end
            end
            ui.set(ref.yaw[2], 25)
            if ui.get(items.roll) then 
                ui.set(ref.roll, math.random(-49, -50))
            end
            velocity2d = gvel(entity.get_local_player())
            
        end
    elseif misses == 2 then
        if side == -1 then
            ui.set(ref.bodyyaw[1], "jitter")
            ui.set(ref.bodyyaw[2], -45)
            if ui.get(items.roll) then 
                cmd.roll = 50
                cmd.roll = math.random(49, 50)
            end
            ui.set(ref.yaw[2], 0)
            
        elseif side == 1 then
            ui.set(ref.bodyyaw[1], "jitter")
            ui.set(ref.bodyyaw[2], 45)
            if ui.get(items.roll) then 
                cmd.roll = -50
                ui.set(ref.roll, math.random(-49, -50))
            end
            velocity2d = gvel(entity.get_local_player())
            ui.set(ref.yaw[2], 0) 
        end
    end
    ui.set(ref.fsbodyyaw, false)
end


local function sync(misses, side, cmd)
    local local_player = entity.get_local_player()
    allow = false
   if not in_air(local_player) then
       allow = true
   else
       allow = false
   end
   ui.set(ref.fsbodyyaw, false)
   local velocity = { entity.get_prop(entity.get_local_player(), "m_vecVelocity") }
   local velocity2d = math.sqrt(velocity[1]^2+velocity[2]^2)
   local wep = entity.get_player_weapon(entity.get_local_player())
   local speedmax = get_maximum_speed(entity.get_local_player(), wep)
   local weapon_ent = entity.get_player_weapon(entity.get_local_player())
   local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
   local weapon = csgo_weapons[weapon_idx]
   if ui.get(items.laa) == false then
        local velocity = { entity.get_prop(entity.get_local_player(), "m_vecVelocity") }
        local velocity2d = math.sqrt(velocity[1]^2+velocity[2]^2)
        if velocity2d > 180 then
            ui.set(ref.limit, 20)
        elseif velocity2d > 60 then
            ui.set(ref.limit, 35)
        else
            ui.set(ref.limit, 45)
        end
        ui.set(ref.fsbodyyaw, true)
    else
        ui.set(ref.limit, 58)
    end
   ui.set(ref.yawjitter[1], "random")
   ui.set(ref.yawjitter[2], math.random(-12, 12))
   local local_player = entity.get_local_player()
   if misses == 0 then
       if side == -1 then
           ui.set(ref.bodyyaw[1], "jitter")
           ui.set(ref.bodyyaw[2], -169)
           if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
                if ui.get(items.roll) then 
                    cmd.roll = math.random(49, 50)
                end
           end
           if ui.get(items.roll) then 
                cmd.roll = math.random(49, 50)
           end
           ui.set(ref.yaw[2], -13)
           
       elseif side == 1 then
           ui.set(ref.bodyyaw[1], "jitter")
           ui.set(ref.bodyyaw[2], 169)
           if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
                if ui.get(items.roll) then 
                    cmd.roll = math.random(-49, -50)
                end
           end
           ui.set(ref.yaw[2], 25)
           if ui.get(items.roll) then 
                ui.set(ref.roll, math.random(-49, -50))
           end
           velocity2d = gvel(entity.get_local_player())
           
           
       end
   elseif misses == 1 then
       if side == 1 then
           ui.set(ref.bodyyaw[1], "jitter")
           ui.set(ref.bodyyaw[2], -180)
           if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
               cmd.roll = math.random(49, 50)
           end
           cmd.roll = math.random(49, 50)
           ui.set(ref.yaw[2], -13)
           
       elseif side == -1 then
           ui.set(ref.bodyyaw[1], "jitter")
           ui.set(ref.bodyyaw[2], 180)
           if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
                if ui.get(items.roll) then 
                     cmd.roll = math.random(-49, -50)
                end
           end
           ui.set(ref.yaw[2], 25)
           if ui.get(items.roll) then 
                ui.set(ref.roll, math.random(-49, -50))
           end
           velocity2d = gvel(entity.get_local_player())
           
       end
   elseif misses == 2 then
       if side == -1 then
           ui.set(ref.bodyyaw[1], "jitter")
           ui.set(ref.bodyyaw[2], -45)
           if ui.get(items.roll) then 
                cmd.roll = 50
                ui.set(ref.roll, math.random(49, 50))
           end
           ui.set(ref.yaw[2], 0)
           
       elseif side == 1 then
           ui.set(ref.bodyyaw[1], "jitter")
           ui.set(ref.bodyyaw[2], 45)
           if ui.get(items.roll) then 
                cmd.roll = -50
                ui.set(ref.roll, math.random(-49, -50))
           end
           velocity2d = gvel(entity.get_local_player())
           ui.set(ref.yaw[2], 0) 
       end
   end
end
local function normjit(cmd)
    ui.set(ref.fsbodyyaw, false)
    local wep = entity.get_player_weapon(entity.get_local_player())
    local speedmax = get_maximum_speed(entity.get_local_player(), wep)
    local weapon_ent = entity.get_player_weapon(entity.get_local_player())
    local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
	local weapon = csgo_weapons[weapon_idx]
    ui.set(ref.yawjitter[1], "center")
    ui.set(ref.yawjitter[2], 22)
    ui.set(ref.bodyyaw[1], "jitter")
    ui.set(ref.bodyyaw[2], 0)
    ui.set(ref.fsbodyyaw, false)
    ui.set(ref.yawbase, "At targets")
    ui.set(ref.yaw[2], 0)
    ui.set(ref.yaw[1], "180")
    ui.set(ref.limit, 58)
    if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
        if ui.get(items.roll) then 
             cmd.roll = -50
        end
    end
    
end



local function wide(misses, side, cmd)
        ui.set(ref.fsbodyyaw, false)
        local wep = entity.get_player_weapon(entity.get_local_player())
        local speedmax = get_maximum_speed(entity.get_local_player(), wep)
        local weapon_ent = entity.get_player_weapon(entity.get_local_player())
        local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
	    local weapon = csgo_weapons[weapon_idx]
        local velocity = { entity.get_prop(entity.get_local_player(), "m_vecVelocity") }
        local velocity2d = math.sqrt(velocity[1]^2+velocity[2]^2)
        ui.set(ref.yawjitter[1], "center")
        ui.set(ref.yawjitter[2], math.random(79,79))
        ui.set(ref.bodyyaw[1], "jitter")
        ui.set(ref.bodyyaw[2], 0)
        ui.set(ref.fsbodyyaw, false)
        ui.set(ref.yawbase, "At targets")
        ui.set(ref.yaw[1], "180")
        ui.set(ref.yaw[2], 0)
        ui.set(ref.limit, 58)
        if cmd ~= 0 and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
            if ui.get(items.roll) then 
                cmd.roll = -50
            end
        end
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end


local function widef(cmd)
    ui.set(ref.fsbodyyaw, false)
    local_player = entity.get_local_player()
    local wep = entity.get_player_weapon(local_player)
    local speedmax = get_maximum_speed(local_player, wep)
    local weapon_ent = entity.get_player_weapon(local_player)
    local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
    local weapon = csgo_weapons[weapon_idx]
    local velocity = { entity.get_prop(local_player, "m_vecVelocity") }
    local velocity2d = math.sqrt(velocity[1]^2+velocity[2]^2)
    ui.set(ref.yawjitter[1], "OFFSET")
    ui.set(ref.yawjitter[2], 0)
    ui.set(ref.bodyyaw[1], "jitter")
    ui.set(ref.bodyyaw[2], 1)
    ui.set(ref.fsbodyyaw, false)
    ui.set(ref.yawbase, "At targets")
    ui.set(ref.yaw[1], "180")
    ui.set(ref.yaw[2], -0)
    if not entity.is_alive(local_player) then return end
	local body_yaw = math.max(-60, math.min(60, round((entity.get_prop(local_player, "m_flPoseParameter", 11) or 0)*120-60+0.5, 1)))
    print(body_yaw)
    ui.set(ref.limit, 58)
    if cmd ~= nil and weapon.type ~= "grenade" and allow == true and cmd.chokedcommands == 0  then
        cmd.roll = math.random(-180, 180)
    end
end

local function reduce(e)
    local cmd = get_user_cmd(g_inputclass , 0, e.command_number)
    if aa.lastlocal + 1.1 > globals.curtime() then
            cmd.tick_count = cmd.tick_count + 8
            aa.ignore = false
    else
        aa.ignore = false
        cmd.tick_count = cmd.tick_count + 1
    end
end

local function legitaa(cmd)
    if cmd.in_grenade1 == 1 or cmd.in_grenade2 == 1 or cmd.in_attack == 1 then return end
    local pitch, yaw = client.camera_angles()
    local weapon = entity.get_player_weapon(entity.get_local_player())
    if weapon ~= nil and entity.get_classname(weapon) == "CC4" then
        if cmd.in_attack == 1 then
            cmd.in_attack = 0
            cmd.in_use = 1
        end
    else
        if cmd.chokedcommands == 0 then
            cmd.in_use = 0
        end
    end
end


local function handle_aa(c)
    if aa.manaa == 0 then
        local target = closestToCrosshair()
        local velocity = { entity.get_prop(entity.get_local_player(), "m_vecVelocity") }
        local velocity2d = math.sqrt(velocity[1]^2+velocity[2]^2)
        local wep = entity.get_player_weapon(entity.get_local_player())
        local speedmax = get_maximum_speed(entity.get_local_player(), wep)
        local weapon_ent = entity.get_player_weapon(entity.get_local_player())
        local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
        local weapon = csgo_weapons[weapon_idx]
        if ui.get(ref.enable) then
            local lp = entity.get_local_player()
            local vel = gvel(lp)
            ui.set(items.left, "On Hotkey")
            ui.set(items.right, "On Hotkey")
            if aa.input + 0.22 < globals.curtime() then
                if aa.manaa == 0 then
                    if ui.get(items.left) then
                        aa.manaa = 1
                        aa.input = globals.curtime()
                    elseif ui.get(items.right) then
                        aa.manaa = 2
                        aa.input = globals.curtime()
                    end
                elseif aa.manaa == 1 then
                    if ui.get(items.right) then
                        aa.manaa = 2
                        aa.input = globals.curtime()
                    elseif ui.get(items.left) then
                        aa.manaa = 0
                        aa.input = globals.curtime()
                    end
                elseif aa.manaa == 2 then
                    if ui.get(items.left) then
                        aa.manaa = 1
                        aa.input = globals.curtime()
                    elseif ui.get(items.right) then
                        aa.manaa = 0
                        aa.input = globals.curtime()
                    end
                end
            end
            if aa.manaa == 2 then
                ui.set(ref.yawjitter[1], "off")
                ui.set(ref.yawjitter[2], 0)
                ui.set(ref.bodyyaw[1], "static")
                ui.set(ref.bodyyaw[2], 180)
                ui.set(ref.fsbodyyaw, false)
                ui.set(ref.yawbase, "local view")
                ui.set(ref.yaw[1], "180")
                ui.set(ref.yaw[2], 90)
                ui.set(ref.limit, 58)
                if ui.get(items.roll) then
                    ui.set(ref.roll, -50)
                    c.roll = -119
                end
            elseif aa.manaa == 1 then            
                ui.set(ref.yawjitter[1], "off")
                ui.set(ref.yawjitter[2], 0)
                ui.set(ref.bodyyaw[1], "static")
                ui.set(ref.bodyyaw[2], 180)
                ui.set(ref.fsbodyyaw, false)
                ui.set(ref.yawbase, "local view")
                ui.set(ref.yaw[1], "180")
                ui.set(ref.yaw[2], -90)
                ui.set(ref.limit, 58)
                if ui.get(items.roll) then 
                    ui.set(ref.roll, 50)
                    c.roll = 119
                end
            else
                ui.set(ref.fsbodyyaw, false)
                ui.set(ref.yawbase, "At targets")
                ui.set(ref.yaw[1], "180")
                ui.set(ref.yaw[2], 5)
                ui.set(ref.limit, 58)
                if target == nil then
                    aa.dormant = true
                else
                    aa.dormant = false
                    if not in_air(lp) then
                        if vel > 50 then
                            if is_crouching(lp) then
                                aa.move = "duck"
                            else
                                if not ui.get(ref.slowmo[1]) or not ui.get(ref.slowmo[2]) then
                                    aa.move = "run"
                                else
                                    aa.move = "slow"
                                end
                            end
                        else
                            aa.move = "stand"
                        end
                    else
                        aa.move = "air"
                    end
                    if updatepos(lp, target) == true or updatepos(target, lp) == true then
                        aa.peek = true
                    else
                        aa.peek = false
                    end
                end
            end
            if ui.get(ref.enable) then
                if ui.get(items.laa) then
                    ui.set(ref.fsbodyyaw, false)
                    ui.set(ref.yawbase, "At targets")
                    ui.set(ref.yaw[1], "180")
                    ui.set(ref.yaw[2], 5)
                    ui.set(ref.limit, 58)
                    if ui.get(items.roll) then
                    else
                        ui.set(ref.roll, 0)
                        c.roll = 0
                    end
                    legitaa(c)
                else
                    if aa.peek == true then
                        if aa.dormant == true then
                            dst = ui.get(items.dorm)
                            if dst == "Wide jitter" then
                                wide(0, 0, c)
                            elseif dst == "Small jitter" then
                                normjit(c)
                            end
                        else
                            local side = betterfs(target)
                            if aa.enem[target] == nil then
                                aa.enem[target] = {shots = 0, time = 0}
                            end
                            local entity_data = aa.enem[target] or {shots = 0, time = 0}
                            
                            
                            if entity_data.shots > 2 then
                                aa.enem[target] = nil
                            end
                            --if entity_data.time + 5 < globals.curtime() then
                            --   aa.enem[target] = nil
                            --end
                            if aa.lastlocal + 0.01 > globals.curtime() then
                            
                                c.sidemove = 1
                                c.roll = 0
                            else
                                aa.ignore = false
                            end
                            if aa.ignore == false then
                                if aa.move == "air" then
                                    dst = ui.get(items.air)
                                    if dst == "Wide Jitter" then
                                        wide(entity_data.shots, side, c)
                                    elseif dst == "Static" then
                                        staticfs(entity_data.shots, side, c)
                                    elseif dst == "Small jitter" then
                                        normjit(c)
                                    elseif dst == "Synced" then
                                        sync(entity_data.shots, side, c)
                                    end
                                elseif aa.move == "duck" then
                                    dst = ui.get(items.duck)
                                    if dst == "Wide jitter" then
                                        wide(entity_data.shots, side, c)
                                    elseif dst == "Static" then
                                        staticfs(entity_data.shots, side, c)
                                    elseif dst == "Small jitter" then
                                        normjit(c)
                                    elseif dst == "Synced" then
                                        sync(entity_data.shots, side, c)
                                    end
                                elseif aa.move == "run" then
                                    dst = ui.get(items.run)
                                    if dst == "Wide jitter" then
                                        wide(entity_data.shots, side, c)
                                    elseif dst == "Static" then
                                        staticfs(entity_data.shots, side, c)
                                    elseif dst == "Small jitter" then
                                        normjit(c)
                                    elseif dst == "Synced" then
                                        sync(entity_data.shots, side, c)
                                    end
                                elseif aa.move == "stand" then
                                    dst = ui.get(items.stand)
                                    if dst == "Wide jitter" then
                                        wide(entity_data.shots, side, c)
                                    elseif dst == "Static" then
                                        staticfs(entity_data.shots, side, c)
                                    elseif dst == "Small jitter" then
                                        normjit(c)
                                    elseif dst == "Synced" then
                                        sync(entity_data.shots, side, c)
                                    end
                                elseif aa.move == "slow" then
                                    dst = ui.get(items.slow)
                                    if dst == "Wide jitter" then
                                        wide(entity_data.shots, side, c)
                                    elseif dst == "Static" then
                                        staticfs(entity_data.shots, side, c)
                                    elseif dst == "Small jitter" then
                                        normjit(c)
                                    elseif dst == "Synced" then
                                        sync(entity_data.shots, side, c)
                                    end
                                end
                                if ui.get(items.legs) == "Slow" then
                                    if ui.get(ref.legmovement) == "Off" then
                                        ui.set(ref.legmovement, "Always slide")
                                    else
                                        ui.set(ref.legmovement, "Off")
                                    end
                                elseif ui.get(items.legs) == "Always" then
                                    if ui.get(ref.legmovement) == "Never slide" then
                                        ui.set(ref.legmovement, "Always slide")
                                    else
                                        ui.set(ref.legmovement, "Never slide")
                                    end
                                end
                            end
                        end
                    else
                        if ui.get(items.enable) == "Jitter until peek" then
                            if aa.dormant == true then
                                dst = ui.get(items.dorm)
                                if dst == "Wide jitter" then
                                    wide(0, 0, c)
                                elseif dst == "Small jitter" then
                                    normjit(c)
                                end
                            else
                                wide(0, 0, c)
                            end
            
                        elseif ui.get(items.enable) == "Jitter until peek unless hs" then
                                if aa.dormant == true then
                                    dst = ui.get(items.dorm)
                                    if dst == "Wide jitter" then
                                        wide(0, 0, c)
                                    elseif dst == "Small jitter" then
                                        normjit(c)
                                    end
                                else
                                    if aa.enemhit[target] == nil then
                                        aa.enemhit[target] = {shots = 0}
                                    end
                                    local entity_data2 = aa.enemhit[target] or {shots = 0}
                                    if entity_data2.shots == 0 then
                                        wide(0, 0, c)
                                    else
                                        if aa.enem[target] == nil then
                                            aa.enem[target] = {shots = 0, time = 0}
                                        end
                                        local entity_data = aa.enem[target] or {shots = 0, time = 0}
                                        dst = ui.get(items.run)
                                        if dst == "Wide jitter" then
                                            wide(entity_data.shots, side, c)
                                        elseif dst == "Static" then
                                            staticfs(entity_data.shots, side, c)
                                        elseif dst == "Small jitter" then
                                            normjit(c)
                                        elseif dst == "Synced" then
                                            sync(entity_data.shots, side, c)
                                        end
                                    end
                                end
                        end
                    end
                end
            end
        end
        if ui.get(items.dtbrrr) then
            if aa.lastdt < globals.curtime() then
                ui.set(ref.sv_maxusrcmds, 17)
                client.set_cvar("cl_clock_correction", "0")
                ui.set(ref.dtspeed, 1)
                ui.set(ref.dtholdaim, true)
            else
                ui.set(ref.sv_maxusrcmds, 19)
                client.set_cvar("cl_clock_correction", "0")
                ui.set(ref.dtspeed, 1)
                ui.set(ref.dtholdaim, true)
            end
        else
            client.set_cvar("cl_clock_correction", "1")
            ui.set(ref.sv_maxusrcmds, 16)
        end
    end
end




local function fire(e)
    if client.userid_to_entindex(e.userid) == entity.get_local_player() then
        aa.lastlocal = globals.curtime()
        if ui.get(ref.dt[1]) and ui.get(ref.dt[2]) then
            aa.lastdt = globals.curtime() + 1.1
        end
    end
end

-- local variables for API functions. any changes to the line below will be lost on re-generation
local bit_band, client_set_event_callback, require, ui_get, ui_new_multiselect, pairs = bit.band, client.set_event_callback, require, ui.get, ui.new_multiselect, pairs

local entity = require("gamesense/entity")

local options = true
local was_on_ground = false

local function table_contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

client_set_event_callback("net_update_end", function()
    local plocal = entity.get_local_player()
    local on_ground = bit_band(entity.get_prop(plocal, "m_fFlags"), 1) == 1
    local animstate = plocal:get_anim_state()
    local modes = true

    if true then
        entity.set_prop(plocal, "m_flPoseParameter", 1, 6) 
    end

    if animstate.hit_in_ground_animation and animstate.head_from_ground_distance_standing and not was_on_ground and on_ground and true then
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0.5, 12)
    end

    was_on_ground = on_ground
end)

local function resetdelta()
   aa.enem = {}
   aa.enemhit = {}
end



-- decode the gif file (example.gif in your CS:GO directory), this returns a gif object

local start_time = globals.realtime()

local function on_player_hurt(e)

    local userid, attacker, health, armor, weapon, dmg_health, dmg_armor, hitgroup = e.userid, e.attacker, e.health, e.armor, e.weapon, e.dmg_health, e.dmg_armor, e.hitgroup

    if userid == nil or attacker == nil or hitgroup < 0 or hitgroup > 1 or dmg_health == nil or health == nil then
        return
    end
    if aa.enemhit[attacker] == nil then
        aa.enemhit[attacker] = {shots = 0}
    end
        local entity_data = aa.enemhit[attacker] or {shots = 0}
        entity_data.shots = entity_data.shots + 1
        aa.enemhit[attacker] = entity_data
end







-- decode the gif file (example.gif in your CS:GO directory), this returns a gif object
local mx, my = client.screen_size()
if (readfile("invlogo.gif")) then
    gif1 = gif_decoder.load_gif(readfile("invlogo.gif") or client.reload_active_scripts())
end
client.set_event_callback("paint_ui", function()
    ui.set(items.left, "On Hotkey")
    ui.set(items.right, "On Hotkey")
    if aa.input + 0.22 < globals.curtime() then
        if aa.manaa == 0 then
            if ui.get(items.left) then
                aa.manaa = 1
                aa.input = globals.curtime()
            elseif ui.get(items.right) then
                aa.manaa = 2
                aa.input = globals.curtime()
            end
        elseif aa.manaa == 1 then
            if ui.get(items.right) then
                aa.manaa = 2
                aa.input = globals.curtime()
            elseif ui.get(items.left) then
                aa.manaa = 0
                aa.input = globals.curtime()
            end
        elseif aa.manaa == 2 then
            if ui.get(items.left) then
                aa.manaa = 1
                aa.input = globals.curtime()
            elseif ui.get(items.right) then
                aa.manaa = 0
                aa.input = globals.curtime()
            end
        end
    end
    if aa.manaa == 2 then
        ui.set(ref.yawjitter[1], "off")
        ui.set(ref.yawjitter[2], 0)
        ui.set(ref.bodyyaw[1], "static")
        ui.set(ref.bodyyaw[2], 180)
        ui.set(ref.fsbodyyaw, false)
        ui.set(ref.yawbase, "local view")
        ui.set(ref.yaw[1], "180")
        ui.set(ref.yaw[2], 90)
        ui.set(ref.limit, 58)
        ui.set(ref.roll, 0)
    elseif aa.manaa == 1 then            
        ui.set(ref.yawjitter[1], "off")
        ui.set(ref.yawjitter[2], 0)
        ui.set(ref.bodyyaw[1], "static")
        ui.set(ref.bodyyaw[2], -180)
        ui.set(ref.fsbodyyaw, false)
        ui.set(ref.yawbase, "local view")
        ui.set(ref.yaw[1], "180")
        ui.set(ref.yaw[2], -90)
        ui.set(ref.limit, 58)
        ui.set(ref.roll, 0)
    end
    renderer.circle(mx - mx + 177, my - my + 48,  15, 15, 15, 155, 10, 0, 0.5)
    renderer.circle_outline(mx - mx + 177, my - my + 48, 255, 0, 0, 250, 10, -86, 0.5, 1)
    renderer.rectangle(mx - mx + 42, my - my + 38, 135, 20, 15, 15, 15, 155)
    renderer.rectangle(mx - mx + 40, my - my + 38, 138, 1, 255, 0, 0, 255)
    renderer.rectangle(mx - mx + 40, my - my + 57, 138, 1, 255, 0, 0, 255)
    renderer.text(mx - mx + 122, my - my + 47, 0, 0, 0, 255, "cb", 0, " jace.paste [crack]")
    renderer.text(mx - mx + 122, my - my + 47, 255, 255, 255, 255, "cb", 0, " jace.paste [crack]")
    if (gif1 ~= nil) then
        gif1:draw(globals.realtime()-start_time, mx - mx + 25, my - my + 25, 40, 40, 255, 255, 255, 255)
    end
end)

client.set_event_callback("player_hurt", on_player_hurt)
client.set_event_callback("round_start", resetdelta)
client.set_event_callback("weapon_fire", fire)
ui.set_callback(ref.enable, menu)
client.set_event_callback("paint_ui", menu)
client.set_event_callback("setup_command", handle_aa)
client.set_event_callback("bullet_impact", detectshot)
client.set_event_callback("setup_command", reduce)
