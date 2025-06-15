--FRIGUS.LUA BETA
--Icy
--icon (snowflake)
--221219\

-- local common,ui,render,vector,color,panorama,files,entity,events,globals,utils,cvar = _G['common'],_G['ui'],_G['render'],_G['vector'],_G['color'],_G['panorama'],_G['files'],_G['entity'],_G['events'],
-- _G['globals'],_G['utils'],_G['cvar']
-- utils.console_exec('clear')

local renderer = require "neverlose/b_renderer"
local gradient  = require("neverlose/gradient")
local lua,helper,ref,eventcall,vis,entitys,antiaim,rages ,notify= {}, {}, {} , {} ,{},{},{},{},{}
local nicetry = false
local vmt_hook = require("neverlose/vmt_hook")
local get_client_entity = utils.get_vfunc("client.dll", "VClientEntityList003", 3, "void*(__thiscall*)(void*, int)")
local ffi = require "ffi"
local clipboard = require("neverlose/clipboard")
local base64 = require("neverlose/base64")
local avat_texture = render.load_image(network.get("https://en.neverlose.cc/static/avatars/"..common.get_username()..".png?t=1655629608"), vector(20,20))
ffi.cdef[[
    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);
    bool DeleteUrlCacheEntryA(const char* lpszUrlName);
    typedef struct
    {
        float x;
        float y;
        float z;
    } Vector_t;

    typedef struct {
		void* fnHandle;
		char szName[260];
		int nLoadFlags;
		int nServerCount;
		int type;
		int flags;
		Vector_t vecMins;
		Vector_t vecMaxs;
		float radius;
		char pad[0x1C];
	} ModelVtable;
]]

local urlmon = ffi.load 'urlmon'
local wininet = ffi.load 'wininet'
local function download(from,to)
    wininet.DeleteUrlCacheEntryA(from)
    urlmon.URLDownloadToFileA(nil, from, to, 0,0)
end
GetModelIndex = (function()
    local GetModelIndex = utils.get_vfunc("engine.dll", "VModelInfoClient004", 2, "int(__thiscall*)(void*, const char*)")
    local NetWorkStringTableContainer = ffi.cast("void***", utils.create_interface("engine.dll", "VEngineClientStringTable001"))
    local FindModelTable = utils.get_vfunc("engine.dll", "VEngineClientStringTable001", 3, "void*(__thiscall*)(void*, const char*)")
    local FindOrLoadModel = utils.get_vfunc("engine.dll", "VModelInfoClient004", 39, "const ModelVtable(__thiscall*)(void*, const char*)")
    local PreCached = function(model_name)
        local FindModelPreCache = {pcall(FindModelTable, "modelprecache")}
        if not FindModelPreCache[1] or FindModelPreCache[2] == ffi.NULL then
            return false
        end

        if FindModelPreCache[1] and FindModelPreCache[2] ~= ffi.NULL then 
            local PreCacheTable = ffi.cast("void***", FindModelPreCache[2])
            if PreCacheTable then
                local PreCacheStringBinder = ffi.cast("int(__thiscall*)(void*, bool, const char*, int, const void*)", PreCacheTable[0][8])
                FindOrLoadModel(model_name)
                local Successed, ModelIndex = pcall(PreCacheStringBinder, PreCacheTable, false, model_name, - 1, nil)
                if not Successed or ModelIndex == ffi.NULL or ModelIndex == - 1 then 
                    return false
                end
            end
        end

        return true
    end

    return function(file_name)
        local ModelName = file_name:lower()
        if not globals.is_in_game or ModelName:len() <= 0 or not ModelName:find(".mdl") then
            return false
        end

        local ModelIndex = GetModelIndex(ModelName)
        if ModelIndex == - 1 then
            PreCached(ModelName)
            return false
        end

        return ModelIndex
    end
end)()

local function down_creat()
    if (files.read("FRIGUA/snow.svg") == nil) then 
        files.create_folder("FRIGUA")
        download("https://files.catbox.moe/o7g6gt.svg","FRIGUA\\snow.svg")
    end
end

down_creat()

local flake = [[

    ========================================================================================================================


    W$$$$$$$$$$$$$*'  \$$$$$$$$$$$$$$#Y;   "W$$$$$$$$$$$~    :fq&$$$$$B%B$$$$Bm'   n$$$$#'      )$$$$B:   /p8$$$$B%%$$$$$k
    #$$$$z________~.  |$$$$&+!!i+/&$$$$Z   .l!!J$$$$hi!!'   (M$$$$br_l,":l-f0&o'   x$$$$o'      1$$$$8:   Q$$$$k_:^^";<{uqq 
    #$$$$xIIIIIIII.   |$$$$W.    ,a$$$$L       v$$$$d      [$$$$$n'          ^i.   x$$$$o'      1$$$$8:  k$$$$Wz\}+!:'   `
    #$$$$$$$$$$$$$<   |$$$$BQCCQq&$$$Mz"       c$$$$d.     0$$$$o'   /CCCCJJJJv`   x$$$$o'      1$$$$8:   >mB$$$$$$$$%#dJ),  
    #$$$$bCCCCCCCJI   |$$$$$BB$$$$$%f^         c$$$$d.     J$$$$M,   JBBB$$$$$8"   x$$$$o.      {$$$$8:     !)vQpaM8$$$$$$M? 
    #$$$$\            |$$$$&l"!U@$$$Wv:        v$$$$d      <8$$$$mi  .```n$$$$W"   /$$$$W:      r$$$$M^   `}l      '"!)&$$$$L 
    #$$$$/            |$$$$W^   +w$$$$Mj"  '1((m$$$$*|((,   ~q$$$$Bwu(]__U$$$$&"   "w$$$$ar}-?)UB$$$B\    ;@@hQn|[--?1cB$$$#_ 
    #$$$$/            |$$$$&"    .1h$$$$o|`"8$$$$$$$$$$$+    .-zdW@$$$$$$$$B&o0^    ')Z#B$$$$$$$$8kz>    " m#B$$$$$$$$$B#Z/


    ========================================================================================================================

]]

print_raw('\a5077C2'..flake)


ref = {
    fakeduck = ui.find('Aimbot','Anti Aim',"Misc","Fake Duck"),
    slowwalk = ui.find('Aimbot','Anti Aim',"Misc","Slow Walk"),
    pitch = ui.find('Aimbot','Anti Aim',"Angles","Pitch"),
    yaw = ui.find('Aimbot','Anti Aim',"Angles","Yaw"),
    yawbase = ui.find('Aimbot','Anti Aim',"Angles","Yaw",'Base'),
    yawadd = ui.find('Aimbot','Anti Aim',"Angles","Yaw",'Offset'),
    fake_lag_limit = ui.find('Aimbot','Anti Aim',"Fake Lag","Limit"),
    yawjitter = ui.find('Aimbot','Anti Aim',"Angles","Yaw Modifier"),
    yawjitter_offset = ui.find('Aimbot','Anti Aim',"Angles","Yaw Modifier",'Offset'),
    fakeangle = ui.find('Aimbot','Anti Aim',"Angles","Body Yaw"),
    inverter = ui.find('Aimbot','Anti Aim',"Angles","Body Yaw","Inverter"),
    left_limit = ui.find('Aimbot','Anti Aim',"Angles","Body Yaw","Left Limit"),
    right_limit = ui.find('Aimbot','Anti Aim',"Angles","Body Yaw","Right Limit"),
    fakeoption = ui.find('Aimbot','Anti Aim',"Angles","Body Yaw","Options"),
    fsbodyyaw = ui.find('Aimbot','Anti Aim',"Angles","Body Yaw","Freestanding"),
    freestanding = ui.find('Aimbot','Anti Aim',"Angles","Freestanding"),
    disableyaw_modifier = ui.find('Aimbot','Anti Aim',"Angles","Freestanding","Disable Yaw Modifiers"),
    body_freestanding = ui.find('Aimbot','Anti Aim',"Angles","Freestanding","Body Freestanding"),
    roll_enable = ui.find('Aimbot','Anti Aim',"Angles","Extended Angles"),
    roll_pitch = ui.find('Aimbot','Anti Aim',"Angles","Extended Angles","Extended Pitch"),
    roll_roll = ui.find('Aimbot','Anti Aim',"Angles","Extended Angles","Extended Roll"),
    leg_movement = ui.find('Aimbot','Anti Aim',"Misc","Leg Movement"),
    hitchance = ui.find('Aimbot','Ragebot',"Selection","Hit Chance"),
    air_strafe = ui.find('Miscellaneous',"Main","Movement",'Air Strafe'),
    windows = ui.find('Miscellaneous',"Main","Other","Windows"),
    scope_overlay = ui.find('Visuals','World','Main','Override Zoom','Scope Overlay'),
    damage = ui.find('Aimbot','Ragebot','Selection','Min. Damage'),
    autopeek = ui.find('Aimbot','Ragebot','Main','Peek Assist'),
    hideshot = ui.find('Aimbot','Ragebot','Main','Hide Shots'),
    dt = ui.find('Aimbot','Ragebot','Main','Double Tap'),
    lag_options = ui.find('Aimbot','Ragebot','Main','Double Tap','Lag Options'),


}
local last_sent , current_choke = 0,0

local    animate = (function()
    local anim = {}

    local lerp = function(start, vend)
        local anim_speed = 12
        return start + (vend - start) * (globals.frametime * anim_speed)
    end

    local lerp_notify = function(start, vend)
        return start + (vend - start) * (globals.frametime * 8)
    end

    
    anim.new_notify = function(value,startpos,endpos,condition)
        if condition ~= nil then
            if condition then
                return lerp_notify(value,startpos)
            else
                return lerp_notify(value,endpos)
            end

        else
            return lerp_notify(value,startpos)
        end
    end



    anim.new = function(value,startpos,endpos,condition)
        if condition ~= nil then
            if condition then
                return lerp(value,startpos)
            else
                return lerp(value,endpos)
            end

        else
            return lerp(value,startpos)
        end

    end

    anim.new_color = function(color,color2,end_value,condition)
        if condition ~= nil then
            if condition then
                color.r = lerp(color.r,color2.r)
                color.g = lerp(color.g,color2.g)
                color.b = lerp(color.b,color2.b)
                color.a = lerp(color.a,color2.a)
            else
                color.r = lerp(color.r,end_value.r)
                color.g = lerp(color.g,end_value.g)
                color.b = lerp(color.b,end_value.b)
                color.a = lerp(color.a,end_value.a)
            end
        else
            color.r = lerp(color.r,color2.r)
            color.g = lerp(color.g,color2.g)
            color.b = lerp(color.b,color2.b)
            color.a = lerp(color.a,color2.a)
        end

        return { r = color.r , g = color.g , b = color.b , a = color.a }
    end

    return anim
end)()




local FONT = {
    tahoma = render.load_font('tahoma',120,'b'),
    verdana11 = render.load_font('verdana',11,'b'),
    verdana12 = render.load_font('verdana',12,'bd'),
    verdana12_b = render.load_font("verdana",11,"ab"),

    
}

local log_paint = function (...)
    local ret = {...}

    table.insert(notify,{
        text = unpack(ret),
        timer = globals.realtime,
        g_alpha = 0,
        addy = 0
    })
end


log_paint('Welcome to Frigus.lua')



helper = {
    gradient = function(r1, g1, b1, a1, r2, g2, b2, a2, text)
            local output = ''
            local len = #text-1
            local rinc = (r2 - r1) / len
            local ginc = (g2 - g1) / len
            local binc = (b2 - b1) / len
            local ainc = (a2 - a1) / len
            for i=1, len+1 do
                output = output .. ('\a%02x%02x%02x%02x%s'):format(r1, g1, b1, a1, text:sub(i, i))
                r1 = r1 + rinc
                g1 = g1 + ginc
                b1 = b1 + binc
                a1 = a1 + ainc
            end
        
        return output
    end,

    hsv_to_rgb = function(b,c,d,e)local f,g,h;local i=math.floor(b*6)local j=b*6-i;local k=d*(1-c)local l=d*(1-j*c)local m=d*(1-(1-j)*c)i=i%6;if i==0 then f,g,h=d,m,k elseif i==1 then f,g,h=l,d,k elseif i==2 then f,g,h=k,d,m elseif i==3 then f,g,h=k,l,d elseif i==4 then f,g,h=m,k,d elseif i==5 then f,g,h=d,k,l end;return f*255,g*255,h*255,e*255 end,


    get_bar_color = function ()
        local r, g, b, a = 255,255,255,255
        local rgb_split_ratio = 100 / 100
        local h = globals.realtime * 30 / 100 or 60 / 1000
        r, g, b = helper.hsv_to_rgb(h, 1, 1, 1)
        r, g, b = r * rgb_split_ratio,g * rgb_split_ratio,b * rgb_split_ratio
        return r, g, b, a 
    end,
   

    clamp = function(num, min, max)
        if num < min then
            num = min
        elseif num > max then
            num = max
        end
        return num
    end,


    vectordistance = function(x1,y1,z1,x2,y2,z2)
        return math.sqrt(math.pow(x1 - x2, 2) + math.pow( y1 - y2, 2) + math.pow( z1 - z2 , 2) )
    end
}

entitys = {
    onground_ticks = 0,
    update_value = {},
    in_air = function (indx)
        return bit.band(indx.m_fFlags,1) == 0
    end,

    on_ground = function (indx,limit)
        local onground = bit.band(indx.m_fFlags,1)
        if onground == 1 then
            entitys.onground_ticks = entitys.onground_ticks + 1
        else
            entitys.onground_ticks = 0
        end

        return entitys.onground_ticks > limit
    end,

    velocity = function(indx)
        local vel = indx.m_vecVelocity
        local velocity = math.sqrt(vel.x * vel.x + vel.y * vel.y)
        return velocity
    end,

    is_crouching = function (indx)
        return indx.m_flDuckAmount > 0.8
    end,

    value_update = function(self,min, max, between, key)
        local between_ = math.abs(between)
        local is_reserved = min < 0 and max < 0
        local math_vars = {max = math.max(max,min),min = math.min(max,min)}
        if not self.update_value[key] then
            self.update_value[key] = is_reserved and math_vars.max or math_vars.min
        end
    
        if globals.choked_commands == 0 then
            if is_reserved then
                self.update_value[key] = self.update_value[key] <= math_vars.min and math_vars.max or (self.update_value[key] - between_)
            elseif not is_reserved then
                self.update_value[key] = self.update_value[key] >= math_vars.max and math_vars.min or (self.update_value[key] + between_)
            end
        end
    
        return self.update_value[key]
    end,

    x_way = function(self,x,degree,key)
        local deg = math.abs(degree)
        return self:value_update(-deg,deg, math.floor(deg/x-2),key)
    end,


}


local log = function (...)
    local ret = {...}
    
    print_raw('\a2ABFFFFrigus.lua'.." \a7D7D7D>> \aFFFFFF"..unpack(ret))
end

local glInfo = ui.create(ui.get_icon('snowflake')..' ','Info')
local glInfo2 = ui.create(ui.get_icon('snowflake')..' ','Update Log')

lua = {

    callback = {},
    uis = {},

    info = {
        username = common.get_username()
    },

    player_states = {
        "Consolidate",
        "Aerobic",
        "Squat",
        "Sluggish-Movement",
        "Heavenly",
        "Heavenly + Squat"
    },

    player_states_temp = {
        "Stand",
        "Move",
        "Duck",
        "Slow-Walk",
        "Air",
        "Air + Duck"
    },




    menu = {

        icons = {
           snowflake = ui.get_icon('snowflake'),
           wrench = ui.get_icon('wrench'),
           eye = ui.get_icon('microchip'),
           crosshairs = ui.get_icon('crosshairs'),
           keyboard = ui.get_icon('keyboard'),
           ey_slash = ui.get_icon('eye-slash'),
           wand_magic = ui.get_icon('unlink'),
           export_config_icon = ui.get_icon("file-export"),
           import_config_icon = ui.get_icon("file-import"),
        },

        new = function(register)
            table.insert(lua.callback,register)
        end,

        sidebar = function ()
            local r,g,b,a = helper.get_bar_color()
            local text_rainbow = helper.gradient(g,b,r,a,r,g,b,a," FRIGUS [BETA]")

            ui.sidebar(text_rainbow,lua.menu.icons.snowflake)
        end,



        create = function ()
           local main_tab , settings_tab , misc_tab  = lua.menu.icons.snowflake..' ',lua.menu.icons.wrench..' ',lua.menu.icons.eye..' '
            
           

        --    local rage1 = ui.create(rage_tab,'Options')
        --    local rage2 = ui.create(rage_tab,'Modifier')

           local global2 = ui.create(settings_tab,'Options')

           local sets_1 = ui.create(settings_tab,'Modifier')
           local sets_2 = ui.create(settings_tab,'Body Options')

           local misc_1  = ui.create(misc_tab,lua.menu.icons.crosshairs..' Rage')
           local misc_2  = ui.create(misc_tab,lua.menu.icons.ey_slash..' Visuals')
           local misc_3  = ui.create(misc_tab,lua.menu.icons.wand_magic..' Misc')
        --    local misc_4  = ui.create(misc_tab,'Modifier')



           lua.uis.info = {}
           lua.uis.sets = {}
           lua.uis.misc = {}
           lua.uis.rage = {}
           local i,s,m,r = lua.uis.info,lua.uis.sets,lua.uis.misc,lua.uis.rage
           i.info_label = glInfo:label('There is a storm is approaching...')
           local icon = render.load_image(
            '<svg t="1672560184540" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2558" width="200" height="200"><path d="M512 982c-63.44 0-124.99-12.43-182.95-36.94-55.97-23.67-106.23-57.56-149.39-100.72s-77.04-93.42-100.72-149.39C54.43 636.99 42 575.44 42 512s12.43-125 36.94-182.95c23.67-55.97 57.56-106.23 100.72-149.39 43.16-43.16 93.42-77.04 149.39-100.72C387.01 54.43 448.56 42 512 42c63.44 0 124.99 12.43 182.95 36.94 55.97 23.67 106.23 57.56 149.39 100.72 43.16 43.16 77.04 93.42 100.72 149.39C969.57 387.01 982 448.56 982 512s-12.43 124.99-36.94 182.95c-23.67 55.97-57.56 106.23-100.72 149.39s-93.42 77.04-149.39 100.72C636.99 969.57 575.44 982 512 982z m0-900C274.9 82 82 274.9 82 512s192.9 430 430 430 430-192.9 430-430S749.1 82 512 82z" p-id="2559" fill="#ffffff"></path><path d="M512 642.87c-3.45 0-6.91-0.89-10-2.68l-96.02-55.44c-6.19-3.57-10-10.17-10-17.32V456.56c0-7.15 3.81-13.75 10-17.32L502 383.81a20.013 20.013 0 0 1 20 0l96.02 55.44c6.19 3.57 10 10.17 10 17.32v110.87c0 7.15-3.81 13.75-10 17.32L522 640.19a19.947 19.947 0 0 1-10 2.68z m-76.02-86.98L512 599.78l76.02-43.89v-87.78L512 424.22l-76.02 43.89v87.78z m172.04 11.55z" p-id="2560" fill="#ffffff"></path><path d="M512 779.16c-11.05 0-20-8.95-20-20V622.87c0-11.05 8.95-20 20-20s20 8.95 20 20v136.29c0 11.05-8.95 20-20 20z" p-id="2561" fill="#ffffff"></path><path d="M572.86 840.02c-5.12 0-10.24-1.95-14.14-5.86l-60.86-60.86c-7.81-7.81-7.81-20.47 0-28.29 7.81-7.81 20.47-7.81 28.28 0L587 805.88c7.81 7.81 7.81 20.47 0 28.29-3.91 3.9-9.02 5.85-14.14 5.85z" p-id="2562" fill="#ffffff"></path><path d="M448.18 842.99c-5.12 0-10.24-1.95-14.14-5.86-7.81-7.81-7.81-20.47 0-28.29l63.82-63.82c7.81-7.81 20.47-7.81 28.28 0 7.81 7.81 7.81 20.47 0 28.29l-63.82 63.82a19.98 19.98 0 0 1-14.14 5.86zM726.03 655.58c-3.39 0-6.83-0.86-9.98-2.68l-118.03-68.14c-9.57-5.52-12.84-17.75-7.32-27.32s17.75-12.84 27.32-7.32l118.03 68.14c9.57 5.52 12.84 17.75 7.32 27.32-3.7 6.42-10.43 10-17.34 10z" p-id="2563" fill="#ffffff"></path><path d="M726.04 655.59c-8.83 0-16.91-5.89-19.31-14.83-2.86-10.67 3.47-21.64 14.14-24.5L804 593.99c10.67-2.87 21.64 3.47 24.5 14.14 2.86 10.67-3.47 21.64-14.14 24.5l-83.13 22.28c-1.74 0.45-3.48 0.68-5.19 0.68z" p-id="2564" fill="#ffffff"></path><path d="M749.4 742.77c-8.83 0-16.91-5.89-19.31-14.83l-23.36-87.19c-2.86-10.67 3.47-21.64 14.14-24.5 10.67-2.86 21.64 3.47 24.5 14.14l23.36 87.19c2.86 10.67-3.47 21.64-14.14 24.5-1.74 0.47-3.48 0.69-5.19 0.69zM608.04 476.57c-6.91 0-13.63-3.59-17.34-10-5.52-9.57-2.25-21.8 7.32-27.32l118.03-68.14c9.56-5.52 21.8-2.25 27.32 7.32s2.25 21.8-7.32 27.32l-118.03 68.14a19.996 19.996 0 0 1-9.98 2.68z" p-id="2565" fill="#ffffff"></path><path d="M726.06 408.42c-1.71 0-3.46-0.22-5.19-0.69-10.67-2.86-17-13.83-14.14-24.49L729 300.11c2.86-10.67 13.83-17.01 24.49-14.14 10.67 2.86 17 13.83 14.14 24.49l-22.27 83.13c-2.39 8.94-10.47 14.83-19.3 14.83z" p-id="2566" fill="#ffffff"></path><path d="M813.25 431.79c-1.71 0-3.46-0.22-5.19-0.69l-87.19-23.36c-10.67-2.86-17-13.83-14.14-24.5 2.86-10.67 13.83-17 24.5-14.14l87.19 23.36c10.67 2.86 17 13.83 14.14 24.5-2.4 8.93-10.48 14.83-19.31 14.83zM512 421.13c-11.05 0-20-8.95-20-20V264.84c0-11.05 8.95-20 20-20s20 8.95 20 20v136.29c0 11.04-8.96 20-20 20z" p-id="2567" fill="#ffffff"></path><path d="M512 284.84c-5.12 0-10.24-1.95-14.14-5.86L437 218.12c-7.81-7.81-7.81-20.47 0-28.28 7.81-7.81 20.47-7.81 28.28 0l60.86 60.86c7.81 7.81 7.81 20.47 0 28.28-3.9 3.91-9.02 5.86-14.14 5.86z" p-id="2568" fill="#ffffff"></path><path d="M512 284.84c-5.12 0-10.24-1.95-14.14-5.86-7.81-7.81-7.81-20.47 0-28.29l63.82-63.82c7.81-7.81 20.47-7.81 28.29 0 7.81 7.81 7.81 20.47 0 28.29l-63.82 63.82a19.943 19.943 0 0 1-14.15 5.86zM415.96 476.57c-3.39 0-6.83-0.86-9.98-2.68l-118.03-68.14c-9.57-5.52-12.84-17.75-7.32-27.32s17.75-12.84 27.32-7.32l118.03 68.14c9.57 5.52 12.84 17.75 7.32 27.32-3.7 6.41-10.43 10-17.34 10z" p-id="2569" fill="#ffffff"></path><path d="M214.81 430.7c-8.83 0-16.91-5.89-19.31-14.83-2.86-10.67 3.47-21.64 14.14-24.5l83.13-22.28c10.67-2.86 21.64 3.47 24.49 14.14 2.86 10.67-3.47 21.64-14.14 24.5L220 430.01c-1.74 0.47-3.48 0.69-5.19 0.69z" p-id="2570" fill="#ffffff"></path><path d="M297.94 408.42c-8.83 0-16.91-5.89-19.31-14.83l-23.36-87.19c-2.86-10.67 3.47-21.64 14.14-24.5 10.67-2.86 21.64 3.47 24.49 14.14l23.36 87.19c2.86 10.67-3.47 21.64-14.14 24.5-1.72 0.47-3.47 0.69-5.18 0.69zM297.97 655.58c-6.91 0-13.63-3.59-17.34-10-5.52-9.57-2.25-21.8 7.32-27.32l118.03-68.14c9.56-5.52 21.8-2.25 27.32 7.32s2.25 21.8-7.32 27.32L307.95 652.9a19.893 19.893 0 0 1-9.98 2.68z" p-id="2571" fill="#ffffff"></path><path d="M275.69 738.72c-1.71 0-3.46-0.22-5.19-0.69-10.67-2.86-17-13.83-14.14-24.5l22.28-83.13c2.86-10.67 13.83-17.01 24.49-14.14 10.67 2.86 17 13.83 14.14 24.5L295 723.89c-2.4 8.93-10.48 14.83-19.31 14.83z" p-id="2572" fill="#ffffff"></path><path d="M297.96 655.58c-1.71 0-3.46-0.22-5.19-0.69l-87.19-23.36c-10.67-2.86-17-13.83-14.14-24.5 2.86-10.67 13.83-17 24.49-14.14l87.19 23.36c10.67 2.86 17 13.83 14.14 24.5-2.38 8.94-10.47 14.83-19.3 14.83z" p-id="2573" fill="#ffffff"></path></svg>',
            vector(200,200))
           local gra_time = helper.gradient(126,159,203,255,255,255,255,255,'2023/2/18')
           local gra_version = helper.gradient(126,159,203,255,255,255,255,255,'Beta')
           local gra_name = helper.gradient(126,159,203,255,255,255,255,255,common.get_username())


           i.info_label2 = glInfo2:label('Last Update Time: '..gra_time)
           i.info_label4 = glInfo2:label('Current Version: '..gra_version)
           i.info_label5 = glInfo2:label('Current User: '..gra_name)
           i.info_ava = glInfo2:texture(avat_texture,vector(20,20),color(),"f",4)

           i.info_label3 = glInfo2:label('You can view the detailed updates of frigus on the Neverlose official website')
           i.icon = glInfo:texture(icon,vector(280,260),color(126,159,203,255),'f')

        --    r.list = misc_1:selectable('Features List',{'Hitchance Modifier',"Denfensive DoubleTap","\aE0D30B96Animation Breaker"})

           r.dt_switch = misc_1:switch('Enchanced DoubleTap',false)
           
           local dt_ref = r.dt_switch:create()

           r.smart_def = dt_ref:switch('Smart Denfensive',false)
           r.tick_fix = dt_ref:switch('Speed Fix',false)
        
           r.hitchance_switch = misc_1:switch('Hitchance Modifier',false)
           local hit_ref = r.hitchance_switch:create()
           r.hitchance_select = hit_ref:selectable('Hitchance Modifier',{'In Air','No Scoped'})
           r.inair_hitchance = hit_ref:slider('In Air Hitchance',0,100,50)
           r.noscope_hitchance = hit_ref:slider('No Scoped Hitchance',0,100,50)
           r.anim_breaker_switch = misc_3:switch('\aE0D30B96Animation Modifier',false)
    
           local anim_ref = r.anim_breaker_switch:create()
           r.anim_breaker = anim_ref:selectable('\aE0D30B96Break anims',{"0 Pitch on land", "Static leg in air", "Break leg", "Static on slow walk", "Static on duck"})

         
           

        --    m.list = misc_1:selectable('Features List',{"Aspect Ratio",'Bloom','Scope Overlay','Speed Indicator',"Solus UI",'ViewModel Changer','Notifications','Kill Say','Clan Tag'})

           m.aspect_ratio_switch = misc_3:switch('Aspect Ratio',false)
           local aspect_ref = m.aspect_ratio_switch:create()
           m.aspect_ratio = aspect_ref:slider('Aspect Ratio',5,50,13,0.1)

           m.view_switch = misc_3:switch('ViewModel Changer',false)
           local view_ref = m.view_switch:create()

           m.v_x = view_ref:slider('Viewmodel X',-10, 10,1)
           m.v_y = view_ref:slider('Viewmodel Y',-10, 10,1)
           m.v_z = view_ref:slider('Viewmodel Z',-10, 10,0)
           m.v_f = view_ref:slider('Viewmodel Fov',0, 100,68)

           m.clantag_switch = misc_3:switch('Clan Tag',false)
           m.killsay = misc_3:switch('Kill Say',false)
           m.strafe_fix = misc_3:switch('Strafe Fix',false)



           m.bloom_switch = misc_2:switch('Bloom Effect',false)
           local bloom_ref = m.bloom_switch:create()
           m.bloom_scale = bloom_ref:slider('Bloom Scale',0,100,20,0.1)
           m.exposure = bloom_ref:slider('Auto Exposure',0,100,0,0.001)
           m.model_ambient = bloom_ref:slider('Minmodel Brightness',0,100,0,0.1)



           m.scope_switch = misc_2:switch('Scope Overlay',false)
           local scope_ref = m.scope_switch:create()
           m.scopeline_color_1 = scope_ref:color_picker('Color 1',color(69,89,147,255))

           m.scopeline_color_2 = scope_ref:color_picker('Color 2',color(69,89,147,0))
           m.scopeline_origin = scope_ref:slider('Scope Origin',0,500,100)
           m.scopeline_width = scope_ref:slider('Scope Width',0,500,100)

          
           m.solus_switch = misc_2:switch('Widgets',false)
           local solus_ref = m.solus_switch:create()

           m.solus_list = solus_ref:selectable('Options',{"Watermark",'Keybind','Spectator','Top Bar','Center Indicator'})
           m.solus_theme = solus_ref:list('Theme',{'Old','Future'})
           m.solus_glow = solus_ref:switch('Glow',false)
           m.solus_color = solus_ref:color_picker("Color",color(141,207,253,255))
           m.solus_rgb  = solus_ref:combo('RGB Mode',{'Dynamic','Static','None'},2)

           m.left_gradient_color  = solus_ref:color_picker('LeftG. Color',color(126,159,203,255))
           m.right_gradient_color  = solus_ref:color_picker('RightG. Color',color(255,255,255,255))
           m.states_color = solus_ref:color_picker('States Color',color(255,255,255,255))
           m.keybind_color = solus_ref:color_picker('Keybind Color',color(255,255,255,255))
           
           m.temp_keybind_x = solus_ref:slider('Temp Key BindX',0,5000,500)
           m.temp_keybind_y = solus_ref:slider('Temp Key BindY',0,5000,500)
           m.temp_spec_x = solus_ref:slider('Temp Key BindX',0,5000,600)
           m.temp_spec_y = solus_ref:slider('Temp Key BindY',0,5000,800)

           m.notify_switch = misc_2:switch('Notifications',false)
           local notify_ref = m.notify_switch:create()

           m.notification_options = notify_ref:selectable('Options',{'Log Events','Log Ragebot'})
           m.notification_options2 = notify_ref:selectable('Options-2',{'Right Log','Center Log','Console Log','Chat Log'})
           m.notification_options3 = notify_ref:combo('Chat Language',{'EN','CN'})
           m.rainbow_bar_switch = misc_2:switch('Rainbow Bar')
        
           local rainbow_ref = m.rainbow_bar_switch:create()

           m.hit_marker = misc_2:switch('Hit Marker')
           local marker_ref = m.hit_marker:create()

            m.hit_color = marker_ref:color_picker('Color',color(255,255,255,255))


            m.slowdown_indicator = misc_2:switch('Slowdown Indicator')
            local slow_ref = m.slowdown_indicator:create()
            m.temp_slow_x = slow_ref:slider('Temp SlowX',0,5000,600)
            m.temp_slow_y = slow_ref:slider('Temp SlowY',0,5000,800)

            m.manual_indicator = misc_2:switch('Manual Indicator')
            local manual_ref = m.manual_indicator:create()
            m.speed_move = manual_ref:switch('By Speed',false)
            m.arrows_distance = manual_ref:slider('Arrow Distance',10,100,15)

            m.manual_color = manual_ref:color_picker('Color',color(255,255,255,255))

            m.model_change_enable = misc_2:switch("Model Changer")
            local model_ref = m.model_change_enable:create()
            m.model_change_select = model_ref:combo("Select",{"varianta_js","variantb_js","variantc_js","varianta","variantb","variantc"})

            m.missmarker_switch = misc_2:switch('Miss Marker')
            local miss_ref = m.missmarker_switch:create()
            m.icon_color = miss_ref:color_picker('Color',color(238,147,147,255))
            m.extra_switch = miss_ref:switch('Extra Info')
            m.extra_color = miss_ref:color_picker('Extra Col',color(255,255,255,255))


      
           s.master_switch = global2:switch('Master Switch',false)

           s.ex_options = global2:selectable('Misc Options',{'Antiaim on use','Manual Yawbase','Pitch Angle'})
           s.manual_yaw = global2:combo("Manual Yawbase",{"At Target", "Forward", "Backward", "Right", "Left", "Freestanding"})
           s.pitch_angle = global2:slider('Pitch Angle',-90,90,0)
           local ex_ref = s.ex_options:create()

           s.use_key = ex_ref:combo('On use mode',{'onkey','always on'})
           s.use_key_on = ex_ref:switch('On key',false)
           s.use_desync_mode = ex_ref:combo('Desync switch',{'Auto','Manual'})
           s.use_manual_on = ex_ref:switch('Manual',false)

           s.a_mode = global2:list('Antiaim Mode',{'Preset','Conditional','Semirage'})
           s.a_selection = global2:list('Player States',lua.player_states)

           lua.uis.custom = {}
        --    lua.colors = {}
            local states_temp = {'C','A','S','SM','H','HS'}

            -- DC377DFF
            -- FFFFFFFF
    

           for key, value in pairs(lua.player_states) do



                lua.uis.custom[key] = {
                    override = sets_1:switch('Override '..lua.player_states[key]..' State',false),
                    pitch = sets_1:combo('['..states_temp[key]..'] Pitch',{"Disabled","Down","Fake Up","Fake Down","Defensive"}),
                    yaw_add_left = sets_1:slider('['..states_temp[key]..'] Yaw Left',-180,180,0),
                    yaw_add_right = sets_1:slider('['..states_temp[key]..'] Yaw Right',-180,180,0),
                    yaw_jitter = sets_1:combo('['..states_temp[key]..'] Yaw Jitter',{"Disabled","Center","Offset","Random","Spin","3 Way","5 Way"}),
                    yaw_jitter_mode = sets_1:list('['..states_temp[key]..'] Yaw Jitter Mode',{"Default",'Jitter',"Reverse"}),
                    yaw_jitter_value = sets_1:slider('['..states_temp[key]..'] Yaw Jitter',-180,180,0),
                    yaw_jitter_value_left = sets_1:slider('['..states_temp[key]..'] Yaw JitterL',-180,180,0),
                    yaw_jitter_value_right = sets_1:slider('['..states_temp[key]..'] Yaw JitterR',-180,180,0),
                    bodyyaw = sets_1:combo('['..states_temp[key]..'] Body Yaw',{"Disabled","Static","Jitter"}),
                    bodyyaw_mode = sets_1:list('['..states_temp[key]..'] Body Yaw Mode',{'Default','Jitter',"Reverse"}),
                    bodyyaw_value = sets_1:slider('['..states_temp[key]..'] Body Yaw',-180,180,0),
                    bodyyaw_value_left = sets_1:slider('['..states_temp[key]..'] Body Left',-180,180,0),
                    bodyyaw_value_right = sets_1:slider('['..states_temp[key]..'] Body Right',-180,180,0),

                    fake_yaw_mode = sets_1:list('['..states_temp[key]..'] Fake Yaw Mode',{'Default','Jitter',"Update"}),
                    fake_yaw_value = sets_1:slider('['..states_temp[key]..'] Fake Yaw',0,60,60),
                    fake_yaw_value_left = sets_1:slider('['..states_temp[key]..'] Fake LimitL',0,60,60),
                    fake_yaw_value_right = sets_1:slider('['..states_temp[key]..'] Fake LimitR',0,60,60),
                    roll_enable = sets_1:switch('['..states_temp[key]..'] Extended Angles',false),
                    roll_pitch = sets_1:slider('['..states_temp[key]..'] Extended Pitch',0,180,180),
                    roll_roll = sets_1:slider('['..states_temp[key]..'] Extended Roll',0,90,70),

                    jitter_options = sets_2:selectable('['..states_temp[key]..'] Body Options',{'Smart Jitter','Freestand Desync'}),
                    fsbodyyaw_mode = sets_2:list('['..states_temp[key]..'] Deysnc Direction',{'Peek Fake','Peek Real'}),
                }



           end

    




        end,

        render_menu_color = function ()

        end,

        visible = function ()
            local i,s,m,r = lua.uis.info,lua.uis.sets,lua.uis.misc,lua.uis.rage

            local s_switch = s.master_switch:get()
            

            -- r.hitchance_select:visibility()
            -- r.inair_hitchance:visibility( )
            -- r.noscope_hitchance:visibility(  )
            -- r.anim_breaker:visibility( )

            s.ex_options:visibility(s_switch)
            s.use_key:visibility(s_switch and s.ex_options:get('Antiaim on use')) 
            s.use_key_on:visibility(s_switch and s.ex_options:get('Antiaim on use') and s.use_key:get() == 'onkey') 
            s.use_desync_mode:visibility(s_switch and s.ex_options:get('Antiaim on use')) 
            s.use_manual_on:visibility(s_switch and s.ex_options:get('Antiaim on use') and s.use_desync_mode:get() == 'Manual') 
            s.a_mode:visibility(s_switch)
            s.manual_yaw:visibility(s_switch and s.ex_options:get('Manual Yawbase')) 
            s.pitch_angle:visibility(s_switch and s.ex_options:get('Pitch Angle')) 
            local show_condition = s_switch and s.a_mode:get() == 2
            local show_condition_semi = s_switch and s.a_mode:get() == 3

            s.a_selection:visibility(show_condition or show_condition_semi)

            local selection = s.a_selection:get()

            for key, value in pairs(lua.player_states) do
                local show_semi = selection == key and show_condition_semi
                local show = selection == key and show_condition

                local overrided = lua.uis.custom[key].override:get()

                lua.uis.custom[key].override:visibility(show or show_semi)

                local sshow = show and overrided
                local sshow_semi = show_semi and overrided

                lua.uis.custom[key].jitter_options:visibility(sshow or sshow_semi)
                lua.uis.custom[key].fsbodyyaw_mode:visibility((sshow or sshow_semi)  and lua.uis.custom[key].jitter_options:get('Freestand Desync'))
                lua.uis.custom[key].pitch:visibility(sshow)
                lua.uis.custom[key].yaw_add_left:visibility(sshow or sshow_semi)
                lua.uis.custom[key].yaw_add_right:visibility(sshow or sshow_semi)
                lua.uis.custom[key].yaw_jitter:visibility(sshow)
                lua.uis.custom[key].yaw_jitter_mode:visibility(sshow and lua.uis.custom[key].yaw_jitter:get() ~= 'Disabled')
                local yaw_jref = {"Default",'Jitter',"Reverse"}
                lua.uis.custom[key].yaw_jitter_value:visibility(sshow and lua.uis.custom[key].yaw_jitter:get() ~= 'Disabled' and yaw_jref[lua.uis.custom[key].yaw_jitter_mode:get()] == 'Default')
                lua.uis.custom[key].yaw_jitter_value_left:visibility(sshow and lua.uis.custom[key].yaw_jitter:get() ~= 'Disabled' and yaw_jref[lua.uis.custom[key].yaw_jitter_mode:get()] ~= 'Default' and lua.uis.custom[key].yaw_jitter:get() ~= '3 Way' and lua.uis.custom[key].yaw_jitter:get() ~= '5 Way')
                lua.uis.custom[key].yaw_jitter_value_right:visibility(sshow and lua.uis.custom[key].yaw_jitter:get() ~= 'Disabled' and yaw_jref[lua.uis.custom[key].yaw_jitter_mode:get()] ~= 'Default' and lua.uis.custom[key].yaw_jitter:get() ~= '3 Way' and lua.uis.custom[key].yaw_jitter:get() ~= '5 Way')
                lua.uis.custom[key].bodyyaw:visibility((sshow or sshow_semi))

                local by_ref = {'Default','Jitter',"Reverse"}
                lua.uis.custom[key].bodyyaw_mode:visibility(sshow and lua.uis.custom[key].bodyyaw:get() ~= 'Disabled')
                lua.uis.custom[key].bodyyaw_value:visibility(sshow and lua.uis.custom[key].bodyyaw:get() ~= 'Disabled' and by_ref[lua.uis.custom[key].bodyyaw_mode:get()] == 'Default')
                lua.uis.custom[key].bodyyaw_value_left:visibility(sshow and lua.uis.custom[key].bodyyaw:get() ~= 'Disabled' and by_ref[lua.uis.custom[key].bodyyaw_mode:get()] ~= 'Default') 
                lua.uis.custom[key].bodyyaw_value_right:visibility(sshow and lua.uis.custom[key].bodyyaw:get() ~= 'Disabled' and by_ref[lua.uis.custom[key].bodyyaw_mode:get()] ~= 'Default')
                local fake_ref = {'Default','Jitter'}
                lua.uis.custom[key].fake_yaw_mode:visibility((sshow or sshow_semi) and lua.uis.custom[key].bodyyaw:get() ~= 'Disabled')

                lua.uis.custom[key].fake_yaw_value:visibility((sshow or sshow_semi) and lua.uis.custom[key].bodyyaw:get() ~= 'Disabled' and fake_ref[lua.uis.custom[key].fake_yaw_mode:get()] == 'Default')
                lua.uis.custom[key].fake_yaw_value_left:visibility((sshow or sshow_semi) and lua.uis.custom[key].bodyyaw:get() ~= 'Disabled' and fake_ref[lua.uis.custom[key].fake_yaw_mode:get()] ~= 'Default')
                lua.uis.custom[key].fake_yaw_value_right:visibility((sshow or sshow_semi) and lua.uis.custom[key].bodyyaw:get() ~= 'Disabled' and fake_ref[lua.uis.custom[key].fake_yaw_mode:get()] ~= 'Default')
                lua.uis.custom[key].roll_enable:visibility(sshow_semi)
                lua.uis.custom[key].roll_pitch:visibility(sshow_semi and lua.uis.custom[key].roll_enable:get())
                lua.uis.custom[key].roll_roll:visibility(sshow_semi and lua.uis.custom[key].roll_enable:get())



            end

            m.solus_glow:visibility(m.solus_theme:get() == 2)
            m.solus_color:visibility(m.solus_theme:get() == 2)
            m.solus_rgb:visibility(m.solus_theme:get() == 1)
            m.left_gradient_color:visibility(m.solus_list:get('Center Indicator'))
            m.right_gradient_color:visibility(m.solus_list:get('Center Indicator'))
            m.states_color:visibility(m.solus_list:get('Center Indicator'))
            m.keybind_color:visibility(m.solus_list:get('Center Indicator'))


            m.temp_keybind_x :visibility(false)
            m.temp_keybind_y:visibility(false)
            m.temp_spec_x:visibility(false)
            m.temp_spec_y:visibility(false)

            -- m.aspect_ratio:visibility(m.list:get('Aspect Ratio'))
            -- m.v_x:visibility(m.list:get('ViewModel Changer'))
            -- m.v_y:visibility(m.list:get('ViewModel Changer'))
            -- m.v_z:visibility(m.list:get('ViewModel Changer'))
            -- m.v_f:visibility(m.list:get('ViewModel Changer'))

            -- m.wall_options:visibility(m.list:get('Bloom'))
            -- m.wall_color:visibility(m.list:get('Bloom'))
            -- m.bloom_scale:visibility(m.list:get('Bloom'))
            -- m.exposure:visibility(m.list:get('Bloom'))
            -- m.model_ambient:visibility(m.list:get('Bloom'))

            -- m.scopeline_color:visibility(m.list:get('Scope Overlay'))
            -- m.scopeline_origin:visibility(m.list:get('Scope Overlay'))
            -- m.scopeline_width:visibility(m.list:get('Scope Overlay'))
            -- m.solus_list:visibility(m.list:get('Solus UI'))

        end,

        call = function ()
            
            for key, value in pairs(lua.uis.sets) do
                value:set_callback(lua.menu.visible)
            end

            for key, value in pairs(lua.uis.misc) do
                value:set_callback(lua.menu.visible)
            end

            for key, value in pairs(lua.uis.rage) do
                value:set_callback(lua.menu.visible)
            end

            for key, value in pairs(lua.uis.custom) do
                for index, value in pairs(lua.uis.custom[key]) do
                    value:set_callback(lua.menu.visible)
                end
            end
        end

    },

    init = function ()
        lua.menu.create()
        lua.menu.visible()
        lua.menu.call()
        table.insert(lua.ui_data.bool,lua.uis.sets.master_switch)
        table.insert(lua.ui_data.str,lua.uis.sets.ex_options)
        table.insert(lua.ui_data.int,lua.uis.sets.a_mode)

        for key, value in pairs(lua.player_states) do
            table.insert(lua.ui_data.bool,lua.uis.custom[key].override)
            table.insert(lua.ui_data.bool,lua.uis.custom[key].roll_enable)
            table.insert(lua.ui_data.str,lua.uis.custom[key].pitch)
            table.insert(lua.ui_data.int,lua.uis.custom[key].yaw_add_left)
            table.insert(lua.ui_data.int,lua.uis.custom[key].yaw_add_right)
            table.insert(lua.ui_data.str,lua.uis.custom[key].yaw_jitter)
            table.insert(lua.ui_data.int,lua.uis.custom[key].yaw_jitter_mode)
            table.insert(lua.ui_data.int,lua.uis.custom[key].yaw_jitter_value)
            table.insert(lua.ui_data.int,lua.uis.custom[key].yaw_jitter_value_left)
            table.insert(lua.ui_data.int,lua.uis.custom[key].yaw_jitter_value_right)
            table.insert(lua.ui_data.str,lua.uis.custom[key].bodyyaw)
            table.insert(lua.ui_data.int,lua.uis.custom[key].bodyyaw_mode)
            table.insert(lua.ui_data.int,lua.uis.custom[key].bodyyaw_value)
            table.insert(lua.ui_data.int,lua.uis.custom[key].bodyyaw_value_left)
            table.insert(lua.ui_data.int,lua.uis.custom[key].bodyyaw_value_right)
            table.insert(lua.ui_data.int,lua.uis.custom[key].fake_yaw_mode)
            table.insert(lua.ui_data.int,lua.uis.custom[key].fake_yaw_value)
            table.insert(lua.ui_data.int,lua.uis.custom[key].fake_yaw_value_left)
            table.insert(lua.ui_data.int,lua.uis.custom[key].fake_yaw_value_right)
            table.insert(lua.ui_data.int,lua.uis.custom[key].roll_pitch)
            table.insert(lua.ui_data.int,lua.uis.custom[key].roll_roll)
            table.insert(lua.ui_data.str,lua.uis.custom[key].jitter_options)
            table.insert(lua.ui_data.int,lua.uis.custom[key].fsbodyyaw_mode)
        end

    end,

    ui_data = {
        bool = {},
        int = {},
        float = {},
        str = {},
        color = {}
    },
}

lua.init()



local export_config = function()
    local data = {{},{},{},{},{}}



    for k, v in pairs(lua.ui_data.bool) do
        table.insert(data[1],v:get())
    end
    for k, v in pairs(lua.ui_data.int) do
        table.insert(data[2],v:get())
    end
    for k, v in pairs(lua.ui_data.float) do
        table.insert(data[3],v:get())
    end
    for k, v in pairs(lua.ui_data.str) do
        table.insert(data[4],v:get())
    end
    for _, colors in pairs(lua.ui_data.color) do
        local clr = colors:get()
        table.insert(data[5], string.format("%02X%02X%02X%02X", math.floor(clr.r * 255), math.floor(clr.g * 255), math.floor(clr.b * 255), math.floor(clr.a * 255)))
    end



    clipboard.set(base64.encode(json.stringify(data)))
    
    log('Exported config to clipboard')
    log_paint('Exported config to clipboard')
end

local import_config = function()
    local protected_ = function ()
        local clipboard = clipboard.get() 
        local json_config = base64.decode(clipboard)
        json_config = json.parse(json_config)

        if json_config == nil then
            error("wrong_json")
            return
        end

        for k, v in pairs(json_config) do
            k = ({[1] = "bool", [2] = "int", [3] = "float", [4] = "str", [5] = "color"})[k]
            for k2, v2 in pairs(v) do
                if (k == "bool") then 

                    lua.ui_data[k][k2]:set(v2) 
                   
                end
                if (k == "int") then 
                    if type(v2) == "number" then
                        lua.ui_data[k][k2]:set(v2) 
                    else
                        return log("Fail to load due to incorrect data type, expect number received "..type(v2))
                    end
                end
                if (k == "float") then 
                    if type(v2) == "number" then
                        lua.ui_data[k][k2]:set(v2) 
                    else
                        return log("Fail to load due to incorrect data type, expect number received "..type(v2))
                    end
                end

                if (k == "str") then 
                    lua.ui_data[k][k2]:set(v2) 
                end
            end
        end


        log('Loaded Config')
        log_paint('Loaded Config')

    end

    log('Trying to load config..')
    log_paint('Trying to load config..')

    local status , message = pcall(protected_)

    if not status then
        log("Error: "..message)
        log_paint("\aFF0000FFError: "..message)
        return 
    end

end



glInfo2:button(lua.menu.icons.export_config_icon.."    Export Config    ",function()
    export_config()
end,true)

glInfo2:button(lua.menu.icons.import_config_icon.."    Import Config    ",function()
    import_config()
end,true)


local c = {}

c.data_call = {}

c.delay_call = function(time, fn)
    table.insert(c.data_call, {
        fn = fn,
        time = time,
        realtime = globals.realtime
    })

    function client_call_delay()
        for i, data in ipairs(client.data_call) do
            if data.realtime + data.time < globals.realtime then
                data.fn()
                data.realtime = globals.realtime
            end
        end
    end
end





hook_function = nil
is_on_ground = false


inside_updateCSA = function(thisptr, edx)
    hook_function(thisptr, edx)

    if entity.get_local_player() == nil or ffi.cast("uintptr_t", thisptr) == nil then return end
    local lp = entity.get_local_player()
    is_on_ground = bit.band(lp.m_fFlags, bit.lshift(1, 0)) == 1
    ref.leg_movement:override(nil)

    if lua.uis.rage.anim_breaker:get("Static on slow walk") and ref.slowwalk:get() then
        ref.leg_movement:override("Walking")
        lp.m_flPoseParameter[9] = 0
    end

    if lua.uis.rage.anim_breaker:get("Break leg") then
        ref.leg_movement:override("Sliding")
        lp.m_flPoseParameter[0] = 0
    end

    
    if lua.uis.rage.anim_breaker:get("Static on duck") then
        lp.m_flPoseParameter[8] = 0
    end

    if lua.uis.rage.anim_breaker:get("Static leg in air") then
        lp.m_flPoseParameter[6] = 1
    end
    if lua.uis.rage.anim_breaker:get("0 Pitch on land") then
        local anim_state = lp:get_anim_state()
        if not anim_state then
            return
        end
        if not is_on_ground or not anim_state.landing then
            return
        end
        lp.m_flPoseParameter[12] = 0.5
    end
end

update_hooked_function = function(cmd)
    local lp = entity.get_local_player()
    if not lp or not lp:is_alive() then
        return
    end
    is_on_ground = bit.band(lp.m_fFlags, bit.lshift(1, 0)) == 1
    local local_index = lp:get_index()
    local local_address = get_client_entity(local_index)
    if not local_address or hook_function then
        return
    end
    local pointer = vmt_hook.new(local_address)
    hook_function = pointer.hook("void(__fastcall*)(void*, void*)", inside_updateCSA, 224)
end
events.createmove_run:set(update_hooked_function)

rages = {

    hitchance_modification = function ()
        if not lua.uis.rage.hitchance_switch:get() then
            return 
        end
        local me = entity.get_local_player()

        if not me:is_alive() then
            return
        end


        local inair_hitchance = lua.uis.rage.inair_hitchance:get()
        local noscope_hitchance = lua.uis.rage.noscope_hitchance:get()

        local is_scoped = me.m_bIsScoped
        local weapon = me:get_player_weapon()

        if lua.uis.rage.hitchance_select:get("In Air") then
            if entitys.in_air(me) then
                ref.hitchance:override(inair_hitchance)
            else
                ref.hitchance:override()
            end
        end

        if lua.uis.rage.hitchance_select:get("No Scoped") then
            if weapon ~= nil then
                if weapon:get_weapon_index() == 38 or  weapon:get_weapon_index() == 11 or  weapon:get_weapon_index() == 9 or  weapon:get_weapon_index() == 40 then
                    if not is_scoped then
                        for i = 1, 64 do
                            ref.hitchance:override(noscope_hitchance)
                        end
                    end
                end
            else
                ref.hitchance:override()
            end
        end

    end,


    dt = function ()
        if not lua.uis.rage.dt_switch:get() then
            return
        end
        if lua.uis.rage.smart_def:get() then
            if not entity.get_local_player() then
                return
            end

            if entitys.in_air(entity.get_local_player()) then
                rage.exploit:allow_defensive(true)
                ref.lag_options:override('Always On')
            else
                ref.lag_options:override('Disabled')
                rage.exploit:allow_defensive(false)
            end

        end

        if lua.uis.rage.tick_fix:get() then
            cvar.sv_maxusrcmdprocessticks:int(16)
        end
        
    end,

    strafe_fix = function()
    
        local me = entity.get_local_player()

        if not me:is_alive() then
            return
        end

        local weapon = me:get_player_weapon()

        if weapon == nil then
            return
        end

        
        if lua.uis.misc.strafe_fix:get()  then
            local is_grenade = 
            weapon:get_weapon_index() == 43 or
            weapon:get_weapon_index() == 44 or
            weapon:get_weapon_index() == 45 or
            weapon:get_weapon_index() == 46 or
            weapon:get_weapon_index() == 47 

            if is_grenade then
                ref.air_strafe:override(true)
            else
                if entitys.velocity(me) < 5 then
                    ref.air_strafe:override(false)
                else
                    ref.air_strafe:override(true)
                end
            end

        else
            ref.air_strafe:override()
        end
        


    end,



}


local notification = function()
    local screen = render.screen_size()
    local cx,cy = screen.x/2,screen.y/2
    local y = cy + 300

    for i, info in pairs(notify) do
    
        if info.text ~= nil and info.text ~= '' then
            info.g_alpha = animate.new_notify(info.g_alpha,0,1,info.timer + 2 < globals.realtime)
            -- info.addy = animate.new_notify(info.addy,y)
            local addy = math.floor(info.addy)
            local text_size = render.measure_text(1,'',info.text)

            local function corner(x, y, w, h, header, r,g,b,a,theme)

                if theme == 2 then 
                    r1,g1,b1 = r, g , b
                    r2,g2,b2 = r, g , b
                    r3,g3,b3 = r, g , b
                    if lua.uis.misc.solus_glow:get() then 
                        render.shadow(vector(x,y), vector(x+w,y+h), color(r,g,b,a),30, 0, 4)
                    end
                    local n = a / 255 * 35;
                    local s = 16/24
                    render.texture(vis.main_menu.svg.solus_pit, vector(x + 4 + w/2 - 4 * 2 - 16/2 + 4,y -8), vector(16,16), color(r,g,b,a), "", 0)
                    render.gradient(vector(x + 4 - s, y), vector(x + 4 + w/2 - 4 * 2 - 16/2, y + 1), color(r1, g1, b1, a), color(r2, g2, b2, a), color(r1, g1, b1, a), color(r2, g2, b2, a))
                    render.gradient(vector(x + 4 + w/2 - 4 * 2 + 16/2 + 8, y), vector(x + 4 + w - 4 * 2 + s, y + 1), color(r2, g2, b2, a), color(r3, g3, b3, a), color(r2, g2, b2, a), color(r3, g3, b3, a))
                    
                    render.circle_outline(vector(x + 4 - s, y + 4), color(r1, g1, b1, a), 4, 180, 0.25, 1)
                    render.circle_outline(vector(x + w - 4 + s, y + 4), color(r3, g3, b3, a), 4, 270, 0.25, 1)

                    render.gradient(vector(x - s, y + 4), vector(x + 1 - s, y + 4 + h - 4 * 2), color(r1, g1, b1, a), color(r1, g1, b1, a), color(r2, g2, b2, n), color(r2, g2, b2, n))
                    render.gradient(vector(x + w - 1 + s, y + 4), vector(x + w + s, y + 4 + h - 4 * 2), color(r3, g3, b3, a), color(r3, g3, b3, a), color(r2, g2, b2, n), color(r2, g2, b2, n))

                    render.circle_outline(vector(x + 4 - s, y + h - 4), color(r2, g2, b2, n), 4, 90, 0.25, 1)
                    render.circle_outline(vector(x + w - 4 + s, y + h - 4), color(r2, g2, b2, n), 4, 0, 0.25, 1)

                    render.gradient(vector(x + 4 - s, y + h - 1), vector(x + 4 + w/2 - 4 * 2, y + h), color(r2, g2, b2, n), color(r1, g1, b1, n), color(r2, g2, b2, n), color(r1, g1, b1, n))
                    render.gradient(vector(x + 4 + w/2 - 4 * 2, y + h - 1), vector(x + 4 + w - 4 * 2 + s, y + h), color(r1, g1, b1, n), color(r2, g2, b2, n), color(r1, g1, b1, n), color(r2, g2, b2, n))

                else
                    local c = {10, 60, 40, 40, 40, 60, 20}
                    for i = 0,6,1 do
                        renderer.rectangle(x+i, y+i, w-(i*2), h-(i*2), c[i+1], c[i+1], c[i+1], a)
                    end
                    if header then
                        local x_inner, y_inner = x+7, y+7
                        local w_inner = w-14
                
                        local a_lower = a/2

                        local r,g,b = helper.get_bar_color()
                        if lua.uis.misc.solus_rgb:get() == 'Dynamic' then
                            --renderer.gradient(x_inner, y_inner+1, w_inner, 1, r,g,b, a_lower, b,g,r, a_lower, false)
                            renderer.gradient(x_inner, y_inner+1, math.floor(w_inner/2), 1, r,g,b, a_lower, b,g,r, a_lower, true)
                            renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, b,g,r, a_lower, g,b,r, a_lower, true)
                        elseif lua.uis.misc.solus_rgb:get() == 'Static' then
                            
                            renderer.gradient(x_inner, y_inner+1, math.floor(w_inner/2), 1, 59, 175, 222, a_lower, 202, 70, 205, a_lower, true)
                            renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, 202, 70, 205, a_lower, 201, 227, 58, a_lower, true)
                        else

                            renderer.gradient(x_inner, y_inner+1, w_inner, 20, 126,159,203, a_lower, 0,0,0, 0, false)
                        end

                        -- renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, 202, 70, 205, a_lower, 201, 227, 58, a_lower, true)
                    end
                end
            end

            local r,g,b,a = 126,159,203,255
            local tt = lua.uis.misc.solus_theme:get()
            local cc = lua.uis.misc.solus_color:get()
            if lua.uis.misc.notify_switch:get() then

                -- for radius = 3, 15 do
                --     local radius = radius / 2;
                --     render.rect_outline(vector(screen.x - math.floor((text_size.x + 43) * info.g_alpha) - 7 - radius,y - 5 - radius), vector(screen.x - math.floor((text_size.x + 45) * info.g_alpha) - 7 - radius + (text_size.x + 43) + radius * 2,y - 5 - radius + (text_size.y + 14) + radius * 2), color(r,g,b,20 - radius * 2),0.5,5)
                -- end

                -- render.blur(vector(screen.x - math.floor((text_size.x + 45) * info.g_alpha) - 7,y - 5 ),vector(screen.x - math.floor((text_size.x + 45) * info.g_alpha) - 7 + (text_size.x + 45),y - 5 + (text_size.y + 14)),2,6)

                corner(screen.x/2 - math.floor((text_size.x/2 + 45 ) * info.g_alpha) + 15 - 7 + 5,y - 7 ,(text_size.x + 45) ,(text_size.y + 20) ,true,cc.r,cc.g,cc.b,a * info.g_alpha,tt)

                -- render.rect(vector(screen.x - math.floor((text_size.x + 45) * info.g_alpha) - 7,y - 5 ),vector(screen.x - math.floor((text_size.x + 45) * info.g_alpha) - 7 + (text_size.x + 45),y - 5 + (text_size.y + 14)),color(0,0,0 ,130 * info.g_alpha ),5)
                -- render.rect_outline(vector(screen.x - math.floor((text_size.x + 45) * info.g_alpha) - 7,y - 5 ),vector(screen.x - math.floor((text_size.x + 45) * info.g_alpha) - 7 + (text_size.x + 45),y - 5 + (text_size.y + 14)),color(r,g,b,a * info.g_alpha ),2,5)

                -- render.rect(vector(screen.x - math.floor((text_size.x + 13) * info.g_alpha) - 7,y - 5  ),vector(screen.x - math.floor((text_size.x + 13) * info.g_alpha) - 7 + 3 ,y - 5 +text_size.y + 14  ),color(r,g,b,a * info.g_alpha))
      
                

                render.texture(vis.main_menu.svg.icon,vector(screen.x/2 - math.floor((text_size.x/2 + 30 ) * info.g_alpha)  + 15- 7,y + 2 ),vector(15,15),color(r,g,b,255 * info.g_alpha),'f')

                render.text(1,vector(screen.x/2 - math.floor((text_size.x/2 + 12)* info.g_alpha) + 15,y + 3),color(255,255,255,255 * info.g_alpha),nil,info.text)
            end         
        end
        y = y + (40 * info.g_alpha )

        if info.timer + 3 < globals.realtime then
            table.remove(notify,i)
        end
    end
end

local aimbot_log = {}

aimbot_log = {

   hitgroup_str = {
        [0] = 'generic',
        'head', 'chest', 'stomach',
        'left arm', 'right arm',
        'left leg', 'right leg',
        'neck', 'generic', 'gear'
    },
    hitgroups_cn = {
        [0] = '全身',
        '头部', '胸部', '胃部',
        '左臂', '右臂',
        '左腿', '右腿',
        '脖子', '全身', '未知'
    },

    miss_cn = {
        ["spread"] = "扩散",
        ["correction"] = "解析",
        ["misprediction"] = "预测失误",
        ["prediction error"] = "预测误差",
        ["lagcomp failure"] = "扩散",
        ["unregistered shot"] = "未注册",
        ["player death"] = "目标死亡",
        ["death"] = "死亡",
    },

    on_hurt = function (e)
        if e.state ~= nil then
            aimbot_log.aim_ack(e)
            return
        end

        local user = entity.get(e.target, true)
        local hitgroup = aimbot_log.hitgroup_str[e.hitgroup]
        local hitgroup_cn = aimbot_log.hitgroups_cn[e.hitgroup]
        local r,g,b,a = helper.get_bar_color()
        local text_rainbow = helper.gradient(g,b,r,a,r,g,b,a," FRIGUS-HitLog")
        local color_ = "\a"..string.sub(lua.uis.misc.solus_color:get():to_hex(),1,8)
        local color_2 = "\a"..string.sub(lua.uis.misc.solus_color:get():to_hex(),1,6)
        if lua.uis.misc.notification_options:get("Log Ragebot") then
            if lua.uis.misc.notification_options2:get("Center Log") then
                log_paint(('\aFFFFFFFFHit %s%s \aFFFFFFFFin the %s%s\aFFFFFFFF for %s%d \aFFFFFFFFdamage (%s%d \aFFFFFFFFhealth remaining)'):format(
                        color_,
                        user:name(), 
                        color_,
                        hitgroup,
                        color_,
                        e.damage, 
                        color_,
                        e.target.m_iHealth
                ))
            end
            if lua.uis.misc.notification_options2:get("Console Log") then
                log(('\aFFFFFFHit %s%s \aFFFFFFin the %s%s\aFFFFFF for %s%d \aFFFFFFdamage (%s%d \aFFFFFFhealth remaining)'):format(
                    color_2,
                    user:name(), 
                    color_2,
                    hitgroup,
                    color_2,
                    e.damage, 
                    color_2,
                    e.target.m_iHealth
                ))
            end
            if lua.uis.misc.notification_options2:get("Right Log") then
                common.add_notify(text_rainbow, ('\aFFFFFFFFHit %s%s \aFFFFFFFFin the %s%s\aFFFFFFFF for %s%d \aFFFFFFFFdamage (%s%d \aFFFFFFFFhealth remaining)'):format(
                    color_,
                    user:name(), 
                    color_,
                    hitgroup,
                    color_,
                    e.damage, 
                    color_,
                    e.target.m_iHealth
                ))
            end
            if lua.uis.misc.notification_options2:get("Chat Log") then
                if lua.uis.misc.notification_options3:get() == 'CN' then
                    print_chat((" \x04✔ 命中 \x08 %s \x01 的 \x04 %s \x01 造成 \x04 %d \x01 伤害 ( 剩余血量: \x04 %d \x01 )"):format(
                        user:name(), 
                        hitgroup_cn,
                        e.damage, 
                        e.target.m_iHealth
                    ))
                else
                    print_chat((" \x04✔ Hit \x08 %s \x01 's \x04 %s \x01 for \x04 %d \x01 damage ( health remaining: \x04 %d \x01 )"):format(
                        user:name(), 
                        hitgroup,
                        e.damage, 
                        e.target.m_iHealth
                    ))
                end
                --print_chat(" \x06✔ \x01命中 \x0c %s \x01 的 \x10 %s \x01 造成 \x02 %d \x01 伤害 ( 剩余血量: \x06 %d \x01 )")
            end
        end
    end,

    aim_ack = function (e)
        if e.id ~= nil and e.target ~= nil then
            if e.state == nil then
                aimbot_log.on_hurt(e)
                return
            end
            local r,g,b,a = helper.get_bar_color()
            local text_rainbow = helper.gradient(g,b,r,a,r,g,b,a," FRIGUS-HitLog")
            local user = entity.get(e.target, true)
            local hitgroup = aimbot_log.hitgroup_str[e.wanted_hitgroup]
            local hitgroup_cn = aimbot_log.hitgroups_cn[e.wanted_hitgroup]
            local color_ = "\a"..string.sub(lua.uis.misc.solus_color:get():to_hex(),1,8)
            local color_2 = "\a"..string.sub(lua.uis.misc.solus_color:get():to_hex(),1,6)
            if lua.uis.misc.notification_options:get("Log Ragebot") then
                if lua.uis.misc.notification_options2:get("Center Log") then
                    log_paint(('\aFFFFFFFFMiss %s%s \aFFFFFFFFin the %s%s\aFFFFFFFF due to \aFF3333FF%s \aFFFFFFFF| backtrack: %s%s \aFFFFFFFFtick | hitchance: %s%s'):format(
                        color_,
                        user:name(), 
                        color_,
                        hitgroup,
                        e.state, 
                        color_,
                        e.backtrack,
                        color_,
                        e.hitchance
                    ))
                end
                if lua.uis.misc.notification_options2:get("Console Log") then
                    log(('\aFFFFFFMiss %s%s \aFFFFFFin the %s%s\aFFFFFF due to \aFF3333%s \aFFFFFF| backtrack: %s%s \aFFFFFFtick | hitchance: %s%s'):format(
                        color_2,
                        user:name(), 
                        color_2,
                        hitgroup,
                        e.state, 
                        color_2,
                        e.backtrack,
                        color_2,
                        e.hitchance
                    ))
                end
                if lua.uis.misc.notification_options2:get("Right Log") then
                    common.add_notify(text_rainbow, ('\aFFFFFFFFMiss %s%s \aFFFFFFFFin the %s%s\aFFFFFFFF due to \aFF3333FF%s \aFFFFFFFF| backtrack: %s%s \aFFFFFFFFtick | hitchance: %s%s'):format(
                        color_,
                        user:name(), 
                        color_,
                        hitgroup,
                        e.state, 
                        color_,
                        e.backtrack,
                        color_,
                        e.hitchance
                    ))
                end
                if lua.uis.misc.notification_options2:get("Chat Log") then
                    if lua.uis.misc.notification_options3:get() == 'CN' then
                        print_chat((" \x02❌ 空了 \x08 %s \x01的 \x02%s \x01由于 \x02%s \x01( 命中率: \x02%s \x01回溯: \x02%s \x01)"):format(
                            user:name(), 
                            hitgroup_cn,
                            aimbot_log.miss_cn[e.state], 
                            e.backtrack,
                            e.hitchance
                        ))
                    else
                        print_chat((" \x02❌ Miss \x08 %s \x01's \x02%s \x01due to \x02%s \x01( hitchance: \x02%s \x01backtrack: \x02%s \x01)"):format(
                            user:name(), 
                            hitgroup,
                            e.state, 
                            e.backtrack,
                            e.hitchance
                        ))
                    end
                end
            end

        end
    end
}



antiaim = {

    value = {
        c = 1,
        yaw_toadd = 0,
        yaw_value = 0,
        randomseed = 0,
        mv_deysnc = 0,
        step_v = 0 ,
        step_t = 0,
        step_m = 0,
        step_x = 0,
        return_value = 0,
    },

    ref_antiaim = {
        pitch = 'Down',
        yaw = 'Backward',
        yawbase = 'At Target',
        yawadd = 0,
        yawjitter = "Disabled",
        yawjitter_value = 0 ,
        fakeangle = true,
        inverter = false,
        left_limit = 0,
        right_limit = 0,
        roll_enable = false,
        roll_pitch = 0,
        roll_roll = 0,
        fakeoption = {
            avoidoverlap = false,
            jitter = false,
            randomjitter = false,
            antibrute = false
        },
        fsbodyyaw = "Off",
    },

    by = (function()
        local j = {}
        local bodyyaw_jitter = function(c, d, e)
            local f = {}
            if e == -180 then
                f[1] = 0.0
            else
                if e ~= 0 then
                    if e == 180 then
                        f[0] = 0.0
                        f[1] = d
                    else
                        math.randomseed(e)
                        f[0] = math.random(-d, d)
                        f[1] = math.random(-d, d)
                    end
                    return f[c % 2]
                end
                f[1] = d
            end
            f[0] = -d
            return f[c % 2]
        end

        j.override_limit = function(g, h, i, x, f )
            local b = 60
            local k = f
            local l = bodyyaw_jitter(antiaim.value.randomseed, 60, k)
            antiaim.ref_antiaim.inverter = l < 0 and true
            b = math.abs(l)
            antiaim.ref_antiaim.left_limit = (math.min(b, x))
            antiaim.ref_antiaim.right_limit =  (math.min(b, x))
        end

        j.jitter = function(f,d)
            local m = globals.choked_commands
            local g = entity.get_local_player()
            local h = g:get_player_weapon()
            if g == nil or h == nil then
                return
            end
            if m == 1 then
               antiaim.value.randomseed = antiaim.value.randomseed + 1
            end
            j.override_limit(g, h, m, d, f)
        end
    
        j.static = function(a, b)
            if a > b and a > 0 then
                antiaim.ref_antiaim.left_limit = math.min(b, 60)
                antiaim.ref_antiaim.right_limit = math.min(b, 60)
                antiaim.ref_antiaim.inverter = false
            elseif a < b and a > 0 then
                antiaim.ref_antiaim.left_limit = math.min(a, 60)
                antiaim.ref_antiaim.right_limit = math.min(a, 60)
                antiaim.ref_antiaim.inverter = true
            elseif math.abs(a) > b and a < 0 then
                antiaim.ref_antiaim.left_limit = math.min(b, 60)
                antiaim.ref_antiaim.right_limit = math.min(b, 60)
                antiaim.ref_antiaim.inverter = true
            elseif math.abs(a) < b and a < 0 then
                antiaim.ref_antiaim.left_limit = math.min(math.abs(a), 60)
                antiaim.ref_antiaim.right_limit = math.min(math.abs(a), 60)
                antiaim.ref_antiaim.inverter = true
            end
        end
        
        return j
    end)(),


    condition = function ()
        local me = entity.get_local_player()
        
        if entitys.in_air(me) and entitys.is_crouching(me) and not entitys.on_ground(me,8) and lua.uis.custom[6].override:get() then
            antiaim.value.c = 6
        elseif entitys.in_air(me) and not entitys.on_ground(me,8) and lua.uis.custom[5].override:get() then
            antiaim.value.c = 5
        elseif ref.slowwalk:get() and lua.uis.custom[4].override:get() then
            antiaim.value.c = 4
        elseif entitys.on_ground(me,8) and entitys.is_crouching(me) and lua.uis.custom[3].override:get() then
            antiaim.value.c = 3
        elseif entitys.on_ground(me,8) and entitys.velocity(me) > 3 and lua.uis.custom[2].override:get() and not ref.slowwalk:get() then
            antiaim.value.c = 2
        elseif entitys.on_ground(me,8) and entitys.velocity(me) < 3 and lua.uis.custom[2].override:get() and not ref.slowwalk:get() then
            antiaim.value.c = 1
        end
        return antiaim.value.c
    end,

    direction = function()
        local direct = lua.uis.sets.manual_yaw:get()

        if direct == 'At Target' then
            antiaim.ref_antiaim.yaw = 'Backward'
            antiaim.ref_antiaim.yawbase = 'At Target'
            antiaim.value.yaw_toadd = 0
        elseif direct == 'Forward' then
            antiaim.ref_antiaim.yaw = 'Backward'
            antiaim.ref_antiaim.yawbase = 'Local View'
            antiaim.value.yaw_toadd = 1
            antiaim.value.yaw_value = 180
        elseif direct == 'Backward' then
            antiaim.ref_antiaim.yaw = 'Backward'
            antiaim.ref_antiaim.yawbase = 'Local View'
            antiaim.value.yaw_toadd = 0
        elseif direct == 'Right' then
            antiaim.ref_antiaim.yaw = 'Backward'
            antiaim.ref_antiaim.yawbase = 'Local View'
            antiaim.value.yaw_toadd = 1
            antiaim.value.yaw_value = 110

        elseif direct == 'Left' then
            antiaim.ref_antiaim.yaw = 'Backward'
            antiaim.ref_antiaim.yawbase = 'Local View'
            antiaim.value.yaw_toadd = -1
            antiaim.value.yaw_value = -70
        end

        ref.freestanding:set(direct == 'Freestanding' and true or false)
    end,

    st_condition = function()

   

        local cod = antiaim.condition()

        antiaim.ref_antiaim.pitch = lua.uis.custom[cod].pitch:get() ~= "Defensive" and lua.uis.custom[cod].pitch:get() or (globals.tickcount % 7 == 0 and "Fake Up" or "Down")
        if lua.uis.custom[cod].override:get() then
            antiaim.ref_antiaim.yawadd = nicetry and lua.uis.custom[cod].yaw_add_left:get() or lua.uis.custom[cod].yaw_add_right:get()
            antiaim.ref_antiaim.yawjitter = lua.uis.custom[cod].yaw_jitter:get()
            local yaw_jref = {"Default",'Jitter',"Reverse"}

            local sync =  (yaw_jref[lua.uis.custom[cod].yaw_jitter_mode:get()] == 'Jitter' and (nicetry and lua.uis.custom[cod].yaw_jitter_value_left:get() or lua.uis.custom[cod].yaw_jitter_value_right:get()))
            local async = (yaw_jref[lua.uis.custom[cod].yaw_jitter_mode:get()] == 'Reverse' and (nicetry and lua.uis.custom[cod].yaw_jitter_value_right:get() or lua.uis.custom[cod].yaw_jitter_value_left:get()))
            local x_way = (antiaim.ref_antiaim.yawjitter == '3 Way' and (entitys:x_way(3,lua.uis.custom[cod].yaw_jitter_value:get(),"3_way")) or (entitys:x_way(5,lua.uis.custom[cod].yaw_jitter_value:get(),"5_way")))
            antiaim.ref_antiaim.yawjitter_value = 
            (antiaim.ref_antiaim.yawjitter ~= '3 Way' and antiaim.ref_antiaim.yawjitter ~= '5 Way') and ((yaw_jref[lua.uis.custom[cod].yaw_jitter_mode:get()] == 'Default' and -lua.uis.custom[cod].yaw_jitter_value:get()) or sync or async ) or x_way 
    

            -- print(math_helpers.clamp(antiaim.value.return_value,antiaim.value.step_m,antiaim.value.step_x) )
            local fake_ref = {'Default','Jitter'}

            antiaim.value.mv_deysnc = 
            (fake_ref[lua.uis.custom[cod].fake_yaw_mode:get()] == 'Default' and lua.uis.custom[cod].fake_yaw_value:get()) or 
            (fake_ref[lua.uis.custom[cod].fake_yaw_mode:get()] == 'Jitter' and (nicetry and lua.uis.custom[cod].fake_yaw_value_left:get() or lua.uis.custom[cod].fake_yaw_value_right:get())) or 
            (entitys:value_update(lua.uis.custom[cod].fake_yaw_value_left:get(),lua.uis.custom[cod].fake_yaw_value_right:get(),3,"update"))
            local fake = antiaim.value.mv_deysnc

            local by_ref = {'Default','Jitter',"Reverse"}

            local by_degree = 
            (by_ref[lua.uis.custom[cod].bodyyaw_mode:get()] == 'Default' and lua.uis.custom[cod].bodyyaw_value:get()) or
            (by_ref[lua.uis.custom[cod].bodyyaw_mode:get()] == 'Jitter' and (nicetry and lua.uis.custom[cod].bodyyaw_value_left:get() or lua.uis.custom[cod].bodyyaw_value_right:get())) or
            (by_ref[lua.uis.custom[cod].bodyyaw_mode:get()] == 'Reverse' and (nicetry and lua.uis.custom[cod].bodyyaw_value_right:get() or lua.uis.custom[cod].bodyyaw_value_left:get())) 

            if lua.uis.custom[cod].bodyyaw:get() == "Disabled" then
                antiaim.by.jitter(0,0)
                antiaim.by.static(0,0)
            elseif lua.uis.custom[cod].bodyyaw:get() == "Static" then
                antiaim.by.static(by_degree,fake)
            elseif lua.uis.custom[cod].bodyyaw:get() == "Jitter" then
                antiaim.by.jitter(by_degree,fake)
            end


            antiaim.ref_antiaim.fakeoption.avoidoverlap = false
            antiaim.ref_antiaim.fakeoption.jitter = lua.uis.custom[cod].jitter_options:get('Smart Jitter')
            antiaim.ref_antiaim.fakeoption.randomjitter = false
            antiaim.ref_antiaim.fakeoption.antibrute = false
            local s = {'Opposite','Sway'}
            local ss = {'Peek Fake','Peek Real'}
            local ssss = {'Default','Opposite','Freestanding','Switch'}
            antiaim.ref_antiaim.fsbodyyaw = lua.uis.custom[cod].jitter_options:get('Freestand Desync') and ss[lua.uis.custom[cod].fsbodyyaw_mode:get()] or 'Disabled'
            antiaim.ref_antiaim.roll_enable = lua.uis.custom[cod].roll_enable:get()
            antiaim.ref_antiaim.roll_pitch = lua.uis.custom[cod].roll_pitch:get()
            antiaim.ref_antiaim.roll_roll = lua.uis.custom[cod].roll_roll:get()
            if lua.uis.sets.a_mode:get() == 2 then 
                if lua.uis.custom[cod].bodyyaw:get() == "Disabled" then
                    antiaim.by.jitter(0,0)
                    antiaim.by.static(0,0)
                elseif lua.uis.custom[cod].bodyyaw:get() == "Static" then
                    antiaim.by.static(by_degree,fake)
                elseif lua.uis.custom[cod].bodyyaw:get() == "Jitter" then
                    antiaim.by.jitter(by_degree,fake)
                end
            elseif lua.uis.sets.a_mode:get() == 3 then
                if lua.uis.custom[cod].bodyyaw:get() == "Disabled" then
                    antiaim.by.jitter(0,0)
                    antiaim.by.static(0,0)
                elseif lua.uis.custom[cod].bodyyaw:get() == "Static" then
                    antiaim.by.static(180,fake)
                elseif lua.uis.custom[cod].bodyyaw:get() == "Jitter" then
                    antiaim.by.jitter(180,fake)
                end
            end
        end
    end,

    using = false,
    in_use = bit.lshift(1, 5),

    on_use = function(cmd)
        antiaim.using = false
        
        if lua.uis.sets.ex_options:get('Antiaim on use') then
            local is_holding_using = bit.band(cmd.buttons, antiaim.in_use) > 0
            local me = entity.get_local_player()
            local active_weapon = me:get_player_weapon() 
            

            if active_weapon == nil then
                return
            end

            local is_bomb_in_hand = false       
            if active_weapon then
                is_bomb_in_hand = active_weapon:get_classname() == "CC4"
            end 
            local is_in_bombzone = me.m_bInBombZone
            local is_planting = is_in_bombzone and is_bomb_in_hand       
            local planted_c4_table = entity.get_entities("CPlantedC4")
            local is_c4_planted = #planted_c4_table > 0
            local bomb_distance = 100        
            if is_c4_planted then
                local c4_entity = planted_c4_table[#planted_c4_table]       
                local c4_origin = c4_entity:get_origin()
                local my_origin = me:get_origin()      
                local get_distance = function(x1, y1, z1, x2, y2, z2)
                    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
                end
     

                bomb_distance = get_distance(c4_origin.x,c4_origin.y,c4_origin.z,my_origin.x,my_origin.y,my_origin.z)
            end       
            local is_defusing = bomb_distance < 62 and me.m_iTeamNum == 3      

            if is_defusing then
                return
            end

            local camera_angles = render.camera_angles()
            local eye_position = me:get_eye_position()
            local forward_vector = vector():angles(camera_angles)
            local trace_end = eye_position + forward_vector * 8192
            local trace = utils.trace_line(eye_position, trace_end, me, 0x4600400B)
            local is_using = is_holding_using
            if trace and trace.fraction < 1 and trace.entity then
                local class_name = trace.entity:get_classname()
                is_using = class_name ~= "CWorld" and class_name ~= "CFuncBrush" and class_name ~= "CCSPlayer"
            end

            if not is_using and not is_planting then

                cmd.buttons = bit.band(cmd.buttons, bit.bnot(antiaim.in_use))
                antiaim.using = true
            end
        end
    end,

    setup = function(cmd)
        
        if not lua.uis.sets.master_switch:get()  then
            return
        end
            
        antiaim.direction()
        antiaim.st_condition()
        antiaim.on_use(cmd)
        if lua.uis.sets.a_mode:get() == 2 then 


            if lua.uis.sets.ex_options:get('Antiaim on use') then
                if lua.uis.sets.use_key:get() == 'always on' or (lua.uis.sets.use_key:get() == 'onkey' and lua.uis.sets.use_key_on:get()) then
                    antiaim.ref_antiaim.pitch = 'Disabled'
                    antiaim.ref_antiaim.yawbase = 'Local View'
                    antiaim.ref_antiaim.yawadd = 180
                    antiaim.ref_antiaim.yawjitter = 'Disabled'
                    antiaim.ref_antiaim.fakeoption.jitter = false
                    if lua.uis.sets.use_desync_mode:get() == 'Manual' then
                        antiaim.ref_antiaim.fsbodyyaw = 'Off'

                        antiaim.by.static( 0,60)
                        antiaim.ref_antiaim.inverter = lua.uis.sets.use_manual_on:get()
                    elseif lua.uis.sets.use_desync_mode:get() == 'Auto' then
                        antiaim.ref_antiaim.fsbodyyaw = 'Peek Fake'
                        antiaim.ref_antiaim.inverter = false
                    end
                else
                
                    antiaim.ref_antiaim.fsbodyyaw = 'Off'
                end
                
            end

            if antiaim.value.yaw_toadd ~= 0 then
                antiaim.ref_antiaim.yawjitter = 'Disabled'
                antiaim.ref_antiaim.fakeoption.jitter = false
                antiaim.by.static( 0,60)
                antiaim.ref_antiaim.inverter = false
            end
            
        
            ref.pitch:override(antiaim.ref_antiaim.pitch)
            ref.yaw:override(antiaim.ref_antiaim.yaw)
            ref.yawbase:override(antiaim.ref_antiaim.yawbase)
            ref.yawadd:override(antiaim.value.yaw_toadd ~= 0 and antiaim.value.yaw_value or antiaim.ref_antiaim.yawadd)
            ref.yawjitter:override((antiaim.ref_antiaim.yawjitter == "3 Way" or antiaim.ref_antiaim.yawjitter == "5 Way") and "Center" or antiaim.ref_antiaim.yawjitter)
            ref.yawjitter_offset:override(antiaim.ref_antiaim.yawjitter_value)
            ref.fakeangle:override(antiaim.ref_antiaim.fakeangle)
            ref.inverter:override(antiaim.ref_antiaim.inverter)
            ref.left_limit:override(antiaim.ref_antiaim.left_limit)
            ref.right_limit:override(antiaim.ref_antiaim.right_limit)
            ref.fakeoption:override(
                antiaim.ref_antiaim.fakeoption.avoidoverlap and "Avoid Overlap" or " ",
                antiaim.ref_antiaim.fakeoption.jitter and "Jitter" or " ",
                antiaim.ref_antiaim.fakeoption.randomjitter and "Randomize Jitter" or " ",
                antiaim.ref_antiaim.fakeoption.antibrute and "Anti Bruteforce" or " "
            )
            ref.fsbodyyaw:override(antiaim.ref_antiaim.fsbodyyaw)
        end
        if lua.uis.sets.a_mode:get() == 3 then 
            ref.pitch:override("Disabled")
            ref.yaw:override(antiaim.ref_antiaim.yaw)
            ref.yawbase:override(antiaim.ref_antiaim.yawbase)
            ref.yawadd:override(antiaim.value.yaw_toadd ~= 0 and antiaim.value.yaw_value or antiaim.ref_antiaim.yawadd)
            ref.yawjitter_offset:override(antiaim.ref_antiaim.yawjitter_value)
            ref.fakeangle:override(antiaim.ref_antiaim.fakeangle)
            ref.inverter:override(antiaim.ref_antiaim.inverter)
            ref.left_limit:override(antiaim.ref_antiaim.left_limit)
            ref.right_limit:override(antiaim.ref_antiaim.right_limit)
            ref.fakeoption:override(
                antiaim.ref_antiaim.fakeoption.avoidoverlap and "Avoid Overlap" or " ",
                antiaim.ref_antiaim.fakeoption.jitter and "Jitter" or " ",
                antiaim.ref_antiaim.fakeoption.randomjitter and "Randomize Jitter" or " ",
                antiaim.ref_antiaim.fakeoption.antibrute and "Anti Bruteforce" or " "
            )
            ref.fsbodyyaw:override(antiaim.ref_antiaim.fsbodyyaw)
            ref.roll_enable:override(antiaim.ref_antiaim.roll_enable)
            ref.roll_pitch:override(antiaim.ref_antiaim.roll_pitch)
            ref.roll_roll:override(antiaim.ref_antiaim.roll_roll)
        end
        if lua.uis.sets.ex_options:get('Pitch Angle') then 
            cmd.view_angles.x = lua.uis.sets.pitch_angle:get() == nil and 0 or lua.uis.sets.pitch_angle:get()
        end
    end

}

vis = {

    main_menu = {

        svg = {
            icon = render.load_image(
                '<svg t="1672560184540" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2558" width="200" height="200"><path d="M512 982c-63.44 0-124.99-12.43-182.95-36.94-55.97-23.67-106.23-57.56-149.39-100.72s-77.04-93.42-100.72-149.39C54.43 636.99 42 575.44 42 512s12.43-125 36.94-182.95c23.67-55.97 57.56-106.23 100.72-149.39 43.16-43.16 93.42-77.04 149.39-100.72C387.01 54.43 448.56 42 512 42c63.44 0 124.99 12.43 182.95 36.94 55.97 23.67 106.23 57.56 149.39 100.72 43.16 43.16 77.04 93.42 100.72 149.39C969.57 387.01 982 448.56 982 512s-12.43 124.99-36.94 182.95c-23.67 55.97-57.56 106.23-100.72 149.39s-93.42 77.04-149.39 100.72C636.99 969.57 575.44 982 512 982z m0-900C274.9 82 82 274.9 82 512s192.9 430 430 430 430-192.9 430-430S749.1 82 512 82z" p-id="2559" fill="#ffffff"></path><path d="M512 642.87c-3.45 0-6.91-0.89-10-2.68l-96.02-55.44c-6.19-3.57-10-10.17-10-17.32V456.56c0-7.15 3.81-13.75 10-17.32L502 383.81a20.013 20.013 0 0 1 20 0l96.02 55.44c6.19 3.57 10 10.17 10 17.32v110.87c0 7.15-3.81 13.75-10 17.32L522 640.19a19.947 19.947 0 0 1-10 2.68z m-76.02-86.98L512 599.78l76.02-43.89v-87.78L512 424.22l-76.02 43.89v87.78z m172.04 11.55z" p-id="2560" fill="#ffffff"></path><path d="M512 779.16c-11.05 0-20-8.95-20-20V622.87c0-11.05 8.95-20 20-20s20 8.95 20 20v136.29c0 11.05-8.95 20-20 20z" p-id="2561" fill="#ffffff"></path><path d="M572.86 840.02c-5.12 0-10.24-1.95-14.14-5.86l-60.86-60.86c-7.81-7.81-7.81-20.47 0-28.29 7.81-7.81 20.47-7.81 28.28 0L587 805.88c7.81 7.81 7.81 20.47 0 28.29-3.91 3.9-9.02 5.85-14.14 5.85z" p-id="2562" fill="#ffffff"></path><path d="M448.18 842.99c-5.12 0-10.24-1.95-14.14-5.86-7.81-7.81-7.81-20.47 0-28.29l63.82-63.82c7.81-7.81 20.47-7.81 28.28 0 7.81 7.81 7.81 20.47 0 28.29l-63.82 63.82a19.98 19.98 0 0 1-14.14 5.86zM726.03 655.58c-3.39 0-6.83-0.86-9.98-2.68l-118.03-68.14c-9.57-5.52-12.84-17.75-7.32-27.32s17.75-12.84 27.32-7.32l118.03 68.14c9.57 5.52 12.84 17.75 7.32 27.32-3.7 6.42-10.43 10-17.34 10z" p-id="2563" fill="#ffffff"></path><path d="M726.04 655.59c-8.83 0-16.91-5.89-19.31-14.83-2.86-10.67 3.47-21.64 14.14-24.5L804 593.99c10.67-2.87 21.64 3.47 24.5 14.14 2.86 10.67-3.47 21.64-14.14 24.5l-83.13 22.28c-1.74 0.45-3.48 0.68-5.19 0.68z" p-id="2564" fill="#ffffff"></path><path d="M749.4 742.77c-8.83 0-16.91-5.89-19.31-14.83l-23.36-87.19c-2.86-10.67 3.47-21.64 14.14-24.5 10.67-2.86 21.64 3.47 24.5 14.14l23.36 87.19c2.86 10.67-3.47 21.64-14.14 24.5-1.74 0.47-3.48 0.69-5.19 0.69zM608.04 476.57c-6.91 0-13.63-3.59-17.34-10-5.52-9.57-2.25-21.8 7.32-27.32l118.03-68.14c9.56-5.52 21.8-2.25 27.32 7.32s2.25 21.8-7.32 27.32l-118.03 68.14a19.996 19.996 0 0 1-9.98 2.68z" p-id="2565" fill="#ffffff"></path><path d="M726.06 408.42c-1.71 0-3.46-0.22-5.19-0.69-10.67-2.86-17-13.83-14.14-24.49L729 300.11c2.86-10.67 13.83-17.01 24.49-14.14 10.67 2.86 17 13.83 14.14 24.49l-22.27 83.13c-2.39 8.94-10.47 14.83-19.3 14.83z" p-id="2566" fill="#ffffff"></path><path d="M813.25 431.79c-1.71 0-3.46-0.22-5.19-0.69l-87.19-23.36c-10.67-2.86-17-13.83-14.14-24.5 2.86-10.67 13.83-17 24.5-14.14l87.19 23.36c10.67 2.86 17 13.83 14.14 24.5-2.4 8.93-10.48 14.83-19.31 14.83zM512 421.13c-11.05 0-20-8.95-20-20V264.84c0-11.05 8.95-20 20-20s20 8.95 20 20v136.29c0 11.04-8.96 20-20 20z" p-id="2567" fill="#ffffff"></path><path d="M512 284.84c-5.12 0-10.24-1.95-14.14-5.86L437 218.12c-7.81-7.81-7.81-20.47 0-28.28 7.81-7.81 20.47-7.81 28.28 0l60.86 60.86c7.81 7.81 7.81 20.47 0 28.28-3.9 3.91-9.02 5.86-14.14 5.86z" p-id="2568" fill="#ffffff"></path><path d="M512 284.84c-5.12 0-10.24-1.95-14.14-5.86-7.81-7.81-7.81-20.47 0-28.29l63.82-63.82c7.81-7.81 20.47-7.81 28.29 0 7.81 7.81 7.81 20.47 0 28.29l-63.82 63.82a19.943 19.943 0 0 1-14.15 5.86zM415.96 476.57c-3.39 0-6.83-0.86-9.98-2.68l-118.03-68.14c-9.57-5.52-12.84-17.75-7.32-27.32s17.75-12.84 27.32-7.32l118.03 68.14c9.57 5.52 12.84 17.75 7.32 27.32-3.7 6.41-10.43 10-17.34 10z" p-id="2569" fill="#ffffff"></path><path d="M214.81 430.7c-8.83 0-16.91-5.89-19.31-14.83-2.86-10.67 3.47-21.64 14.14-24.5l83.13-22.28c10.67-2.86 21.64 3.47 24.49 14.14 2.86 10.67-3.47 21.64-14.14 24.5L220 430.01c-1.74 0.47-3.48 0.69-5.19 0.69z" p-id="2570" fill="#ffffff"></path><path d="M297.94 408.42c-8.83 0-16.91-5.89-19.31-14.83l-23.36-87.19c-2.86-10.67 3.47-21.64 14.14-24.5 10.67-2.86 21.64 3.47 24.49 14.14l23.36 87.19c2.86 10.67-3.47 21.64-14.14 24.5-1.72 0.47-3.47 0.69-5.18 0.69zM297.97 655.58c-6.91 0-13.63-3.59-17.34-10-5.52-9.57-2.25-21.8 7.32-27.32l118.03-68.14c9.56-5.52 21.8-2.25 27.32 7.32s2.25 21.8-7.32 27.32L307.95 652.9a19.893 19.893 0 0 1-9.98 2.68z" p-id="2571" fill="#ffffff"></path><path d="M275.69 738.72c-1.71 0-3.46-0.22-5.19-0.69-10.67-2.86-17-13.83-14.14-24.5l22.28-83.13c2.86-10.67 13.83-17.01 24.49-14.14 10.67 2.86 17 13.83 14.14 24.5L295 723.89c-2.4 8.93-10.48 14.83-19.31 14.83z" p-id="2572" fill="#ffffff"></path><path d="M297.96 655.58c-1.71 0-3.46-0.22-5.19-0.69l-87.19-23.36c-10.67-2.86-17-13.83-14.14-24.5 2.86-10.67 13.83-17 24.49-14.14l87.19 23.36c10.67 2.86 17 13.83 14.14 24.5-2.38 8.94-10.47 14.83-19.3 14.83z" p-id="2573" fill="#ffffff"></path></svg>',
                vector(200,200)),


            key = render.load_image(
                '<svg t="1672649673608" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2883" width="200" height="200"><path d="M896 256v512H128V256h768zM298.666667 469.333333H213.333333v85.333334h85.333334v-85.333334z m128 0H341.333333v85.333334h85.333334v-85.333334z m128 0h-85.333334v85.333334h85.333334v-85.333334z m128 0h-85.333334v85.333334h85.333334v-85.333334z m128 0h-85.333334v85.333334h85.333334v-85.333334zM341.333333 341.333333H213.333333v85.333334h128V341.333333z m128 0H384v85.333334h85.333333V341.333333z m128 0h-85.333333v85.333334h85.333333V341.333333z m213.333334 0h-170.666667v85.333334h170.666667V341.333333zM341.333333 597.333333H213.333333v85.333334h128v-85.333334z m298.666667 0H384v85.333334h256v-85.333334z m170.666667 0h-128v85.333334h128v-85.333334z" fill="#ffffff" p-id="2884"></path></svg>'
                ,vector(200,200)
            ),

            eyes = render.load_image(
                '<svg t="1672650286909" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6217" width="200" height="200"><path d="M511.948323 248.807692c-293.14141 0-448.565249 277.992385-448.565249 277.992385s167.818123 247.090585 448.565249 247.090585c280.767592 0 448.604134-247.090585 448.604134-247.090585S822.670134 248.807692 511.948323 248.807692zM512.223592 669.520593c-89.384773 0-161.849178-70.711482-161.849178-157.924799 0-87.212294 72.464405-157.924799 161.849178-157.924799 89.384773 0 161.849178 70.712505 161.849178 157.924799C674.072771 598.809111 601.607342 669.520593 512.223592 669.520593zM511.967766 447.199135c-39.134299 0-70.857814 31.467689-70.857814 70.273507 0 38.805818 31.723515 70.273507 70.857814 70.273507s70.857814-31.467689 70.857814-70.273507C582.82558 478.666824 551.102065 447.199135 511.967766 447.199135z" fill="#ffffff" p-id="6218"></path></svg>',
                vector(200,200)
            ),

            slow =  render.load_image(
                '<svg t="1672674000064" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="51290" width="200" height="200"><path d="M97.1 959.1c-17.7 0-32-14.3-32-32 0-60.3 11.8-118.8 35.1-173.9 22.5-53.2 54.7-101 95.7-142s88.8-73.2 142-95.7c55.1-23.3 113.6-35.1 173.9-35.1 46.6 0 92.5 7.1 136.5 21.2 16.8 5.4 26.1 23.4 20.7 40.2-5.4 16.8-23.4 26.1-40.2 20.7-37.6-12.1-77-18.2-116.9-18.2-211 0-382.7 171.7-382.7 382.7-0.1 17.7-14.4 32.1-32.1 32.1zM511.7 473.6c-107.4 0-197.7-84.1-204-192.6-3.2-54.5 15.1-107 51.4-147.8 36.3-40.8 86.3-65 140.9-68.2 112.6-6.6 209.5 79.7 216 192.3 6.6 112.6-79.7 209.5-192.3 216-4 0.2-8 0.3-12 0.3z m-8-344.8c-37.5 2.2-71.8 18.8-96.8 46.9s-37.5 64.1-35.3 101.6c4.5 77.3 71.1 136.6 148.4 132.1 77.3-4.5 136.6-71.1 132.1-148.4-4.5-77.4-71.1-136.7-148.4-132.2z" fill="" p-id="51291"></path><path d="M890.3 960.3H486.4c-17.7 0-32-14.3-32-32s14.3-32 32-32h403.9c3.3 0 6-2.7 6-6V733.6c0-3.3-2.7-6-6-6H486.4c-17.7 0-32-14.3-32-32s14.3-32 32-32h403.9c38.6 0 70 31.4 70 70v156.7c0 38.6-31.4 70-70 70z" fill="" p-id="51292"></path><path d="M479.8 724.5c-7.5 0-15.1-2.6-21.2-8-13.2-11.7-14.5-31.9-2.8-45.2l68.4-77.3c11.7-13.2 31.9-14.5 45.2-2.8 13.2 11.7 14.5 31.9 2.8 45.2l-68.4 77.3c-6.3 7.1-15.1 10.8-24 10.8z" fill="" p-id="51293"></path><path d="M548.4 802.7c-8.9 0-17.7-3.7-24-10.8L456 714.6c-11.7-13.2-10.5-33.5 2.8-45.2 13.2-11.7 33.5-10.5 45.2 2.8l68.3 77.3c11.7 13.2 10.5 33.5-2.8 45.2-6 5.4-13.6 8-21.1 8z" fill="" p-id="51294"></path></svg>',
                vector(200,200)
            ),

            right_arrow = render.load_image(
                '<svg t="1673423365615" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="21294" width="200" height="200"><path d="M558.933333 490.666667L384 665.6l59.733333 59.733333 234.666667-234.666666L443.733333 256 384 315.733333l174.933333 174.933334z" fill="#ffffff" p-id="21295"></path></svg>'
                ,vector(200,200)
            ),
            left_arrow = render.load_image(
                '<svg t="1673423921427" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="21477" width="200" height="200"><path d="M503.466667 490.666667l174.933333 174.933333-59.733333 59.733333L384 490.666667 618.666667 256l59.733333 59.733333-174.933333 174.933334z" fill="#ffffff" p-id="21478"></path></svg>'
                ,vector(200,200)
            ),
            pit = render.load_image_from_file("FRIGUA\\snow.svg", vector(600,600)),
            solus_pit = render.load_image_from_file("FRIGUA\\snow.svg", vector(16,16))

        },

        top_bar = {
            tx = 0,
            ty = 0,
            al = 0,
            r_render = function ()
                
                local menu_pos = ui.get_position()
                local menu_size = ui.get_size()
                local function corner(x, y, w, h, header, r,g,b,a,theme)

                    if theme == 2 then 
                        r1,g1,b1 = r, g , b
                        r2,g2,b2 = r, g , b
                        r3,g3,b3 = r, g , b
                        if lua.uis.misc.solus_glow:get() then 
                            render.shadow(vector(x,y), vector(x+w,y+h), color(r,g,b,a),30, 0, 4)
                        end
                        local n = a / 255 * 35;
                        local s = 16/24
                        render.texture(vis.main_menu.svg.solus_pit, vector(x + 4 + w/2 - 4 * 2 - 16/2 + 4,y -8), vector(16,16), color(r,g,b,a), "", 0)
                        render.gradient(vector(x + 4 - s, y), vector(x + 4 + w/2 - 4 * 2 - 16/2, y + 1), color(r1, g1, b1, a), color(r2, g2, b2, a), color(r1, g1, b1, a), color(r2, g2, b2, a))
                        render.gradient(vector(x + 4 + w/2 - 4 * 2 + 16/2 + 8, y), vector(x + 4 + w - 4 * 2 + s, y + 1), color(r2, g2, b2, a), color(r3, g3, b3, a), color(r2, g2, b2, a), color(r3, g3, b3, a))
                        
                        render.circle_outline(vector(x + 4 - s, y + 4), color(r1, g1, b1, a), 4, 180, 0.25, 1)
                        render.circle_outline(vector(x + w - 4 + s, y + 4), color(r3, g3, b3, a), 4, 270, 0.25, 1)
    
                        render.gradient(vector(x - s, y + 4), vector(x + 1 - s, y + 4 + h - 4 * 2), color(r1, g1, b1, a), color(r1, g1, b1, a), color(r2, g2, b2, n), color(r2, g2, b2, n))
                        render.gradient(vector(x + w - 1 + s, y + 4), vector(x + w + s, y + 4 + h - 4 * 2), color(r3, g3, b3, a), color(r3, g3, b3, a), color(r2, g2, b2, n), color(r2, g2, b2, n))
    
                        render.circle_outline(vector(x + 4 - s, y + h - 4), color(r2, g2, b2, n), 4, 90, 0.25, 1)
                        render.circle_outline(vector(x + w - 4 + s, y + h - 4), color(r2, g2, b2, n), 4, 0, 0.25, 1)
    
                        render.gradient(vector(x + 4 - s, y + h - 1), vector(x + 4 + w/2 - 4 * 2, y + h), color(r2, g2, b2, n), color(r1, g1, b1, n), color(r2, g2, b2, n), color(r1, g1, b1, n))
                        render.gradient(vector(x + 4 + w/2 - 4 * 2, y + h - 1), vector(x + 4 + w - 4 * 2 + s, y + h), color(r1, g1, b1, n), color(r2, g2, b2, n), color(r1, g1, b1, n), color(r2, g2, b2, n))
    
                    else
                        local c = {10, 60, 40, 40, 40, 60, 20}
                        for i = 0,6,1 do
                            renderer.rectangle(x+i, y+i, w-(i*2), h-(i*2), c[i+1], c[i+1], c[i+1], a)
                        end
                        if header then
                            local x_inner, y_inner = x+7, y+7
                            local w_inner = w-14
                    
                            local a_lower = a/2
    
                            local r,g,b = helper.get_bar_color()
                            if lua.uis.misc.solus_rgb:get() == 'Dynamic' then
                                --renderer.gradient(x_inner, y_inner+1, w_inner, 1, r,g,b, a_lower, b,g,r, a_lower, false)
                                renderer.gradient(x_inner, y_inner+1, math.floor(w_inner/2), 1, r,g,b, a_lower, b,g,r, a_lower, true)
                                renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, b,g,r, a_lower, g,b,r, a_lower, true)
                            elseif lua.uis.misc.solus_rgb:get() == 'Static' then
                                
                                renderer.gradient(x_inner, y_inner+1, math.floor(w_inner/2), 1, 59, 175, 222, a_lower, 202, 70, 205, a_lower, true)
                                renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, 202, 70, 205, a_lower, 201, 227, 58, a_lower, true)
                            else
    
                                renderer.gradient(x_inner, y_inner+1, w_inner, 20, 126,159,203, a_lower, 0,0,0, 0, false)
                            end
    
                            -- renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, 202, 70, 205, a_lower, 201, 227, 58, a_lower, true)
                        end
                    end
                end

                vis.main_menu.top_bar.al = animate.new(vis.main_menu.top_bar.al,1,0,lua.uis.misc.solus_list:get('Top Bar') and lua.uis.misc.solus_switch:get())
                vis.main_menu.top_bar.tx = animate.new(vis.main_menu.top_bar.tx,menu_pos.x)
                vis.main_menu.top_bar.ty = animate.new(vis.main_menu.top_bar.ty,menu_pos.y)
                local tt = lua.uis.misc.solus_theme:get()
                local cc = lua.uis.misc.solus_color:get()

                corner(vis.main_menu.top_bar.tx,vis.main_menu.top_bar.ty  - 65,menu_size.x,60 ,true,cc.r,cc.g,cc.b,255 * ui.get_alpha() * vis.main_menu.top_bar.al,tt)

                renderer.texture(vis.main_menu.svg.icon,vis.main_menu.top_bar.tx + menu_size.x/2-20,vis.main_menu.top_bar.ty  - 53,40,40,126,159,203,255 * ui.get_alpha() * vis.main_menu.top_bar.al,'f',0)
                -- renderer.rectangle(menu_pos.x,menu_pos.y - 65,menu_size.x,60 ,0,0,0,255 * ui.get_alpha(),5)
                -- renderer.rectangle(menu_pos.x + 2,menu_pos.y - 63,menu_size.x - 4,60 - 4 ,30,30,30,255 * ui.get_alpha(),5)


            end
        },


        init = function ()
            vis.main_menu.top_bar.r_render()
        end
    },

    misc_ = {
        aspect_ratio_value = 0,
        view = {
            x = 0,y = 0 ,z = 0, f = 0
        },
        aspect_ratio = function()

            if lua.uis.misc.aspect_ratio_switch:get() then
                vis.misc_.aspect_ratio_value = animate.new(vis.misc_.aspect_ratio_value,lua.uis.misc.aspect_ratio:get()/10)
                cvar.r_aspectratio:float(vis.misc_.aspect_ratio_value,true)
            end
    
        end,

        viewmodel_changer = function()
            if not lua.uis.misc.view_switch:get() then
                return
            end
            local md = lua.uis.misc.v_f:get()
            local x,y,z = lua.uis.misc.v_x:get(),lua.uis.misc.v_y:get(),lua.uis.misc.v_z:get()
            vis.misc_.view.x = animate.new(vis.misc_.view.x ,x)
            vis.misc_.view.y = animate.new(vis.misc_.view.y,y)
            vis.misc_.view.z = animate.new(vis.misc_.view.z,z)
            vis.misc_.view.f = animate.new(vis.misc_.view.f,md)
 
            cvar.viewmodel_offset_x:float(vis.misc_.view.x ,true)
            cvar.viewmodel_offset_y:float(vis.misc_.view.y ,true)
            cvar.viewmodel_offset_z:float(vis.misc_.view.z ,true)
            cvar.viewmodel_fov:float(vis.misc_.view.f,true)
    
        end,

        bloom = {

         
            
            Bloom = function()
                
                if not lua.uis.misc.bloom_switch:get() then
                    local tone_map_controllers = entity.get_entities("CEnvTonemapController")
                    if tone_map_controllers then
                        for i, tone_map_controller in pairs(tone_map_controllers) do
                            if not tone_map_controller then
                                goto skip
                            end
                            tone_map_controller["m_bUseCustomAutoExposureMin"] = false
                            tone_map_controller["m_bUseCustomAutoExposureMax"] = false
                            tone_map_controller["m_flCustomAutoExposureMin"] = 0
                            tone_map_controller["m_flCustomAutoExposureMax"] = 0
                            tone_map_controller["m_flCustomBloomScale"] = 0
                            ::skip::
                        end
                    end
                    cvar.mat_bloom_scalefactor_scalar:float(0,true)
                else

                    local bloom_scale = lua.uis.misc.bloom_scale:get()
                    local exposure = lua.uis.misc.exposure:get()
                    local model_brightness = lua.uis.misc.model_ambient:get()
                    local tone_map_controllers = entity.get_entities("CEnvTonemapController")
                    if tone_map_controllers then
                            for i, tone_map_controller in pairs(tone_map_controllers) do
                                if not tone_map_controller then
                                    goto skip
                                end
                                tone_map_controller["m_bUseCustomAutoExposureMin"] = true
                                tone_map_controller["m_bUseCustomAutoExposureMax"] = true
                                tone_map_controller["m_flCustomAutoExposureMin"] = math.max(0.0000, exposure)
                                tone_map_controller["m_flCustomAutoExposureMax"] = math.max(0.0000, exposure)
                                tone_map_controller["m_flCustomBloomScale"] = bloom_scale/100
                                ::skip::
                            end
                    
                        cvar.mat_bloom_scalefactor_scalar:float(model_brightness,true)
                    end
                end
                
            
            end

        },

        scope_overlay = {

            v = {
                toleng = 0,
                length_scope = 0,
                offset_scope = 0
            },


            line = function()
                local me = entity.get_local_player()
                if me == nil or not me:is_alive() then
                    return
                end
             
                local v = vis.misc_.scope_overlay.v
                if lua.uis.misc.scope_switch:get()  then
                    ref.scope_overlay:set('Remove All')
                    local lp = entity.get_local_player()
                    local color_1 = lua.uis.misc.scopeline_color_1 :get()
                    local color_2 = lua.uis.misc.scopeline_color_2 :get()
                    if lp and lp:is_alive() then
                            local isscope = lp["m_bIsScoped"]
                            local screen_size = render.screen_size()

                            v.length_scope = animate.new(v.length_scope,lua.uis.misc.scopeline_width:get(),0,isscope)
                            v.offset_scope = animate.new(v.offset_scope,lua.uis.misc.scopeline_origin:get(),0,isscope)

                            render.gradient(vector(screen_size.x/2-v.length_scope, screen_size.y/2-0.5), vector(screen_size.x/2-v.offset_scope,screen_size.y/2+0.5), color_2, color_1, color_2, color_1)--left
                            render.gradient(vector(screen_size.x/2+v.offset_scope, screen_size.y/2-0.5), vector(screen_size.x/2+v.length_scope,screen_size.y/2+0.5), color_1, color_2, color_1, color_2)--right
                            render.gradient(vector(screen_size.x/2-0.5, screen_size.y/2-v.offset_scope), vector(screen_size.x/2+0.5,screen_size.y/2-v.length_scope), color_1, color_1, color_2, color_2)--up
                            render.gradient(vector(screen_size.x/2-0.5, screen_size.y/2+v.offset_scope), vector(screen_size.x/2+0.5,screen_size.y/2+v.length_scope), color_1, color_1, color_2, color_2)--down
                        
                    end
        
                else
                    ref.scope_overlay:set()
                end
            end

        },

        clantag = {

           animation = {
              "F",
              "FR",
              "FRI",
              "FR",
              "FRI",
              "FRIG",
              "FRIGU",
              "FRIG",
              "FRIGU",
              "FRIGUS",
              "FRIGUS.",
              "FRIGUS.L",
              "FRIGUS.",
              "FRIGUS.L",
              "FRIGUS.LU",
              "FRIGUS.LUA",
              "FRIGUS.LU",
              "FRIGUS.LUA",
              "FRIGUS.LUA[",
              "FRIGUS.LUA",
              "FRIGUS.LUA[",
              "FRIGUS.LUA[!",
              "FRIGUS.LUA[",
              "FRIGUS.LUA[!",
              "FRIGUS.LUA[!]",
              "FRIGUS.LUA[!]",
              "FRIGUS.LUA[!]",
              "FRIGUS.LUA[!",
              "FRIGUS.LUA[",
              "FRIGUS.LUA",
              "FRIGUS.LUA»",
              "FRIGUS.LUA»G",
              "FRIGUS.LUA»",
              "FRIGUS.LUA»G",
              "FRIGUS.LUA»GO",
              "FRIGUS.LUA»G",
              "FRIGUS.LUA»GO",
              "FRIGUS.LUA»GOD",
              "FRIGUS.LUA»GO",
              "FRIGUS.LUA»GOD",
              "FRIGUS.LUA»GO",
              "FRIGUS.LUA»GOD",
              "FRIGUS.LUA»GOD",
              "FRIGUS.LUA»GOD",
              "FRIGUS.LUA»GO",
              "FRIGUS.LUA»G",
              "FRIGUS.LUA»",
              "FRIGUS.LUA",
              "FRIGUS.LU",
              "FRIGUS.L",
              "FRIGUS.",
              "FRIGUS",
              "FRIGU",
              "FRIG",
              "FRI",
              "FR",
             "F",
              "",
              "",
             },
            
            vars = {
                remove = false,
                timer = 0
            },
            
            run = function()
                local curtime = math.floor(globals.curtime * 2)
            
                if vis.misc_.clantag.vars.timer ~= curtime then
                    common.set_clan_tag(vis.misc_.clantag.animation[curtime % #vis.misc_.clantag.animation + 1])
                    vis.misc_.clantag.vars.timer = curtime
                end
            
                vis.misc_.clantag.vars.remove = true
            end,
            
           remove = function()
                if vis.misc_.clantag.vars.remove then
                    common.set_clan_tag("")
                    vis.misc_.clantag.vars.remove = false
                end
            end
        },
        


        init = function()
            vis.misc_.aspect_ratio()
            vis.misc_.viewmodel_changer()
            vis.misc_.scope_overlay.line()
            vis.misc_.bloom.Bloom()
        end


    },

    s = {
        g_a = 0,

        w_a = 0,
        w_w = 0,

        k_a = 0,

        ka_a = {},
        ka_y = {},
        ka_w = 0,
        c_a = 0 ,
        c_w = 0,
        c_x = 0,

        s_a = 0,

    
        
        sa_a = {},
        sa_y = {},
        sa_w = 0,
        sc_a = 0 ,
        sc_w = 0,
        sc_x = 0,

        drag = false,
        drags = false,
        cursor_last_poss = vector(0,0),

        cursor_last_pos = vector(0,0)
    },

    solus_ui = {

        is_breaking_lc = false,
        get_cmd_width = 0,


        solus_render = function ()

            local function corner(x, y, w, h, header, r,g,b,a,theme)

                if theme == 2 then 
                    r1,g1,b1 = r, g , b
                    r2,g2,b2 = r, g , b
                    r3,g3,b3 = r, g , b
                    if lua.uis.misc.solus_glow:get() then 
                        render.shadow(vector(x,y), vector(x+w,y+h), color(r,g,b,a),30, 0, 4)
                    end
                    local n = a / 255 * 35;
                    local s = 16/24
                    render.texture(vis.main_menu.svg.solus_pit, vector(x + 4 + w/2 - 4 * 2 - 16/2 + 4,y -8), vector(16,16), color(r,g,b,a), "", 0)
                    render.gradient(vector(x + 4 - s, y), vector(x + 4 + w/2 - 4 * 2 - 16/2, y + 1), color(r1, g1, b1, a), color(r2, g2, b2, a), color(r1, g1, b1, a), color(r2, g2, b2, a))
                    render.gradient(vector(x + 4 + w/2 - 4 * 2 + 16/2 + 8, y), vector(x + 4 + w - 4 * 2 + s, y + 1), color(r2, g2, b2, a), color(r3, g3, b3, a), color(r2, g2, b2, a), color(r3, g3, b3, a))
                    
                    render.circle_outline(vector(x + 4 - s, y + 4), color(r1, g1, b1, a), 4, 180, 0.25, 1)
                    render.circle_outline(vector(x + w - 4 + s, y + 4), color(r3, g3, b3, a), 4, 270, 0.25, 1)

                    render.gradient(vector(x - s, y + 4), vector(x + 1 - s, y + 4 + h - 4 * 2), color(r1, g1, b1, a), color(r1, g1, b1, a), color(r2, g2, b2, n), color(r2, g2, b2, n))
                    render.gradient(vector(x + w - 1 + s, y + 4), vector(x + w + s, y + 4 + h - 4 * 2), color(r3, g3, b3, a), color(r3, g3, b3, a), color(r2, g2, b2, n), color(r2, g2, b2, n))

                    render.circle_outline(vector(x + 4 - s, y + h - 4), color(r2, g2, b2, n), 4, 90, 0.25, 1)
                    render.circle_outline(vector(x + w - 4 + s, y + h - 4), color(r2, g2, b2, n), 4, 0, 0.25, 1)

                    render.gradient(vector(x + 4 - s, y + h - 1), vector(x + 4 + w/2 - 4 * 2, y + h), color(r2, g2, b2, n), color(r1, g1, b1, n), color(r2, g2, b2, n), color(r1, g1, b1, n))
                    render.gradient(vector(x + 4 + w/2 - 4 * 2, y + h - 1), vector(x + 4 + w - 4 * 2 + s, y + h), color(r1, g1, b1, n), color(r2, g2, b2, n), color(r1, g1, b1, n), color(r2, g2, b2, n))

                else
                    local c = {10, 60, 40, 40, 40, 60, 20}
                    for i = 0,6,1 do
                        renderer.rectangle(x+i, y+i, w-(i*2), h-(i*2), c[i+1], c[i+1], c[i+1], a)
                    end
                    if header then
                        local x_inner, y_inner = x+7, y+7
                        local w_inner = w-14
                
                        local a_lower = a/2

                        local r,g,b = helper.get_bar_color()
                        if lua.uis.misc.solus_rgb:get() == 'Dynamic' then
                            --renderer.gradient(x_inner, y_inner+1, w_inner, 1, r,g,b, a_lower, b,g,r, a_lower, false)
                            renderer.gradient(x_inner, y_inner+1, math.floor(w_inner/2), 1, r,g,b, a_lower, b,g,r, a_lower, true)
                            renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, b,g,r, a_lower, g,b,r, a_lower, true)
                        elseif lua.uis.misc.solus_rgb:get() == 'Static' then
                            
                            renderer.gradient(x_inner, y_inner+1, math.floor(w_inner/2), 1, 59, 175, 222, a_lower, 202, 70, 205, a_lower, true)
                            renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, 202, 70, 205, a_lower, 201, 227, 58, a_lower, true)
                        else

                            renderer.gradient(x_inner, y_inner+1, w_inner, 20, 126,159,203, a_lower, 0,0,0, 0, false)
                        end

                        -- renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, 202, 70, 205, a_lower, 201, 227, 58, a_lower, true)
                    end
                end
            end


            vis.color_all_ = lua.uis.misc.solus_color:get()
            
            vis.theme_s = lua.uis.misc.solus_theme:get()
            vis.s.g_a = animate.new(vis.s.g_a , 1,0,lua.uis.misc.solus_switch:get())
            
            if vis.s.g_a <= 0.01 then
                return
            end
    
            -- local r,g,b,a = lua.uis.misc.solus_color:get().r,lua.uis.misc.solus_color:get().g,lua.uis.misc.solus_color:get().b,lua.uis.misc.solus_color:get().a
            local a = 255
            local screen = render.screen_size()
            local sx,sy = screen.x,screen.y
            local cx,cy = screen.x/2,screen.y/2

        
            local normalize_yaw = function(self,ang)
                while (ang > 180.0) do
                    ang = ang - 360.0
                end
                while (ang < -180.0) do
                    ang = ang + 360.0
                end
                return ang
            end
    
 
            local watermark = function ()
                vis.s.w_a = animate.new( vis.s.w_a ,1,0,lua.uis.misc.solus_list:get('Watermark'))
    
                if vis.s.w_a <= 0.01 then
                    return
                end
                local get_ping = function ()
                   local ntinfo =  utils.net_channel()
                   if not ntinfo then return "0" end
                   local p = ntinfo.avg_latency[0]
                   return math.floor(p * 1000.0 + 0.5).."ms"
                end
                local alpha = math.sin(math.abs(-math.pi + (globals.curtime * (1 / 0.7)) % (math.pi * 2))) * 255
                local gradi_main = gradient.text_animate([[FRIGUS.lua]],-1,{
                    color(126,159,203,255 * vis.s.w_a * vis.s.g_a), 
                    color(255,255,255,255 * vis.s.w_a * vis.s.g_a)
                    }
                )
                gradi_main:animate()
                --local gr_ti = helper.gradient(126,159,203,255 * vis.s.w_a * vis.s.g_a,255,255,255,255 * vis.s.w_a * vis.s.g_a,'FRIGUS')
                local text_size = render.measure_text(FONT.verdana11,nil,gradi_main:get_animated_text()..' \aFFFFFFE8@'..lua.info.username.." delay: "..get_ping().." "..math.floor(1.0 / globals.tickinterval)..'ticks')

      
                --corner(x, y, w, h, header, r,g,b,a,theme)
                corner(sx - (text_size.x + 15) - 30,text_size.y - 3,text_size.x + 35, text_size.y  + 20 ,true,vis.color_all_.r,vis.color_all_.g,vis.color_all_.b,a * vis.s.w_a * vis.s.g_a,vis.theme_s)
                render.text(FONT.verdana11,vector(sx - (text_size.x + 11) - 8,text_size.y + 7),color(255,255,255,255* vis.s.w_a * vis.s.g_a),nil,gradi_main:get_animated_text()..' \aFFFFFFE8@'..lua.info.username.." delay: "..get_ping().." "..math.floor(1.0 / globals.tickinterval)..'ticks')

                renderer.texture(vis.main_menu.svg.icon,sx - (text_size.x + 15) - 20,text_size.y+ 6,15,15,126,159,203,255* vis.s.w_a * vis.s.g_a)

                if not entity.get_local_player() then
                    return                    
                end

                if rage.exploit:get() == 1 then
                    vis.solus_ui.is_breaking_lc = true
                else
                    vis.solus_ui.is_breaking_lc = false
                end
    
             
        
                local text_fl = ("FL:%s"):format(
                    (function()
                 
                        if tonumber(last_sent) < 10 then
                            return "\x20"..last_sent
                        end
                        return last_sent
                end)()
                )
                

                local text_tick = ""


                if vis.solus_ui.is_breaking_lc == true then
                    text_tick = " | SHIFTING"
                elseif vis.solus_ui.is_breaking_lc == false then
    
                    text_tick = ""
                end
    
                local text_tick_size = render.measure_text(FONT.verdana11,nil,text_tick)
                local text_fl_size = render.measure_text(FONT.verdana11,nil,text_fl)
    
                local text_cmd = text_fl..text_tick
                local text_cmd_size = text_fl_size.x + text_tick_size.x
                vis.solus_ui.get_cmd_width = animate.new(vis.solus_ui.get_cmd_width,(text_cmd_size + 20)*vis.s.w_a )

                local w_cmd ,h_cmd = vis.solus_ui.get_cmd_width,28

                corner(sx - (w_cmd+10) ,h_cmd/2 + h_cmd + 2,w_cmd,h_cmd,true,vis.color_all_.r,vis.color_all_.g,vis.color_all_.b,255 *vis.s.w_a,vis.theme_s)
                local h = 18 * vis.s.w_a
                render.text(FONT.verdana11,vector(sx - (w_cmd+8) + 9 + 1 ,h_cmd/2 + h + 18 + 1 + 1 + 1),color(10,10,10,255 *vis.s.w_a),nil,text_cmd)
                render.text(FONT.verdana11,vector(sx - (w_cmd+8) + 9 ,h_cmd/2 + h + 18 + 1 + 1),color(255,255,255,255 *vis.s.w_a ),nil,text_cmd)
    
            end
    
            local keybind = function ()
                vis.s.k_a = animate.new( vis.s.k_a ,1,0,lua.uis.misc.solus_list:get('Keybind'))
                if vis.s.k_a <= 0.01 then
                    return
                end
    
                local me = entity.get_local_player()
                
                if me == nil then
                   return 
                end
    
                local x,y = lua.uis.misc.temp_keybind_x:get(),lua.uis.misc.temp_keybind_y:get()
                local v = vis.s
                local binds = ui.get_binds()
    
                v.c_a = animate.new(v.c_a , 1,0,ui.get_alpha() == 1 or #binds > 0) 
    
                local container = function (x,y,w)
                    local height = 18
                    local title_size = render.measure_text(FONT.verdana11,nil,'keybinds')
                    
                    corner(x - 60 ,y - 10,w ,height  + 15,true,vis.color_all_.r,vis.color_all_.g,vis.color_all_.b,a * vis.s.k_a * vis.s.g_a * v.c_a ,vis.theme_s)
                    render.text(FONT.verdana11,vector(x - 59  + 25 , y  + 0.8 ),color(255,255,255,255  * v.c_a * vis.s.k_a * vis.s.g_a),nil,'Keybinds')

                    local tr,tg,tb = 126,159,203
                    local r,g,b = helper.get_bar_color()
                    if (lua.uis.misc.solus_rgb:get() == 'Dynamic' or lua.uis.misc.solus_rgb:get() == 'Static')  then
                        tr,tg,tb = 70,70,70
                    else
                        tr,tg,tb = 126,159,203
                    end

                    renderer.texture(vis.main_menu.svg.key,x - 59 + 5 , y  - 3,20,20,tr,tg,tb ,255* v.c_a * vis.s.k_a * vis.s.g_a)

                end
    
    
                local addy = 0
                local max_width = 0
    
                for i = 1, #binds do
                    local bind = binds[i]
                    table.insert(v.ka_a,0)
    
                    local name = bind.name
                    table.insert(v.ka_a,name)
    
                    if v.ka_a[name] == nil then
                        v.ka_a[name] = 0
                    end
    
                    addy = addy + v.ka_a[name] / 20
    
                    if name ~= '' then
                        v.ka_a[name] = animate.new(v.ka_a[name],255,0,bind.active)
    
                            
                        local states =  (bind.mode == 1 and '[holding]' or '[toggled]')
                        local states_size = render.measure_text(FONT.verdana11,nil,states)
                        local name_size = render.measure_text(FONT.verdana11,nil, name)
                        local alpha = math.floor(v.ka_a[name] * vis.s.k_a * vis.s.g_a)
                        local width = math.floor(v.ka_w)
    
                        v.c_x = animate.new(v.c_x,(width - states_size.x) - 3)
                        local rex = math.floor(v.c_x)
                        render.text(FONT.verdana11, vector( x - 56 + 1, y + 13 + addy + 1), color(12, 12, 12, alpha),nil,name)
                        render.text(FONT.verdana11, vector(x + rex + 1, y + 13 + addy + 1),color(12, 12, 12, alpha),nil,states)
    
                        render.text(FONT.verdana11, vector( x - 56, y + 13 + addy), color(255, 255, 255, alpha),nil,name)
                        
                        render.text(FONT.verdana11, vector(x + rex, y + 13 + addy),color(255, 255, 255, alpha),nil,states)
    
                        local length = 75
                        local bind_width = states_size.x + name_size.x - 40
                        
                        if bind_width > length then
                            if bind_width > max_width then
                                max_width = bind_width
                            end
                        end
    
    
                        
                    else
                        addy = addy - v.ka_a[name] / 20
                    end
    
                    
                 
                end
    
                v.ka_w = math.max(65, max_width)
                if ui.get_alpha() == 0 then
                    v.drag = false
                end
        
                
                local width = math.floor(v.ka_w)
                local mouse = ui.get_mouse_position()
        
                v.c_w = animate.new(v.c_w,width + 60)
                container(x, y, math.floor(v.c_w))
    
                if ui.get_alpha() == 1 or #binds > 0 then
                    if common.is_button_down(0x1) then
                        if not v.drag then
                            if mouse.x >= x - 70 and mouse.y >= y and mouse.x <= x + width and mouse.y <= y + 18 then
                                v.drag = true
                            end
                        else
                            local x_pos = x + (mouse.x - v.cursor_last_pos.x)
                            local y_pos = y + (mouse.y - v.cursor_last_pos.y)
        
    
                            lua.uis.misc.temp_keybind_x:set(math.floor(x_pos))
                            lua.uis.misc.temp_keybind_y:set(math.floor(y_pos))
                        end
                    else
                        v.drag = false
                    end
        
                    v.cursor_last_pos = mouse
                end
    
                
            end
    
            local spectator = function ()
                vis.s.s_a = animate.new( vis.s.s_a ,1,0,lua.uis.misc.solus_list:get('Spectator'))
                if vis.s.s_a <= 0.01 then
                    return
                end
    
                local me = entity.get_local_player()
                
                if me == nil then
                   return 
                end
                local v = vis.s
    
    
                
                local get_specs = function()
                    local get_s = function(player) 
                        local buffer = { }
                    
                        local players = entity.get_players()
                        for tbl_idx, player_pointer in pairs(players) do
                            if player_pointer:get_index() ~= player:get_index() then
                                if not player_pointer:is_alive() then
                                    local spectatingMode = player_pointer.m_iObserverMode
                                    local spectatingPlayer = player_pointer.m_hObserverTarget
                
                                    if spectatingPlayer then
                                        if spectatingMode >= 4 or spectatingMode <= 5 then
                                            local spectatingEntity = entity.get(spectatingPlayer)
                                            if spectatingEntity ~= nil and spectatingEntity:get_index() == player:get_index() then
                                                local player_info = player_pointer:get_player_info()
                                                table.insert(buffer, 1, {
                                                    id = player_info.steamid,
                                                    id64 = player_info.steamid64,
                                                    name = player_pointer:name(),
                                                    idx = player_pointer
                                                })
                                            end
                                        end
                                end
                                end
                            end
                        end
    
                        return buffer
    
                    end
    
                       
    
                  local getspectators = function()
                        if not globals.is_connected or me == nil then return end
                             local local_player = me
                             if local_player == nil then return end
                    
                             if local_player:is_alive() then
                                 return get_s(local_player)
                             else
                                 local m_hObserverTarget = local_player.m_hObserverTarget
                                 if m_hObserverTarget then
                                     local targetEntity = entity.get(m_hObserverTarget)
                                    if targetEntity ~= nil and targetEntity:is_player() then
                                         return get_s(targetEntity)
                                    end
                                 end
                             end
                    end
                
                    return getspectators()
                end
    
                local addy = 0
                local max_width = 0
    
                local spec = get_specs()
                
                
                if spec == nil then
                    return
                end
                
                local x,y = lua.uis.misc.temp_spec_x:get(),lua.uis.misc.temp_spec_y:get()
                v.sc_a = animate.new(v.sc_a , 1,0,ui.get_alpha() == 1 or #spec > 0) 
    
                local container = function (x,y,w)
                    local height = 18
                    local title_size = render.measure_text(FONT.verdana11,nil,'Spectators')
                    


                    local tr,tg,tb = 126,159,203
                    local r,g,b = helper.get_bar_color()
                    if (lua.uis.misc.solus_rgb:get() == 'Dynamic' or lua.uis.misc.solus_rgb:get() == 'Static')  then
                        tr,tg,tb = 70,70,70
                    else
                        tr,tg,tb = 126,159,203
                    end

                    corner(x - 60 ,y - 10,w ,height + 15 ,true,vis.color_all_.r,vis.color_all_.g,vis.color_all_.b,a * vis.s.s_a * vis.s.g_a *  v.sc_a ,vis.theme_s)
                    render.text(FONT.verdana11,vector(x - 59 + 28 , y  + 0.8),color(255,255,255,255* vis.s.s_a * vis.s.g_a*  v.sc_a),nil,'Spectators')
                    renderer.texture(vis.main_menu.svg.eyes,x - 59 + 6 , y  - 2,20,20,tr,tg,tb,255* vis.s.s_a * vis.s.g_a*  v.sc_a)

                end
    
    
    
            
             
                for i = 1, #spec do
                    local bind = spec[i]
                    table.insert(v.sa_a,0)
    
                    local name = bind.name
                    if name == nil then
                        return
                    end
    
                    table.insert(v.sa_a,name)
                    if v.sa_a[name] == nil then
                        v.sa_a[name] = 0
                    end
    
    
    
    
                    addy = addy + v.sa_a[name] / 14
    
                    if name ~= '' then
                        v.sa_a[name] = animate.new(v.sa_a[name],255)
    
                        local avatar = bind.idx:get_steam_avatar()
                        -- local states = bind.mode == 1 and '[holding]' or '[toggled]'
                        -- local states_size = render.measure_text(FONT.verdana11,nil,states)
                        local name_size = render.measure_text(FONT.verdana11,nil, name)
                        local alpha = math.floor(v.sa_a[name] * vis.s.s_a * vis.s.g_a)
                        local width = math.floor(v.sa_w)
                        render.texture(avatar,vector( x - 63  + 10+ 1, y + 10 - 3 + addy + 1),vector(16,16),color(255, 255, 255,  alpha),'f',12)
                        render.text(FONT.verdana11, vector( x - 63  + 30+ 1, y+ 10 - 1  + addy + 1), color(12, 12, 12,  alpha),nil,name)
                        render.text(FONT.verdana11, vector( x - 63 + 30, y + 10- 1  + addy), color(255, 255, 255,  alpha),nil,name)
    
                        local length = 75
                        local bind_width =  (name_size.x + 18) - 40
                        
                        if bind_width > length then
                            if bind_width > max_width then
                                max_width = bind_width
                            end
                        end
    
    
                        
                    else
                        addy = addy - v.sa_a[name] / 14
                    end
    
                    
                 
                end
    
                v.sa_w = math.max(65, max_width)
                if ui.get_alpha() == 0 then
                    v.drags = false
                end
        
                
                local width = math.floor(v.sa_w)
                local mouse = ui.get_mouse_position()
        
                v.sc_w = animate.new(v.sc_w,width + 60)
                container(x, y, math.floor(v.sc_w))
    
                if ui.get_alpha() == 1 or #spec > 0 then
                    if common.is_button_down(0x1) then
                        if not v.drags then
                            if mouse.x >= x - 70 and mouse.y >= y and mouse.x <= x + width and mouse.y <= y + 18 then
                                v.drags = true
                            end
                        else
                            local x_pos = x + (mouse.x - v.cursor_last_poss.x)
                            local y_pos = y + (mouse.y - v.cursor_last_poss.y)
        
    
                            lua.uis.misc.temp_spec_x:set(math.floor(x_pos))
                            lua.uis.misc.temp_spec_y:set(math.floor(y_pos))
                        end
                    else
                        v.drags = false
                    end
        
                    v.cursor_last_poss = mouse
                end
    
            end
            watermark()
            keybind()
            spectator()
        end,
    
        init = function ()
            if lua.uis.misc.solus_switch:get() then
                vis.solus_ui.solus_render()

            end
        end
    },

    center_indicator = {

        v = {
            scope_var = 0,

            ['center'] = {
                ['flashing'] = {
                    cur = 0, min = 0 , max = 1,target = 0,step = 1,speed = 0.12
                },
                ['values'] = {
                    0,0,0,0
                },
                ['doubletap_color'] = {
                    r = 0 , g = 0 , b = 0 , a = 0
                },
                ['active_color'] = {
                    r = 0 , g = 0 , b = 0 , a = 0
                }
            },
    
            act = 0,
            act_temp = 0,
            sss = 0,

            modif = 0,
        },

        render = function ()
            

            if not lua.uis.misc.solus_list:get('Center Indicator') or not lua.uis.misc.solus_switch:get()  then
                return
            end

            local sc = render.screen_size()

            local cx,cy = sc.x/2 , sc.y/2
            local alpha = math.sin(math.abs(-math.pi + (globals.curtime * (1 / 0.7)) % (math.pi * 2))) * 255
            local v = vis.center_indicator.v
            local main_textsize = render.measure_text(FONT.verdana12,nil,[[FRIGUS.LUA]])
            local main_textsizes = render.measure_text(FONT.verdana12,nil,[[FRIGUS.LUA]])

            local lp = entity.get_local_player()
            if lp and lp:is_alive() then
                local isscope = lp["m_bIsScoped"]
                local anti_con = antiaim.condition()
                local states_text = lua.player_states_temp[antiaim.value.c]

                local ST_textsize = render.measure_text(2,nil,'-'..states_text..'-')


                local rl,gl,bl,al = lua.uis.misc.left_gradient_color:get().r,lua.uis.misc.left_gradient_color:get().g,lua.uis.misc.left_gradient_color:get().b,lua.uis.misc.left_gradient_color:get().a
                local rr,gr,br,ar = lua.uis.misc.right_gradient_color:get().r,lua.uis.misc.right_gradient_color:get().g,lua.uis.misc.right_gradient_color:get().b,lua.uis.misc.right_gradient_color:get().a
                local rs,gs,bs,as = lua.uis.misc.states_color:get().r,lua.uis.misc.states_color:get().g,lua.uis.misc.states_color:get().b,lua.uis.misc.states_color:get().a
                local rk,gk,bk,ak = lua.uis.misc.keybind_color:get().r , lua.uis.misc.keybind_color:get().g,lua.uis.misc.keybind_color:get().b,lua.uis.misc.keybind_color:get().a
                local gradi_main = gradient.text_animate([[FRIGUS.LUA]],-1,{
                        color(rl,gl,bl,al), 
                        color(rr,gr,br,ar)
                    }
                )
                gradi_main:animate()
                local modifier = entity.get_local_player().m_flVelocityModifier ~= 1

                v.modif = animate.new(v.modif,1,0,modifier)



                renderer.rectangle(cx - main_textsize.x/2  + math.floor(25 * v.scope_var),cy + 13 + 11 ,main_textsizes.x ,3,15,15,15,255  * v.modif)
                renderer.rectangle(cx - main_textsize.x/2  + math.floor(25 * v.scope_var) + 1,cy + 13 + 12 ,(main_textsizes.x - 2)  * entity.get_local_player().m_flVelocityModifier,1,255,255,255,255  * v.modif)

                v.scope_var = animate.new(v.scope_var,1,0,isscope)

                render.text(FONT.verdana12,vector(cx - main_textsize.x/2  + math.floor(25 * v.scope_var),cy + 11),color(255,255,255,255),'',gradi_main:get_animated_text())

                --renderer.text(cx - main_textsize.x + 7 + math.floor(25 * v.scope_var),cy + 13, 255,255,255,255,'-',0,gradi_main:get_animated_text())
                render.shadow(vector(cx - main_textsize.x/2  + math.floor(25 * v.scope_var),cy + 18), vector(cx + main_textsize.x/2 + math.floor(25 * v.scope_var),cy + 18), color(rl,gl,bl,al),25, 0, 0)
                renderer.text(cx + math.floor(25 * v.scope_var) ,cy + 15 + main_textsize.y +math.floor( 4 * v.modif),rs,gs,bs,as,'c-',0,string.upper('-'..states_text..'-'))
                
                v['center']['doubletap_color'] = 
                animate.new_color(
                    v['center']['doubletap_color'],
                    {r = rk , g = gk,b = bk,a = ak},
                    {r = 255 , g = 0,b = 0,a = 255},
                    ref.dt:get() and rage.exploit:get() == 1
                )


                v['center']['active_color'] = 
                animate.new_color(
                    v['center']['active_color'],
                    {r = 0 , g = 255,b = 0,a = 255},
                    {r = 175 , g = 175,b = 175,a = 255},
                    ref.dt:get() and rage.exploit:get() == 1 and not ref.hideshot:get()
                )




                local keys = {
    
                    [1] = {
                        ['condition'] = ref.hideshot:get() and not ref.dt:get(),
                        ['text'] = 'HIDE',
                        ['color'] = {rk,gk,bk,ak }
                    },
    
                    [2] = {
                        ['condition'] = ref.dt:get() and not ref.hideshot:get(),
                        ['text'] = 'DT',
                        ['color'] = {v['center']['doubletap_color'].r,v['center']['doubletap_color'].g,v['center']['doubletap_color'].b,255}              
            
                    },
                }
                

                v.act = animate.new(v.act, ref.dt:get() and rage.exploit:get() == 1 and not ref.hideshot:get() and 1 or (ref.dt:get() and rage.exploit:get() ~= 1 and not ref.hideshot:get()) and 0.5 or 0,0)
                v.act_temp = animate.new(v.act_temp, ref.dt:get() and rage.exploit:get() == 1 and not ref.hideshot:get() and 1 or 0,0)

                local text = (ref.dt:get() and rage.exploit:get() == 1 and not ref.hideshot:get()) and 'ACTIVE' or (ref.dt:get() and rage.exploit:get() ~= 1 and not ref.hideshot:get()) and 'WAITING' or ''
                renderer.text(cx - 10  + math.floor(25 * v.scope_var) , cy + 17 + main_textsize.y + math.floor( 4 * v.modif),v['center']['active_color'].r,v['center']['active_color'].g,v['center']['active_color'].b,255 * v.act,'-',0,string.sub(text,(text:len() + 1) * -v.act_temp))
                
                local act_textsize = render.measure_text(2,'',text)
                v.sss = animate.new(v.sss,ref.dt:get() and not ref.hideshot:get() and 13 or 0 )

                local ind_offset= 0
                for k, items in pairs(keys) do

                    local flags = 2
                    local text_width , text_height = render.measure_text(flags,items['text'])
                    local key = items['condition'] and 1 or 0
    
                    v['center']['values'][k] = animate.new(v['center']['values'][k],key)
                    local x,y = cx + 3 + math.floor(25 * v.scope_var) , cy + 23 + main_textsize.y

                    -- v.mov = animate.new_notify(v.mov,0,23,is_scoped)
                    -- local x , y = cx -( ts.x/2 -  math.floor(v.mov)) + math.floor((ts.x/2  + 4)*  v.c.m),cy + ( 34)

                    -- v.criS = animate.new(v.criS,1,0,k == 4)
                    
                    render.text(2,
                        vector( x -4 - v.sss,y  + math.floor( 4 * v.modif) +  math.floor(ind_offset * v['center']['values'][k])),
                        color( items['color'][1],items['color'][2],items['color'][3],items['color'][4] * v['center']['values'][k]  * (k == 2 and v.act or 1) ),
                       'c',
                     -- text_width * v['center']['values'][k] + 3,
                         string.sub(items['text'],(items['text']:len() + 1) * -v['center']['values'][k])
                    )
            
            
                    ind_offset = ind_offset + math.floor(10 * v['center']['values'][k])
                end
    

                renderer.text(cx+1 + math.floor(25 * v.scope_var) , cy + 23 + main_textsize.y  + math.floor( 4 * v.modif)+ ind_offset,185,185,185,155,'c-',0,'DORMANT')
                
            end

          
        end,


        init = function ()
            vis.center_indicator.render()
        end
    },

    rainbow_bar = {
        render = function ()
            
            if not lua.uis.misc.rainbow_bar_switch:get() then
                return
            end
            local r,g,b,a = helper.get_bar_color()
            local sc = render.screen_size()
            renderer.gradient(0,2,sc.x,5,r,g,b,a,b,g,r,a,true)
            renderer.gradient(0,2,7,sc.y,r,g,b,a,b,g,r,a,false)
            renderer.gradient(0,sc.y - 5,sc.x,9,r,g,b,a,b,g,r,a,true)
            renderer.gradient(sc.x - 7,2,7,sc.y,r,g,b,a,b,g,r,a,false)


        end
    },

    hit_marker = {
        hitmarker = {},

        vars = {
            data = {},
            queue = {}
        },

        on_bullet_impact = function (e)
            if not lua.uis.misc.hit_marker:get() then return end
            if entity.get(e.userid, true) == entity.get_local_player() then
                local impactX = e.x
                local impactY = e.y
                local impactZ = e.z
                table.insert(vis.hit_marker.vars.data, { impactX, impactY, impactZ, globals.realtime })
            end
        end,

        on_player_hurt = function (e)
            if not lua.uis.misc.hit_marker:get() then return end
            local bestX, bestY, bestZ = 0, 0, 0
            local bestdistance = 100
            local realtime = globals.realtime
            if entity.get(e.attacker, true) == entity.get_local_player() then
                local victim = entity.get(e.userid, true)
                if victim ~= nil then
                    local victimOrigin = victim.m_vecOrigin
                    local victimDamage = e.dmg_health
                    local victimhelf = victim.m_iHealth - victimDamage
        
                    for i in ipairs(vis.hit_marker.vars.data) do
                        local data = vis.hit_marker.vars.data[i]
                        if data[4] + (4) >= realtime then
                            local impactX = data[1]
                            local impactY = data[2]
                            local impactZ = data[3]
        
                            local distance = helper.vectordistance(victimOrigin.x, victimOrigin.y, victimOrigin.z, impactX, impactY, impactZ)
                            if distance < bestdistance then
                                bestdistance = distance
                                bestX = impactX
                                bestY = impactY
                                bestZ = impactZ
                            end
                        end
                    end
        
                    if bestX == 0 and bestY == 0 and bestZ == 0 then
                        victimOrigin.z = victimOrigin.z + 50
                        bestX = victimOrigin.x
                        bestY = victimOrigin.y
                        bestZ = victimOrigin.z
                    end
        
                    for k in ipairs(vis.hit_marker.vars.data) do
                        vis.hit_marker.vars.data[k] = { 0, 0, 0, 0 }
                    end
                    table.insert(vis.hit_marker.vars.queue, { bestX, bestY, bestZ, realtime, victimDamage, victimhelf } )
                end
            end
        end,

                
        on_player_spawned = function(e)
            if not lua.uis.misc.hit_marker:get() then return end
            if entity.get(e.userid, true) == entity.get_local_player() then
                for i in ipairs(vis.hit_marker.vars.data) do
                    vis.hit_marker.vars.data[i] = { 0, 0, 0, 0 }
                end
            
                for i in ipairs(vis.hit_marker.vars.queue) do
                    vis.hit_marker.vars.queue[i] = { 0, 0, 0, 0, 0, 0 }
                end
            end
        end,

        draw = function()
            local HIT_MARKER_DURATION = 2
            local realtime = globals.realtime
            local maxTimeDelta = HIT_MARKER_DURATION / 2
            local maxtime = realtime - maxTimeDelta / 2
            
            for i in ipairs(vis.hit_marker.vars.queue) do
                local marker = vis.hit_marker.vars.queue[i]
                if marker[4] + HIT_MARKER_DURATION > maxtime then
                    if marker[1] ~= nil then
        
                        local add = (marker[4] - realtime) * 50
        
                        local w2c = render.world_to_screen(vector((marker[1]), (marker[2]), (marker[3])))
                        local w2c2 = render.world_to_screen(vector((marker[1]), (marker[2]), (marker[3]) - add))
                        if not w2c or not w2c2 then return end
                        if w2c.x ~= nil and w2c.y ~= nil then
                            local alpha = 255      
                            if (marker[4] - (realtime - HIT_MARKER_DURATION)) < (HIT_MARKER_DURATION / 2) then                          
                                alpha = math.floor((marker[4] - (realtime - HIT_MARKER_DURATION)) / (HIT_MARKER_DURATION / 2) * 255)
                                if alpha < 5 then
                                    marker = { 0 , 0 , 0 , 0, 0, 0 }
                                end              
                            end
        
                            local HIT_MARKER_SIZE = 6
                            local col = lua.uis.misc.hit_color:get()
        
                            -- local color1 = color(255, 255, 255, alpha)
                            local color2 = color(155, 200, 21, alpha)
        
        
                            local colorspiese = marker [6] <= 0 and color2 or col2
        
                            render.gradient(vector(w2c.x - 1, w2c.y - HIT_MARKER_SIZE), vector(w2c.x + 1, w2c.y), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), 0)
                            render.gradient(vector(w2c.x - HIT_MARKER_SIZE, w2c.y - 1), vector(w2c.x, w2c.y + 1), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), 0)
                            render.gradient(vector(w2c.x - 1, w2c.y + HIT_MARKER_SIZE), vector(w2c.x + 1, w2c.y), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), 0)
                            render.gradient(vector(w2c.x + HIT_MARKER_SIZE, w2c.y - 1), vector(w2c.x, w2c.y + 1), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), color(col.r, col.g, col.b, alpha), 0)
                            
                        end
                    end
                end
            end
        end

    },

    slowdown_indicator = {
        v = {
            slow_a = 0
        },
        render = function ()
            local function corner(x, y, w, h, header, r,g,b,a,theme)

                if theme == 2 then 
                    r1,g1,b1 = r, g , b
                    r2,g2,b2 = r, g , b
                    r3,g3,b3 = r, g , b
                    if lua.uis.misc.solus_glow:get() then 
                        render.shadow(vector(x,y), vector(x+w,y+h), color(r,g,b,a),30, 0, 4)
                    end
                    local n = a / 255 * 35;
                    local s = 16/24
                    render.texture(vis.main_menu.svg.solus_pit, vector(x + 4 + w/2 - 4 * 2 - 16/2 + 4,y -8), vector(16,16), color(r,g,b,a), "", 0)
                    render.gradient(vector(x + 4 - s, y), vector(x + 4 + w/2 - 4 * 2 - 16/2, y + 1), color(r1, g1, b1, a), color(r2, g2, b2, a), color(r1, g1, b1, a), color(r2, g2, b2, a))
                    render.gradient(vector(x + 4 + w/2 - 4 * 2 + 16/2 + 8, y), vector(x + 4 + w - 4 * 2 + s, y + 1), color(r2, g2, b2, a), color(r3, g3, b3, a), color(r2, g2, b2, a), color(r3, g3, b3, a))
                    
                    render.circle_outline(vector(x + 4 - s, y + 4), color(r1, g1, b1, a), 4, 180, 0.25, 1)
                    render.circle_outline(vector(x + w - 4 + s, y + 4), color(r3, g3, b3, a), 4, 270, 0.25, 1)

                    render.gradient(vector(x - s, y + 4), vector(x + 1 - s, y + 4 + h - 4 * 2), color(r1, g1, b1, a), color(r1, g1, b1, a), color(r2, g2, b2, n), color(r2, g2, b2, n))
                    render.gradient(vector(x + w - 1 + s, y + 4), vector(x + w + s, y + 4 + h - 4 * 2), color(r3, g3, b3, a), color(r3, g3, b3, a), color(r2, g2, b2, n), color(r2, g2, b2, n))

                    render.circle_outline(vector(x + 4 - s, y + h - 4), color(r2, g2, b2, n), 4, 90, 0.25, 1)
                    render.circle_outline(vector(x + w - 4 + s, y + h - 4), color(r2, g2, b2, n), 4, 0, 0.25, 1)

                    render.gradient(vector(x + 4 - s, y + h - 1), vector(x + 4 + w/2 - 4 * 2, y + h), color(r2, g2, b2, n), color(r1, g1, b1, n), color(r2, g2, b2, n), color(r1, g1, b1, n))
                    render.gradient(vector(x + 4 + w/2 - 4 * 2, y + h - 1), vector(x + 4 + w - 4 * 2 + s, y + h), color(r1, g1, b1, n), color(r2, g2, b2, n), color(r1, g1, b1, n), color(r2, g2, b2, n))

                else
                    local c = {10, 60, 40, 40, 40, 60, 20}
                    for i = 0,6,1 do
                        renderer.rectangle(x+i, y+i, w-(i*2), h-(i*2), c[i+1], c[i+1], c[i+1], a)
                    end
                    if header then
                        local x_inner, y_inner = x+7, y+7
                        local w_inner = w-14
                
                        local a_lower = a/2

                        local r,g,b = helper.get_bar_color()
                        if lua.uis.misc.solus_rgb:get() == 'Dynamic' then
                            --renderer.gradient(x_inner, y_inner+1, w_inner, 1, r,g,b, a_lower, b,g,r, a_lower, false)
                            renderer.gradient(x_inner, y_inner+1, math.floor(w_inner/2), 1, r,g,b, a_lower, b,g,r, a_lower, true)
                            renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, b,g,r, a_lower, g,b,r, a_lower, true)
                        elseif lua.uis.misc.solus_rgb:get() == 'Static' then
                            
                            renderer.gradient(x_inner, y_inner+1, math.floor(w_inner/2), 1, 59, 175, 222, a_lower, 202, 70, 205, a_lower, true)
                            renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, 202, 70, 205, a_lower, 201, 227, 58, a_lower, true)
                        else

                            renderer.gradient(x_inner, y_inner+1, w_inner, 20, 126,159,203, a_lower, 0,0,0, 0, false)
                        end

                        -- renderer.gradient(x_inner+math.floor(w_inner/2), y_inner+1, math.ceil(w_inner/2), 1, 202, 70, 205, a_lower, 201, 227, 58, a_lower, true)
                    end
                end
            end
            local sc = render.screen_size()
            local v = vis.slowdown_indicator.v
            local cx,cy = sc.x/2 , sc.y/2
            local tt = lua.uis.misc.solus_theme:get()
            local cc = lua.uis.misc.solus_color:get()
            if entity.get_local_player() == nil then
                return
            end
            local modifier = entity.get_local_player().m_flVelocityModifier ~= 1
            local x,y = lua.uis.misc.temp_slow_x:get(),lua.uis.misc.temp_slow_y:get()
            local mouse = ui.get_mouse_position()

            v.slow_a = animate.new(v.slow_a,1,0,(ui.get_alpha() == 1 or modifier) and lua.uis.misc.slowdown_indicator:get())

            if ui.get_alpha() == 1 and common.is_button_down(0x1) and mouse.x > x and mouse.x < x + 100 and mouse.y > y and mouse.y < y + 25 then
                lua.uis.misc.temp_slow_x:set(mouse.x - 50)
                lua.uis.misc.temp_slow_y:set(mouse.y - 12)
            end


            --renderer.texture(vis.main_menu.svg.slow,x + 1,y + 1,50,50,15,15,15,col.a * v.slow_a,'f')
            --renderer.texture(vis.main_menu.svg.slow,x - 1,y - 1,50,50,15,15,15,col.a * v.slow_a,'f')
            --renderer.texture(vis.main_menu.svg.slow,x + 1,y - 1,50,50,15,15,15,col.a * v.slow_a,'f')
            --renderer.texture(vis.main_menu.svg.slow,x - 1,y + 1,50,50,15,15,15,col.a * v.slow_a,'f')

            local function rgb_health_based(percentage)
                local r = 124*2 - 124 * percentage
                local g = 195 * percentage
                local b = 13
                return r, g, b
            end

            local r,g,b = rgb_health_based(entity.get_local_player().m_flVelocityModifier)


            --renderer.texture(vis.main_menu.svg.slow,x,y,50,50,col.r,col.g,col.b,col.a * v.slow_a,'f')
            corner(x, y, 132, 40, true,cc.r,cc.g,cc.b, v.slow_a*255,tt)

            render.text(1,vector(x+10,y + 14),color(255,255,255,255 * v.slow_a),'',"Speed:")
            local text_l = render.measure_text(1,"","Speed:") + 10

            renderer.rectangle(x+text_l.x+1 ,y + 16, (132-text_l.x-15) * entity.get_local_player().m_flVelocityModifier,10,r,g,b,255 * v.slow_a,4)

        end
    },


    manual_indicator = {

        v = {



            ['arrows'] = {
                g_alpha = 0,
                ['left'] = {
                    r = 0 , g = 0 , b = 0 , a = 0
                },
                ['right'] = {
                    r = 0 , g = 0 , b = 0 , a = 0
                },
                ['animate'] = {
                    right_x = 0,
                    left_x = 0
                }
                
            } ,
            
        },

        render = function ()
            local v = vis.manual_indicator.v['arrows']
            local sc = render.screen_size()
    
            local me = entity.get_local_player()
            if me == nil or not me:is_alive() then
                return
            end
            
            local r,g,b,a = lua.uis.misc.manual_color:get().r,lua.uis.misc.manual_color:get().g,lua.uis.misc.manual_color:get().b,lua.uis.misc.manual_color:get().a
            local dist = (sc.x/2) / 210 * lua.uis.misc.arrows_distance:get()
            v.g_alpha = animate.new(v.g_alpha,1,0,lua.uis.misc.manual_indicator:get())
    
            if v.g_alpha < 0.01 then return end
    
            v['left'] = animate.new_color(v['left'],{r = r , g = g,b = b,a = a * v.g_alpha},{ r = 0,g = 0 , b = 0 , a = 0 },lua.uis.sets.manual_yaw:get() == 'Left')
            v['right'] = animate.new_color(v['right'],{r = r , g = g,b = b,a = a * v.g_alpha},{ r = 0,g = 0 , b = 0 , a = 0 },lua.uis.sets.manual_yaw:get() == 'Right')
            local vel = entitys.velocity(me)


            local right_x = (sc.x/2) - 34 + dist + (lua.uis.misc.speed_move:get() and vel or 0)
            local left_x = (sc.x/2) - dist - (lua.uis.misc.speed_move:get() and vel or 0)
    
            v['animate'].right_x = animate.new(v['animate'].right_x,right_x)
            v['animate'].left_x = animate.new(v['animate'].left_x,left_x)
    
            local rex_r = math.floor(v['animate'].right_x)
            local rex_l = math.floor(v['animate'].left_x)


            
            local left_arrow ,right_arrow = vis.main_menu.svg.left_arrow,vis.main_menu.svg.right_arrow
            render.texture(left_arrow,vector(rex_l,(sc.y/2) + 1),vector(32,31),color(40,40,40,180 * v.g_alpha),'f')
            render.texture(right_arrow,vector(rex_r +  (40 * vis.center_indicator.v.scope_var),(sc.y/2) - 1),vector(32,32),color(40,40,40,180 * v.g_alpha),'f')
    
            render.texture(left_arrow,vector(rex_l + 1,(sc.y/2) + 1 + 1),vector(32,31),color(25,25,25,v['left'].a),'f')
            render.texture(right_arrow,vector(rex_r +  (40 * vis.center_indicator.v.scope_var) + 1,(sc.y/2)  - 1 + 1),vector(32,32),color(25,25,25,v['right'].a),'f')
    
            render.texture(left_arrow,vector(rex_l,(sc.y/2) + 1),vector(32,31),color(v['left'].r,v['left'].g,v['left'].b,v['left'].a),'f')
            render.texture(right_arrow,vector(rex_r +  (40 * vis.center_indicator.v.scope_var),(sc.y/2)  - 1),vector(32,32),color(v['right'].r,v['right'].g,v['right'].b,v['right'].a),'f')
        end
    },

    miss_marker = {

        hitgroup_str = {
            [0] = 'generic',
            'head', 'chest', 'stomach',
            'left arm', 'right arm',
            'left leg', 'right leg',
            'neck', 'generic', 'gear'
        },
        
        missr_str = {
            ['prediction error'] = 'PREDICTION',
            ['lagcomp failure'] = 'LAGCOMP',
            ['unregistered shot'] = 'UNREGISTERED'
        },
        
        missvalue = 
        {
            ["UNKNOWN"]     = function(Shot) return vis.miss_marker.hitgroup_str[Shot.hitgroup] or nil end,
            ["SPREAD"]      = function(Shot) return math.floor(Shot.hitchance + 0.5) .. "%" end,
            ["PREDICTION"]  = function(Shot) return globals.tickcount - Shot.tick .. "t" end
        },

        v = {
            _WaitTime = 2,
            _FadeTime = 0.5,
            Shots = {},
     
        },

        render = function()
            local bMaster, bExtra   = lua.uis.misc.missmarker_switch:get(), lua.uis.misc.extra_switch:get()
            local IconColor = lua.uis.misc.icon_color:get()
            local TextColor = lua.uis.misc.extra_color:get()
        
            for i, Miss in pairs(vis.miss_marker.v.Shots) do
                if not bMaster or Miss.FadeTime <= 0 then
                    vis.miss_marker.v.Shots[i] = nil
                else
                    Miss.WaitTime      = Miss.WaitTime - globals.frametime
                    if Miss.WaitTime <= 0 then
                        Miss.FadeTime  = Miss.FadeTime - ((1 / vis.miss_marker.v._FadeTime) * globals.frametime)
                    end
        
                    local sb = render.world_to_screen(vector(Miss.Pos.x, Miss.Pos.y, Miss.Pos.z))
                    if sb ~= nil and Miss.Reason and Miss.FadeTime > 0.05 then

                        local IconSize = render.measure_text(2,nil, "❌")

                        
                        local IconPos = vector(sb.x - (IconSize.x / 2), sb.y - (IconSize.y / 2))
                        
                        renderer.text(IconPos.x, IconPos.y, IconColor.r, IconColor.g, IconColor.b, IconColor.a * Miss.FadeTime, "", 0, "X")
                        renderer.text(IconPos.x + IconSize.x + 1, IconPos.y - ((15 ) * (1 - Miss.FadeTime)), 255,255,255,255 * Miss.FadeTime, "-", 0, Miss.Reason)
        
                        if bExtra and Miss.Value then
                            local ReasonSize = render.measure_text(2,nil, Miss.Reason)
                            renderer.text(IconPos.x + IconSize.x, IconPos.y + (ReasonSize.y * 0.85) - ((15) * (1 - Miss.FadeTime)),255,255,255,255 * Miss.FadeTime, "-", 0, Miss.Value)
                        end
                    end
                end
            end
        end

    },

    
    onloading = {
        v = {
            ol = {
                gclr_alpha = 0,
                rectclr = 0,
                s = false,
                t = globals.realtime,
                icon = render.load_image(
                    '<svg t="1672560184540" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2558" width="200" height="200"><path d="M512 982c-63.44 0-124.99-12.43-182.95-36.94-55.97-23.67-106.23-57.56-149.39-100.72s-77.04-93.42-100.72-149.39C54.43 636.99 42 575.44 42 512s12.43-125 36.94-182.95c23.67-55.97 57.56-106.23 100.72-149.39 43.16-43.16 93.42-77.04 149.39-100.72C387.01 54.43 448.56 42 512 42c63.44 0 124.99 12.43 182.95 36.94 55.97 23.67 106.23 57.56 149.39 100.72 43.16 43.16 77.04 93.42 100.72 149.39C969.57 387.01 982 448.56 982 512s-12.43 124.99-36.94 182.95c-23.67 55.97-57.56 106.23-100.72 149.39s-93.42 77.04-149.39 100.72C636.99 969.57 575.44 982 512 982z m0-900C274.9 82 82 274.9 82 512s192.9 430 430 430 430-192.9 430-430S749.1 82 512 82z" p-id="2559" fill="#ffffff"></path><path d="M512 642.87c-3.45 0-6.91-0.89-10-2.68l-96.02-55.44c-6.19-3.57-10-10.17-10-17.32V456.56c0-7.15 3.81-13.75 10-17.32L502 383.81a20.013 20.013 0 0 1 20 0l96.02 55.44c6.19 3.57 10 10.17 10 17.32v110.87c0 7.15-3.81 13.75-10 17.32L522 640.19a19.947 19.947 0 0 1-10 2.68z m-76.02-86.98L512 599.78l76.02-43.89v-87.78L512 424.22l-76.02 43.89v87.78z m172.04 11.55z" p-id="2560" fill="#ffffff"></path><path d="M512 779.16c-11.05 0-20-8.95-20-20V622.87c0-11.05 8.95-20 20-20s20 8.95 20 20v136.29c0 11.05-8.95 20-20 20z" p-id="2561" fill="#ffffff"></path><path d="M572.86 840.02c-5.12 0-10.24-1.95-14.14-5.86l-60.86-60.86c-7.81-7.81-7.81-20.47 0-28.29 7.81-7.81 20.47-7.81 28.28 0L587 805.88c7.81 7.81 7.81 20.47 0 28.29-3.91 3.9-9.02 5.85-14.14 5.85z" p-id="2562" fill="#ffffff"></path><path d="M448.18 842.99c-5.12 0-10.24-1.95-14.14-5.86-7.81-7.81-7.81-20.47 0-28.29l63.82-63.82c7.81-7.81 20.47-7.81 28.28 0 7.81 7.81 7.81 20.47 0 28.29l-63.82 63.82a19.98 19.98 0 0 1-14.14 5.86zM726.03 655.58c-3.39 0-6.83-0.86-9.98-2.68l-118.03-68.14c-9.57-5.52-12.84-17.75-7.32-27.32s17.75-12.84 27.32-7.32l118.03 68.14c9.57 5.52 12.84 17.75 7.32 27.32-3.7 6.42-10.43 10-17.34 10z" p-id="2563" fill="#ffffff"></path><path d="M726.04 655.59c-8.83 0-16.91-5.89-19.31-14.83-2.86-10.67 3.47-21.64 14.14-24.5L804 593.99c10.67-2.87 21.64 3.47 24.5 14.14 2.86 10.67-3.47 21.64-14.14 24.5l-83.13 22.28c-1.74 0.45-3.48 0.68-5.19 0.68z" p-id="2564" fill="#ffffff"></path><path d="M749.4 742.77c-8.83 0-16.91-5.89-19.31-14.83l-23.36-87.19c-2.86-10.67 3.47-21.64 14.14-24.5 10.67-2.86 21.64 3.47 24.5 14.14l23.36 87.19c2.86 10.67-3.47 21.64-14.14 24.5-1.74 0.47-3.48 0.69-5.19 0.69zM608.04 476.57c-6.91 0-13.63-3.59-17.34-10-5.52-9.57-2.25-21.8 7.32-27.32l118.03-68.14c9.56-5.52 21.8-2.25 27.32 7.32s2.25 21.8-7.32 27.32l-118.03 68.14a19.996 19.996 0 0 1-9.98 2.68z" p-id="2565" fill="#ffffff"></path><path d="M726.06 408.42c-1.71 0-3.46-0.22-5.19-0.69-10.67-2.86-17-13.83-14.14-24.49L729 300.11c2.86-10.67 13.83-17.01 24.49-14.14 10.67 2.86 17 13.83 14.14 24.49l-22.27 83.13c-2.39 8.94-10.47 14.83-19.3 14.83z" p-id="2566" fill="#ffffff"></path><path d="M813.25 431.79c-1.71 0-3.46-0.22-5.19-0.69l-87.19-23.36c-10.67-2.86-17-13.83-14.14-24.5 2.86-10.67 13.83-17 24.5-14.14l87.19 23.36c10.67 2.86 17 13.83 14.14 24.5-2.4 8.93-10.48 14.83-19.31 14.83zM512 421.13c-11.05 0-20-8.95-20-20V264.84c0-11.05 8.95-20 20-20s20 8.95 20 20v136.29c0 11.04-8.96 20-20 20z" p-id="2567" fill="#ffffff"></path><path d="M512 284.84c-5.12 0-10.24-1.95-14.14-5.86L437 218.12c-7.81-7.81-7.81-20.47 0-28.28 7.81-7.81 20.47-7.81 28.28 0l60.86 60.86c7.81 7.81 7.81 20.47 0 28.28-3.9 3.91-9.02 5.86-14.14 5.86z" p-id="2568" fill="#ffffff"></path><path d="M512 284.84c-5.12 0-10.24-1.95-14.14-5.86-7.81-7.81-7.81-20.47 0-28.29l63.82-63.82c7.81-7.81 20.47-7.81 28.29 0 7.81 7.81 7.81 20.47 0 28.29l-63.82 63.82a19.943 19.943 0 0 1-14.15 5.86zM415.96 476.57c-3.39 0-6.83-0.86-9.98-2.68l-118.03-68.14c-9.57-5.52-12.84-17.75-7.32-27.32s17.75-12.84 27.32-7.32l118.03 68.14c9.57 5.52 12.84 17.75 7.32 27.32-3.7 6.41-10.43 10-17.34 10z" p-id="2569" fill="#ffffff"></path><path d="M214.81 430.7c-8.83 0-16.91-5.89-19.31-14.83-2.86-10.67 3.47-21.64 14.14-24.5l83.13-22.28c10.67-2.86 21.64 3.47 24.49 14.14 2.86 10.67-3.47 21.64-14.14 24.5L220 430.01c-1.74 0.47-3.48 0.69-5.19 0.69z" p-id="2570" fill="#ffffff"></path><path d="M297.94 408.42c-8.83 0-16.91-5.89-19.31-14.83l-23.36-87.19c-2.86-10.67 3.47-21.64 14.14-24.5 10.67-2.86 21.64 3.47 24.49 14.14l23.36 87.19c2.86 10.67-3.47 21.64-14.14 24.5-1.72 0.47-3.47 0.69-5.18 0.69zM297.97 655.58c-6.91 0-13.63-3.59-17.34-10-5.52-9.57-2.25-21.8 7.32-27.32l118.03-68.14c9.56-5.52 21.8-2.25 27.32 7.32s2.25 21.8-7.32 27.32L307.95 652.9a19.893 19.893 0 0 1-9.98 2.68z" p-id="2571" fill="#ffffff"></path><path d="M275.69 738.72c-1.71 0-3.46-0.22-5.19-0.69-10.67-2.86-17-13.83-14.14-24.5l22.28-83.13c2.86-10.67 13.83-17.01 24.49-14.14 10.67 2.86 17 13.83 14.14 24.5L295 723.89c-2.4 8.93-10.48 14.83-19.31 14.83z" p-id="2572" fill="#ffffff"></path><path d="M297.96 655.58c-1.71 0-3.46-0.22-5.19-0.69l-87.19-23.36c-10.67-2.86-17-13.83-14.14-24.5 2.86-10.67 13.83-17 24.49-14.14l87.19 23.36c10.67 2.86 17 13.83 14.14 24.5-2.38 8.94-10.47 14.83-19.3 14.83z" p-id="2573" fill="#ffffff"></path></svg>',
                    vector(200,200))
            },

        
        
        },
        onload = function ()
        
            local v = vis.onloading.v.ol

            v.gclr_alpha = animate.new(v.gclr_alpha,0,1,v.s)

            if v.gclr_alpha <= 0.01 then
                return
            end

            local screensize = render.screen_size()
            local cscrx,cscry = screensize.x/2,screensize.y/2
         
            render.blur(vector(0,0),vector(screensize.x,screensize.y), 5* v.gclr_alpha, 255* v.gclr_alpha,0)
            render.shadow(vector(cscrx - 123+ 1,cscry  + 250+ 1),vector(cscrx - 123+ 1 + 250,cscry  + 250+ 1 ), color(255,255,255,255 *v.gclr_alpha), 250,20, 1)

            -- renderer.texture(v.icon,cscrx - 1,cscry - 1,600,600,0,0,0,255,'f',0)
            -- renderer.texture(v.icon,cscrx + 1,cscry - 1,600,600,0,0,0,255,'f',0)
            -- renderer.texture(v.icon,cscrx - 1,cscry + 1,600,600,0,0,0,255,'f',0)
            renderer.texture(vis.main_menu.svg.pit,cscrx - 300* v.gclr_alpha + 1,cscry - 350* v.gclr_alpha + 1,600* v.gclr_alpha,600* v.gclr_alpha,0,0,0,255* v.gclr_alpha,'f',0)

            renderer.texture(vis.main_menu.svg.pit,cscrx - 300* v.gclr_alpha, cscry - 350* v.gclr_alpha, 600* v.gclr_alpha, 600* v.gclr_alpha, 126, 159,203,255* v.gclr_alpha,'f',0)
            render.shadow(vector(cscrx, cscry-50), vector(cscrx, cscry-50), color(44,121,178,v.gclr_alpha*255), 1200*v.gclr_alpha, 0, 0)

            local grta = helper.gradient(126,159,203,255,255,255,255,255,'F R I G U S . L U A')

            local t = 'FRIGUS'



            renderer.text(cscrx - 123+ 1,cscry  + 250+ 1,0,0,0,255 * v.gclr_alpha,'+',0,'F R I G U S . L U A')

            renderer.text(cscrx -123,cscry + 250,255,255,255,255 * v.gclr_alpha,'+',0, grta)

            
            renderer.rectangle(cscrx - 121 + 1,cscry + 280 + 1,252* v.gclr_alpha,4,0,0,0,255 * v.gclr_alpha)
            renderer.gradient(cscrx - 121,cscry + 280,252* v.gclr_alpha,4,126,159,203,255* v.gclr_alpha,255,255,255,255* v.gclr_alpha,true)
            if v.t + 4 < globals.realtime then
                v.t = globals.realtime
                v.s = true
            end
        end,

        setup = function ()
            vis.onloading.onload()
        end
    },

    killsay = {
        killtext = {
            "🅂 🄻 🄴 🄴 🄿",
            "𝙂𝙇𝙝𝙛.𝙚𝙭𝙚 𝘼𝙘𝙩𝙞𝙫𝙖𝙩𝙚𝙙",
            "𝐰𝐡𝐚𝐭 𝐲𝐨𝐮 𝐝𝐨 𝐝𝐨𝐠??",
            '真的是你的大脑在控制你吗？',
            "𝟏 𝐰𝐞𝐞𝐤 𝐥𝐨𝐮 𝐝𝐨𝐠𝐠𝐨 𝐨𝐯𝐧𝐞𝐭",
            "有我孤帅哥一半厉害吗？废物",
            "𝟏𝟐𝐩 𝐁𝐎𝐓",
            "𝐰𝐡𝐲 𝐲𝐨𝐮 𝐬𝐥𝐞𝐞𝐩 𝐝𝐨𝐠???",
            "𝐩𝐔𝐫𝐛𝐫𝐚𝐢𝐧 = 𝐝𝐞𝐚𝐝",
            "𝐦_𝐟𝐥𝐔𝐫𝐢𝐪 = 𝟎",
            "𝟏𝟔:𝟎 𝐔𝐑 𝐃𝐎𝐆 𝐒𝐇𝐈𝐓",
            "𝙏𝙊𝙊 𝙀𝘼𝙎𝙔!",
            "𝚂𝙲𝚄𝙼.",
            "𝐮 𝐬𝐡𝐚𝐥𝐥 𝐝𝐢𝐞",
            "𝚂𝚕𝚊𝚢 𝙰𝙻𝙻",
            "𝓑𝓵𝓪𝓼𝓽 𝓞𝓯𝓯!",
            "𝐓𝐡𝐢𝐬 𝐢𝐬 𝐭𝐡𝐞 𝐏𝐎𝐖𝐄𝐑 𝐨𝐟 𝐅𝐑𝐈𝐆𝐔𝐒",
            "𝚌𝚛𝚒𝚗𝚐𝚎",
            "𝙱𝚎 𝚐𝚘𝚗𝚎!",
            "𝐘𝐨𝐮 𝐚𝐫𝐞 𝐠𝐨𝐢𝐧𝐠 𝐝𝐨𝐰𝐧.. 𝐃𝐔𝐒𝐓 𝐓𝐎 𝐃𝐔𝐒𝐓",
            "𝐖𝐡𝐚𝐭 𝐲𝐨𝐮 𝐬𝐚𝐲?",
            "𝐉𝐀𝐂𝐊𝐏𝐎𝐓",
            "𝕮𝖔𝖒𝖊 𝖔𝖓 𝖕𝖚𝖕𝖕𝖞,𝖑𝖊𝖙'𝖘 𝖌𝖔",
            "$$$ 1 𝑻𝑨𝑷 𝑼𝑭𝑭 𝒀𝑨 $$$",
            "0 iq",
            "1",
            "活死人",
            "iq ? HAHAHA",
            "XAXAXAXAXAXA (◣_◢)",
            "𝑭𝑹𝑰𝑮𝑼𝑺当之无愧为𝐍𝐄𝐕𝐄𝐑𝐋𝐎𝐒𝐄最好的脚本",
            "𝔽ℝ𝕀𝔾𝕌𝕊.𝕃𝕌𝔸 ℕ𝕚𝕔𝕖 𝕋𝕠𝕡 𝕠𝕟𝕖",
            "𝔽ℝ𝕀𝔾𝕌𝕊.𝕃𝕌𝔸 𝕋𝕙𝕖 𝕓𝕖𝕤𝕥 𝕒𝕝𝕝-𝕣𝕠𝕦𝕟𝕕 𝕤𝕔𝕣𝕚𝕡𝕥 𝕚𝕟 𝕥𝕙𝕖 𝕨𝕠𝕣𝕝𝕕",
            "Может, тебе стоит взглянуть на свой мозг.",
            "Ты слабый, да?",
            "Слишком медленно. Я всегда на шаг быстрее тебя.",
            "Ты был свиньей в прошлой жизни, тупой!",
            "Ха ха ха ха ха, убей меня!",
            "FRIGUS.LUA, необходимый сценарий для того, чтобы стать сильным",
            "Это было случайное поражение, не так ли?",
            "𝐌𝐚𝐫𝐤𝐞𝐭 𝐬𝐞𝐚𝐫𝐜𝐡 𝐅𝐑𝐈𝐆𝐔𝐒.𝐋𝐔𝐀, 𝐛𝐮𝐲 𝐢𝐭, 𝐭𝐡𝐞 𝐧𝐞𝐱𝐭 𝐬𝐭𝐫𝐨𝐧𝐠𝐞𝐬𝐭 𝐢𝐬 𝐲𝐨𝐮",
        },

        init = function()
            local _first = vis.killsay.killtext[math.random(1, #vis.killsay.killtext)]

            if _first ~= nil  then
                utils.console_exec('say ' .._first)
            end
        end

    },


    model_changer = {

        mt = {
            ["varianta_js"] = "models/player/custom_player/legacy/tm_jumpsuit_variantA.mdl",
            ["variantb_js"] = "models/player/custom_player/legacy/tm_jumpsuit_variantB.mdl",
            ["variantc_js"] = "models/player/custom_player/legacy/tm_jumpsuit_variantC.mdl",
            ["varianta"] = "models/player/custom_player/legacy/tm_pirate_variantA.mdl",
            ["variantb"] = "models/player/custom_player/legacy/tm_pirate_variantB.mdl",
            ["variantc"] = "models/player/custom_player/legacy/tm_pirate_variantC.mdl",
        },


        model_change = function(e)
            local lp = entity.get_local_player()
            if not lp and not lp:is_alive() then return end
            local data_model_index = nil
            local model_index = GetModelIndex(vis.model_changer.mt[lua.uis.misc.model_change_select:get()])
            if lua.uis.misc.model_change_enable:get() and model_index then
                lp["m_nModelIndex"] = model_index
            end
        end

    }
}




eventcall = {
    createmove = function (cmd)
        antiaim.setup(cmd)
        rages.dt()
        rages.strafe_fix()
        if lua.uis.misc.clantag_switch:get() then
            vis.misc_.clantag.run()
        else
            vis.misc_.clantag.remove()
        end
        
        rages.hitchance_modification()
        if globals.choked_commands == 0 then            
            last_sent = current_choke

        end



        current_choke = globals.choked_commands


    end,

    createmove_run = function(cmd)
    end,

    render = function()
        if entity.get_local_player() ~= nil then
            nicetry = (math.floor(math.min(ref.left_limit:get(), entity.get_local_player().m_flPoseParameter[11] * (ref.left_limit:get() * 2) - ref.left_limit:get()))) > 0
        end

        lua.menu.sidebar()
        lua.menu.render_menu_color()
        vis.main_menu.init()
        vis.misc_.init()
        vis.center_indicator.init()
        vis.solus_ui.init()
        vis.rainbow_bar.render()
        vis.hit_marker.draw()
        vis.slowdown_indicator.render()
        vis.manual_indicator.render()
        vis.miss_marker.render()
        vis.onloading.setup()
        notification()

    end,

    bullet_fire = function(e)
  
    end,

    aim_ack = function (e)

        vis.miss_marker.v.Shots[e.id] = {
            Pos = {x = e.aim.x,y = e.aim.y, z = e.aim.z},
            WaitTime    = vis.miss_marker.v._WaitTime,
            FadeTime    = 1,
        }
        if e.state ~= nil then
            local Reason            = string.upper(vis.miss_marker.missr_str[e.state] or e.state)
            vis.miss_marker.v.Shots[e.id].Reason   = Reason == nil and 'nil' or Reason
            vis.miss_marker.v.Shots[e.id].Value    = vis.miss_marker.missvalue[Reason] and  vis.miss_marker.missvalue[Reason](e) or nil
        end

    
        aimbot_log.aim_ack(e)
    end,

    bullet_impact = function (e)
        vis.hit_marker.on_bullet_impact(e)
    end,

    player_spawned = function (e)
        vis.hit_marker.on_player_spawned(e)

    end,


    player_hurt = function (e)


        vis.hit_marker.on_player_hurt(e)


        local me = entity.get_local_player()
        local user = entity.get(e.userid,true)
        if user == me and e.hitgroup ~= 0 then
            if lua.uis.misc.notification_options:get("Log Events") then
                log_paint("\a00FF9FFFReseted data due to player hurt")
                log("\a00FF9FReseted data due to player hurt")
            end

        end
        local attacker = entity.get(e.attacker, true)
        if e.hitgroup ~= 0 and me == attacker then
            if lua.uis.misc.killsay:get() then
                vis.killsay.init()
            end

        end



    end,

    shutdown = function ()
        
        local tone_map_controllers = entity.get_entities("CEnvTonemapController")
        if tone_map_controllers then
            for i, tone_map_controller in pairs(tone_map_controllers) do
                if not tone_map_controller then
                    goto skip
                end
                tone_map_controller["m_bUseCustomAutoExposureMin"] = false
                tone_map_controller["m_bUseCustomAutoExposureMax"] = false
                tone_map_controller["m_flCustomAutoExposureMin"] = 0
                tone_map_controller["m_flCustomAutoExposureMax"] = 0
                tone_map_controller["m_flCustomBloomScale"] = 0
                ::skip::
            end
        end
        cvar.mat_bloom_scalefactor_scalar:float(0,true)
    end,


    net_update_end = function (e)
        vis.model_changer.model_change(e)
    end,


    setup = function()
        events.render:set(eventcall.render)
        events.net_update_end:set(eventcall.net_update_end)
        events.createmove:set(eventcall.createmove)
        events.createmove_run:set(eventcall.createmove_run)
        events.player_hurt:set(eventcall.player_hurt)
        events.aim_ack:set(eventcall.aim_ack)
        events.bullet_impact:set(eventcall.bullet_impact)
        events.player_spawned:set(eventcall.player_spawned)
        events.shutdown:set(eventcall.shutdown)

    end
}
local function aa_enable()
    local r,g,b,a = helper.get_bar_color()
    local text_rainbow = helper.gradient(g,b,r,a,r,g,b,a," FRIGUS.LUA [BETA] AntiAim")
    if lua.uis.sets.master_switch:get() then 
        common.add_notify(text_rainbow, "Anti-Aim Enabled")
    else
        common.add_notify(text_rainbow, "Anti-Aim Shutdown")
    end
end

lua.uis.sets.master_switch:set_callback(aa_enable)

eventcall.setup()

