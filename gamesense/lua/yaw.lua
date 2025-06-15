
local User_HeadBall_Image = render.load_image_from_file("nl\\Dream\\user.png", vector(1920, 1080))--render.LoadImage(Http.Get("https://en.neverlose.cc/static/avatars/" .. Username .. ".png"), vector(1920, 1080))
local Username = common.get_username()
local Screen_Size = render.screen_size()
local Image_Dream = render.load_image_from_file("nl\\Dream\\dream.png", vector(100, 25))--render.LoadImage(Http.Get("https://wmpics.pics/di-EZUY.png"), vector(100, 25))
local Zues_Warning_Icon = render.load_image_from_file("nl\\Dream\\flash.png", vector(300, 300))
local Font = {
    Font_Segoe = render.load_font("Verdana", 10, 'b,r'),
    Font_Verdana = render.load_font("Verdana", 50, 'b'),
    Font_Verdana_Thin = render.load_font("Verdana", 30),
    Font_Comfortaa = render.load_font("nl\\Dream\\pixel.ttf", 20, 'b'),
    Font_Comfortaa2 = render.load_font("nl\\Dream\\pixel.ttf", 10, 'o'),
    Font_Sitka = render.load_font("Verdana", 30, 'b'),
    Font_Impact = render.load_font("nl\\Dream\\impact.ttf", 30),
    Font_System = render.load_font("Verdana", 20, 'b'),
}
--[[Font_Segoe = render.load_font("Segoe UI", 150, 'b,r'),
Font_Verdana = render.load_font("Verdana", 50, 'b'),
Font_Verdana_Thin = render.load_font("Verdana", 30),
Font_Comfortaa = render.load_font("Comfortaa", 20, 'b'),
Font_Sitka = render.load_font("Sitka Small", 100, 'b'),
Font_Impact = render.load_font("Impact", 30),
Font_System = render.load_font("Comic Sans MS", 10, 'b'),]]

local Menu_Default_Color = color(250, 0, 0, 255)
localplayer = entity.get_local_player()
local Reference = {
    Inverter_Ref = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"),
    HS_Ref = ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"),
    DT_Ref = ui.find("Aimbot", "Ragebot", "Main", "Double Tap"),
    BM_Ref = ui.find("Aimbot", "Ragebot", "Safety", "Pistols", "Body Aim"),
    DMG_Ref = ui.find("Aimbot", "Ragebot", "Selection", "Min. Damage"),
    HC_Ref = ui.find("Aimbot", "Ragebot", "Selection", "Hit Chance"),
    FL_Ref = ui.find("Aimbot", "Anti Aim", "Fake Lag", "Limit"),
    Freestand = ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"),

    Yaw_Base = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Base"),
    Yaw_Add = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"),
    Yaw_Modifier = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"),
    --LBY_Mode = ui.find("Aimbot", "Anti Aim", "Fake Angle", "LBY Mode"),
    --Freestanding_Desync = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Freestanding"),
    Fake_Options = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"),

    Pistol_DMG_Ref = ui.find("Aimbot", "Ragebot", "Selection", "Pistols", "Hit Chance"),
    Auto_DMG_Ref = ui.find("Aimbot", "Ragebot", "Selection", "AutoSnipers", "Hit Chance"),
    AWP_DMG_Ref = ui.find("Aimbot", "Ragebot", "Selection", "AWP", "Hit Chance"),
    Scout_DMG_Ref = ui.find("Aimbot", "Ragebot", "Selection", "SSG-08", "Hit Chance"),
    DE_DMG_Ref = ui.find("Aimbot", "Ragebot", "Selection", "Desert Eagle", "Hit Chance"),
    R8_DMG_Ref = ui.find("Aimbot", "Ragebot", "Selection", "R8 Revolver", "Hit Chance"),

    Pistol_HC_Ref = ui.find("Aimbot", "Ragebot", "Selection", "Pistols", "Min. Damage"),
    Auto_HC_Ref = ui.find("Aimbot", "Ragebot", "Selection", "AutoSnipers", "Min. Damage"),
    AWP_HC_Ref = ui.find("Aimbot", "Ragebot", "Selection", "AWP", "Min. Damage"),
    Scout_HC_Ref = ui.find("Aimbot", "Ragebot", "Selection", "SSG-08", "Min. Damage"),
    DE_HC_Ref = ui.find("Aimbot", "Ragebot", "Selection", "Desert Eagle", "Min. Damage"),
    R8_HC_Ref = ui.find("Aimbot", "Ragebot", "Selection", "R8 Revolver", "Min. Damage"),
}

local CVar_Var = {
    SV_Cheats = cvar.sv_cheats,
}

local Override_Var = {
    Override_Flag = false,
    Toggle_Flag_First = true,
    Toggle_Flag_Second = false,
    Another_Flag = 0,
    Inserted = false,
    Dmg = 0,
    Mode = "Toggle"
}
local Binds_Info = {

}

local Tank_AA_Cache = {
    Rotate_Angle_Offset1 = {
        [1] = 30,--25
        [2] = -30,
    },
    Rotate_Angle_Offset2 = {
        [1] = 50,
        [2] = -50,
    },
    Rotate_Angle_Offset3 = {
        [1] = 70,
        [2] = -70,
    },
    Time_Change = 0,
    Control_Value = 1,
    Original_Setting = {
        Fake_Angle = nil,
        Yaw_Add = nil,
        Yaw_Modifier = nil,
        --LBY_Mode = nil,
        --Freestanding_Desync = nil,
    },
    Saved = false,
    Restored = true,
}

local function GetVelocity(player)
    local x_Velocity = player["m_vecVelocity[0]"]
    local y_Velocity = player["m_vecVelocity[1]"]
    local z_Velocity = player["m_vecVelocity[2]"]
    return math.sqrt(x_Velocity * x_Velocity + y_Velocity * y_Velocity + z_Velocity * z_Velocity)

end
localplayer = entity.get_local_player()
local Script_Useful_Function = {
    Table_Contain = function(_table, value)
        for i = 1, #_table do
            if _table[i] == value then
                return true
            end
        end
        return false
    end,

    Check_Visible = function(index_, hitbox)
        for i = 0, hitbox do
            local Hitbox_Pos = index_:GetHitboxCenter(i)
            if index_:IsVisible(Hitbox_Pos) then
                return true
            end
        end
        return false
    end,
    Get_Enemy_Damage = function(index)

        local Enemy_CBase = (entity.GetClientEntity(index)):GetPlayer()
        local Head_Pos = Enemy_CBase:GetHitboxCenter(0)
        local Local_Player = entity.get_local_player()
        local Local_Eye_Pos = Local_Player:get_eye_position()
        local Head_Dmg = common.FireBullet(Local_Player, Local_Eye_Pos, Head_Pos).damage
        return {Head_Dmg, 0}
    end,
    Cal_Distance = function(a, b)
        _X = a.x - b.x
        _Y = a.y - b.y
        _Z = a.z - b.z
        return math.sqrt(_X * _X + _Y * _Y + _Z * _Z)
    end,
    Cal_Distance_2D = function(a, b)
        _X = a.x - b.x
        _Y = a.y - b.y
    
        return math.sqrt(_X * _X + _Y * _Y)
    end,
}
localplayer = entity.get_local_player()
local Script_Function = {
    Check_Binds = function()
        local Binds = ui.get_binds()
        local Write_Binds = {}
        for i = 1, #Binds do
            table.insert(Write_Binds, {
                Name = Binds[i].name ,
                Active = Binds[i].active ,
                Value = Binds[i].value ,
                Mode = Binds[i].mode == 1 and "Hold" or "Toggle"
            })
        end
        return Write_Binds
        --Binds_Info = Write_Binds
    end,
   
    Draw_Rect = function(x, y, len1, len2, width, color1, color2, flag)
        local Box1_Start = nil
        local Box1_End = nil
        local Box2_Start = nil
        local Box2_End = nil
        local Box3_Start = nil
        local Box3_End = nil
        if flag == 1 then
            Box1_Start = vector(x, y)
            Box1_End = vector(x + width, y + width)
            Box2_Start = vector(x + width, y)
            Box2_End = vector(x + width + len1, y + width)
            Box3_Start = vector(x, y + width)
            Box3_End = vector(x + width, y + width + len2)

            render.rect(Box1_Start, Box1_End, color2)
            render.gradient(Box2_Start, Box2_End, color2, color1, color2, color1)
            render.gradient(Box3_Start, Box3_End, color2, color2, color1, color1)
        elseif flag == 2 then
            Box1_Start = vector(x, y)
            Box1_End = vector(x - width, y + width)
            Box2_Start = vector(x - width, y)
            Box2_End = vector(x - width - len1, y + width)
            Box3_Start = vector(x, y + width)
            Box3_End = vector(x - width, y + width + len2)
            render.rect(Box1_Start, Box1_End, color1)
            render.gradient(Box2_Start, Box2_End, color1, color2, color1, color2)
            render.gradient(Box3_Start, Box3_End, color1, color1, color2, color2)
        elseif flag == 3 then
            Box1_Start = vector(x, y)
            Box1_End = vector(x + width, y - width)
            Box2_Start = vector(x + width, y)
            Box2_End = vector(x + width + len1, y - width)
            Box3_Start = vector(x, y - width)
            Box3_End = vector(x + width, y - width - len2)
            render.rect(Box1_Start, Box1_End, color1)
            render.gradient(Box2_Start, Box2_End, color1, color2, color1, color2)
            render.gradient(Box3_Start, Box3_End, color1, color1, color2, color2)
        elseif flag == 4 then
            Box1_Start = vector(x, y)
            Box1_End = vector(x - width, y - width)
            Box2_Start = vector(x - width, y)
            Box2_End = vector(x - width - len1, y - width)
            Box3_Start = vector(x, y - width)
            Box3_End = vector(x - width, y - width - len2)
            render.rect(Box1_Start, Box1_End, color1)
            render.gradient(Box2_Start, Box2_End, color1, color2, color1, color2)
            render.gradient(Box3_Start, Box3_End, color1, color1, color2, color2)
        end
        
    end,


    --Draw_TriFilled = function()
    Draw_Trapezoid = function(x, y, up_len, down_len, height, color)
        render.poly(color, vector(x, y), vector(x + up_len, y), vector(x + down_len, y + height), vector(x, y + height))
    end,
    Calc_Delta = function()
        local desync_rotation = AntiAim.GetFakeRotation()
        local real_rotation = AntiAim.GetCurrentRealRotation()
        local delta_to_draw = math.min(math.abs(real_rotation - desync_rotation) / 2, 60)
        return string.format("%1.f", delta_to_draw)
    end,
    Calc_Reverse_Linear = function(x1, y1, x2, y2, var)
        return ((y2 - y1)/(x2 - x1)) * (var - x1) + y1
    end,
    Get_Zues_Size_Pos = function(Pos, Dist, Size, From_Head)
        local length = Dist*Size
        local width = length *(5/5)
        local Return_Pos = vector(Pos.x - length/2, Pos.y - Dist*From_Head)
        return vector(length, width), Return_Pos
    end,


    Get_Movement_Type = function(localplayer)
        
        local Type
        if (ui.find("Aimbot", "Ragebot", "Main", "Peek Assist")):get() == true then
            Type = "PEEK"
        elseif (ui.find("Aimbot", "Anti Aim", "Misc", "Slow Walk")):get() then
            Type = "SLOWWALK"
        elseif (localplayer["m_flFallVelocity"] ~= 0) or (localplayer["m_fFlags"] == 256 or localplayer["m_fFlags"] == 262) then
            Type = "JUMP"
        elseif localplayer['m_bDucked'] then
            Type = "DUCK"
        else
            Type = "WALK"
        end
        return Type
    end
  
}
maininfo = ui.create("Main", "Info & Config")
rageui =  ui.create("Rage", "Rage")
visual = ui.create("Visual", "Visual")
weaponui = ui.create("Weapons", "Weapons")
miscui = ui.create("Misc", "Misc")
local Script_Data = {
    
    maininfo:label("[+] Welcome to using Dream.lua\n\nOwner: GLshou\n\nAuthor: GLshou"),
    Import = maininfo:button("Info & Config", "Config Import"),
    Export = maininfo:button("Info & Config", "Config Export"),
    
    Rage = {
        
        AA_FL_Menu_Select = rageui:list("Rage Menu Select", { "Anti Aim", "Fake Lag", "Slowwalk & Tank AA"}, 0),



        Tank_AA = rageui:switch("Muti Condition Tank AA", false),
        Slowwalk_Speed_Enable = rageui:switch("Slowwalk Speed Enable", false),
        Slowwalk_Speed = rageui:slider("Slowwalk Speed", 1, 50),


        AntiAim_Mode = rageui:list("AA Mode", {"Stand", "Walk", "Slowwalk", "Duck", "Jump"}, 0),

        
        
        Stand_Fake_Options = rageui:selectable("Stand FakeOptions", "Avoid Overlap", "Jitter", "Randomize Jitter", "Anti Bruteforce"),

        Stand_Modifier = rageui:combo("Stand Yaw Modifier", "Center", "Offset", "Random"),
        Stand_Modifier_offset = rageui:slider("Stand Yaw Modifier Offset", -180, 180),

        Stand_AA_Override_Limit = rageui:switch("Stand Override Limit", false),
        Stand_Limit_AA_Min = rageui:slider("Stand Limit AA Min", 0,  60),
        Stand_Limit_AA_Max = rageui:slider("Stand Limit AA Max", 0, 60),
        Stand_AA_Override_Yaw = rageui:switch("Stand Override Yaw", false),
        Stand_Yaw_AA_Min = rageui:slider("Stand Yaw AA Min",  -180, 180),
        Stand_Yaw_AA_Max = rageui:slider("Stand Yaw AA Max",  -180, 180),



        Walk_Fake_Options = rageui:selectable("Walk FakeOptions", "Avoid Overlap", "Jitter", "Randomize Jitter", "Anti Bruteforce"),

        Walk_Modifier = rageui:combo("Walk Yaw Modifier", "Center", "Offset", "Random"),
        Walk_Modifier_offset = rageui:slider("Walk Yaw Modifier Offset", -180, 180),

        Walk_AA_Override_Limit = rageui:switch("Walk Override Limit", false),
        Walk_Limit_AA_Min = rageui:slider("Walk Limit AA Min", 0, 60),
        Walk_Limit_AA_Max = rageui:slider("Walk Limit AA Max", 0, 60),
        Walk_AA_Override_Yaw = rageui:switch("Walk Override Yaw", false),
        Walk_Yaw_AA_Min = rageui:slider("Walk Yaw AA Min", -180, 180),
        Walk_Yaw_AA_Max = rageui:slider("Walk Yaw AA Max", -180, 180),




        Slowwalk_Fake_Options = rageui:selectable("Slowwalk FakeOptions", "Avoid Overlap", "Jitter", "Randomize Jitter", "Anti Bruteforce"),

        Slowwalk_Modifier = rageui:combo("Slowwalk Yaw Modifier", "Center", "Offset", "Random"),
        Slowwalk_Modifier_offset = rageui:slider("Slowwalk Yaw Modifier Offset", -180, 180),

        Slowwalk_AA_Override_Limit = rageui:switch("Slowwalk Override Limit", false),
        Slowwalk_Limit_AA_Min = rageui:slider("Slowwalk Limit AA Min", 0, 60),
        Slowwalk_Limit_AA_Max = rageui:slider("Slowwalk Limit AA Max", 0, 60),
        Slowwalk_AA_Override_Yaw = rageui:switch("Slowwalk Override Yaw", false),
        Slowwalk_Yaw_AA_Min = rageui:slider("Slowwalk Yaw AA Min", -180, 180),
        Slowwalk_Yaw_AA_Max = rageui:slider("Slowwalk Yaw AA Max", -180, 180),

        Duck_Fake_Options = rageui:selectable("Duck FakeOptions", "Avoid Overlap", "Jitter", "Randomize Jitter", "Anti Bruteforce"),

        Duck_Modifier = rageui:combo("Duck Yaw Modifier", "Center", "Offset", "Random"),
        Duck_Modifier_offset = rageui:slider("Duck Yaw Modifier Offset", -180, 180),

        Duck_AA_Override_Limit = rageui:switch("Duck Override Limit", false),
        Duck_Limit_AA_Min = rageui:slider("Duck Limit AA Min", 0, 60),
        Duck_Limit_AA_Max = rageui:slider("Duck Limit AA Max", 0, 60),
        Duck_AA_Override_Yaw = rageui:switch("Duck Override Yaw", false),
        Duck_Yaw_AA_Min = rageui:slider("Duck Yaw AA Min", -180, 180),
        Duck_Yaw_AA_Max = rageui:slider("Duck Yaw AA Max", -180, 180),



        Jump_Fake_Options = rageui:selectable("Jump FakeOptions", "Avoid Overlap", "Jitter", "Randomize Jitter", "Anti Bruteforce"),

        Jump_Modifier = rageui:combo("Jump Yaw Modifier", "Center", "Offset", "Random"),
        Jump_Modifier_offset = rageui:slider("Jump Yaw Modifier Offset", -180, 180),

        Jump_AA_Override_Limit = rageui:switch("Jump Override Limit", false),
        Jump_Limit_AA_Min = rageui:slider("Jump Limit AA Min", 0, 60),
        Jump_Limit_AA_Max = rageui:slider("Jump Limit AA Max", 0, 60),
        Jump_AA_Override_Yaw = rageui:switch("Jump Override Yaw", false),
        Jump_Yaw_AA_Min = rageui:slider("Jump Yaw AA Min", -180, 180),
        Jump_Yaw_AA_Max = rageui:slider("Jump Yaw AA Max", -180, 180),




        FakeLag_Type = rageui:list("Fakelag Mode", {"Slowwalk", "Walk", "Jump", "Duck", "Stand"}, 0),
        
        Slowwalk_FakeLag_Min = rageui:slider("Slowwalk Limit Min", 0, 14),
        Slowwalk_FakeLag_Max = rageui:slider("Slowwalk Limit Max", 0, 14),

        Walk_FakeLag_Min = rageui:slider("Walk Limit Min", 0, 14),
        Walk_FakeLag_Max = rageui:slider("Walk Limit Max", 0, 14),

        Jump_FakeLag_Min = rageui:slider("Jump Limit Min", 0, 14),
        Jump_FakeLag_Max = rageui:slider("Jump Limit Max", 0, 14),

        Duck_FakeLag_Min = rageui:slider("Duck Limit Min", 0, 14),
        Duck_FakeLag_Max = rageui:slider("Duck Limit Max", 0, 14),

        Stand_FakeLag_Min = rageui:slider("Stand Limit Min", 0, 14),
        Stand_FakeLag_Max = rageui:slider("Stand Limit Max", 0, 14),
   
    },
    Visuals = {
        
        FPS_Boost = visual:switch("FPS Boost", true),

        indic_switch = visual:switch("Crosshair Indicator"),
        indicglow  = visual:switch("Glow"),
        color_pick = visual:color_picker("Main Colour",color(255, 0, 0, 255)),
        color_pick2 = visual:color_picker("Second Colour",color(0, 150, 255, 255)),
        indicspeed = visual:slider("Speed", 1, 5),
        color_pickglow = visual:color_picker("Glow Colour"),
        glowsize = visual:slider("Glow Size", 1, 500),

        
        Left_Indicator = visual:selectable("Left Indicator type", {"HC", "DMG", "DT", "HS", "Config"}, 0),
        Left_Indicator_FL_Color = visual:color_picker("HC Color"),
        Left_Indicator_DMG_Color = visual:color_picker("DMG Color"),
        Left_Indicator_Fake_Color = visual:color_picker("DT Color"),
        Left_Indicator_EXAA_Color = visual:color_picker("HS Color"),
        Left_Indicator_Config_Name = visual:input("Config Name", "Config Name"),
        Left_Indicator_Config_Color = visual:color_picker("Config Color"),
        --Left_Indicator_Config_Color = Menu.

        Info_Panel        = visual:switch("Info Panel"),
        Info_Panel_glow          = visual:switch("Info Panel Glow"),
        Info_Panel_color   = visual:color_picker("Info Panel UI Color", color('7D7DE1FF')),
        
        solus_select = visual:selectable("Solus UI", {'Watermark', 'Keybinds', 'Choke indication', 'Client information'}, 0),
        blur_switch = visual:switch("Solus UI Blur / transp.", false),
        color_picker_solus = visual:color_picker("Solus UI color", color(107, 139, 255, 255)),
        custom_name = visual:input("Solus UI Username", ""..common.get_username()..""),
        
        

        Water_Mark_Setting = visual:switch("Watermark Setting", false),
        Water_Mark_Offset_X = visual:slider("Watermark X", 0, Screen_Size.x),
        Water_Mark_Offset_Y = visual:slider("Watermark Y", 0, Screen_Size.y),
        Water_Mark_Dream = visual:color_picker("Watermark Dream Color", color(1, 1, 1, 255)),
        Water_Mark_Text = visual:color_picker("Watermark text Color", color(1, 1, 1, 255)),
        Water_Mark_Box = visual:color_picker("Watermark Box Color1", color(1, 1, 1, 255)),
        Water_Mark_Box2 = visual:color_picker("Watermark Box color()", color(1, 1, 1, 255)),

        Water_Mark_NL = visual:color_picker("Watermark NL", color(72, 61, 139)),
        Scope_Line = visual:switch("Scope Line", false),
        Scope_Line_Color = visual:color_picker("Scope Line Color"),
        Scope_Line_Length = visual:slider("Scope Line Length", 50, 150),
        Scope_Line_Scape = visual:slider("Scope Line Scape", 20, 100),

        Hit_Effect = visual:switch("Hit Effect", false),
        Hit_Effect_time = visual:slider("Hit Effect time", 0.9,  2),


        aspect_ratio_switch = visual:switch("Aspect ratio", false),
        aspect_ratio_slider = visual:slider("Value", 0, 20, 0, 0.1),
        viewmodel_switch = visual:switch("Viewmodel", false),
        viewmodel_fov = visual:slider("FOV", -100, 100, 68),
        viewmodel_x = visual:slider("X", -10, 10, 2.5),
        viewmodel_y = visual:slider("Y", -10, 10, 0),
        viewmodel_z = visual:slider("Z", -10, 10, -1.5),
        
        

        
        


    },
    
    
    Misc = {
        Clantag = miscui:switch("Clan Tag", false),
        HitLog = miscui:switch("Hit Log", false),

        DT_Enhence = miscui:switch("DT Enhence", false),
        DT_Clock_Correction = miscui:switch("Disable Correction", false),
        DT_Speed = miscui:slider("DT Speed",  13, 18),
        DT_Charge = miscui:switch("Fast Charge", false),
    

    },

    Kill_Man = nil,
    Hit_Man = {

    },
    Draw_Weapon_Setting = nil,
}




local Local_Time =  globals.curtime
function Set_Visible()

    Script_Data.Visuals.FPS_Boost:visibility(false)


    Script_Data.Visuals.Scope_Line_Color:visibility(false)
    Script_Data.Visuals.Scope_Line_Length:visibility(false)
    Script_Data.Visuals.Scope_Line_Scape:visibility(false)

    Script_Data.Visuals.Left_Indicator_Fake_Color:visibility(false)
    Script_Data.Visuals.Left_Indicator_FL_Color:visibility(false)
    Script_Data.Visuals.Left_Indicator_DMG_Color:visibility(false)
    Script_Data.Visuals.Left_Indicator_EXAA_Color:visibility(false)
    Script_Data.Visuals.Left_Indicator_Config_Name:visibility(false)
    Script_Data.Visuals.Left_Indicator_Config_Color:visibility(false)

    Script_Data.Visuals.Hit_Effect_time:visibility(Script_Data.Visuals.Hit_Effect:get())


    Script_Data.Visuals.Info_Panel_color:visibility(Script_Data.Visuals.Info_Panel:get())
    Script_Data.Visuals.Info_Panel_glow:visibility(Script_Data.Visuals.Info_Panel:get())





    Script_Data.Visuals.Water_Mark_Offset_X:visibility(false)
    Script_Data.Visuals.Water_Mark_Offset_Y:visibility(false)
    Script_Data.Visuals.Water_Mark_Dream:visibility(false)
    Script_Data.Visuals.Water_Mark_Text:visibility(false)
    Script_Data.Visuals.Water_Mark_Box:visibility(false)
    Script_Data.Visuals.Water_Mark_Box2:visibility(false)




    Script_Data.Rage.Tank_AA:visibility(false)
    Script_Data.Rage.Slowwalk_Speed_Enable:visibility(false)
    Script_Data.Rage.Slowwalk_Speed:visibility(false)



    Script_Data.Rage.AntiAim_Mode:visibility(false)

    Script_Data.Rage.Stand_Modifier:visibility(false)
    Script_Data.Rage.Stand_Modifier_offset:visibility(false)
    Script_Data.Rage.Stand_AA_Override_Limit:visibility(false)
    Script_Data.Rage.Stand_Limit_AA_Min:visibility(false)
    Script_Data.Rage.Stand_Limit_AA_Max:visibility(false)
    Script_Data.Rage.Stand_AA_Override_Yaw:visibility(false)
    Script_Data.Rage.Stand_Yaw_AA_Min:visibility(false)
    Script_Data.Rage.Stand_Yaw_AA_Max:visibility(false)

    Script_Data.Rage.Walk_Modifier:visibility(false)
    Script_Data.Rage.Walk_Modifier_offset:visibility(false)
    Script_Data.Rage.Walk_AA_Override_Limit:visibility(false)
    Script_Data.Rage.Walk_Limit_AA_Min:visibility(false)
    Script_Data.Rage.Walk_Limit_AA_Max:visibility(false)
    Script_Data.Rage.Walk_AA_Override_Yaw:visibility(false)
    Script_Data.Rage.Walk_Yaw_AA_Min:visibility(false)
    Script_Data.Rage.Walk_Yaw_AA_Max:visibility(false)

    Script_Data.Rage.Slowwalk_Modifier:visibility(false)
    Script_Data.Rage.Slowwalk_Modifier_offset:visibility(false)
    Script_Data.Rage.Slowwalk_AA_Override_Limit:visibility(false)
    Script_Data.Rage.Slowwalk_Limit_AA_Min:visibility(false)
    Script_Data.Rage.Slowwalk_Limit_AA_Max:visibility(false)
    Script_Data.Rage.Slowwalk_AA_Override_Yaw:visibility(false)
    Script_Data.Rage.Slowwalk_Yaw_AA_Min:visibility(false)
    Script_Data.Rage.Slowwalk_Yaw_AA_Max:visibility(false)

    Script_Data.Rage.Duck_Modifier:visibility(false)
    Script_Data.Rage.Duck_Modifier_offset:visibility(false)
    Script_Data.Rage.Duck_AA_Override_Limit:visibility(false)
    Script_Data.Rage.Duck_Limit_AA_Min:visibility(false)
    Script_Data.Rage.Duck_Limit_AA_Max:visibility(false)
    Script_Data.Rage.Duck_AA_Override_Yaw:visibility(false)
    Script_Data.Rage.Duck_Yaw_AA_Min:visibility(false)
    Script_Data.Rage.Duck_Yaw_AA_Max:visibility(false)

    Script_Data.Rage.Jump_Modifier:visibility(false)
    Script_Data.Rage.Jump_Modifier_offset:visibility(false)
    Script_Data.Rage.Jump_AA_Override_Limit:visibility(false)
    Script_Data.Rage.Jump_Limit_AA_Min:visibility(false)
    Script_Data.Rage.Jump_Limit_AA_Max:visibility(false)
    Script_Data.Rage.Jump_AA_Override_Yaw:visibility(false)
    Script_Data.Rage.Jump_Yaw_AA_Min:visibility(false)
    Script_Data.Rage.Jump_Yaw_AA_Max:visibility(false)


    Script_Data.Rage.FakeLag_Type:visibility(false)
    Script_Data.Rage.Slowwalk_FakeLag_Min:visibility(false)
    Script_Data.Rage.Slowwalk_FakeLag_Max:visibility(false)



    Script_Data.Rage.Walk_FakeLag_Min:visibility(false)
    Script_Data.Rage.Walk_FakeLag_Max:visibility(false)


    Script_Data.Rage.Jump_FakeLag_Min:visibility(false)
    Script_Data.Rage.Jump_FakeLag_Max:visibility(false)
    Script_Data.Rage.Duck_FakeLag_Min:visibility(false)
    Script_Data.Rage.Duck_FakeLag_Max:visibility(false)
    Script_Data.Rage.Stand_FakeLag_Min:visibility(false)
    Script_Data.Rage.Stand_FakeLag_Max:visibility(false)


    Script_Data.Rage.Stand_Fake_Options:visibility(false)
    Script_Data.Rage.Walk_Fake_Options:visibility(false)
    Script_Data.Rage.Slowwalk_Fake_Options:visibility(false)
    Script_Data.Rage.Duck_Fake_Options:visibility(false)
    Script_Data.Rage.Jump_Fake_Options:visibility(false)




   




    Script_Data.Misc.DT_Clock_Correction:visibility(false)
    Script_Data.Misc.DT_Speed:visibility(false)
    Script_Data.Misc.DT_Charge:visibility(false)




         if Script_Data.Rage.AA_FL_Menu_Select:get() == 1 then
            Script_Data.Rage.AntiAim_Mode:visibility(true)
            if Script_Data.Rage.AntiAim_Mode:get() == 1 then
    
                Script_Data.Rage.Stand_Fake_Options:visibility(true)
                Script_Data.Rage.Stand_Modifier:visibility(true)
                Script_Data.Rage.Stand_Modifier_offset:visibility(true)
    
                Script_Data.Rage.Stand_AA_Override_Limit:visibility(true)
                if Script_Data.Rage.Stand_AA_Override_Limit:get() then
                    Script_Data.Rage.Stand_Limit_AA_Min:visibility(true)
                    Script_Data.Rage.Stand_Limit_AA_Max:visibility(true)
                end
                Script_Data.Rage.Stand_AA_Override_Yaw:visibility(true)
                if Script_Data.Rage.Stand_AA_Override_Yaw:get() then
                    Script_Data.Rage.Stand_Yaw_AA_Min:visibility(true)
                    Script_Data.Rage.Stand_Yaw_AA_Max:visibility(true)
                end

    
            elseif Script_Data.Rage.AntiAim_Mode:get() == 2 then
                Script_Data.Rage.Walk_Fake_Options:visibility(true)
                Script_Data.Rage.Walk_Modifier:visibility(true)
                Script_Data.Rage.Walk_Modifier_offset:visibility(true)
    
                Script_Data.Rage.Walk_AA_Override_Limit:visibility(true)
                if Script_Data.Rage.Walk_AA_Override_Limit:get() then
                    Script_Data.Rage.Walk_Limit_AA_Min:visibility(true)
                    Script_Data.Rage.Walk_Limit_AA_Max:visibility(true)
                end
                Script_Data.Rage.Walk_AA_Override_Yaw:visibility(true)
                if Script_Data.Rage.Walk_AA_Override_Yaw:get() then
                    Script_Data.Rage.Walk_Yaw_AA_Min:visibility(true)
                    Script_Data.Rage.Walk_Yaw_AA_Max:visibility(true)
                end

            elseif Script_Data.Rage.AntiAim_Mode:get() == 3 then
                Script_Data.Rage.Slowwalk_Fake_Options:visibility(true)
                Script_Data.Rage.Slowwalk_Modifier:visibility(true)
                Script_Data.Rage.Slowwalk_Modifier_offset:visibility(true)
    
                Script_Data.Rage.Slowwalk_AA_Override_Limit:visibility(true)
                if Script_Data.Rage.Slowwalk_AA_Override_Limit:get() then
                    Script_Data.Rage.Slowwalk_Limit_AA_Min:visibility(true)
                    Script_Data.Rage.Slowwalk_Limit_AA_Max:visibility(true)
                end
                Script_Data.Rage.Slowwalk_AA_Override_Yaw:visibility(true)
                if Script_Data.Rage.Slowwalk_AA_Override_Yaw:get() then
                    Script_Data.Rage.Slowwalk_Yaw_AA_Min:visibility(true)
                    Script_Data.Rage.Slowwalk_Yaw_AA_Max:visibility(true)
                end
    
            elseif Script_Data.Rage.AntiAim_Mode:get() == 4 then
                Script_Data.Rage.Duck_Fake_Options:visibility(true)
                Script_Data.Rage.Duck_Modifier:visibility(true)
                Script_Data.Rage.Duck_Modifier_offset:visibility(true)

                Script_Data.Rage.Duck_AA_Override_Limit:visibility(true)
                if Script_Data.Rage.Duck_AA_Override_Limit:get() then
                    Script_Data.Rage.Duck_Limit_AA_Min:visibility(true)
                    Script_Data.Rage.Duck_Limit_AA_Max:visibility(true)
                end
                Script_Data.Rage.Duck_AA_Override_Yaw:visibility(true)
                if Script_Data.Rage.Duck_AA_Override_Yaw:get() then
                    Script_Data.Rage.Duck_Yaw_AA_Min:visibility(true)
                    Script_Data.Rage.Duck_Yaw_AA_Max:visibility(true)
                end
            elseif Script_Data.Rage.AntiAim_Mode:get() == 5 then
                Script_Data.Rage.Jump_Fake_Options:visibility(true)
                Script_Data.Rage.Jump_Modifier:visibility(true)
                Script_Data.Rage.Jump_Modifier_offset:visibility(true)
    
                Script_Data.Rage.Jump_AA_Override_Limit:visibility(true)
                if Script_Data.Rage.Jump_AA_Override_Limit:get() then
                    Script_Data.Rage.Jump_Limit_AA_Min:visibility(true)
                    Script_Data.Rage.Jump_Limit_AA_Max:visibility(true)
                end
                Script_Data.Rage.Jump_AA_Override_Yaw:visibility(true)
                if Script_Data.Rage.Jump_AA_Override_Yaw:get() then
                    Script_Data.Rage.Jump_Yaw_AA_Min:visibility(true)
                    Script_Data.Rage.Jump_Yaw_AA_Max:visibility(true)
                end
        
        
            end
        elseif Script_Data.Rage.AA_FL_Menu_Select:get() == 2 then
    
            Script_Data.Rage.FakeLag_Type:visibility(true)
            if Script_Data.Rage.FakeLag_Type:get() == 1 then
                

 
                    Script_Data.Rage.Slowwalk_FakeLag_Min:visibility(true)
                    Script_Data.Rage.Slowwalk_FakeLag_Max:visibility(true)

    
            elseif Script_Data.Rage.FakeLag_Type:get() == 2 then


                    Script_Data.Rage.Walk_FakeLag_Min:visibility(true)
                    Script_Data.Rage.Walk_FakeLag_Max:visibility(true)

            elseif Script_Data.Rage.FakeLag_Type:get() == 3 then


                    Script_Data.Rage.Jump_FakeLag_Min:visibility(true)
                    Script_Data.Rage.Jump_FakeLag_Max:visibility(true)
             elseif Script_Data.Rage.FakeLag_Type:get() == 4 then


                    Script_Data.Rage.Duck_FakeLag_Min:visibility(true)
                    Script_Data.Rage.Duck_FakeLag_Max:visibility(true)
            elseif Script_Data.Rage.FakeLag_Type:get() == 5 then


                    Script_Data.Rage.Stand_FakeLag_Min:visibility(true)
                    Script_Data.Rage.Stand_FakeLag_Max:visibility(true)

            end
        elseif Script_Data.Rage.AA_FL_Menu_Select:get() == 3 then
            Script_Data.Rage.Tank_AA:visibility(true)
            Script_Data.Rage.Slowwalk_Speed_Enable:visibility(true)
            if Script_Data.Rage.Slowwalk_Speed_Enable:get() then
                Script_Data.Rage.Slowwalk_Speed:visibility(true)
            end
        
        end

        


        if Script_Data.Visuals.Scope_Line:get() then
            Script_Data.Visuals.Scope_Line_Color:visibility(true)
            Script_Data.Visuals.Scope_Line_Length:visibility(true)
            Script_Data.Visuals.Scope_Line_Scape:visibility(true)
        end

        if Script_Data.Visuals.Left_Indicator:get() ~= 0 then
            if Script_Data.Visuals.Left_Indicator:get(1) then
                Script_Data.Visuals.Left_Indicator_FL_Color:visibility(true)
            end
            if Script_Data.Visuals.Left_Indicator:get(2) then
                Script_Data.Visuals.Left_Indicator_DMG_Color:visibility(true)
            end
            if Script_Data.Visuals.Left_Indicator:get(3) then
                Script_Data.Visuals.Left_Indicator_Fake_Color:visibility(true)
            end
            if Script_Data.Visuals.Left_Indicator:get(4) then
                Script_Data.Visuals.Left_Indicator_EXAA_Color:visibility(true)
            end
            if Script_Data.Visuals.Left_Indicator:get(5) then
                Script_Data.Visuals.Left_Indicator_Config_Name:visibility(true)
                Script_Data.Visuals.Left_Indicator_Config_Color:visibility(true)
            end

        end




    
        if Script_Data.Visuals.Water_Mark_Setting:get() then
            Script_Data.Visuals.Water_Mark_Offset_X:visibility(true)
            Script_Data.Visuals.Water_Mark_Offset_Y:visibility(true)
            Script_Data.Visuals.Water_Mark_Dream:visibility(true)
            Script_Data.Visuals.Water_Mark_Text:visibility(true)
            Script_Data.Visuals.Water_Mark_Box:visibility(true)
            Script_Data.Visuals.Water_Mark_Box2:visibility(true)
        end



        if Script_Data.Misc.DT_Enhence:get() then
            Script_Data.Misc.DT_Clock_Correction:visibility(true)
            Script_Data.Misc.DT_Enhence:visibility(true)
            Script_Data.Misc.DT_Speed:visibility(true)
            Script_Data.Misc.DT_Charge:visibility(true)
        end



    ---end
end

--Visuals
--[[function Draw_Water_Mark()
    
    Local_Time = common.get_system_time()
    local Position_X = Script_Data.Visuals.Water_Mark_Offset_X:get()
    local Position_Y = Script_Data.Visuals.Water_Mark_Offset_Y:get()
    

    local System_Time = string.format('%02d%02d', Local_Time.hours, Local_Time.minutes)
    local GetNetChannelInfo_ = utils.net_channel()
    local ping = 0
    local Word_Size = render.measure_text(1, nil,Username .. " | " .. System_Time .. " | " .. tostring(math.floor(ping)) .. "ms", null, Font.Font_Impact)
    if GetNetChannelInfo_ ~= nil then
        local net_chan = utils.net_channel()
        if not net_chan then
          return
        end
        ping = net_chan.latency[0]
    end

    if Position_X >= Screen_Size.x - Word_Size.x - 108 then
        Position_X = Screen_Size.x - Word_Size.x - 108
    end
    if Position_Y >= Screen_Size.y - Word_Size.y - 34 then
        Position_Y = Screen_Size.y - Word_Size.y - 34
    end

    local Color_Dream = Script_Data.Visuals.Water_Mark_Dream:get()
    if Color_Dream.a < 0.5 then
        Color_Dream.a = 0.5
    end
    local Color_Text = Script_Data.Visuals.Water_Mark_Text:get()
    if Color_Text.a < 0.5 then
        Color_Text.a = 0.5
    end
    local Color_Box = Script_Data.Visuals.Water_Mark_Box:get()
    local Color_Box2 = Script_Data.Visuals.Water_Mark_Box2:get()

    --render.blur(vector(Position_X - 10, Position_Y), vector(Position_X - 3 + 70, Position_Y + 25), color(1, 1, 1, 1))
    render.texture(Image_Dream, vector(Position_X - 3, Position_Y), vector(100, 25), Color_Dream)
    local Under_Start_X = Position_X
    local Under_Start_Y = Position_Y + 25
    --under 1
    
    render.blur(vector(Under_Start_X + 100, Position_Y), vector(Under_Start_X + 105 + Word_Size.x, Position_Y + Word_Size.y), 1.0, 10)
    
    render.text(Font.Font_Impact, vector(Under_Start_X + 105, Position_Y), Color_Text, null,Username)
    render.text(Font.Font_Impact, vector(Under_Start_X + 105 + render.measure_text(1, nil,Username, null, Font.Font_Impact).x, Position_Y), Color_Text, null, " | ")
    render.text(Font.Font_Impact, vector(Under_Start_X + 105 + render.measure_text(1, nil,Username .. " | ", null, Font.Font_Impact).x, Position_Y), Color_Text, null, System_Time)
    
    --local ping = GetNetChannelInfo_:GetLatency(0)

    render.text(Font.Font_Impact, vector(Under_Start_X + 105 + render.measure_text(1, nil,Username .. " | " .. System_Time, null, Font.Font_Impact).x, Position_Y), Color_Text, null, " | ")
    render.text(Font.Font_Impact,  vector(Under_Start_X + 105 + render.measure_text(1, nil,Username .. " | " .. System_Time .. " | ", null, Font.Font_Impact).x, Position_Y),  Color_Text, null, tostring(math.floor(ping)) .. "ms")
    
    local Left_Color = color(Color_Box.r, Color_Box.g, Color_Box.b, 0)
    local Right_Color = color(Color_Box.r, Color_Box.g, Color_Box.b, Color_Box.a)

    local Left_Color_ = color(Color_Box2.r, Color_Box2.g, Color_Box2.b, 0)
    local Right_Color_ = color(Color_Box2.r, Color_Box2.g, Color_Box2.b, Color_Box2.a)

    
    render.gradient(vector(Under_Start_X + 15, Under_Start_Y), vector(Under_Start_X + 97, Under_Start_Y + 2), Left_Color, Right_Color, Left_Color, Right_Color)
    render.gradient(vector(Under_Start_X + 97, Under_Start_Y), vector(Under_Start_X + 105 + Word_Size.x, Under_Start_Y + 2), Right_Color, Right_Color, Right_Color, Right_Color)
    
    render.gradient(vector(Under_Start_X + 105 + Word_Size.x, Under_Start_Y + 2), vector(Under_Start_X + 105 + Word_Size.x + 2, Under_Start_Y + 8 - Word_Size.y), Right_Color, Right_Color, Left_Color, Left_Color)
    
    render.gradient(vector(Under_Start_X + 60 + Word_Size.x, Position_Y), vector(Under_Start_X + 100 + Word_Size.x, Position_Y + 2), Right_Color_, Left_Color_, Right_Color_, Left_Color_)
    render.gradient(vector(Under_Start_X + 101, Position_Y), vector(Under_Start_X + 60 + Word_Size.x, Position_Y + 2), Right_Color_, Right_Color_, Right_Color_, Right_Color_)
    render.gradient(vector(Under_Start_X + 99, Position_Y), vector(Under_Start_X + 101, Position_Y - 8 + Word_Size.y), Right_Color_, Right_Color_, Left_Color_, Left_Color_)
    
end]]
function Draw_Water_Mark_NL()
    if Script_Data.Visuals.Water_Mark_NL:get() == false  then
        return
    end
    local Menu_Pos = ui.get_position()
    local Menu_Size = ui.get_size()


    local Text_Size = render.measure_text(1, nil,"Dream.yaw", math.floor(Menu_Size.x/13), Font.Font_Sitka)
    local Text_Start = vector(vector(Menu_Pos.x, Menu_Pos.y - Menu_Size.y/6).x + (vector(Menu_Pos.x + Menu_Size.x, Menu_Pos.y - Menu_Size.y/80).x - vector(Menu_Pos.x, Menu_Pos.y - Menu_Size.y/6).x)/2 - Text_Size.x/2, vector(Menu_Pos.x, Menu_Pos.y - Menu_Size.y/6).y + (vector(Menu_Pos.x + Menu_Size.x, Menu_Pos.y - Menu_Size.y/80).y - vector(Menu_Pos.x, Menu_Pos.y - Menu_Size.y/6).y) / 2 - Text_Size.y/2)
    render.rect(vector(Menu_Pos.x, Menu_Pos.y - Menu_Size.y/6), vector(Menu_Pos.x + Menu_Size.x, Menu_Pos.y - Menu_Size.y/80), color(0, 0, 0, 150/255), 10)

    render.texture(Image_Dream, vector(Text_Start.x , Text_Start.y), vector(200, 50), Script_Data.Visuals.Water_Mark_NL:get())
    

    render.text(Font.Font_System, vector(vector(Menu_Pos.x + Menu_Size.x, Menu_Pos.y - Menu_Size.y/80).x - render.measure_text(1, nil,"Version : 1.2.1", null, Font.Font_System).x - 5, vector(Menu_Pos.x + Menu_Size.x, Menu_Pos.y - Menu_Size.y/80).y - render.measure_text(1, nil,"Version : 1.2.1", 15, Font.Font_System).y - 2), Script_Data.Visuals.Water_Mark_NL:get(), null, "Version : 1.2.1")

end

events.render:set(function()
    if (ui.get_alpha() > 0) then Draw_Water_Mark_NL() end-- or mouse in bounds
end)



--locals
local tween=(function()local a={}local b,c,d,e,f,g,h=math.pow,math.sin,math.cos,math.pi,math.sqrt,math.abs,math.asin;local function i(j,k,l,m)return l*j/m+k end;local function n(j,k,l,m)return l*b(j/m,2)+k end;local function o(j,k,l,m)j=j/m;return-l*j*(j-2)+k end;local function p(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,2)+k end;return-l/2*((j-1)*(j-3)-1)+k end;local function q(j,k,l,m)if j<m/2 then return o(j*2,k,l/2,m)end;return n(j*2-m,k+l/2,l/2,m)end;local function r(j,k,l,m)return l*b(j/m,3)+k end;local function s(j,k,l,m)return l*(b(j/m-1,3)+1)+k end;local function t(j,k,l,m)j=j/m*2;if j<1 then return l/2*j*j*j+k end;j=j-2;return l/2*(j*j*j+2)+k end;local function u(j,k,l,m)if j<m/2 then return s(j*2,k,l/2,m)end;return r(j*2-m,k+l/2,l/2,m)end;local function v(j,k,l,m)return l*b(j/m,4)+k end;local function w(j,k,l,m)return-l*(b(j/m-1,4)-1)+k end;local function x(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,4)+k end;return-l/2*(b(j-2,4)-2)+k end;local function y(j,k,l,m)if j<m/2 then return w(j*2,k,l/2,m)end;return v(j*2-m,k+l/2,l/2,m)end;local function z(j,k,l,m)return l*b(j/m,5)+k end;local function A(j,k,l,m)return l*(b(j/m-1,5)+1)+k end;local function B(j,k,l,m)j=j/m*2;if j<1 then return l/2*b(j,5)+k end;return l/2*(b(j-2,5)+2)+k end;local function C(j,k,l,m)if j<m/2 then return A(j*2,k,l/2,m)end;return z(j*2-m,k+l/2,l/2,m)end;local function D(j,k,l,m)return-l*d(j/m*e/2)+l+k end;local function E(j,k,l,m)return l*c(j/m*e/2)+k end;local function F(j,k,l,m)return-l/2*(d(e*j/m)-1)+k end;local function G(j,k,l,m)if j<m/2 then return E(j*2,k,l/2,m)end;return D(j*2-m,k+l/2,l/2,m)end;local function H(j,k,l,m)if j==0 then return k end;return l*b(2,10*(j/m-1))+k-l*0.001 end;local function I(j,k,l,m)if j==m then return k+l end;return l*1.001*(-b(2,-10*j/m)+1)+k end;local function J(j,k,l,m)if j==0 then return k end;if j==m then return k+l end;j=j/m*2;if j<1 then return l/2*b(2,10*(j-1))+k-l*0.0005 end;return l/2*1.0005*(-b(2,-10*(j-1))+2)+k end;local function K(j,k,l,m)if j<m/2 then return I(j*2,k,l/2,m)end;return H(j*2-m,k+l/2,l/2,m)end;local function L(j,k,l,m)return-l*(f(1-b(j/m,2))-1)+k end;local function M(j,k,l,m)return l*f(1-b(j/m-1,2))+k end;local function N(j,k,l,m)j=j/m*2;if j<1 then return-l/2*(f(1-j*j)-1)+k end;j=j-2;return l/2*(f(1-j*j)+1)+k end;local function O(j,k,l,m)if j<m/2 then return M(j*2,k,l/2,m)end;return L(j*2-m,k+l/2,l/2,m)end;local function P(Q,R,l,m)Q,R=Q or m*0.3,R or 0;if R<g(l)then return Q,l,Q/4 end;return Q,R,Q/(2*e)*h(l/R)end;local function S(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m;if j==1 then return k+l end;Q,R,T=P(Q,R,l,m)j=j-1;return-(R*b(2,10*j)*c((j*m-T)*2*e/Q))+k end;local function U(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m;if j==1 then return k+l end;Q,R,T=P(Q,R,l,m)return R*b(2,-10*j)*c((j*m-T)*2*e/Q)+l+k end;local function V(j,k,l,m,R,Q)local T;if j==0 then return k end;j=j/m*2;if j==2 then return k+l end;Q,R,T=P(Q,R,l,m)j=j-1;if j<0 then return-0.5*R*b(2,10*j)*c((j*m-T)*2*e/Q)+k end;return R*b(2,-10*j)*c((j*m-T)*2*e/Q)*0.5+l+k end;local function W(j,k,l,m,R,Q)if j<m/2 then return U(j*2,k,l/2,m,R,Q)end;return S(j*2-m,k+l/2,l/2,m,R,Q)end;local function X(j,k,l,m,T)T=T or 1.70158;j=j/m;return l*j*j*((T+1)*j-T)+k end;local function Y(j,k,l,m,T)T=T or 1.70158;j=j/m-1;return l*(j*j*((T+1)*j+T)+1)+k end;local function Z(j,k,l,m,T)T=(T or 1.70158)*1.525;j=j/m*2;if j<1 then return l/2*j*j*((T+1)*j-T)+k end;j=j-2;return l/2*(j*j*((T+1)*j+T)+2)+k end;local function _(j,k,l,m,T)if j<m/2 then return Y(j*2,k,l/2,m,T)end;return X(j*2-m,k+l/2,l/2,m,T)end;local function a0(j,k,l,m)j=j/m;if j<1/2.75 then return l*7.5625*j*j+k end;if j<2/2.75 then j=j-1.5/2.75;return l*(7.5625*j*j+0.75)+k elseif j<2.5/2.75 then j=j-2.25/2.75;return l*(7.5625*j*j+0.9375)+k end;j=j-2.625/2.75;return l*(7.5625*j*j+0.984375)+k end;local function a1(j,k,l,m)return l-a0(m-j,0,l,m)+k end;local function a2(j,k,l,m)if j<m/2 then return a1(j*2,0,l,m)*0.5+k end;return a0(j*2-m,0,l,m)*0.5+l*.5+k end;local function a3(j,k,l,m)if j<m/2 then return a0(j*2,k,l/2,m)end;return a1(j*2-m,k+l/2,l/2,m)end;a.easing={linear=i,inQuad=n,outQuad=o,inOutQuad=p,outInQuad=q,inCubic=r,outCubic=s,inOutCubic=t,outInCubic=u,inQuart=v,outQuart=w,inOutQuart=x,outInQuart=y,inQuint=z,outQuint=A,inOutQuint=B,outInQuint=C,inSine=D,outSine=E,inOutSine=F,outInSine=G,inExpo=H,outExpo=I,inOutExpo=J,outInExpo=K,inCirc=L,outCirc=M,inOutCirc=N,outInCirc=O,inElastic=S,outElastic=U,inOutElastic=V,outInElastic=W,inBack=X,outBack=Y,inOutBack=Z,outInBack=_,inBounce=a1,outBounce=a0,inOutBounce=a2,outInBounce=a3}local function a4(a5,a6,a7)a7=a7 or a6;local a8=getmetatable(a6)if a8 and getmetatable(a5)==nil then setmetatable(a5,a8)end;for a9,aa in pairs(a6)do if type(aa)=="table"then a5[a9]=a4({},aa,a7[a9])else a5[a9]=a7[a9]end end;return a5 end;local function ab(ac,ad,ae)ae=ae or{}local af,ag;for a9,ah in pairs(ad)do af,ag=type(ah),a4({},ae)table.insert(ag,tostring(a9))if af=="number"then assert(type(ac[a9])=="number","Parameter '"..table.concat(ag,"/").."' is missing from subject or isn't a number")elseif af=="table"then ab(ac[a9],ah,ag)else assert(af=="number","Parameter '"..table.concat(ag,"/").."' must be a number or table of numbers")end end end;local function ai(aj,ac,ad,ak)assert(type(aj)=="number"and aj>0,"duration must be a positive number. Was "..tostring(aj))local al=type(ac)assert(al=="table"or al=="userdata","subject must be a table or userdata. Was "..tostring(ac))assert(type(ad)=="table","target must be a table. Was "..tostring(ad))assert(type(ak)=="function","easing must be a function. Was "..tostring(ak))ab(ac,ad)end;local function am(ak)ak=ak or"linear"if type(ak)=="string"then local an=ak;ak=a.easing[an]if type(ak)~="function"then error("The easing function name '"..an.."' is invalid")end end;return ak end;local function ao(ac,ad,ap,aq,aj,ak)local j,k,l,m;for a9,aa in pairs(ad)do if type(aa)=="table"then ao(ac[a9],aa,ap[a9],aq,aj,ak)else j,k,l,m=aq,ap[a9],aa-ap[a9],aj;ac[a9]=ak(j,k,l,m)end end end;local ar={}local as={__index=ar}function ar:set(aq)assert(type(aq)=="number","clock must be a positive number or 0")self.initial=self.initial or a4({},self.target,self.subject)self.clock=aq;if self.clock<=0 then self.clock=0;a4(self.subject,self.initial)elseif self.clock>=self.duration then self.clock=self.duration;a4(self.subject,self.target)else ao(self.subject,self.target,self.initial,self.clock,self.duration,self.easing)end;return self.clock>=self.duration end;function ar:reset()return self:set(0)end;function ar:update(at)assert(type(at)=="number","dt must be a number")return self:set(self.clock+at)end;function a.new(aj,ac,ad,ak)ak=am(ak)ai(aj,ac,ad,ak)return setmetatable({duration=aj,subject=ac,target=ad,easing=ak,clock=0},as)end;return a end)()
local tween_table = {}
local tween_data = {
    kb_alpha = 0,
    wm_alpha = 0
}
local refs = {
    dt = ui.find("Aimbot", "Ragebot", "Main", "Double Tap"),
    fl = ui.find("Aimbot", "Anti Aim", "Fake Lag", "Limit"),
    hs = ui.find("Aimbot", "Ragebot", "Main", "Hide Shots")
}

--main
function tween_updater()
    for _, t in pairs(tween_table) do
        t:update(globals.frametime)
    end
end
events.render:set(tween_updater)

--watermark
function watermark()
    if Script_Data.Visuals.solus_select:get('Watermark') then
    local x,y = render.screen_size().x, render.screen_size().y
    local lp = entity.get_local_player()

    local net = utils.net_channel()
    local time = common.get_system_time()
    local time_text = string.format('%02d:%02d', time.hours, time.minutes)

    local maximum_off = 28
    local text_w = render.measure_text(1, nil, "Dream.yaw  "..Script_Data.Visuals.custom_name:get().."  "..time_text.."").x - 30
    maximum_off = maximum_off < text_w and text_w or maximum_off
    local w = 108 - maximum_off

    render.gradient(vector(x - 165 - 2 + w, y/60 - 6 - 2), vector(x - 7 + 2, y/60 + 16 + 2), color(Script_Data.Visuals.color_picker_solus:get().r, Script_Data.Visuals.color_picker_solus:get().g, Script_Data.Visuals.color_picker_solus:get().b, 255), color(Script_Data.Visuals.color_picker_solus:get().r, Script_Data.Visuals.color_picker_solus:get().g, Script_Data.Visuals.color_picker_solus:get().b, 255), color(0, 0, 0, 0), color(0, 0, 0, 0), 7)

    if Script_Data.Visuals.blur_switch:get() then
        render.blur(vector(x - 165 + w, y/60 - 6), vector(x - 7, y/60 + 16), 10, 1, 7)
    else
        render.rect(vector(x - 165 + w, y/60 - 6), vector(x - 7, y/60 + 16), color(0, 0, 0, 190), 7)
    end

    --render.rect(vector(x - 165 + w, y/2 1005 - 6), vector(x - 7, y/2 1002 + 16), color(0, 0, 0, 190), 7)

    --render.rect(vector(x/1.09 - 5, y/60 - 6), vector(x/1.09 + 153, y/60 + 16), color(0, 0, 0, 190), 7)
    --render.rect(vector(x - 18, y - 35), vector(x + 18, y + 35), color(0, 0, 0, 255), 7)

    render.text(1, vector(x - 150 - 5 + w, y/60 - 2), color(255, 255, 255, 255), nil, "Dream      ")
    render.text(1, vector(x - 127 + w, y/60 - 2), color(Script_Data.Visuals.color_picker_solus:get().r, Script_Data.Visuals.color_picker_solus:get().g, Script_Data.Visuals.color_picker_solus:get().b, 255), nil, ".yaw")
    render.text(1, vector(x - 150 - 5 + w + render.measure_text(1, nil, "Dream.yaw  ").x, y/60 - 2), color(255, 255, 255, 255), nil, ""..Script_Data.Visuals.custom_name:get().." ")
    render.text(1, vector(x - 150 - 5 + w + render.measure_text(1, nil, "Dream.yaw  "..Script_Data.Visuals.custom_name:get().."").x, y/60 - 2), color(255, 255, 255, 255), nil, "  "..time_text.."")
end
end
events.render:set(watermark)

--fakelag
-- // wwe3#0001 bestie
current_choke = 0
function choke()
    local lp = entity.get_local_player()
    if lp == nil then return end
    current_choke = globals.choked_commands
    utils.execute_after(0.4, choke)
end
utils.execute_after(0.4, choke)


function statepanel()
    if Script_Data.Visuals.solus_select:get('Choke indication') then
    local x,y = render.screen_size().x, render.screen_size().y
    local lp = entity.get_local_player()
    if lp == nil then return end
    local maximum_off = 0
    local net = utils.net_channel()
    local maximum_off = 28
    current_fl = current_choke

    if refs.dt:get() or refs.hs:get() then
        text = '  FL: '..current_fl..' | SHIFTING'
        maximum_off = 60
    else
        text = 'FL: '..current_fl..''
        maximum_off = 115
    end

    local text_w = render.measure_text(1, "c", ""..text.."").x - 30
    maximum_off = maximum_off < text_w and text_w or maximum_off
    local w = 108 - maximum_off

    --render.rect(vector(x - 165 + w, y/60 - 6), vector(x - 7, y/60 + 16), color(0, 0, 0, 190), 7)

    tween_table.wm_alpha = tween.new(0.25, tween_data, {wm_alpha = w}, 'outCubic');w = tween_data.wm_alpha

    if Script_Data.Visuals.solus_select:get('Watermark') then

    if refs.dt:get() or refs.hs:get() or current_fl < 1 then
        render.gradient(vector(x - 60 - 2 - w, y/22 - 6 - 2), vector(x - 7 + 2, y/22 + 16 + 2), color(250, 95, 95, 125), color(0, 0, 0, 0), color(250, 95, 95, 125), color(0, 0, 0, 0), 7)
        render.gradient(vector(x - 60 - 2 - w, y/22 - 6 - 2), vector(x - 7 + 2, y/22 + 16 + 2), color(0, 0, 0, 0), color(0, 0, 0, 0), color(0, 0, 0, 0), color(250, 95, 95, 125), 7)
    else

        render.gradient(vector(x - 60 - 2 - w, y/22 - 6 - 2), vector(x - 7 + 2, y/22 + 16 + 2), color(110, 250, 95, 125), color(0, 0, 0, 0), color(110, 250, 95, 125), color(0, 0, 0, 0), 7)
    end

    if Script_Data.Visuals.blur_switch:get() then
        render.blur(vector(x - 60 - w, y/22 - 6), vector(x - 7, y/22 + 16), 10, 1, 7)
    else
        render.rect(vector(x - 60 - w, y/22 - 6), vector(x - 7, y/22 + 16), color(0, 0, 0, 190), 7)
    end

   if refs.dt:get() or refs.hs:get() then
        render.text(1, vector(x - 52 - 8, y/22 + 4), color(255, 255, 255, 255), "c", ""..text.."")
    else
        render.text(1, vector(x - 52 + 23, y/22 + 4), color(255, 255, 255, 255), "c", ""..text.."")
    end

    else

    if refs.dt:get() or refs.hs:get() or current_fl < 1 then
        render.gradient(vector(x - 59 - 2 - w, y/60 - 6 - 2), vector(x - 7 + 2, y/60 + 16 + 2), color(250, 95, 95, 125), color(0, 0, 0, 0), color(250, 95, 95, 125), color(0, 0, 0, 0), 7)
        render.gradient(vector(x - 59 - 2 - w, y/60 - 6 - 2), vector(x - 7 + 2, y/60 + 16 + 2), color(0, 0, 0, 0), color(0, 0, 0, 0),color(0, 0, 0, 0), color(250, 95, 95, 125), 7)
        else
        render.gradient(vector(x - 59 - 2 - w, y/60 - 6 - 2), vector(x - 7 + 2, y/60 + 16 + 2), color(110, 250, 95, 125), color(0, 0, 0, 0), color(110, 250, 95, 125), color(0, 0, 0, 0), 7)
        end

        render.rect(vector(x - 59 - w, y/60 - 6), vector(x - 7, y/60 + 16), color(0, 0, 0, 190), 7)
        if refs.dt:get() or refs.hs:get() then
            render.text(1, vector(x - 52 - 8, y/60 + 4), color(255, 255, 255, 255), "c", ""..text.."")
        else
            render.text(1, vector(x - 52 + 23, y/60 + 4), color(255, 255, 255, 255), "c", ""..text.."")
        end

    end

end
end
events.render:set(statepanel)
--
function desync_delta()
    local desync_rotation = rage.antiaim:get_rotation()
    local delta_to_draw = math.min(math.abs(desync_rotation) / 2, 60)
    return string.format("%.1f", delta_to_draw)
end
--
jmp_ecx = utils.opcode_scan('engine.dll', 'FF E1')
fnGetModuleHandle = ffi.cast('uint32_t(__fastcall*)(unsigned int, unsigned int, const char*)', jmp_ecx)
fnGetProcAddress = ffi.cast('uint32_t(__fastcall*)(unsigned int, unsigned int, uint32_t, const char*)', jmp_ecx)
pGetProcAddress = ffi.cast('uint32_t**', ffi.cast('uint32_t', utils.opcode_scan('engine.dll', 'FF 15 ? ? ? ? A3 ? ? ? ? EB 05')) + 2)[0][0]
pGetModuleHandle = ffi.cast('uint32_t**', ffi.cast('uint32_t', utils.opcode_scan('engine.dll', 'FF 15 ? ? ? ? 85 C0 74 0B')) + 2)[0][0]
function BindExports(sModuleName, sFunctionName, sTypeOf)
    local ctype = ffi.typeof(sTypeOf)
    return function(...)
        return ffi.cast(ctype, jmp_ecx)(fnGetProcAddress(pGetProcAddress, 0, fnGetModuleHandle(pGetModuleHandle, 0, sModuleName), sFunctionName), 0, ...)
    end
end
fnEnumDisplaySettingsA = BindExports('user32.dll', 'EnumDisplaySettingsA', 'int(__fastcall*)(unsigned int, unsigned int, unsigned int, unsigned long, void*)');
pLpDevMode = ffi.new('struct { char pad_0[120]; unsigned long dmDisplayFrequency; char pad_2[32]; }[1]')
fnEnumDisplaySettingsA(0, 4294967295, pLpDevMode[0])


function iopanel()
    if Script_Data.Visuals.solus_select:get('Client information') then
    local x,y = render.screen_size().x, render.screen_size().y
    local lp = entity.get_local_player()
    if lp == nil then return end

    local net = utils.net_channel()
    local ping = net.avg_latency[0]
    local time = common.get_system_time()
    local time_text = string.format('%02d:%02d', time.hours, time.minutes)
    local frequency = pLpDevMode[0].dmDisplayFrequency
    local ping = math.floor(net.avg_latency[0] * 1000)

    --vector(x - 60 - 2 - w, y/60 - 6 - 2), vector(x - 7 + 2, y/60 + 16 + 2)

    if Script_Data.Visuals.solus_select:get('Watermark') and Script_Data.Visuals.solus_select:get('Choke indication') then

    if ping < 100 then
        render.gradient(vector(x - 95 - 2, y/13 - 6 - 2), vector(x - 7 + 2, y/13 + 16 + 2), color(110, 250, 95, 125), color(0, 0, 0, 0), color(110, 250, 95, 125), color(0, 0, 0, 0), 7)
    end
    if ping > 50 then
        render.gradient(vector(x - 95 - 2, y/13 - 6 - 2), vector(x - 7 + 2, y/13 + 16 + 2), color(255, 244, 87, 125), color(0, 0, 0, 0), color(255, 244, 87, 125), color(0, 0, 0, 0), 7)
    end

    if Script_Data.Visuals.blur_switch:get() then
        render.blur(vector(x - 95, y/13 - 6), vector(x - 7, y/13 + 16), 10, 1, 7)
    else
        render.rect(vector(x - 95, y/13 - 6), vector(x - 7, y/13 + 16), color(0, 0, 0, 190), 7)
    end
    render.text(1, vector(x - 50, y/13 + 4), color(255, 255, 255, 255), "c", ""..ping.."ms | "..frequency.."hz")

    else


    if ping < 100 then
        render.gradient(vector(x - 95 - 2, y/21 - 6 - 2), vector(x - 7 + 2, y/21 + 16 + 2), color(110, 250, 95, 125), color(0, 0, 0, 0), color(110, 250, 95, 125), color(0, 0, 0, 0), 7)
    end
    if ping > 50 then
        render.gradient(vector(x - 95 - 2, y/21 - 6 - 2), vector(x - 7 + 2, y/21 + 16 + 2), color(255, 244, 87, 125), color(0, 0, 0, 0), color(255, 244, 87, 125), color(0, 0, 0, 0), 7)
    end

    if Script_Data.Visuals.blur_switch:get() then
        render.blur(vector(x - 95, y/21 - 6), vector(x - 7, y/21 + 16), 10, 1, 7)
    else
        render.rect(vector(x - 95, y/21 - 6), vector(x - 7, y/21 + 16), color(0, 0, 0, 190), 7)
    end

    render.text(1, vector(x - 50, y/21 + 4), color(255, 255, 255, 255), "c", ""..ping.."ms | "..frequency.."hz")

    --[[if refs.dt:get() or refs.hs:get() then
        render.text(1, vector(x - 52 - 8, y/60 + 4), color(255, 255, 255, 255), "c", ""..text.."")
    else
        render.text(1, vector(x - 52 + 23, y/60 + 4), color(255, 255, 255, 255), "c", ""..text.."")
    end--]]

    end
end
end
events.render:set(iopanel)

--keybinds
local animations = {

	speed = 9.2,
	stored_values = {},
	active_this_frame = {},
	prev_realtime = globals.realtime,
    realtime = globals.realtime,
    multiplier = 0.0,


    clamp = function(v, min, max)
		return ((v > max) and max) or ((v < min) and min or v)
	end,


    new_frame = function(self)
    	self.prev_realtime = self.realtime
        self.realtime = globals.realtime
        self.multiplier = (self.realtime - self.prev_realtime) * self.speed

        for k, v in pairs(self.stored_values) do
            if self.active_this_frame[k] ~= nil then goto continue end
			self.stored_values[k] = nil
			::continue::
        end

        self.active_this_frame = {}
    end,
    reset = function(self, name)
        self.stored_values[name] = nil
    end,


    animate = function (self, name, decrement, max_value)
        max_value = max_value or 1.0
		decrement = decrement or false

        local frames = self.multiplier * (decrement and -1 or 1)

		local v = self.clamp(self.stored_values[name] and self.stored_values[name] or 0.0, 0.0, max_value)
        v = self.clamp(v + frames, 0.0, max_value)

        self.stored_values[name] = v
        self.active_this_frame[name] = true

        return v
    end
}

local memory = { x, y }
local drag_items = {
    x_slider = visual:slider("X position", 0, 2560, 50.0, 0.01),
    y_slider= visual:slider("Y position", 0, 1440, 50.0, 0.01)
}
drag_items.x_slider:visibility(false)
drag_items.y_slider:visibility(false)

local drag_window = function(x, y, w, h, val1, val2)
    local key_pressed  = common.is_button_down(0x01);
    local mouse_pos    = ui.get_mouse_position()

    if mouse_pos.x >= x and mouse_pos.x <= x + w and mouse_pos.y >= y and mouse_pos.y <= y + h then
        if key_pressed and drag == false then
            drag = true;
            memory.x = x - mouse_pos.x;
            memory.y = y - mouse_pos.y;
        end
    end

    if not key_pressed then
        drag = false;
    end

    if drag == true and ui.get_alpha() == 1 then
        val1:set(mouse_pos.x + memory.x);
        val2:set(mouse_pos.y + memory.y);
    end
end

local function render_conteiner(x, y, w, h, name, font_size, font, alpha)
    if Script_Data.Visuals.solus_select:get('Keybinds') then
    local alpha2 = (alpha/350)
    local name_size = render.measure_text(1, nil, name)

    if Script_Data.Visuals.blur_switch:get() then
        render.gradient(vector(x + 1 - 2, y - 4 - 2), vector(x + w + 1 + 2, y + h - 3), color(Script_Data.Visuals.color_picker_solus:get().r, Script_Data.Visuals.color_picker_solus:get().g, Script_Data.Visuals.color_picker_solus:get().b, alpha), color(Script_Data.Visuals.color_picker_solus:get().r, Script_Data.Visuals.color_picker_solus:get().g, Script_Data.Visuals.color_picker_solus:get().b, alpha), color(0, 0, 0, alpha*0), color(0, 0, 0, alpha*0), 7)
        render.blur(vector(x + 1, y - 4), vector(x + w + 2, y + h - 1.5), 10, alpha*1, 7)
    else
        render.gradient(vector(x + 1 - 2, y - 4 - 2), vector(x + w + 1 + 2, y + h + 2), color(Script_Data.Visuals.color_picker_solus:get().r, Script_Data.Visuals.color_picker_solus:get().g, Script_Data.Visuals.color_picker_solus:get().b, alpha), color(Script_Data.Visuals.color_picker_solus:get().r, Script_Data.Visuals.color_picker_solus:get().g, Script_Data.Visuals.color_picker_solus:get().b, alpha), color(0, 0, 0, alpha*0), color(0, 0, 0, alpha*0), 7)
        render.rect(vector(x + 1, y - 4), vector(x + w + 1, y + h - 1.5), color(0, 0, 0, alpha/1.4), 7)
    end

    render.text(1, vector(x-1 + w / 2 + 1 - name_size.x / 2, y - 1.5), color(255, 255, 255, alpha), nil, name)
    end
end


local function keybinds()
    if Script_Data.Visuals.solus_select:get('Keybinds') then
    animations:new_frame()
    local binds = ui.get_binds()
    local j = 0
    local m_alpha = 0
    local maximum_offset = 28
    local kb_shown = false

    for i = 1, #binds do
        local c_name = binds[i].name
        if c_name == 'Peek Assist' then c_name = 'Quick peek' end
        if c_name == 'Edge Jump' then c_name = 'Jump at edge' end
        if c_name == 'Hide Shots' then c_name = 'Hide shots' end
        if c_name == 'Minimum Damage' then c_name = 'Damage override' end
        if c_name == 'Fake Latency' then c_name = 'Ping spike' end
        if c_name == 'Fake Duck' then c_name = 'Duck peek assist' end
        if c_name == 'Safe Points' then c_name = 'Safe point' end
        if c_name == 'Body Aim' then c_name = 'Body aim' end
        if c_name == 'Yaw Base' then c_name = 'Manual override' end
        if c_name == 'Slow Walk' then c_name = 'Slow motion' end

        local text_width = render.measure_text(1, nil, c_name).x - 30

        if binds[i].active then
            kb_shown = true
            maximum_offset = maximum_offset < text_width and text_width or maximum_offset
        end
    end

    local w = 90 + maximum_offset
    local x,y = drag_items.x_slider:get(), drag_items.y_slider:get()

    m_alpha = animations:animate('state', not (kb_shown or ui.get_alpha() == 1))
    tween_table.kb_alpha = tween.new(0.25, tween_data, {kb_alpha = w}, 'outCubic');w = tween_data.kb_alpha

    render_conteiner(x-1, y, w, 17, 'keybinds', 11, 1, math.floor(tonumber(m_alpha*255)))
    --Render.BoxFilled(vector(x, y), vector(x + w, y + 18), Color.new(0,0,0,1*m_alpha))
    --Render.BoxFilled(vector(x, y), vector(x + w, y + 2), Color.new(173/255, 249/255, 1,1*m_alpha))

    --Render.Text(' ' .. 'keybinds', vector(x - Render.CalcTextSize('keybinds', 11, font).x / 2 + w/2, y + 4), Color.new(1.0, 1.0, 1.0, 1*m_alpha), 11, 1, false)

    for i=1, #binds do
        local alpha = animations:animate(binds[i].name, not binds[i].active)
        local get_mode = binds[i].mode == 1 and '[holding]' or (binds[i].mode == 2 and '[toggled]') or '[?]'

        local c_name = binds[i].name
        if c_name == 'Peek Assist' then c_name = 'Quick peek' end
        if c_name == 'Edge Jump' then c_name = 'Jump at edge' end
        if c_name == 'Hide Shots' then c_name = 'Hide shots' end
        if c_name == 'Minimum Damage' then c_name = 'Damage override' end
        if c_name == 'Fake Latency' then c_name = 'Ping spike' end
        if c_name == 'Fake Duck' then c_name = 'Duck peek assist' end
        if c_name == 'Safe Points' then c_name = 'Safe point' end
        if c_name == 'Body Aim' then c_name = 'Body aim' end
        if c_name == 'Double Tap' then c_name = 'Double tap' end
        if c_name == 'Yaw Base' then c_name = 'Manual override' end
        if c_name == 'Slow Walk' then c_name = 'Slow motion' end


        local get_value = binds[i].value
        if c_name == 'Damage override' or c_name == 'Ping spike' then
            render.text(1, vector(x + 2, y + 18 + j), color(255, 255, 255, alpha*255), nil, c_name)
            render.text(1, vector(x - 12 + w - render.measure_text(1, nil, get_value).x , y + 18 + j), color(255, 255, 255, alpha*255), nil, "["..get_value.."]")
        else
            render.text(1, vector(x + 2, y + 18 + j), color(255, 255, 255, alpha*255), nil, c_name)
            render.text(1, vector(x - 2 + w - render.measure_text(1, nil, get_mode).x , y + 18 + j), color(255, 255, 255, alpha*255), nil, '' .. get_mode)
        end

        j = j + 15*alpha
        ::skip::
    end

    drag_window(x, y, 150, 25, drag_items.x_slider, drag_items.y_slider)
end
end
events.render:set(keybinds)

function Draw_Water_Mark()
    if not Script_Data.Visuals.Water_Mark_Setting:get() then return end
    
    local Position_X = Script_Data.Visuals.Water_Mark_Offset_X:get()
    local Position_Y = Script_Data.Visuals.Water_Mark_Offset_Y:get()
    
    Local_Time = common.get_system_time()
    local System_Time = string.format("%02d:%02d:%02d", Local_Time.hours, Local_Time.minutes, Local_Time.seconds)
    local GetNetChannelInfo_ = utils.net_channel()
    local ping = 0
    if GetNetChannelInfo_ ~= nil then
        ping = GetNetChannelInfo_.latency[1]
    end
    local Word_Size = render.measure_text(Font.Font_Impact, null,Username .. " | " .. System_Time .. " | " .. tostring(math.floor(ping)) .. "ms", 100)


    if Position_X >= Screen_Size.x - Word_Size.x - 108 then
        Position_X = Screen_Size.x - Word_Size.x - 108
    end
    if Position_Y >= Screen_Size.y - Word_Size.y - 34 then
        Position_Y = Screen_Size.y - Word_Size.y - 34
    end

    local Color_Dream = Script_Data.Visuals.Water_Mark_Dream:get()
    if Color_Dream.a < 0.5 then
        Color_Dream.a = 0.5
    end
    local Color_Text = Script_Data.Visuals.Water_Mark_Text:get()
    if Color_Text.a < 0.5 then
        Color_Text.a = 0.5
    end
    local Color_Box = Script_Data.Visuals.Water_Mark_Box:get()
    local Color_Box2 = Script_Data.Visuals.Water_Mark_Box2:get()

    --render.blur(vector(Position_X - 10, Position_Y), vector(Position_X - 3 + 70, Position_Y + 25), color(1, 1, 1, 1))
    render.texture(Image_Dream, vector(Position_X - 3, Position_Y), vector(100, 25), Color_Dream)
    local Under_Start_X = Position_X
    local Under_Start_Y = Position_Y + 25
    --under 1
    
    render.blur(vector(Under_Start_X + 100, Position_Y), vector(Under_Start_X + 105 + Word_Size.x, Position_Y + Word_Size.y), 1.0, 10)
    
    render.text(Font.Font_Impact, vector(Under_Start_X + 105, Position_Y), Color_Text, null,Username)
    render.text(Font.Font_Impact, vector(Under_Start_X + 400, Position_Y), Color_Text, null, " | ")
    render.text(Font.Font_Impact, vector(Under_Start_X + 410, Position_Y), Color_Text, null, System_Time)
    render.text(Font.Font_Impact, vector(Under_Start_X + 515, Position_Y), Color_Text, null, " | ")
    render.text(Font.Font_Impact, vector(Under_Start_X + 525, Position_Y), Color_Text, null, tostring(math.floor(ping)) .. "ms")
    --local ping = GetNetChannelInfo_:GetLatency(0)


    local Left_Color = color(Color_Box.r, Color_Box.g, Color_Box.b, 0)
    local Right_Color = color(Color_Box.r, Color_Box.g, Color_Box.b, Color_Box.a)

    local Left_Color_ = color(Color_Box2.r, Color_Box2.g, Color_Box2.b, 0)
    local Right_Color_ = color(Color_Box2.r, Color_Box2.g, Color_Box2.b, Color_Box2.a)

    
    render.gradient(vector(Under_Start_X + 15, Under_Start_Y), vector(Under_Start_X + 97, Under_Start_Y + 2), Left_Color, Right_Color, Left_Color, Right_Color)
    render.gradient(vector(Under_Start_X + 97, Under_Start_Y), vector(Under_Start_X + 105 + Word_Size.x, Under_Start_Y + 2), Right_Color, Right_Color, Right_Color, Right_Color)
    
    render.gradient(vector(Under_Start_X + 105 + Word_Size.x, Under_Start_Y + 2), vector(Under_Start_X + 105 + Word_Size.x + 2, Under_Start_Y + 8 - Word_Size.y), Right_Color, Right_Color, Left_Color, Left_Color)
    
    render.gradient(vector(Under_Start_X + 60 + Word_Size.x, Position_Y), vector(Under_Start_X + 100 + Word_Size.x, Position_Y + 2), Right_Color_, Left_Color_, Right_Color_, Left_Color_)
    render.gradient(vector(Under_Start_X + 101, Position_Y), vector(Under_Start_X + 60 + Word_Size.x, Position_Y + 2), Right_Color_, Right_Color_, Right_Color_, Right_Color_)
    render.gradient(vector(Under_Start_X + 99, Position_Y), vector(Under_Start_X + 101, Position_Y - 8 + Word_Size.y), Right_Color_, Right_Color_, Left_Color_, Left_Color_)
    
end


local old_time = 0
function Draw_ClanTag()
    local Dream_Tag = { 
        "Dream ",
        "ream D",
        "eam Dr",
        "am Dre",
        "m Drea",
        "Dream ",
    }
    if Script_Data.Misc.Clantag:get() then
        local curtime = math.floor(globals.curtime * 3)
        if old_time ~= curtime then
            common.set_clan_tag(Dream_Tag[curtime % #Dream_Tag + 1], Dream_Tag[curtime % #Dream_Tag + 1])
        end
        old_time = curtime
    end
end





local renderer, fonts = {}, {feature = render.load_font('Calibri', vector(24, 24, 0), 'ba')}
local renderer = {
    indicator = function(r, g, b, a, string, xtazst)
        if (string == nil or string == '' or string == ' ') then return end
        render.gradient(vector(13, render.screen_size().y - 350 - xtazst * 37), vector(13 + (render.measure_text(fonts.feature, '', string).x / 2), (render.screen_size().y - 345 - xtazst * 37) + 28), color(0, 0, 0, 0), color(0, 0, 0, 60), color(0, 0, 0, 0), color(0, 0, 0, 60), 0)
        render.gradient(vector(13 + (render.measure_text(fonts.feature, '', string).x), render.screen_size().y - 350 - xtazst * 37), vector(13 + (render.measure_text(fonts.feature, '', string).x / 2), (render.screen_size().y - 345 - xtazst * 37) + 28), color(0, 0, 0, 0), color(0, 0, 0, 60), color(0, 0, 0, 0), color(0, 0, 0, 60), 0)

        render.text(fonts.feature, vector(20, (render.screen_size().y - 343) - xtazst * 37), color(0, 0, 0, 150), '', string)
        render.text(fonts.feature, vector(19, (render.screen_size().y - 344) - xtazst * 37), color(r, g, b, a), '', string)
    end
}


events.render:set(function()
    local xtazst = 0
    local localplayer = entity.get_local_player()
    if not localplayer then return end


    







  

      if Script_Data.Visuals.Left_Indicator:get(5)  then
        renderer.indicator(Script_Data.Visuals.Left_Indicator_Config_Color:get().r, Script_Data.Visuals.Left_Indicator_Config_Color:get().g, Script_Data.Visuals.Left_Indicator_Config_Color:get().b, Script_Data.Visuals.Left_Indicator_Config_Color:get().a, Script_Data.Visuals.Left_Indicator_Config_Name:get(), xtazst)
        xtazst = xtazst + 1
      end

      if Script_Data.Visuals.Left_Indicator:get(4) and Reference.HS_Ref:get() then
        renderer.indicator(Script_Data.Visuals.Left_Indicator_EXAA_Color:get().r, Script_Data.Visuals.Left_Indicator_EXAA_Color:get().g, Script_Data.Visuals.Left_Indicator_EXAA_Color:get().b, Script_Data.Visuals.Left_Indicator_EXAA_Color:get().a, 'ONSHOT', xtazst)
        xtazst = xtazst + 1
      end

      if Script_Data.Visuals.Left_Indicator:get(3) and Reference.DT_Ref:get() then
        if (rage.exploit:get() == 1) then
            renderer.indicator(Script_Data.Visuals.Left_Indicator_Fake_Color:get().r, Script_Data.Visuals.Left_Indicator_Fake_Color:get().b, Script_Data.Visuals.Left_Indicator_Fake_Color:get().g, Script_Data.Visuals.Left_Indicator_Fake_Color:get().a, 'DT', xtazst)
        else
            renderer.indicator(255, 0, 50, 255, 'DT', xtazst)
        end
        xtazst = xtazst + 1
      end

      if Script_Data.Visuals.Left_Indicator:get(2) then
        renderer.indicator(Script_Data.Visuals.Left_Indicator_DMG_Color:get().r, Script_Data.Visuals.Left_Indicator_DMG_Color:get().g, Script_Data.Visuals.Left_Indicator_DMG_Color:get().b, Script_Data.Visuals.Left_Indicator_DMG_Color:get().a, string.format("DMG: %s", Reference.DMG_Ref:get()), xtazst)
        xtazst = xtazst + 1
       end
       
       if Script_Data.Visuals.Left_Indicator:get(1) then
        renderer.indicator(Script_Data.Visuals.Left_Indicator_FL_Color:get().r, Script_Data.Visuals.Left_Indicator_FL_Color:get().g, Script_Data.Visuals.Left_Indicator_FL_Color:get().b, Script_Data.Visuals.Left_Indicator_FL_Color:get().a, string.format("HC: %s", Reference.HC_Ref:get()), xtazst)
        xtazst = xtazst + 1
      end

end)


events.player_death:set(function(e)
    local attacker = entity.get(e.attacker, true)
    me = entity.get_local_player()
    
    if Script_Data.Visuals.Hit_Effect:get() then 
        
    if me == attacker then
        me.m_flHealthShotBoostExpirationTime = globals.curtime + Script_Data.Visuals.Hit_Effect_time:get() 
    end
  

    end
end)

local MTools = require("neverlose/mtools") -- used for rendering




-- Gets your country code from your ip
local ip            = network.get('http://ip-api.com/json/?fields=61439')
local ip_parse      = json.parse(ip)
local countrycode   = ip_parse["countryCode"]

-- Downloads flag for your country code
local flag      = network.get('https://www.countryflagicons.com/FLAT/64/' .. countrycode .. '.png')
local flagimg   = render.load_image(flag, vector(35, 35))

-- Panel Function
local function panel()
    local lp = entity.get_local_player()
    if not lp or not lp:is_alive() or not Script_Data.Visuals.Info_Panel:get() then return end
    local screen            = render.screen_size()
    local username_length   = render.measure_text(Font.Font_Segoe, nil, common.get_username()).x
    local luaname           = 'Dream'
    local text1_length      = render.measure_text(Font.Font_Segoe, nil, "> " .. luaname)

    if Script_Data.Visuals.Info_Panel_glow:get() then
        MTools.Render.Box_Outline_Glow(
            { 
                vector(2, screen.y / 2 + 43), vector(10 + 90 + username_length + 24, screen.y / 2 + 78)
            },
            color(Script_Data.Visuals.Info_Panel_color:get().r, Script_Data.Visuals.Info_Panel_color:get().g, Script_Data.Visuals.Info_Panel_color:get().b, Script_Data.Visuals.Info_Panel_color:get().a),
            65,
            7.5
        );
    end

    MTools.Render.Modern.Box_Outline(
        { 
            vector(2, screen.y / 2 + 43), vector(10 + 90 + username_length + 24, screen.y / 2 + 78)
        },
        {
            5, 5, 
            5, 5, 
        },
        color(Script_Data.Visuals.Info_Panel_color:get().r, Script_Data.Visuals.Info_Panel_color:get().g, Script_Data.Visuals.Info_Panel_color:get().b, Script_Data.Visuals.Info_Panel_color:get().a),
        1.25
    );

    render.text(Font.Font_Segoe, vector(10 + 36, screen.y / 2 + 48), color(255, 255, 255, 255), nil, "> " .. luaname)
    render.text(Font.Font_Segoe, vector(10 + 36 + text1_length.x, screen.y / 2 + 48), color(Script_Data.Visuals.Info_Panel_color:get().r, Script_Data.Visuals.Info_Panel_color:get().g, Script_Data.Visuals.Info_Panel_color:get().b, 255), nil, ".Yaw")
    render.text(Font.Font_Segoe, vector(10 + 36, screen.y / 2 + 60), color(255, 255, 255, 255), nil, "> " .. common.get_username() .. " - [Debug]")
    render.texture(flagimg, vector(10 - 2, screen.y / 2 + 43), vector(35, 35), color(255, 255, 255, 255), 'f', 3)
end

events.render:set(panel)


screen = render.screen_size()
anim_num = 0
lerp = function(a, b, t)
    return a + (b - a) * t
end

events.render:set(function()
  lp = entity.get_local_player()
  if not globals.is_in_game then
    return
  end
  if not lp:is_alive() then
    return
  end

    local_player = entity.get_local_player()
    if not local_player or not local_player:is_alive() or not local_player.m_bIsScoped then
        anim_num = lerp(anim_num, 0, 10 * globals.frametime)
    else
        anim_num = lerp(anim_num, 1, 10 * globals.frametime)
    end
    offset = Script_Data.Visuals.Scope_Line_Scape:get() * anim_num
    length = Script_Data.Visuals.Scope_Line_Length:get() * anim_num

    width = 1

    start_x = screen.x / 2
    start_y = screen.y / 2
    if Script_Data.Visuals.Scope_Line:get() then
        ui.find("Visuals", "World", "Main", "Override Zoom", "Scope Overlay"):override("Remove All")
        if not local_player or not local_player:is_alive() then return end

        render.gradient(vector(start_x - offset - length, start_y + width), vector(start_x - offset, start_y),    Script_Data.Visuals.Scope_Line_Color:get(), color(Script_Data.Visuals.Scope_Line_Color:get().r,Script_Data.Visuals.Scope_Line_Color:get().g,Script_Data.Visuals.Scope_Line_Color:get().b,20), Script_Data.Visuals.Scope_Line_Color:get(), color(Script_Data.Visuals.Scope_Line_Color:get().r,Script_Data.Visuals.Scope_Line_Color:get().g,Script_Data.Visuals.Scope_Line_Color:get().b,20))
        render.gradient(vector(start_x + offset + length, start_y + width), vector(start_x + offset + 1, start_y), Script_Data.Visuals.Scope_Line_Color:get(),  color(Script_Data.Visuals.Scope_Line_Color:get().r,Script_Data.Visuals.Scope_Line_Color:get().g,Script_Data.Visuals.Scope_Line_Color:get().b,20), Script_Data.Visuals.Scope_Line_Color:get(), color(Script_Data.Visuals.Scope_Line_Color:get().r,Script_Data.Visuals.Scope_Line_Color:get().g,Script_Data.Visuals.Scope_Line_Color:get().b,20))
        render.gradient(vector(start_x + width, start_y + offset + length), vector(start_x, start_y + offset),  Script_Data.Visuals.Scope_Line_Color:get(), Script_Data.Visuals.Scope_Line_Color:get(), color(Script_Data.Visuals.Scope_Line_Color:get().r,Script_Data.Visuals.Scope_Line_Color:get().g,Script_Data.Visuals.Scope_Line_Color:get().b,20),  color(Script_Data.Visuals.Scope_Line_Color:get().r,Script_Data.Visuals.Scope_Line_Color:get().g,Script_Data.Visuals.Scope_Line_Color:get().b,20))
        render.gradient(vector(start_x + width, start_y - offset - length), vector(start_x, start_y - offset), Script_Data.Visuals.Scope_Line_Color:get(),  Script_Data.Visuals.Scope_Line_Color:get(), color(Script_Data.Visuals.Scope_Line_Color:get().r,Script_Data.Visuals.Scope_Line_Color:get().g,Script_Data.Visuals.Scope_Line_Color:get().b,20),  color(Script_Data.Visuals.Scope_Line_Color:get().r,Script_Data.Visuals.Scope_Line_Color:get().g,Script_Data.Visuals.Scope_Line_Color:get().b,20))

    else
        ui.find("Visuals", "World", "Main", "Override Zoom", "Scope Overlay"):override()
    end
end)

--refs
FakeLatency = ui.find("Miscellaneous", "Main", "Other", "Fake Latency")
bodyaim = ui.find("Aimbot", "Ragebot", "Safety", "Body Aim")
sp = ui.find("Aimbot", "Ragebot", "Safety", "Safe Points")
da = ui.find("Aimbot", "Ragebot", "Main", "Enabled", "Dormant Aimbot")
overrideresolver = ui.find("Aimbot", "Ragebot", "Main", "Enabled", "Override Resolver")
isDMG = ui.find("Aimbot", "Ragebot", "Selection", "Min. Damage")
fov = ui.find("Aimbot","Ragebot","Main","Field Of View")
enble = ui.find("Aimbot","Ragebot","Main","Enabled")
aw = ui.find("Aimbot","Ragebot","Selection","Penetrate Walls")
antiaimswitch = ui.find("Aimbot", "Anti Aim", "Angles", "enabled")
isFS = ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding")
isFD = ui.find("Aimbot", "Anti Aim", "Misc", "Fake Duck")
isroll = ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles")
hitc = ui.find("Aimbot", "Ragebot", "Selection", "Hit Chance")
hscale = ui.find("Aimbot", "Ragebot", "Selection", "Multipoint", "Head Scale")
bscale = ui.find("Aimbot", "Ragebot", "Selection", "Multipoint", "Body Scale")
doubletap = ui.find("Aimbot", "Ragebot", "Main", "Double Tap")
onshot = ui.find("Aimbot", "Ragebot", "Main", "Hide Shots")
scope_overlay = ui.find("Visuals", "World", "Main", "Override Zoom", "Scope Overlay")
antiuntrust = ui.find('Miscellaneous',"Main","Other",'Anti Untrusted')
weaponactions = ui.find('Miscellaneous',"Main","Other",'Weapon Actions')
BodyYawInverter = ui.find("aimbot", "anti aim", "angles", "body yaw", "inverter")
invert = ui.find("aimbot", "anti aim", "angles", "body yaw", "inverter")
FakeLagSwitch = ui.find("aimbot", "anti aim", "fake lag", "enabled")
FakeLagLimit = ui.find("aimbot", "anti aim", "fake lag", "limit")
FakeLagVariability = ui.find("aimbot", "anti aim", "fake lag", "variability")
Pitch = ui.find("aimbot", "anti aim", "angles", "pitch")
Yaw = ui.find("aimbot", "anti aim", "angles", "yaw")
YawBase = ui.find("aimbot", "anti aim", "angles", "yaw", "base")
YawOffset = ui.find("aimbot", "anti aim", "angles", "yaw", "offset")
YawBackstab = ui.find("aimbot", "anti aim", "angles", "yaw", "avoid backstab")
YawModifier = ui.find("aimbot", "anti aim", "angles", "yaw modifier")
YawModifierOffset = ui.find("aimbot", "anti aim", "angles", "yaw modifier", "offset")
BodyYaw = ui.find("aimbot", "anti aim", "angles", "body yaw")
BodyYawLeftLimit = ui.find("aimbot", "anti aim", "angles", "body yaw", "left limit")
BodyYawRightLimit = ui.find("aimbot", "anti aim", "angles", "body yaw", "right limit")
BodyYawOptions = ui.find("aimbot", "anti aim", "angles", "body yaw", "options")
BodyYawFreestanding = ui.find("aimbot", "anti aim", "angles", "body yaw", "freestanding")
Freestanding = ui.find("aimbot", "anti aim", "angles", "freestanding")
FreestandingDisableYaw = ui.find("aimbot", "anti aim", "angles", "freestanding", "disable yaw modifiers")
FreestandingBody = ui.find("aimbot", "anti aim", "angles", "freestanding", "body freestanding")
Roll = ui.find("aimbot", "anti aim", "angles", "extended angles")
RollExtendedPitch = ui.find("aimbot", "anti aim", "angles", "extended angles", "extended pitch")
RollExtendedRoll = ui.find("aimbot", "anti aim", "angles", "extended angles", "extended roll")
legmovement = ui.find("Aimbot", "Anti Aim", "Misc", "Leg Movement")
logev = ui.find('Miscellaneous',"Main","Other",'Log Events')
slowwalk = ui.find("Aimbot", "Anti Aim", "Misc", "Slow Walk")
dt_menu = ui.find("Aimbot", "Ragebot", "Main", "Double Tap")
qp_menu = ui.find("Aimbot", "Ragebot", "Main", "Peek Assist")
lo_menu = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Lag Options")
fl_menu = ui.find("Aimbot", "Anti Aim", "Fake Lag", "Limit")
md_menu = ui.find("Aimbot", "Ragebot", "Selection", "Min. Damage")
hc_menu = ui.find("Aimbot", "Ragebot", "Selection", "Hit Chance")
lagoptions = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Lag Options")
fklimitondt = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Fake Lag Limit")
asoptions = ui.find("Aimbot", "Ragebot", "Accuracy", "Auto Stop", "Options")
asdtoptions = ui.find("Aimbot", "Ragebot", "Accuracy", "Auto Stop", "Double Tap")
weaponchams = ui.find("Visuals", "Players", "Self", "Chams", "Weapon")
weaponchamsstyle = ui.find("Visuals", "Players", "Self", "Chams", "Weapon", "Style")
chamsoutline = ui.find("Visuals", "Players", "Self", "Chams", "Weapon", "Outline")
chamsbrightness = ui.find("Visuals", "Players", "Self", "Chams", "Weapon", "Brightness")
chamsfill = ui.find("Visuals", "Players", "Self", "Chams", "Weapon", "Fill")
chamscolour = ui.find("Visuals", "Players", "Self", "Chams", "Weapon", "Color")
weaponchamsstylecolor,chamscolor = ui.find("Visuals", "Players", "Self", "Chams", "Weapon", "Style")
hiddenoption = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Hidden")
hitboxes = ui.find("Aimbot", "Ragebot", "Selection", "Hitboxes")
multipoint = ui.find("Aimbot", "Ragebot", "Selection", "Multipoint")
air_strafe = ui.find("Miscellaneous", "Main", "Movement", "Air Strafe")







events.createmove:set(function()
    if Script_Data.Visuals.aspect_ratio_switch:get() then
        cvar.r_aspectratio:float(Script_Data.Visuals.aspect_ratio_slider:get()/10)
    else
        cvar.r_aspectratio:float(0)
    end
end)

events.createmove:set(function()
    if Script_Data.Visuals.viewmodel_switch:get() then
        cvar.viewmodel_fov:int(Script_Data.Visuals.viewmodel_fov:get(), true)
        cvar.viewmodel_offset_x:float(Script_Data.Visuals.viewmodel_x:get(), true)
        cvar.viewmodel_offset_y:float(Script_Data.Visuals.viewmodel_y:get(), true)
        cvar.viewmodel_offset_z:float(Script_Data.Visuals.viewmodel_z:get(), true)
    else
        cvar.viewmodel_fov:int(68)
        cvar.viewmodel_offset_x:float(2.5)
        cvar.viewmodel_offset_y:float(0)
        cvar.viewmodel_offset_z:float(-1.5)
    end
end)

events.shutdown:set(function()
    cvar.viewmodel_fov:int(68)
    cvar.viewmodel_offset_x:float(2.5)
    cvar.viewmodel_offset_y:float(0)
    cvar.viewmodel_offset_z:float(-1.5)
end)

    
conditionaa = ""
events.createmove:set(function()

  lp = entity.get_local_player()
  if not globals.is_in_game then
    return
  end
  if not lp:is_alive() then
    return
  end
  movement = lp:get_anim_state()
  isDuck = movement.anim_duck_amount 
  isJump = movement.duration_in_air 
  speed2 = lp['m_vecVelocity[2]']
  speed1 = lp['m_vecVelocity[1]']
  speed0 = lp['m_vecVelocity[0]']
  isMoving = math.sqrt(speed1 * speed1 + speed2 * speed2 + speed0 * speed0)

if Script_Data.Rage.Tank_AA:get() then
    conditionaa = "FAKEDUCK"
    Pitch:override("Down")
    YawBase:override("At Target")
    Yaw:override("Backward")
    BodyYaw:override(true)
    YawModifier:override("Center")
    YawModifierOffset:override(-80)
    YawOffset:override(10)
    BodyYawLeftLimit:override(60)
    BodyYawRightLimit:override(60)
    BodyYawOptions:override("Jitter")
    FakeLagSwitch:override(true)
    FakeLagLimit:override(14)
else




  if isFD:get() then
    conditionaa = "FAKEDUCK"
    Pitch:set("Down")
    YawBase:set("At Target")
    Yaw:set("Backward")
    BodyYaw:set(true)
    YawModifier:set(Script_Data.Rage.Duck_Modifier:get())
    YawModifierOffset:set(Script_Data.Rage.Duck_Modifier_offset:get())
    if Script_Data.Rage.Duck_AA_Override_Yaw:get() then
        YawOffset:set(math.random(Script_Data.Rage.Duck_Yaw_AA_Min:get(),Script_Data.Rage.Duck_Yaw_AA_Max:get()))
    end
    if Script_Data.Rage.Duck_AA_Override_Limit:get() then
      BodyYawLeftLimit:set(math.random(Script_Data.Rage.Duck_Limit_AA_Min:get(),Script_Data.Rage.Duck_Limit_AA_Max:get()))
      BodyYawRightLimit:set(math.random(Script_Data.Rage.Duck_Limit_AA_Min:get(),Script_Data.Rage.Duck_Limit_AA_Max:get()))
    end
    BodyYawOptions:set(Script_Data.Rage.Duck_Fake_Options:get())
    FakeLagSwitch:set(true)
    FakeLagLimit:set(math.random(Script_Data.Rage.Duck_FakeLag_Max:get(),Script_Data.Rage.Duck_FakeLag_Min:get()))
  else
    if slowwalk:get() then
        conditionaa = "SLOWWALK"
        Pitch:set("Down")
        YawBase:set("At Target")
        Yaw:set("Backward")
        BodyYaw:set(true)
        YawModifier:set(Script_Data.Rage.Slowwalk_Modifier:get())
        YawModifierOffset:set(Script_Data.Rage.Slowwalk_Modifier_offset:get())
        if Script_Data.Rage.Slowwalk_AA_Override_Yaw:get() then
            YawOffset:set(math.random(Script_Data.Rage.Slowwalk_Yaw_AA_Min:get(),Script_Data.Rage.Slowwalk_Yaw_AA_Max:get()))
        end
        if Script_Data.Rage.Slowwalk_AA_Override_Limit:get() then
          BodyYawLeftLimit:set(math.random(Script_Data.Rage.Slowwalk_Limit_AA_Min:get(),Script_Data.Rage.Slowwalk_Limit_AA_Max:get()))
          BodyYawRightLimit:set(math.random(Script_Data.Rage.Slowwalk_Limit_AA_Min:get(),Script_Data.Rage.Slowwalk_Limit_AA_Max:get()))
        end
        BodyYawOptions:set(Script_Data.Rage.Slowwalk_Fake_Options:get())
        FakeLagSwitch:set(true)
        FakeLagLimit:set(math.random(Script_Data.Rage.Slowwalk_FakeLag_Max:get(),Script_Data.Rage.Slowwalk_FakeLag_Min:get()))
    else
      if isDuck == 1 then
        if isJump ~= 0 then
            conditionaa = "JUMP"
            Pitch:set("Down")
            YawBase:set("At Target")
            Yaw:set("Backward")
            BodyYaw:set(true)
            YawModifier:set(Script_Data.Rage.Jump_Modifier:get())
            YawModifierOffset:set(Script_Data.Rage.Jump_Modifier_offset:get())
            if Script_Data.Rage.Jump_AA_Override_Yaw:get() then
                YawOffset:set(math.random(Script_Data.Rage.Jump_Yaw_AA_Min:get(),Script_Data.Rage.Jump_Yaw_AA_Max:get()))
            end
            if Script_Data.Rage.Jump_AA_Override_Limit:get() then
              BodyYawLeftLimit:set(math.random(Script_Data.Rage.Jump_Limit_AA_Min:get(),Script_Data.Rage.Jump_Limit_AA_Max:get()))
              BodyYawRightLimit:set(math.random(Script_Data.Rage.Jump_Limit_AA_Min:get(),Script_Data.Rage.Jump_Limit_AA_Max:get()))
            end
            BodyYawOptions:set(Script_Data.Rage.Jump_Fake_Options:get())
            FakeLagSwitch:set(true)
            FakeLagLimit:set(math.random(Script_Data.Rage.Jump_FakeLag_Max:get(),Script_Data.Rage.Jump_FakeLag_Min:get()))
        else
            conditionaa = "DUCK"
            Pitch:set("Down")
            YawBase:set("At Target")
            Yaw:set("Backward")
            BodyYaw:set(true)
            YawModifier:set(Script_Data.Rage.Duck_Modifier:get())
            YawModifierOffset:set(Script_Data.Rage.Duck_Modifier_offset:get())
            if Script_Data.Rage.Duck_AA_Override_Yaw:get() then
                YawOffset:set(math.random(Script_Data.Rage.Duck_Yaw_AA_Min:get(),Script_Data.Rage.Duck_Yaw_AA_Max:get()))
            end
            if Script_Data.Rage.Duck_AA_Override_Limit:get() then
              BodyYawLeftLimit:set(math.random(Script_Data.Rage.Duck_Limit_AA_Min:get(),Script_Data.Rage.Duck_Limit_AA_Max:get()))
              BodyYawRightLimit:set(math.random(Script_Data.Rage.Duck_Limit_AA_Min:get(),Script_Data.Rage.Duck_Limit_AA_Max:get()))
            end
            BodyYawOptions:set(Script_Data.Rage.Duck_Fake_Options:get())
            FakeLagSwitch:set(true)
            FakeLagLimit:set(math.random(Script_Data.Rage.Duck_FakeLag_Max:get(),Script_Data.Rage.Duck_FakeLag_Min:get()))
        end
      else
        if isJump ~= 0 then
            conditionaa = "JUMP"
            Pitch:set("Down")
            YawBase:set("At Target")
            Yaw:set("Backward")
            BodyYaw:set(true)
            YawModifier:set(Script_Data.Rage.Jump_Modifier:get())
            YawModifierOffset:set(Script_Data.Rage.Jump_Modifier_offset:get())
            if Script_Data.Rage.Jump_AA_Override_Yaw:get() then
                YawOffset:set(math.random(Script_Data.Rage.Jump_Yaw_AA_Min:get(),Script_Data.Rage.Jump_Yaw_AA_Max:get()))
            end
            if Script_Data.Rage.Jump_AA_Override_Limit:get() then
              BodyYawLeftLimit:set(math.random(Script_Data.Rage.Jump_Limit_AA_Min:get(),Script_Data.Rage.Jump_Limit_AA_Max:get()))
              BodyYawRightLimit:set(math.random(Script_Data.Rage.Jump_Limit_AA_Min:get(),Script_Data.Rage.Jump_Limit_AA_Max:get()))
            end
            BodyYawOptions:set(Script_Data.Rage.Jump_Fake_Options:get())
            FakeLagSwitch:set(true)
            FakeLagLimit:set(math.random(Script_Data.Rage.Jump_FakeLag_Max:get(),Script_Data.Rage.Jump_FakeLag_Min:get()))
        else
          if isMoving < 1.2 then
            conditionaa = "STAND"
            Pitch:set("Down")
            YawBase:set("At Target")
            Yaw:set("Backward")
            BodyYaw:set(true)
            YawModifier:set(Script_Data.Rage.Stand_Modifier:get())
            YawModifierOffset:set(Script_Data.Rage.Stand_Modifier_offset:get())
            if Script_Data.Rage.Stand_AA_Override_Yaw:get() then
                YawOffset:set(math.random(Script_Data.Rage.Stand_Yaw_AA_Min:get(),Script_Data.Rage.Stand_Yaw_AA_Max:get()))
            end
            if Script_Data.Rage.Stand_AA_Override_Limit:get() then
              BodyYawLeftLimit:set(math.random(Script_Data.Rage.Stand_Limit_AA_Min:get(),Script_Data.Rage.Stand_Limit_AA_Max:get()))
              BodyYawRightLimit:set(math.random(Script_Data.Rage.Stand_Limit_AA_Min:get(),Script_Data.Rage.Stand_Limit_AA_Max:get()))
            end
            BodyYawOptions:set(Script_Data.Rage.Stand_Fake_Options:get())
            FakeLagSwitch:set(true)
            FakeLagLimit:set(math.random(Script_Data.Rage.Stand_FakeLag_Max:get(),Script_Data.Rage.Stand_FakeLag_Min:get()))
          else
            conditionaa = "WALK"
            Pitch:set("Down")
            YawBase:set("At Target")
            Yaw:set("Backward")
            BodyYaw:set(true)
            YawModifier:set(Script_Data.Rage.Walk_Modifier:get())
            YawModifierOffset:set(Script_Data.Rage.Walk_Modifier_offset:get())
            if Script_Data.Rage.Walk_AA_Override_Yaw:get() then
                YawOffset:set(math.random(Script_Data.Rage.Walk_Yaw_AA_Min:get(),Script_Data.Rage.Walk_Yaw_AA_Max:get()))
            end
            if Script_Data.Rage.Walk_AA_Override_Limit:get() then
              BodyYawLeftLimit:set(math.random(Script_Data.Rage.Walk_Limit_AA_Min:get(),Script_Data.Rage.Walk_Limit_AA_Max:get()))
              BodyYawRightLimit:set(math.random(Script_Data.Rage.Walk_Limit_AA_Min:get(),Script_Data.Rage.Walk_Limit_AA_Max:get()))
            end
            BodyYawOptions:set(Script_Data.Rage.Walk_Fake_Options:get())
            FakeLagSwitch:set(true)
            FakeLagLimit:set(math.random(Script_Data.Rage.Walk_FakeLag_Max:get(),Script_Data.Rage.Walk_FakeLag_Min:get()))
          end
        end
      end
    end
  end
end
  
  
end)

events.createmove:set(function(cmd)                                                                                                                                                 
    if Script_Data.Rage.Slowwalk_Speed_Enable:get() then
      if cmd.forwardmove >= Script_Data.Rage.Slowwalk_Speed:get() then
          cmd.forwardmove = Script_Data.Rage.Slowwalk_Speed:get()
      end 
      if cmd.sidemove >= Script_Data.Rage.Slowwalk_Speed:get() then
          cmd.sidemove = Script_Data.Rage.Slowwalk_Speed:get()
      end 
      if cmd.forwardmove < 0 and -cmd.forwardmove >=Script_Data.Rage.Slowwalk_Speed:get() then
          cmd.forwardmove = -Script_Data.Rage.Slowwalk_Speed:get()
      end
      if cmd.sidemove < 0 and -cmd.sidemove >=Script_Data.Rage.Slowwalk_Speed:get() then
          cmd.sidemove = -Script_Data.Rage.Slowwalk_Speed:get()
      end
    end
  end)	

local verdana = render.load_font("Verdana", 12)


local hitgroup_str = {
    [0] = '通用的',
    '头', '胸部', '胃',
    '左臂', '右臂',
    '左腿', '右腿',
    '脖子', '通用的', '齿轮'
}

events.aim_ack:set(function(e)


    local target = entity.get(e.target)
    local damage = e.damage
    local wanted_damage = e.wanted_damage
    local wanted_hitgroup = hitgroup_str[e.wanted_hitgroup]
    local hitchance = e.hitchance
    local state = e.state
    noncolstate = e.state
    local bt = e.backtrack
    if not target then return end
    if target == nil then return end
    local health = target["m_iHealth"]

    if state == "spread" then
      state = "\aFEEA7DSpread"
      noncolstate = "Spread"
    end
    if state == "prediction error" then
      state = "\aFEEA7DPrediction Error"
      noncolstate = "Prediction Error"
    end
    if state == "correction" then
      state = "\aFF5959Resolver"
      noncolstate = "Resolver"
    end
    if state == "misprediction" then
      state = "\aFF5959Misprediction"
      noncolstate = "Misprediction"
    end
    if state == "lagcomp failure" then
      state = "\aFF5959LagComp Failure"
      noncolstate = "LagComp Failure"
    end

    if state == "damage rejection" then
      state = "\aFF5959Damage Rejection"
      noncolstate = "Damage Rejection"
    end
    
    if state == "unregistered shot" then
      state = "\aFF5959Unregistered Shot"
      noncolstate = "Unregistered Shot"
    end

    if state == "player death" then
      state = "\aFF5959Player death"
      noncolstate = "Player death"
    end

    if state == "death" then
      state = "\aFF5959Death"
      noncolstate = "Death"
    end

    
    



    local hitgroup = hitgroup_str[e.hitgroup]
    
  state_1 = e.state
  if state_1  == "prediction error" then
    state_1 = "Prediction Error"
  end
  if state_1  == "correction" then
    state_1 = "Resolver"
  end
  if state_1  == "misprediction" then
    state_1 = "Misprediction"
  end
  if state_1  == "lagcomp failure" then
    state_1 = "LagComp Failure"
  end

  if state_1  == "damage rejection" then
    state_1 = "Damage Rejection"
  end
  
  if state_1  == "unregistered shot" then
    state_1 = "Unregistered Shot"
  end

  if state_1  == "player death" then
    state_1 = "Player death"
  end

  if state_1  == "death" then
    state_1 = "Death"
  end


  if Script_Data.Misc.HitLog:get() then


      if state_1 == nil then
        print_chat(("[Dream.Yaw] 在 [%s] 上他的 [%s] 中射出了 [%s] 点伤害！"):format(target:get_name(), hitgroup, e.damage))
      else
        print_chat(('[Dream.Yaw] 由于 '..'\a['..state_1..'] 未命中 [%s] 上的 [%s] ,造成 [%s] 点伤害！'):format(target:get_name(), wanted_hitgroup, wanted_damage))
      end
  end

end)







--modern

x = render.screen_size().x/2
y = render.screen_size().y/2
lerpik = function (a, b, percentage) return math.floor(a + (b - a) * percentage) end
anim = {0, 0, 0, 0, 0, 0}


gradient = require("neverlose/gradient")
events.render:set(function()
    Script_Data.Visuals.color_pick:visibility(Script_Data.Visuals.indic_switch:get())
    Script_Data.Visuals.color_pick2:visibility(Script_Data.Visuals.indic_switch:get())
    Script_Data.Visuals.indicspeed:visibility(Script_Data.Visuals.indic_switch:get())
    Script_Data.Visuals.indicglow:visibility(Script_Data.Visuals.indic_switch:get())
    Script_Data.Visuals.color_pickglow:visibility(Script_Data.Visuals.indic_switch:get() and Script_Data.Visuals.indicglow:get())
    Script_Data.Visuals.glowsize:visibility(Script_Data.Visuals.indic_switch:get() and Script_Data.Visuals.indicglow:get())
  
    add_y = 15
    lp = entity.get_local_player()
    if not globals.is_in_game then
      return
    end
    if not lp:is_alive() then
      return
    end
    alpha = math.min(math.floor(math.sin((globals.curtime%3) * 4) * 175 + 50), 255)
  
    if not Script_Data.Visuals.indic_switch:get() then return end

      
      if lp.m_bIsScoped then anim[4] = lerpik(anim[4], -40, globals.frametime * 5)
        else anim[4] = lerpik(anim[4], 0, globals.frametime * 12) 
      end

      if Script_Data.Visuals.indicglow:get() then 
        render.shadow(vector(x - anim[4], y + add_y), vector(x - anim[4], y + add_y), Script_Data.Visuals.color_pickglow:get(), Script_Data.Visuals.glowsize:get())
      end
      


      gradient2 = require("neverlose/gradient")
          gradientindicators = gradient2.text_animate("Dream.Yaw", Script_Data.Visuals.indicspeed:get(), {
            color(Script_Data.Visuals.color_pick:get().r, Script_Data.Visuals.color_pick:get().g, Script_Data.Visuals.color_pick:get().b), 
            color(Script_Data.Visuals.color_pick2:get().r, Script_Data.Visuals.color_pick2:get().g, Script_Data.Visuals.color_pick2:get().b)
          })
    
          render.text(Font.Font_Comfortaa2, vector(x - anim[4], y + add_y), color(255, 255, 255), 'c', gradientindicators:get_animated_text())
          add_y = add_y + 9
          gradientindicators:animate()




      charge_clr = rage.exploit:get() == 1 and color(0, 255, 0, anim[1]) or color(255, 0, 50, anim[1])
      if doubletap:get() then
        anim[1] = lerpik(anim[1], 255, globals.frametime * 11)
        add_y = add_y + 9
        render.text(Font.Font_Comfortaa2, vector(x - anim[4], y + add_y), color(0, 255, 0, 255), 'c', "DoubleTap")
      end



      if onshot:get() then
        anim[1] = lerpik(anim[1], 255, globals.frametime * 11)
        add_y = add_y + 9
        render.text(Font.Font_Comfortaa2, vector(x - anim[4], y + add_y), color(137, 174, 255, 255), 'c', "HideShot")
      end

      if isFD:get() then
        anim[1] = lerpik(anim[1], 255, globals.frametime * 11)
        add_y = add_y + 9
        render.text(Font.Font_Comfortaa2, vector(x - anim[4], y + add_y), color(227, 139, 25, 255), 'c', "FakeDuck")
      end
      

end)



function Set_DT()
    
    local Local_Player_Weapon = entity.get_local_player():get_player_weapon()
    if Local_Player_Weapon == nil then
        return
    end
    local Weapon_ID = Local_Player_Weapon:get_weapon_index()
    local cl_clock_correction = cvar.cl_clock_correction
    local cl_clock_correction_adjustment_max_amount = cvar.cl_clock_correction_adjustment_max_amount
    OverrideDoubleTapSpeed = cvar.sv_maxusrcmdprocessticks
    
    if Script_Data.Misc.DT_Enhence:get() then
            OverrideDoubleTapSpeed:int(Script_Data.Misc.DT_Speed:get())
            cl_clock_correction:int(0)
            cl_clock_correction_adjustment_max_amount:int(450)
            if Script_Data.Misc.DT_Charge:get() then
                rage.exploit:force_charge()
            end
    end
end





--AA & FL
events.render:set(function()
    Set_Visible()
    if Script_Data.Visuals.FPS_Boost:get() then
        cvar.r_shadows:int(0)
        cvar.cl_csm_static_prop_shadows:int(0)
        cvar.cl_csm_shadows:int(0)
        cvar.cl_csm_world_shadows:int(0)
        cvar.cl_foot_contact_shadows:int(0)
        cvar.cl_csm_viewmodel_shadows:int(0)
        cvar.cl_csm_rope_shadows:int(0)
        cvar.cl_csm_sprite_shadows:int(0)
        cvar.cl_csm_world_shadows_in_viewmodelcascade:int(0)
        cvar.cl_csm_translucent_shadows:int(0)
        cvar.cl_csm_entity_shadows:int(0)
        cvar.violence_hblood:int(0)
        cvar.r_3dsky:int(0)
        cvar.r_drawdecals:int(0)
        cvar.r_drawrain:int(0)
        cvar.r_drawropes:int(0)
        cvar.r_drawsprites:int(0)
        cvar.fog_enable_water_fog:int(0)
        cvar.dsp_slow_cpu:int(1)
        cvar.cl_disable_ragdolls:int(1)
        cvar.mat_disable_bloom:int(1)
        Script_Data.Visuals.FPS_Boost:set(false)
    end
    Draw_Water_Mark()

    Draw_ClanTag()

end)

events.createmove:set(function(cmd)
    --FakeLag_Choking = FakeLag.Choking()
    Set_DT()
end)




local json = require("neverlose/better_json")
local base64 = require("neverlose/base64")
local clipboard = require("neverlose/clipboard")


--[[Script_Data.Export(function()
        local test = json.stringify(
            {
                AntiAim_Brute_Force = Script_Data.Rage.AntiAim_Brute_Force:get(),
                Big_Angle_Offset = Script_Data.Rage.Big_Angle_Offset:get(),
                Flicker_Offset = Script_Data.Rage.Flicker_Offset:get(),

                Stand_Fake_Options = Script_Data.Rage.Stand_Fake_Options:get(),
                
                Stand_AA_Override_Limit = Script_Data.Rage.Stand_AA_Override_Limit:get(),
                Stand_Limit_AA_Type = Script_Data.Rage.Stand_Limit_AA_Type:get(),
                Stand_Limit_AA_Time = Script_Data.Rage.Stand_Limit_AA_Time:get(),
                Stand_Limit_AA_Min = Script_Data.Rage.Stand_Limit_AA_Min:get(),
                Stand_Limit_AA_Max = Script_Data.Rage.Stand_Limit_AA_Max:get(),
                
                Stand_AA_Override_Yaw = Script_Data.Rage.Stand_AA_Override_Yaw:get(),
                Stand_Yaw_AA_Type = Script_Data.Rage.Stand_Yaw_AA_Type:get(),
                Stand_Yaw_AA_Time = Script_Data.Rage.Stand_Yaw_AA_Time:get(),
                Stand_Yaw_AA_Min = Script_Data.Rage.Stand_Yaw_AA_Min:get(),
                Stand_Yaw_AA_Max = Script_Data.Rage.Stand_Yaw_AA_Max:get(),
                
                Stand_AA_Override_LBY = Script_Data.Rage.Stand_AA_Override_LBY:get(),
                Stand_LBY_AA_Type = Script_Data.Rage.Stand_LBY_AA_Type:get(),
                Stand_LBY_AA_Time = Script_Data.Rage.Stand_LBY_AA_Time:get(),
                Stand_LBY_AA_Min = Script_Data.Rage.Stand_LBY_AA_Min:get(),
                Stand_LBY_AA_Max = Script_Data.Rage.Stand_LBY_AA_Max:get(),

                Walk_Fake_Options = Script_Data.Rage.Walk_Fake_Options:get(),
                Walk_AA_Override_Limit = Script_Data.Rage.Walk_AA_Override_Limit:get(),
                Walk_Limit_AA_Type = Script_Data.Rage.Walk_Limit_AA_Type:get(),
                Walk_Limit_AA_Time = Script_Data.Rage.Walk_Limit_AA_Time:get(),
                Walk_Limit_AA_Min = Script_Data.Rage.Walk_Limit_AA_Min:get(),
                Walk_Limit_AA_Max = Script_Data.Rage.Walk_Limit_AA_Max:get(),
                Walk_AA_Override_Yaw = Script_Data.Rage.Walk_AA_Override_Yaw:get(),
                Walk_Yaw_AA_Type = Script_Data.Rage.Walk_Yaw_AA_Type:get(),
                Walk_Yaw_AA_Time = Script_Data.Rage.Walk_Yaw_AA_Time:get(),
                Walk_Yaw_AA_Min = Script_Data.Rage.Walk_Yaw_AA_Min:get(),
                Walk_Yaw_AA_Max = Script_Data.Rage.Walk_Yaw_AA_Max:get(),
                Walk_AA_Override_LBY = Script_Data.Rage.Walk_AA_Override_LBY:get(),
                Walk_LBY_AA_Type = Script_Data.Rage.Walk_LBY_AA_Type:get(),
                Walk_LBY_AA_Time = Script_Data.Rage.Walk_LBY_AA_Time:get(),
                Walk_LBY_AA_Min = Script_Data.Rage.Walk_LBY_AA_Min:get(),
                Walk_LBY_AA_Max = Script_Data.Rage.Walk_LBY_AA_Max:get(),

                Slowwalk_Fake_Options = Script_Data.Rage.Slowwalk_Fake_Options:get(),
                Slowwalk_AA_Override_Limit = Script_Data.Rage.Slowwalk_AA_Override_Limit:get(),
                Slowwalk_Limit_AA_Type = Script_Data.Rage.Slowwalk_Limit_AA_Type:get(),
                Slowwalk_Limit_AA_Time = Script_Data.Rage.Slowwalk_Limit_AA_Time:get(),
                Slowwalk_Limit_AA_Min = Script_Data.Rage.Slowwalk_Limit_AA_Min:get(),
                Slowwalk_Limit_AA_Max = Script_Data.Rage.Slowwalk_Limit_AA_Max:get(),
                Slowwalk_AA_Override_Yaw = Script_Data.Rage.Slowwalk_AA_Override_Yaw:get(),
                Slowwalk_Yaw_AA_Type = Script_Data.Rage.Slowwalk_Yaw_AA_Type:get(),
                Slowwalk_Yaw_AA_Time = Script_Data.Rage.Slowwalk_Yaw_AA_Time:get(),
                Slowwalk_Yaw_AA_Min = Script_Data.Rage.Slowwalk_Yaw_AA_Min:get(),
                Slowwalk_Yaw_AA_Max = Script_Data.Rage.Slowwalk_Yaw_AA_Max:get(),
                Slowwalk_AA_Override_LBY = Script_Data.Rage.Slowwalk_AA_Override_LBY:get(),
                Slowwalk_LBY_AA_Type = Script_Data.Rage.Slowwalk_LBY_AA_Type:get(),
                Slowwalk_LBY_AA_Time = Script_Data.Rage.Slowwalk_LBY_AA_Time:get(),
                Slowwalk_LBY_AA_Min = Script_Data.Rage.Slowwalk_LBY_AA_Min:get(),
                Slowwalk_LBY_AA_Max = Script_Data.Rage.Slowwalk_LBY_AA_Max:get(),

                Onshot_Fake_Options = Script_Data.Rage.Onshot_Fake_Options:get(),
                Onshot_AA_Override_Limit = Script_Data.Rage.Onshot_AA_Override_Limit:get(),
                Onshot_Limit_AA_Type = Script_Data.Rage.Onshot_Limit_AA_Type:get(),
                Onshot_Limit_AA_Time = Script_Data.Rage.Onshot_Limit_AA_Time:get(),
                Onshot_Limit_AA_Min = Script_Data.Rage.Onshot_Limit_AA_Min:get(),
                Onshot_Limit_AA_Max = Script_Data.Rage.Onshot_Limit_AA_Max:get(),
                Onshot_AA_Override_Yaw = Script_Data.Rage.Onshot_AA_Override_Yaw:get(),
                Onshot_Yaw_AA_Type = Script_Data.Rage.Onshot_Yaw_AA_Type:get(),
                Onshot_Yaw_AA_Time = Script_Data.Rage.Onshot_Yaw_AA_Time:get(),
                Onshot_Yaw_AA_Min = Script_Data.Rage.Onshot_Yaw_AA_Min:get(),
                Onshot_Yaw_AA_Max = Script_Data.Rage.Onshot_Yaw_AA_Max:get(),
                Onshot_AA_Override_LBY = Script_Data.Rage.Onshot_AA_Override_LBY:get(),
                Onshot_LBY_AA_Type = Script_Data.Rage.Onshot_LBY_AA_Type:get(),
                Onshot_LBY_AA_Time = Script_Data.Rage.Onshot_LBY_AA_Time:get(),
                Onshot_LBY_AA_Min = Script_Data.Rage.Onshot_LBY_AA_Min:get(),
                Onshot_LBY_AA_Max = Script_Data.Rage.Onshot_LBY_AA_Max:get(),

                Duck_Fake_Options = Script_Data.Rage.Duck_Fake_Options:get(),
                Duck_AA_Override_Limit = Script_Data.Rage.Duck_AA_Override_Limit:get(),
                Duck_Limit_AA_Type = Script_Data.Rage.Duck_Limit_AA_Type:get(),
                Duck_Limit_AA_Time = Script_Data.Rage.Duck_Limit_AA_Time:get(),
                Duck_Limit_AA_Min = Script_Data.Rage.Duck_Limit_AA_Min:get(),
                Duck_Limit_AA_Max = Script_Data.Rage.Duck_Limit_AA_Max:get(),
                Duck_AA_Override_Yaw = Script_Data.Rage.Duck_AA_Override_Yaw:get(),
                Duck_Yaw_AA_Type = Script_Data.Rage.Duck_Yaw_AA_Type:get(),
                Duck_Yaw_AA_Time = Script_Data.Rage.Duck_Yaw_AA_Time:get(),
                Duck_Yaw_AA_Min = Script_Data.Rage.Duck_Yaw_AA_Min:get(),
                Duck_Yaw_AA_Max = Script_Data.Rage.Duck_Yaw_AA_Max:get(),
                Duck_AA_Override_LBY = Script_Data.Rage.Duck_AA_Override_LBY:get(),
                Duck_LBY_AA_Type = Script_Data.Rage.Duck_LBY_AA_Type:get(),
                Duck_LBY_AA_Time = Script_Data.Rage.Duck_LBY_AA_Time:get(),
                Duck_LBY_AA_Min = Script_Data.Rage.Duck_LBY_AA_Min:get(),
                Duck_LBY_AA_Max = Script_Data.Rage.Duck_LBY_AA_Max:get(),

                Jump_Fake_Options = Script_Data.Rage.Script_Data.Rage.Jump_Fake_Options:get(),
                Jump_AA_Override_Limit = Script_Data.Rage.Script_Data.Rage.Jump_AA_Override_Limit:get(),
                Jump_Limit_AA_Type = Script_Data.Rage.Jump_Limit_AA_Type:get(),
                Jump_Limit_AA_Time = Script_Data.Rage.Jump_Limit_AA_Time:get(),
                Jump_Limit_AA_Min = Script_Data.Rage.Script_Data.Rage.Jump_Limit_AA_Min:get(),
                Jump_Limit_AA_Max = Script_Data.Rage.Script_Data.Rage.Jump_Limit_AA_Max:get(),
                Jump_AA_Override_Yaw = Script_Data.Rage.Jump_AA_Override_Yaw:get(),
                Jump_Yaw_AA_Type = Script_Data.Rage.Jump_Yaw_AA_Type:get(),
                Jump_Yaw_AA_Time = Script_Data.Rage.Jump_Yaw_AA_Time:get(),
                Jump_Yaw_AA_Min = Script_Data.Rage.Jump_Yaw_AA_Min:get(),
                Jump_Yaw_AA_Max = Script_Data.Rage.Jump_Yaw_AA_Max:get(),
                Jump_AA_Override_LBY = Script_Data.Rage.Jump_AA_Override_LBY:get(),
                Jump_LBY_AA_Type = Script_Data.Rage.Jump_LBY_AA_Type:get(),
                Jump_LBY_AA_Time = Script_Data.Rage.Jump_LBY_AA_Time:get(),
                Jump_LBY_AA_Min = Script_Data.Rage.Jump_LBY_AA_Min:get(),
                Jump_LBY_AA_Max = Script_Data.Rage.Jump_LBY_AA_Max:get(),

                Peek_Fake_Options = Script_Data.Rage.Peek_Fake_Options:get(),
                Peek_AA_Override_Limit = Script_Data.Rage.Peek_AA_Override_Limit:get(),
                Peek_Limit_AA_Type = Script_Data.Rage.Peek_Limit_AA_Type:get(),
                Peek_Limit_AA_Time = Script_Data.Rage.Peek_Limit_AA_Time:get(),
                Peek_Limit_AA_Min = Script_Data.Rage.Peek_Limit_AA_Min:get(),
                Peek_Limit_AA_Max = Script_Data.Rage.Peek_Limit_AA_Max:get(),
                Peek_AA_Override_Yaw = Script_Data.Rage.Peek_AA_Override_Yaw:get(),
                Peek_Yaw_AA_Type = Script_Data.Rage.Peek_Yaw_AA_Type:get(),
                Peek_Yaw_AA_Time = Script_Data.Rage.Peek_Yaw_AA_Time:get(),
                Peek_Yaw_AA_Min = Script_Data.Rage.Peek_Yaw_AA_Min:get(),
                Peek_Yaw_AA_Max = Script_Data.Rage.Peek_Yaw_AA_Max:get(),
                Peek_AA_Override_LBY = Script_Data.Rage.Peek_AA_Override_LBY:get(),
                Peek_LBY_AA_Type = Script_Data.Rage.Peek_LBY_AA_Type:get(),
                Peek_LBY_AA_Time = Script_Data.Rage.Peek_LBY_AA_Time:get(),
                Peek_LBY_AA_Min = Script_Data.Rage.Peek_LBY_AA_Min:get(),
                Peek_LBY_AA_Max = Script_Data.Rage.Peek_LBY_AA_Max:get(),

                Legit_Fake_Options = Script_Data.Rage.Legit_Fake_Options:get(),
                Legit_AA_Override_Limit = Script_Data.Rage.Legit_AA_Override_Limit:get(),
                Legit_Limit_AA_Type = Script_Data.Rage.Legit_Limit_AA_Type:get(),
                Legit_Limit_AA_Time = Script_Data.Rage.Legit_Limit_AA_Time:get(),
                Legit_Limit_AA_Min = Script_Data.Rage.Legit_Limit_AA_Min:get(),
                Legit_Limit_AA_Max = Script_Data.Rage.Legit_Limit_AA_Max:get(),
                Legit_AA_Override_Yaw = Script_Data.Rage.Legit_AA_Override_Yaw:get(),
                Legit_Yaw_AA_Type = Script_Data.Rage.Legit_Yaw_AA_Type:get(),
                Legit_Yaw_AA_Time = Script_Data.Rage.Legit_Yaw_AA_Time:get(),
                Legit_Yaw_AA_Min = Script_Data.Rage.Legit_Yaw_AA_Min:get(),
                Legit_Yaw_AA_Max = Script_Data.Rage.Legit_Yaw_AA_Max:get(),
                Legit_AA_Override_LBY = Script_Data.Rage.Legit_AA_Override_LBY:get(),
                Legit_LBY_AA_Type = Script_Data.Rage.Legit_LBY_AA_Type:get(),
                Legit_LBY_AA_Time = Script_Data.Rage.Legit_LBY_AA_Time:get(),
                Legit_LBY_AA_Min = Script_Data.Rage.Legit_LBY_AA_Min:get(),
                Legit_LBY_AA_Max = Script_Data.Rage.Legit_LBY_AA_Max:get(),


                Slowwalk_FakeLag_Type = Script_Data.Rage.Slowwalk_FakeLag_Type:get(),
                Slowwalk_FakeLag_Min = Script_Data.Rage.Slowwalk_FakeLag_Min:get(),
                Slowwalk_FakeLag_Max = Script_Data.Rage.Slowwalk_FakeLag_Max:get(),
                Slowwalk_FakeLag_Rate = Script_Data.Rage.Slowwalk_FakeLag_Rate:get(),

                Walk_FakeLag_Type = Script_Data.Rage.Walk_FakeLag_Type:get(),
                Walk_FakeLag_Min = Script_Data.Rage.Walk_FakeLag_Min:get(),
                Walk_FakeLag_Max = Script_Data.Rage.Walk_FakeLag_Max:get(),
                Walk_FakeLag_Rate = Script_Data.Rage.Walk_FakeLag_Rate:get(),

                Jump_FakeLag_Type = Script_Data.Rage.Jump_FakeLag_Type:get(),
                Jump_FakeLag_Min = Script_Data.Rage.Script_Data.Rage.Jump_FakeLag_Min:get(),
                Jump_FakeLag_Max = Script_Data.Rage.Script_Data.Rage.Jump_FakeLag_Max:get(),
                Jump_FakeLag_Rate = Script_Data.Rage.Jump_FakeLag_Rate:get(),

                Onshot_FakeLag_Type = Script_Data.Rage.Onshot_FakeLag_Type:get(),
                Onshot_FakeLag_Min = Script_Data.Rage.Onshot_FakeLag_Min:get(),
                Onshot_FakeLag_Max = Script_Data.Rage.Onshot_FakeLag_Max:get(),
                Onshot_FakeLag_Rate = Script_Data.Rage.Onshot_FakeLag_Rate:get(),


                --Override_Key = Script_Data.Weapon.Override_Key:get(),
                --Override_Type = Script_Data.Weapon.Override_Type:get(),


                DE_Enable = Script_Data.Weapon.DE_Enable:get(),
                R8_Enable = Script_Data.Weapon.R8_Enable:get(),
                Auto_Enable = Script_Data.Weapon.Auto_Enable:get(),
                Scout_Enable = Script_Data.Weapon.Scout_Enable:get(),
                AWP_Enable = Script_Data.Weapon.AWP_Enable:get(),
                Tec_Enable = Script_Data.Weapon.Tec_Enable:get(),
                FN57_Enable = Script_Data.Weapon.FN57_Enable:get(),
                DP_Enable = Script_Data.Weapon.DP_Enable:get(),

                DP_Max_DMG = Script_Data.Weapon.DP_Max_DMG:get(),
                DP_Min_DMG = Script_Data.Weapon.DP_Min_DMG:get(),
                DP_HC = Script_Data.Weapon.DP_HC:get(),
                DP_Jump_HC = Script_Data.Weapon.DP_Jump_HC:get(),
                DP_Visible_Enable = Script_Data.Weapon.DP_Visible_Enable:get(),
                DP_Visible_DMG = Script_Data.Weapon.DP_Visible_DMG:get(),
                DP_AutoWall_Enable = Script_Data.Weapon.DP_AutoWall_Enable:get(),
                DP_AutoWall = Script_Data.Weapon.DP_AutoWall:get(),
                DP_Head_Scale = Script_Data.Weapon.DP_Head_Scale:get(),
                DP_Body_Scale = Script_Data.Weapon.DP_Body_Scale:get(),
                DP_DT_Enhence = Script_Data.Weapon.DP_DT_Enhence:get(),
                DP_DT_Cor = Script_Data.Weapon.DP_DT_Cor:get(),
                DP_DT_Speed = Script_Data.Weapon.DP_DT_Speed:get(),
                DP_DT_Charge = Script_Data.Weapon.DP_DT_Charge:get(),


                DE_Max_DMG = Script_Data.Weapon.DE_Max_DMG:get(),
                DE_Min_DMG = Script_Data.Weapon.DE_Min_DMG:get(),
                DE_HC = Script_Data.Weapon.DE_HC:get(),
                DE_Jump_HC = Script_Data.Weapon.DE_Jump_HC:get(),
                DE_Visible_Enable = Script_Data.Weapon.DE_Visible_Enable:get(),
                DE_Visible_DMG = Script_Data.Weapon.DE_Visible_DMG:get(),
                DE_AutoWall_Enable = Script_Data.Weapon.DE_AutoWall_Enable:get(),
                DE_AutoWall = Script_Data.Weapon.DE_AutoWall:get(),
                DE_Head_Scale = Script_Data.Weapon.DE_Head_Scale:get(),
                DE_Body_Scale = Script_Data.Weapon.DE_Body_Scale:get(),
                DE_DT_Enhence = Script_Data.Weapon.DE_DT_Enhence:get(),
                DE_DT_Cor = Script_Data.Weapon.DE_DT_Cor:get(),
                DE_DT_Speed = Script_Data.Weapon.DE_DT_Speed:get(),
                DE_DT_Charge = Script_Data.Weapon.DE_DT_Charge:get(),

                R8_Max_DMG = Script_Data.Weapon.R8_Max_DMG:get(),
                R8_Min_DMG = Script_Data.Weapon.R8_Min_DMG:get(),
                R8_HC = Script_Data.Weapon.R8_HC:get(),
                R8_Jump_HC = Script_Data.Weapon.R8_Jump_HC:get(),
                R8_Visible_Enable = Script_Data.Weapon.R8_Visible_Enable:get(),
                R8_Visible_DMG = Script_Data.Weapon.R8_Visible_DMG:get(),
                R8_AutoWall_Enable = Script_Data.Weapon.R8_AutoWall_Enable:get(),
                R8_AutoWall = Script_Data.Weapon.R8_AutoWall:get(),
                R8_Head_Scale = Script_Data.Weapon.R8_Head_Scale:get(),
                R8_Body_Scale = Script_Data.Weapon.R8_Body_Scale:get(),

                Auto_Max_DMG = Script_Data.Weapon.Auto_Max_DMG:get(),
                Auto_Min_DMG = Script_Data.Weapon.Auto_Min_DMG:get(),
                Auto_Scope_HC = Script_Data.Weapon.Auto_Scope_HC:get(),
                Auto_Scope_Jump_HC = Script_Data.Weapon.Auto_Scope_Jump_HC:get(),
                Auto_No_Scope_HC = Script_Data.Weapon.Auto_No_Scope_HC:get(),
                Auto_No_Scope_Jump_HC = Script_Data.Weapon.Auto_No_Scope_Jump_HC:get(),
                Auto_Visible_Enable = Script_Data.Weapon.Auto_Visible_Enable:get(),
                Auto_Visible_DMG = Script_Data.Weapon.Auto_Visible_DMG:get(),
                Auto_AutoWall_Enable = Script_Data.Weapon.Auto_AutoWall_Enable:get(),
                Auto_AutoWall = Script_Data.Weapon.Auto_AutoWall:get(),
                Auto_Head_Scale = Script_Data.Weapon.Auto_Head_Scale:get(),
                Auto_Body_Scale = Script_Data.Weapon.Auto_Body_Scale:get(),
                Auto_DT_Enhence = Script_Data.Weapon.Auto_DT_Enhence:get(),
                Auto_DT_Cor = Script_Data.Weapon.Auto_DT_Cor:get(),
                Auto_DT_Speed = Script_Data.Weapon.Auto_DT_Speed:get(),
                Auto_DT_Charge = Script_Data.Weapon.Auto_DT_Charge:get(),

                Scout_Max_DMG = Script_Data.Weapon.Scout_Max_DMG:get(),
                Scout_Min_DMG = Script_Data.Weapon.Scout_Min_DMG:get(),
                Scout_Scope_HC = Script_Data.Weapon.Scout_Scope_HC:get(),
                Scout_Scope_Jump_HC = Script_Data.Weapon.Scout_Scope_Jump_HC:get(),
                Scout_No_Scope_HC = Script_Data.Weapon.Scout_No_Scope_HC:get(),
                Scout_No_Scope_Jump_HC = Script_Data.Weapon.Scout_No_Scope_Jump_HC:get(),
                Scout_Visible_Enable = Script_Data.Weapon.Scout_Visible_Enable:get(),
                Scout_Visible_DMG = Script_Data.Weapon.Scout_Visible_DMG:get(),
                Scout_AutoWall_Enable = Script_Data.Weapon.Scout_AutoWall_Enable:get(),
                Scout_AutoWall = Script_Data.Weapon.Scout_AutoWall:get(),
                Scout_Head_Scale = Script_Data.Weapon.Scout_Head_Scale:get(),
                Scout_Body_Scale = Script_Data.Weapon.Scout_Body_Scale:get(),

                AWP_Max_DMG = Script_Data.Weapon.AWP_Max_DMG:get(),
                AWP_Min_DMG = Script_Data.Weapon.AWP_Min_DMG:get(),
                AWP_Scope_HC = Script_Data.Weapon.AWP_Scope_HC:get(),
                AWP_Scope_Jump_HC = Script_Data.Weapon.AWP_Scope_Jump_HC:get(),
                AWP_No_Scope_HC = Script_Data.Weapon.AWP_No_Scope_HC:get(),
                AWP_No_Scope_Jump_HC = Script_Data.Weapon.AWP_No_Scope_Jump_HC:get(),
                AWP_Visible_Enable = Script_Data.Weapon.AWP_Visible_Enable:get(),
                AWP_Visible_DMG = Script_Data.Weapon.AWP_Visible_DMG:get(),
                AWP_AutoWall_Enable = Script_Data.Weapon.AWP_AutoWall_Enable:get(),
                AWP_AutoWall = Script_Data.Weapon.AWP_AutoWall:get(),
                AWP_Head_Scale = Script_Data.Weapon.AWP_Head_Scale:get(),
                AWP_Body_Scale = Script_Data.Weapon.AWP_Body_Scale:get(),


                Tec_Max_DMG = Script_Data.Weapon.Tec_Max_DMG:get(),
                Tec_Min_DMG = Script_Data.Weapon.Tec_Min_DMG:get(),
                Tec_HC = Script_Data.Weapon.Tec_HC:get(),
                Tec_Jump_HC = Script_Data.Weapon.Tec_Jump_HC:get(),
                Tec_Visible_Enable = Script_Data.Weapon.Tec_Visible_Enable:get(),
                Tec_Visible_DMG = Script_Data.Weapon.Tec_Visible_DMG:get(),
                Tec_AutoWall_Enable = Script_Data.Weapon.Tec_AutoWall_Enable:get(),
                Tec_AutoWall = Script_Data.Weapon.Tec_AutoWall:get(),
                Tec_Head_Scale = Script_Data.Weapon.Tec_Head_Scale:get(),
                Tec_Body_Scale = Script_Data.Weapon.Tec_Body_Scale:get(),
                Tec_DT_Enhence = Script_Data.Weapon.Tec_DT_Enhence:get(),
                Tec_DT_Cor = Script_Data.Weapon.Tec_DT_Cor:get(),
                Tec_DT_Speed = Script_Data.Weapon.Tec_DT_Speed:get(),
                Tec_DT_Charge = Script_Data.Weapon.Tec_DT_Charge:get(),


                FN57_Max_DMG = Script_Data.Weapon.FN57_Max_DMG:get(),
                FN57_Min_DMG = Script_Data.Weapon.FN57_Min_DMG:get(),
                FN57_HC = Script_Data.Weapon.FN57_HC:get(),
                FN57_Jump_HC = Script_Data.Weapon.FN57_Jump_HC:get(),
                FN57_Visible_Enable = Script_Data.Weapon.FN57_Visible_Enable:get(),
                FN57_Visible_DMG = Script_Data.Weapon.FN57_Visible_DMG:get(),
                FN57_AutoWall_Enable = Script_Data.Weapon.FN57_AutoWall_Enable:get(),
                FN57_AutoWall = Script_Data.Weapon.FN57_AutoWall:get(),
                FN57_Head_Scale = Script_Data.Weapon.FN57_Head_Scale:get(),
                FN57_Body_Scale = Script_Data.Weapon.FN57_Body_Scale:get(),
                FN57_DT_Enhence = Script_Data.Weapon.FN57_DT_Enhence:get(),
                FN57_DT_Cor = Script_Data.Weapon.FN57_DT_Cor:get(),
                FN57_DT_Speed = Script_Data.Weapon.FN57_DT_Speed:get(),
                FN57_DT_Charge = Script_Data.Weapon.FN57_DT_Charge:get(),

                common.add_notify("Config Export", "Config Export Success")
            }
        )
        clipboard.set(base64.encode(test))
    end
)
Script_Data.Import(function()
        --local cfg = "ewoJIlNjb3V0X05vX1Njb3BlX0p1bXBfSEMiOiA0MiwKCSJTY291dF9NaW5fRE1HIjogNCwKCSJTdGFuZF9MQllfQUFfTWluIjogMzUsCgkiU2NvdXRfTWF4X0RNRyI6IDEwMSwKCSJUZWNfRFRfRW5oZW5jZSI6IGZhbHNlLAoJIldhbGtfQUFfT3ZlcnJpZGVfTEJZIjogdHJ1ZSwKCSJQZWVrX0FBX092ZXJyaWRlX0xpbWl0IjogZmFsc2UsCgkiRHVja19ZYXdfQUFfVGltZSI6IDAuMjAwMDAwMDAyOTgwMjMyMjQsCgkiUjhfVmlzaWJsZV9ETUciOiA3NywKCSJUZWNfRFRfQ29yIjogZmFsc2UsCgkiTGVnaXRfTGltaXRfQUFfVGltZSI6IDAuMjAwMDAwMDAyOTgwMjMyMjQsCgkiU3RhbmRfWWF3X0FBX01heCI6IC0yMCwKCSJXYWxrX0xpbWl0X0FBX1RpbWUiOiAwLjEwMDAwMDAwMTQ5MDExNjEyLAoJIkZONTdfRFRfRW5oZW5jZSI6IGZhbHNlLAoJIlNsb3d3YWxrX0xCWV9BQV9UeXBlIjogMywKCSJBdXRvX0VuYWJsZSI6IHRydWUsCgkiV2Fsa19BQV9PdmVycmlkZV9MaW1pdCI6IHRydWUsCgkiSnVtcF9ZYXdfQUFfVHlwZSI6IDEsCgkiRHVja19BQV9PdmVycmlkZV9MQlkiOiB0cnVlLAoJIkFXUF9FbmFibGUiOiB0cnVlLAoJIlN0YW5kX0FBX092ZXJyaWRlX0xpbWl0IjogdHJ1ZSwKCSJKdW1wX1lhd19BQV9NYXgiOiAtMTgsCgkiTGVnaXRfQUFfT3ZlcnJpZGVfTGltaXQiOiB0cnVlLAoJIkR1Y2tfTGltaXRfQUFfTWluIjogNjAsCgkiUjhfQXV0b1dhbGxfRW5hYmxlIjogdHJ1ZSwKCSJBdXRvX0F1dG9XYWxsX0VuYWJsZSI6IGZhbHNlLAoJIldhbGtfWWF3X0FBX1RpbWUiOiAwLjEwMDAwMDAwMTQ5MDExNjEyLAoJIk9uc2hvdF9ZYXdfQUFfTWluIjogMCwKCSJEUF9KdW1wX0hDIjogMzAsCgkiTGVnaXRfTEJZX0FBX1R5cGUiOiAwLAoJIlBlZWtfWWF3X0FBX1RpbWUiOiAwLjMwMDAwMDAxMTkyMDkyODk2LAoJIlI4X01pbl9ETUciOiAxMSwKCSJMZWdpdF9MQllfQUFfVGltZSI6IDAuMjAwMDAwMDAyOTgwMjMyMjQsCgkiTGVnaXRfQUFfT3ZlcnJpZGVfTEJZIjogdHJ1ZSwKCSJTdGFuZF9MQllfQUFfVHlwZSI6IDQsCgkiUjhfQXV0b1dhbGwiOiAxMDEsCgkiSnVtcF9BQV9PdmVycmlkZV9ZYXciOiB0cnVlLAoJIlRlY19WaXNpYmxlX0RNRyI6IDAsCgkiU2xvd3dhbGtfRmFrZUxhZ19NaW4iOiA3LAoJIkR1Y2tfWWF3X0FBX01heCI6IDIwLAoJIkp1bXBfTEJZX0FBX1R5cGUiOiA0LAoJIkF1dG9fSGVhZF9TY2FsZSI6IDUzLAoJIkR1Y2tfTEJZX0FBX1RpbWUiOiAwLjEwMDAwMDAwMTQ5MDExNjEyLAoJIkp1bXBfTEJZX0FBX01heCI6IDU4LAoJIkR1Y2tfQUFfT3ZlcnJpZGVfWWF3IjogdHJ1ZSwKCSJXYWxrX0xCWV9BQV9NaW4iOiA1OCwKCSJQZWVrX0xCWV9BQV9NaW4iOiAwLAoJIkFudGlBaW1fQnJ1dGVfRm9yY2UiOiAwLAoJIlBlZWtfRmFrZV9PcHRpb25zIjogMCwKCSJQZWVrX0xpbWl0X0FBX01pbiI6IDAsCgkiRk41N19BdXRvV2FsbCI6IDEwMSwKCSJTbG93d2Fsa19ZYXdfQUFfVGltZSI6IDAuMTAwMDAwMDAxNDkwMTE2MTIsCgkiRk41N19IZWFkX1NjYWxlIjogNDMsCgkiRk41N19BdXRvV2FsbF9FbmFibGUiOiB0cnVlLAoJIlI4X0JvZHlfU2NhbGUiOiA1MywKCSJPbnNob3RfWWF3X0FBX01heCI6IDAsCgkiQmlnX0FuZ2xlX09mZnNldCI6IDU3LAoJIlNsb3d3YWxrX0xpbWl0X0FBX1RpbWUiOiAwLjEwMDAwMDAwMTQ5MDExNjEyLAoJIkR1Y2tfTEJZX0FBX01heCI6IDU4LAoJIlI4X0p1bXBfSEMiOiA1MCwKCSJBV1BfTWluX0RNRyI6IDExLAoJIkRFX0F1dG9XYWxsX0VuYWJsZSI6IGZhbHNlLAoJIlNjb3V0X1Njb3BlX0hDIjogNzIsCgkiQXV0b19EVF9Db3IiOiBmYWxzZSwKCSJERV9EVF9DaGFyZ2UiOiBmYWxzZSwKCSJSOF9FbmFibGUiOiB0cnVlLAoJIlNsb3d3YWxrX0xCWV9BQV9NYXgiOiA1OCwKCSJERV9EVF9TcGVlZCI6IDE4LAoJIlBlZWtfTEJZX0FBX1RpbWUiOiAwLjMwMDAwMDAxMTkyMDkyODk2LAoJIkRQX0RUX0VuaGVuY2UiOiBmYWxzZSwKCSJXYWxrX0Zha2VMYWdfUmF0ZSI6IDEsCgkiU2xvd3dhbGtfWWF3X0FBX01pbiI6IC0yOCwKCSJPbnNob3RfWWF3X0FBX1R5cGUiOiAwLAoJIldhbGtfTEJZX0FBX1RpbWUiOiAwLjIwMDAwMDAwMjk4MDIzMjI0LAoJIkZONTdfRFRfQ2hhcmdlIjogZmFsc2UsCgkiU3RhbmRfTGltaXRfQUFfTWF4IjogNjAsCgkiU2NvdXRfQXV0b1dhbGwiOiAxMDAsCgkiVGVjX0VuYWJsZSI6IHRydWUsCgkiVGVjX0JvZHlfU2NhbGUiOiAyNywKCSJUZWNfSGVhZF9TY2FsZSI6IDQyLAoJIlRlY19BdXRvV2FsbF9FbmFibGUiOiB0cnVlLAoJIk9uc2hvdF9BQV9PdmVycmlkZV9MQlkiOiBmYWxzZSwKCSJTbG93d2Fsa19GYWtlTGFnX1R5cGUiOiAwLAoJIlBlZWtfTEJZX0FBX01heCI6IDAsCgkiQVdQX1Njb3BlX0hDIjogNjgsCgkiV2Fsa19BQV9PdmVycmlkZV9ZYXciOiB0cnVlLAoJIkF1dG9fTWluX0RNRyI6IDIsCgkiTGVnaXRfTGltaXRfQUFfTWF4IjogNjAsCgkiU2NvdXRfQm9keV9TY2FsZSI6IDU3LAoJIk9uc2hvdF9GYWtlTGFnX1JhdGUiOiAxLAoJIk9uc2hvdF9GYWtlTGFnX1R5cGUiOiAwLAoJIkZONTdfTWF4X0RNRyI6IDMwLAoJIkRQX01pbl9ETUciOiAyLAoJIkRQX1Zpc2libGVfRE1HIjogMCwKCSJXYWxrX0Zha2VfT3B0aW9ucyI6IDcsCgkiVGVjX0RUX1NwZWVkIjogMTMsCgkiQXV0b19EVF9TcGVlZCI6IDE3LAoJIlRlY19NaW5fRE1HIjogMSwKCSJEdWNrX0xCWV9BQV9UeXBlIjogMiwKCSJBdXRvX1Zpc2libGVfRE1HIjogNDIsCgkiUGVla19MaW1pdF9BQV9UeXBlIjogMCwKCSJKdW1wX0xpbWl0X0FBX1RpbWUiOiAwLjEwMDAwMDAwMTQ5MDExNjEyLAoJIk9uc2hvdF9BQV9PdmVycmlkZV9MaW1pdCI6IGZhbHNlLAoJIk9uc2hvdF9GYWtlTGFnX01heCI6IDE0LAoJIlBlZWtfWWF3X0FBX1R5cGUiOiAwLAoJIkZONTdfRFRfU3BlZWQiOiAxMywKCSJTY291dF9BdXRvV2FsbF9FbmFibGUiOiBmYWxzZSwKCSJTdGFuZF9GYWtlX09wdGlvbnMiOiA5LAoJIldhbGtfWWF3X0FBX1R5cGUiOiAxLAoJIlN0YW5kX1lhd19BQV9UeXBlIjogMSwKCSJEdWNrX1lhd19BQV9UeXBlIjogMiwKCSJPbnNob3RfTEJZX0FBX1R5cGUiOiAwLAoJIlI4X0hDIjogNjUsCgkiREVfQm9keV9TY2FsZSI6IDQzLAoJIkF1dG9fTWF4X0RNRyI6IDQzLAoJIkp1bXBfTEJZX0FBX01pbiI6IDU4LAoJIk9uc2hvdF9MQllfQUFfTWF4IjogMCwKCSJEUF9BdXRvV2FsbCI6IDAsCgkiSnVtcF9MaW1pdF9BQV9NaW4iOiA2MCwKCSJTbG93d2Fsa19GYWtlTGFnX1JhdGUiOiAyLAoJIk9uc2hvdF9MaW1pdF9BQV9NYXgiOiAwLAoJIlNsb3d3YWxrX1lhd19BQV9UeXBlIjogMSwKCSJMZWdpdF9ZYXdfQUFfTWF4IjogMCwKCSJEdWNrX0xCWV9BQV9NaW4iOiA1OCwKCSJTbG93d2Fsa19MaW1pdF9BQV9NYXgiOiA2MCwKCSJBdXRvX05vX1Njb3BlX0hDIjogNTAsCgkiQXV0b19WaXNpYmxlX0VuYWJsZSI6IGZhbHNlLAoJIlNjb3V0X05vX1Njb3BlX0hDIjogNTUsCgkiREVfSnVtcF9IQyI6IDE3LAoJIkF1dG9fU2NvcGVfSEMiOiA1MiwKCSJXYWxrX0xpbWl0X0FBX01heCI6IDYwLAoJIkxlZ2l0X1lhd19BQV9NaW4iOiAwLAoJIkR1Y2tfRmFrZV9PcHRpb25zIjogNiwKCSJQZWVrX1lhd19BQV9NaW4iOiAwLAoJIkRQX0hlYWRfU2NhbGUiOiA0NywKCSJGTjU3X0VuYWJsZSI6IHRydWUsCgkiVGVjX1Zpc2libGVfRW5hYmxlIjogZmFsc2UsCgkiRFBfQXV0b1dhbGxfRW5hYmxlIjogZmFsc2UsCgkiRFBfRFRfQ2hhcmdlIjogZmFsc2UsCgkiVGVjX01heF9ETUciOiAzMCwKCSJQZWVrX0xpbWl0X0FBX01heCI6IDAsCgkiT25zaG90X0Zha2VfT3B0aW9ucyI6IDAsCgkiREVfTWF4X0RNRyI6IDMwLAoJIkZONTdfVmlzaWJsZV9FbmFibGUiOiBmYWxzZSwKCSJMZWdpdF9ZYXdfQUFfVHlwZSI6IDAsCgkiSnVtcF9BQV9PdmVycmlkZV9MQlkiOiB0cnVlLAoJIkFXUF9BdXRvV2FsbCI6IDEwMSwKCSJUZWNfSnVtcF9IQyI6IDMyLAoJIkp1bXBfQUFfT3ZlcnJpZGVfTGltaXQiOiB0cnVlLAoJIkxlZ2l0X0xCWV9BQV9NYXgiOiAxMCwKCSJBV1BfVmlzaWJsZV9FbmFibGUiOiBmYWxzZSwKCSJBV1BfVmlzaWJsZV9ETUciOiAxMDAsCgkiSnVtcF9MQllfQUFfVGltZSI6IDAuMTAwMDAwMDAxNDkwMTE2MTIsCgkiRk41N19WaXNpYmxlX0RNRyI6IDAsCgkiSnVtcF9ZYXdfQUFfVGltZSI6IDAuMTAwMDAwMDAxNDkwMTE2MTIsCgkiU2xvd3dhbGtfQUFfT3ZlcnJpZGVfTGltaXQiOiB0cnVlLAoJIkRFX0RUX0VuaGVuY2UiOiBmYWxzZSwKCSJTbG93d2Fsa19MQllfQUFfVGltZSI6IDAuMTAwMDAwMDAxNDkwMTE2MTIsCgkiTGVnaXRfQUFfT3ZlcnJpZGVfWWF3IjogdHJ1ZSwKCSJQZWVrX1lhd19BQV9NYXgiOiAwLAoJIlNsb3d3YWxrX0Zha2VMYWdfTWF4IjogMTQsCgkiQVdQX05vX1Njb3BlX0p1bXBfSEMiOiA0NSwKCSJTbG93d2Fsa19BQV9PdmVycmlkZV9MQlkiOiB0cnVlLAoJIkFXUF9Ob19TY29wZV9IQyI6IDY2LAoJIlN0YW5kX1lhd19BQV9NaW4iOiAxMywKCSJEUF9EVF9TcGVlZCI6IDEzLAoJIlRlY19BdXRvV2FsbCI6IDEwMSwKCSJEdWNrX1lhd19BQV9NaW4iOiAtMTgsCgkiRk41N19EVF9Db3IiOiBmYWxzZSwKCSJPbnNob3RfTEJZX0FBX01pbiI6IDAsCgkiRFBfQm9keV9TY2FsZSI6IDI4LAoJIlNsb3d3YWxrX0xCWV9BQV9NaW4iOiA1OCwKCSJEUF9NYXhfRE1HIjogMjUsCgkiU2xvd3dhbGtfTGltaXRfQUFfTWluIjogNjAsCgkiUGVla19BQV9PdmVycmlkZV9ZYXciOiBmYWxzZSwKCSJMZWdpdF9GYWtlX09wdGlvbnMiOiAyLAoJIlN0YW5kX0xpbWl0X0FBX1RpbWUiOiAwLjEwMDAwMDAwMTQ5MDExNjEyLAoJIlNsb3d3YWxrX0FBX092ZXJyaWRlX1lhdyI6IHRydWUsCgkiSnVtcF9GYWtlX09wdGlvbnMiOiAxMSwKCSJXYWxrX0Zha2VMYWdfVHlwZSI6IDAsCgkiTGVnaXRfWWF3X0FBX1RpbWUiOiAwLjIwMDAwMDAwMjk4MDIzMjI0LAoJIkFXUF9NYXhfRE1HIjogMTAxLAoJIlRlY19EVF9DaGFyZ2UiOiBmYWxzZSwKCSJEdWNrX0FBX092ZXJyaWRlX0xpbWl0IjogdHJ1ZSwKCSJXYWxrX1lhd19BQV9NaW4iOiAtMTUsCgkiV2Fsa19GYWtlTGFnX01heCI6IDE0LAoJIkR1Y2tfTGltaXRfQUFfVGltZSI6IDAuMTAwMDAwMDAxNDkwMTE2MTIsCgkiT25zaG90X0xpbWl0X0FBX1R5cGUiOiAwLAoJIldhbGtfTEJZX0FBX1R5cGUiOiAxLAoJIkR1Y2tfTGltaXRfQUFfTWF4IjogNjAsCgkiV2Fsa19MaW1pdF9BQV9UeXBlIjogMSwKCSJKdW1wX1lhd19BQV9NaW4iOiAxMywKCSJEUF9WaXNpYmxlX0VuYWJsZSI6IGZhbHNlLAoJIkRFX0VuYWJsZSI6IHRydWUsCgkiQXV0b19TY29wZV9KdW1wX0hDIjogMjUsCgkiQVdQX0hlYWRfU2NhbGUiOiAxOCwKCSJTbG93d2Fsa19GYWtlX09wdGlvbnMiOiA3LAoJIkR1Y2tfTGltaXRfQUFfVHlwZSI6IDEsCgkiU3RhbmRfQUFfT3ZlcnJpZGVfWWF3IjogdHJ1ZSwKCSJERV9BdXRvV2FsbCI6IDMxLAoJIlBlZWtfTEJZX0FBX1R5cGUiOiAwLAoJIkZsaWNrZXJfT2Zmc2V0IjogMTA5LAoJIkZONTdfSEMiOiA1MiwKCSJERV9WaXNpYmxlX0VuYWJsZSI6IGZhbHNlLAoJIkp1bXBfRmFrZUxhZ19UeXBlIjogMCwKCSJQZWVrX0xpbWl0X0FBX1RpbWUiOiAwLjMwMDAwMDAxMTkyMDkyODk2LAoJIkZONTdfTWluX0RNRyI6IDEsCgkiUGVla19BQV9PdmVycmlkZV9MQlkiOiBmYWxzZSwKCSJPbnNob3RfTGltaXRfQUFfVGltZSI6IDAuMzAwMDAwMDExOTIwOTI4OTYsCgkiRFBfRW5hYmxlIjogdHJ1ZSwKCSJMZWdpdF9MaW1pdF9BQV9UeXBlIjogMCwKCSJTdGFuZF9ZYXdfQUFfVGltZSI6IDAuMTAwMDAwMDAxNDkwMTE2MTIsCgkiSnVtcF9GYWtlTGFnX01pbiI6IDAsCgkiREVfVmlzaWJsZV9ETUciOiAyNSwKCSJKdW1wX0xpbWl0X0FBX1R5cGUiOiAwLAoJIldhbGtfTEJZX0FBX01heCI6IDU4LAoJIk9uc2hvdF9GYWtlTGFnX01pbiI6IDYsCgkiT25zaG90X0FBX092ZXJyaWRlX1lhdyI6IGZhbHNlLAoJIlN0YW5kX0xCWV9BQV9NYXgiOiA1OCwKCSJKdW1wX0Zha2VMYWdfUmF0ZSI6IDEsCgkiV2Fsa19GYWtlTGFnX01pbiI6IDUsCgkiT25zaG90X0xCWV9BQV9UaW1lIjogMC4zMDAwMDAwMTE5MjA5Mjg5NiwKCSJMZWdpdF9MQllfQUFfTWluIjogLTEyLAoJIkxlZ2l0X0xpbWl0X0FBX01pbiI6IDYwLAoJIlNjb3V0X0VuYWJsZSI6IHRydWUsCgkiU3RhbmRfTGltaXRfQUFfTWluIjogNjAsCgkiSnVtcF9GYWtlTGFnX01heCI6IDAsCgkiRk41N19Cb2R5X1NjYWxlIjogMjcsCgkiRk41N19KdW1wX0hDIjogMjgsCgkiRFBfRFRfQ29yIjogZmFsc2UsCgkiSnVtcF9MaW1pdF9BQV9NYXgiOiA2MCwKCSJBdXRvX0RUX0NoYXJnZSI6IGZhbHNlLAoJIlN0YW5kX0xpbWl0X0FBX1R5cGUiOiA0LAoJIkRFX0hlYWRfU2NhbGUiOiA1OCwKCSJERV9EVF9Db3IiOiBmYWxzZSwKCSJTbG93d2Fsa19ZYXdfQUFfTWF4IjogMzUsCgkiV2Fsa19ZYXdfQUFfTWF4IjogMjEsCgkiUjhfVmlzaWJsZV9FbmFibGUiOiBmYWxzZSwKCSJXYWxrX0xpbWl0X0FBX01pbiI6IDU5LAoJIlN0YW5kX0xCWV9BQV9UaW1lIjogMC4xMDAwMDAwMDE0OTAxMTYxMiwKCSJERV9IQyI6IDUyLAoJIkF1dG9fTm9fU2NvcGVfSnVtcF9IQyI6IDI1LAoJIkF1dG9fQXV0b1dhbGwiOiAzNCwKCSJBdXRvX0JvZHlfU2NhbGUiOiA1NSwKCSJBdXRvX0RUX0VuaGVuY2UiOiBmYWxzZSwKCSJTY291dF9TY29wZV9KdW1wX0hDIjogNDYsCgkiU2NvdXRfVmlzaWJsZV9FbmFibGUiOiBmYWxzZSwKCSJTY291dF9WaXNpYmxlX0RNRyI6IDEwMCwKCSJTdGFuZF9BQV9PdmVycmlkZV9MQlkiOiB0cnVlLAoJIkRFX01pbl9ETUciOiAxLAoJIkRQX0hDIjogNTIsCgkiU2NvdXRfSGVhZF9TY2FsZSI6IDY4LAoJIlNsb3d3YWxrX0xpbWl0X0FBX1R5cGUiOiA0LAoJIlRlY19IQyI6IDUyLAoJIlI4X01heF9ETUciOiA3NywKCSJBV1BfQXV0b1dhbGxfRW5hYmxlIjogZmFsc2UsCgkiUjhfSGVhZF9TY2FsZSI6IDQ4LAoJIkFXUF9Cb2R5X1NjYWxlIjogOTcsCgkiQVdQX1Njb3BlX0p1bXBfSEMiOiA0NSwKCSJPbnNob3RfTGltaXRfQUFfTWluIjogMCwKCSJPbnNob3RfWWF3X0FBX1RpbWUiOiAwLjMwMDAwMDAxMTkyMDkyODk2Cn0="
        local v = json.parse(base64.decode(clipboard.get()))
        if type(v) == "table" then
            Script_Data.Rage.AntiAim_Brute_Force:set(v.AntiAim_Brute_Force)
            Script_Data.Rage.Big_Angle_Offset:set(v.Big_Angle_Offset)
            Script_Data.Rage.Flicker_Offset:set(v.Flicker_Offset)
            Script_Data.Rage.Stand_Fake_Options:set(v.Stand_Fake_Options)
            Script_Data.Rage.Stand_AA_Override_Limit:set(v.Stand_AA_Override_Limit)
            Script_Data.Rage.Stand_Limit_AA_Type:set(v.Stand_Limit_AA_Type)
            Script_Data.Rage.Stand_Limit_AA_Time:set(v.Stand_Limit_AA_Time)
            Script_Data.Rage.Stand_Limit_AA_Min:set(v.Stand_Limit_AA_Min)
            Script_Data.Rage.Stand_Limit_AA_Max:set(v.Stand_Limit_AA_Max)
            Script_Data.Rage.Stand_AA_Override_Yaw:set(v.Stand_AA_Override_Yaw)
            Script_Data.Rage.Stand_Yaw_AA_Type:set(v.Stand_Yaw_AA_Type)
            Script_Data.Rage.Stand_Yaw_AA_Time:set(v.Stand_Yaw_AA_Time)
            Script_Data.Rage.Stand_Yaw_AA_Min:set(v.Stand_Yaw_AA_Min)
            Script_Data.Rage.Stand_Yaw_AA_Max:set(v.Stand_Yaw_AA_Max)
            Script_Data.Rage.Stand_AA_Override_LBY:set(v.Stand_AA_Override_LBY)
            Script_Data.Rage.Stand_LBY_AA_Type:set(v.Stand_LBY_AA_Type)
            Script_Data.Rage.Stand_LBY_AA_Time:set(v.Stand_LBY_AA_Time)
            Script_Data.Rage.Stand_LBY_AA_Min:set(v.Stand_LBY_AA_Min)
            Script_Data.Rage.Stand_LBY_AA_Max:set(v.Stand_LBY_AA_Max)

            Script_Data.Rage.Walk_Fake_Options:set(v.Walk_Fake_Options)
            Script_Data.Rage.Walk_AA_Override_Limit:set(v.Walk_AA_Override_Limit)
            Script_Data.Rage.Walk_Limit_AA_Type:set(v.Walk_Limit_AA_Type)
            Script_Data.Rage.Walk_Limit_AA_Time:set(v.Walk_Limit_AA_Time)
            Script_Data.Rage.Walk_Limit_AA_Min:set(v.Walk_Limit_AA_Min)
            Script_Data.Rage.Walk_Limit_AA_Max:set(v.Walk_Limit_AA_Max)
            Script_Data.Rage.Walk_AA_Override_Yaw:set(v.Walk_AA_Override_Yaw)
            Script_Data.Rage.Walk_Yaw_AA_Type:set(v.Walk_Yaw_AA_Type)
            Script_Data.Rage.Walk_Yaw_AA_Time:set(v.Walk_Yaw_AA_Time)
            Script_Data.Rage.Walk_Yaw_AA_Min:set(v.Walk_Yaw_AA_Min)
            Script_Data.Rage.Walk_Yaw_AA_Max:set(v.Walk_Yaw_AA_Max)
            Script_Data.Rage.Walk_AA_Override_LBY:set(v.Walk_AA_Override_LBY)
            Script_Data.Rage.Walk_LBY_AA_Type:set(v.Walk_LBY_AA_Type)
            Script_Data.Rage.Walk_LBY_AA_Time:set(v.Walk_LBY_AA_Time)
            Script_Data.Rage.Walk_LBY_AA_Min:set(v.Walk_LBY_AA_Min)
            Script_Data.Rage.Walk_LBY_AA_Max:set(v.Walk_LBY_AA_Max)

            Script_Data.Rage.Slowwalk_Fake_Options:set(v.Slowwalk_Fake_Options)
            Script_Data.Rage.Slowwalk_AA_Override_Limit:set(v.Slowwalk_AA_Override_Limit)
            Script_Data.Rage.Slowwalk_Limit_AA_Type:set(v.Slowwalk_Limit_AA_Type)
            Script_Data.Rage.Slowwalk_Limit_AA_Time:set(v.Slowwalk_Limit_AA_Time)
            Script_Data.Rage.Slowwalk_Limit_AA_Min:set(v.Slowwalk_Limit_AA_Min)
            Script_Data.Rage.Slowwalk_Limit_AA_Max:set(v.Slowwalk_Limit_AA_Max)
            Script_Data.Rage.Slowwalk_AA_Override_Yaw:set(v.Slowwalk_AA_Override_Yaw)
            Script_Data.Rage.Slowwalk_Yaw_AA_Type:set(v.Slowwalk_Yaw_AA_Type)
            Script_Data.Rage.Slowwalk_Yaw_AA_Time:set(v.Slowwalk_Yaw_AA_Time)
            Script_Data.Rage.Slowwalk_Yaw_AA_Min:set(v.Slowwalk_Yaw_AA_Min)
            Script_Data.Rage.Slowwalk_Yaw_AA_Max:set(v.Slowwalk_Yaw_AA_Max)
            Script_Data.Rage.Slowwalk_AA_Override_LBY:set(v.Slowwalk_AA_Override_LBY)
            Script_Data.Rage.Slowwalk_LBY_AA_Type:set(v.Slowwalk_LBY_AA_Type)
            Script_Data.Rage.Slowwalk_LBY_AA_Time:set(v.Slowwalk_LBY_AA_Time)
            Script_Data.Rage.Slowwalk_LBY_AA_Min:set(v.Slowwalk_LBY_AA_Min)
            Script_Data.Rage.Slowwalk_LBY_AA_Max:set(v.Slowwalk_LBY_AA_Max)

            Script_Data.Rage.Onshot_Fake_Options:set(v.Onshot_Fake_Options)
            Script_Data.Rage.Onshot_AA_Override_Limit:set(v.Onshot_AA_Override_Limit)
            Script_Data.Rage.Onshot_Limit_AA_Type:set(v.Onshot_Limit_AA_Type)
            Script_Data.Rage.Onshot_Limit_AA_Time:set(v.Onshot_Limit_AA_Time)
            Script_Data.Rage.Onshot_Limit_AA_Min:set(v.Onshot_Limit_AA_Min)
            Script_Data.Rage.Onshot_Limit_AA_Max:set(v.Onshot_Limit_AA_Max)
            Script_Data.Rage.Onshot_AA_Override_Yaw:set(v.Onshot_AA_Override_Yaw)
            Script_Data.Rage.Onshot_Yaw_AA_Type:set(v.Onshot_Yaw_AA_Type)
            Script_Data.Rage.Onshot_Yaw_AA_Time:set(v.Onshot_Yaw_AA_Time)
            Script_Data.Rage.Onshot_Yaw_AA_Min:set(v.Onshot_Yaw_AA_Min)
            Script_Data.Rage.Onshot_Yaw_AA_Max:set(v.Onshot_Yaw_AA_Max)
            Script_Data.Rage.Onshot_AA_Override_LBY:set(v.Onshot_AA_Override_LBY)
            Script_Data.Rage.Onshot_LBY_AA_Type:set(v.Onshot_LBY_AA_Type)
            Script_Data.Rage.Onshot_LBY_AA_Time:set(v.Onshot_LBY_AA_Time)
            Script_Data.Rage.Onshot_LBY_AA_Min:set(v.Onshot_LBY_AA_Min)
            Script_Data.Rage.Onshot_LBY_AA_Max:set(v.Onshot_LBY_AA_Max)

            Script_Data.Rage.Duck_Fake_Options:set(v.Duck_Fake_Options)
            Script_Data.Rage.Duck_AA_Override_Limit:set(v.Duck_AA_Override_Limit)
            Script_Data.Rage.Duck_Limit_AA_Type:set(v.Duck_Limit_AA_Type)
            Script_Data.Rage.Duck_Limit_AA_Time:set(v.Duck_Limit_AA_Time)
            Script_Data.Rage.Duck_Limit_AA_Min:set(v.Duck_Limit_AA_Min)
            Script_Data.Rage.Duck_Limit_AA_Max:set(v.Duck_Limit_AA_Max)
            Script_Data.Rage.Duck_AA_Override_Yaw:set(v.Duck_AA_Override_Yaw)
            Script_Data.Rage.Duck_Yaw_AA_Type:set(v.Duck_Yaw_AA_Type)
            Script_Data.Rage.Duck_Yaw_AA_Time:set(v.Duck_Yaw_AA_Time)
            Script_Data.Rage.Duck_Yaw_AA_Min:set(v.Duck_Yaw_AA_Min)
            Script_Data.Rage.Duck_Yaw_AA_Max:set(v.Duck_Yaw_AA_Max)
            Script_Data.Rage.Duck_AA_Override_LBY:set(v.Duck_AA_Override_LBY)
            Script_Data.Rage.Duck_LBY_AA_Type:set(v.Duck_LBY_AA_Type)
            Script_Data.Rage.Duck_LBY_AA_Time:set(v.Duck_LBY_AA_Time)
            Script_Data.Rage.Duck_LBY_AA_Min:set(v.Duck_LBY_AA_Min)
            Script_Data.Rage.Duck_LBY_AA_Max:set(v.Duck_LBY_AA_Max)

            Script_Data.Rage.Jump_Fake_Options:set(v.Jump_Fake_Options)
            Script_Data.Rage.Jump_AA_Override_Limit:set(v.Jump_AA_Override_Limit)
            Script_Data.Rage.Jump_Limit_AA_Type:set(v.Jump_Limit_AA_Type)
            Script_Data.Rage.Jump_Limit_AA_Time:set(v.Jump_Limit_AA_Time)
            Script_Data.Rage.Jump_Limit_AA_Min:set(v.Jump_Limit_AA_Min)
            Script_Data.Rage.Jump_Limit_AA_Max:set(v.Jump_Limit_AA_Max)
            Script_Data.Rage.Jump_AA_Override_Yaw:set(v.Jump_AA_Override_Yaw)
            Script_Data.Rage.Jump_Yaw_AA_Type:set(v.Jump_Yaw_AA_Type)
            Script_Data.Rage.Jump_Yaw_AA_Time:set(v.Jump_Yaw_AA_Time)
            Script_Data.Rage.Jump_Yaw_AA_Min:set(v.Jump_Yaw_AA_Min)
            Script_Data.Rage.Jump_Yaw_AA_Max:set(v.Jump_Yaw_AA_Max)
            Script_Data.Rage.Jump_AA_Override_LBY:set(v.Jump_AA_Override_LBY)
            Script_Data.Rage.Jump_LBY_AA_Type:set(v.Jump_LBY_AA_Type)
            Script_Data.Rage.Jump_LBY_AA_Time:set(v.Jump_LBY_AA_Time)
            Script_Data.Rage.Jump_LBY_AA_Min:set(v.Jump_LBY_AA_Min)
            Script_Data.Rage.Jump_LBY_AA_Max:set(v.Jump_LBY_AA_Max)

            Script_Data.Rage.Peek_Fake_Options:set(v.Peek_Fake_Options)
            Script_Data.Rage.Peek_AA_Override_Limit:set(v.Peek_AA_Override_Limit)
            Script_Data.Rage.Peek_Limit_AA_Type:set(v.Peek_Limit_AA_Type)
            Script_Data.Rage.Peek_Limit_AA_Time:set(v.Peek_Limit_AA_Time)
            Script_Data.Rage.Peek_Limit_AA_Min:set(v.Peek_Limit_AA_Min)
            Script_Data.Rage.Peek_Limit_AA_Max:set(v.Peek_Limit_AA_Max)
            Script_Data.Rage.Peek_AA_Override_Yaw:set(v.Peek_AA_Override_Yaw)
            Script_Data.Rage.Peek_Yaw_AA_Type:set(v.Peek_Yaw_AA_Type)
            Script_Data.Rage.Peek_Yaw_AA_Time:set(v.Peek_Yaw_AA_Time)
            Script_Data.Rage.Peek_Yaw_AA_Min:set(v.Peek_Yaw_AA_Min)
            Script_Data.Rage.Peek_Yaw_AA_Max:set(v.Peek_Yaw_AA_Max)
            Script_Data.Rage.Peek_AA_Override_LBY:set(v.Peek_AA_Override_LBY)
            Script_Data.Rage.Peek_LBY_AA_Type:set(v.Peek_LBY_AA_Type)
            Script_Data.Rage.Peek_LBY_AA_Time:set(v.Peek_LBY_AA_Time)
            Script_Data.Rage.Peek_LBY_AA_Min:set(v.Peek_LBY_AA_Min)
            Script_Data.Rage.Peek_LBY_AA_Max:set(v.Peek_LBY_AA_Max)

            Script_Data.Rage.Legit_Fake_Options:set(v.Legit_Fake_Options)
            Script_Data.Rage.Legit_AA_Override_Limit:set(v.Legit_AA_Override_Limit)
            Script_Data.Rage.Legit_Limit_AA_Type:set(v.Legit_Limit_AA_Type)
            Script_Data.Rage.Legit_Limit_AA_Time:set(v.Legit_Limit_AA_Time)
            Script_Data.Rage.Legit_Limit_AA_Min:set(v.Legit_Limit_AA_Min)
            Script_Data.Rage.Legit_Limit_AA_Max:set(v.Legit_Limit_AA_Max)
            Script_Data.Rage.Legit_AA_Override_Yaw:set(v.Legit_AA_Override_Yaw)
            Script_Data.Rage.Legit_Yaw_AA_Type:set(v.Legit_Yaw_AA_Type)
            Script_Data.Rage.Legit_Yaw_AA_Time:set(v.Legit_Yaw_AA_Time)
            Script_Data.Rage.Legit_Yaw_AA_Min:set(v.Legit_Yaw_AA_Min)
            Script_Data.Rage.Legit_Yaw_AA_Max:set(v.Legit_Yaw_AA_Max)
            Script_Data.Rage.Legit_AA_Override_LBY:set(v.Legit_AA_Override_LBY)
            Script_Data.Rage.Legit_LBY_AA_Type:set(v.Legit_LBY_AA_Type)
            Script_Data.Rage.Legit_LBY_AA_Time:set(v.Legit_LBY_AA_Time)
            Script_Data.Rage.Legit_LBY_AA_Min:set(v.Legit_LBY_AA_Min)
            Script_Data.Rage.Legit_LBY_AA_Max:set(v.Legit_LBY_AA_Max)

            Script_Data.Rage.Slowwalk_FakeLag_Type:set(v.Slowwalk_FakeLag_Type)
            Script_Data.Rage.Slowwalk_FakeLag_Min:set(v.Slowwalk_FakeLag_Min)
            Script_Data.Rage.Slowwalk_FakeLag_Max:set(v.Slowwalk_FakeLag_Max)
            Script_Data.Rage.Slowwalk_FakeLag_Rate:set(v.Slowwalk_FakeLag_Rate)

            Script_Data.Rage.Walk_FakeLag_Type:set(v.Walk_FakeLag_Type)
            Script_Data.Rage.Walk_FakeLag_Min:set(v.Walk_FakeLag_Min)
            Script_Data.Rage.Walk_FakeLag_Max:set(v.Walk_FakeLag_Max)
            Script_Data.Rage.Walk_FakeLag_Rate:set(v.Walk_FakeLag_Rate)

            Script_Data.Rage.Jump_FakeLag_Type:set(v.Jump_FakeLag_Type)
            Script_Data.Rage.Jump_FakeLag_Min:set(v.Jump_FakeLag_Min)
            Script_Data.Rage.Jump_FakeLag_Max:set(v.Jump_FakeLag_Max)
            Script_Data.Rage.Jump_FakeLag_Rate:set(v.Jump_FakeLag_Rate)

            Script_Data.Rage.Onshot_FakeLag_Type:set(v.Onshot_FakeLag_Type)
            Script_Data.Rage.Onshot_FakeLag_Min:set(v.Onshot_FakeLag_Min)
            Script_Data.Rage.Onshot_FakeLag_Max:set(v.Onshot_FakeLag_Max)
            Script_Data.Rage.Onshot_FakeLag_Rate:set(v.Onshot_FakeLag_Rate)
            

            --Script_Data.Weapon.Override_Key:set(v.Override_Key)
            --Script_Data.Weapon.Override_Type:set(v.Override_Type)

            Script_Data.Weapon.DE_Max_DMG:set(v.DE_Max_DMG)
            Script_Data.Weapon.DE_Min_DMG:set(v.DE_Min_DMG)
            Script_Data.Weapon.DE_HC:set(v.DE_HC)
            Script_Data.Weapon.DE_Jump_HC:set(v.DE_Jump_HC)
            Script_Data.Weapon.DE_Visible_Enable:set(v.DE_Visible_Enable)
            Script_Data.Weapon.DE_Visible_DMG:set(v.DE_Visible_DMG)
            Script_Data.Weapon.DE_AutoWall_Enable:set(v.DE_AutoWall_Enable)
            Script_Data.Weapon.DE_AutoWall:set(v.DE_AutoWall)
            Script_Data.Weapon.DE_Head_Scale:set(v.DE_Head_Scale)
            Script_Data.Weapon.DE_Body_Scale:set(v.DE_Body_Scale)
            Script_Data.Weapon.DE_DT_Enhence:set(v.DE_DT_Enhence)
            Script_Data.Weapon.DE_DT_Cor:set(v.DE_DT_Cor)
            Script_Data.Weapon.DE_DT_Speed:set(v.DE_DT_Speed)
            Script_Data.Weapon.DE_DT_Charge:set(v.DE_DT_Charge)

            Script_Data.Weapon.R8_Max_DMG:set(v.R8_Max_DMG)
            Script_Data.Weapon.R8_Min_DMG:set(v.R8_Min_DMG)
            Script_Data.Weapon.R8_HC:set(v.R8_HC)
            Script_Data.Weapon.R8_Jump_HC:set(v.R8_Jump_HC)
            Script_Data.Weapon.R8_Visible_Enable:set(v.R8_Visible_Enable)
            Script_Data.Weapon.R8_Visible_DMG:set(v.R8_Visible_DMG)
            Script_Data.Weapon.R8_AutoWall_Enable:set(v.R8_AutoWall_Enable)
            Script_Data.Weapon.R8_AutoWall:set(v.R8_AutoWall)
            Script_Data.Weapon.R8_Head_Scale:set(v.R8_Head_Scale)
            Script_Data.Weapon.R8_Body_Scale:set(v.R8_Body_Scale)

            Script_Data.Weapon.Auto_Max_DMG:set(v.Auto_Max_DMG)
            Script_Data.Weapon.Auto_Min_DMG:set(v.Auto_Min_DMG)
            Script_Data.Weapon.Auto_Scope_HC:set(v.Auto_Scope_HC)
            Script_Data.Weapon.Auto_Scope_Jump_HC:set(v.Auto_Scope_Jump_HC)
            Script_Data.Weapon.Auto_No_Scope_HC:set(v.Auto_No_Scope_HC)
            Script_Data.Weapon.Auto_No_Scope_Jump_HC:set(v.Auto_No_Scope_Jump_HC)
            Script_Data.Weapon.Auto_Visible_Enable:set(v.Auto_Visible_Enable)
            Script_Data.Weapon.Auto_Visible_DMG:set(v.Auto_Visible_DMG)
            Script_Data.Weapon.Auto_AutoWall_Enable:set(v.Auto_AutoWall_Enable)
            Script_Data.Weapon.Auto_AutoWall:set(v.Auto_AutoWall)
            Script_Data.Weapon.Auto_Head_Scale:set(v.Auto_Head_Scale)
            Script_Data.Weapon.Auto_Body_Scale:set(v.Auto_Body_Scale)
            Script_Data.Weapon.Auto_DT_Enhence:set(v.Auto_DT_Enhence)
            Script_Data.Weapon.Auto_DT_Cor:set(v.Auto_DT_Cor)
            Script_Data.Weapon.Auto_DT_Speed:set(v.Auto_DT_Speed)
            Script_Data.Weapon.Auto_DT_Charge:set(v.Auto_DT_Charge)

            Script_Data.Weapon.Scout_Max_DMG:set(v.Scout_Max_DMG)
            Script_Data.Weapon.Scout_Min_DMG:set(v.Scout_Min_DMG)
            Script_Data.Weapon.Scout_Scope_HC:set(v.Scout_Scope_HC)
            Script_Data.Weapon.Scout_Scope_Jump_HC:set(v.Scout_Scope_Jump_HC)
            Script_Data.Weapon.Scout_No_Scope_HC:set(v.Scout_No_Scope_HC)
            Script_Data.Weapon.Scout_No_Scope_Jump_HC:set(v.Scout_No_Scope_Jump_HC)
            Script_Data.Weapon.Scout_Visible_Enable:set(v.Scout_Visible_Enable)
            Script_Data.Weapon.Scout_Visible_DMG:set(v.Scout_Visible_DMG)
            Script_Data.Weapon.Scout_AutoWall_Enable:set(v.Scout_AutoWall_Enable)
            Script_Data.Weapon.Scout_AutoWall:set(v.Scout_AutoWall)
            Script_Data.Weapon.Scout_Head_Scale:set(v.Scout_Head_Scale)
            Script_Data.Weapon.Scout_Body_Scale:set(v.Scout_Body_Scale)

            Script_Data.Weapon.AWP_Max_DMG:set(v.AWP_Max_DMG)
            Script_Data.Weapon.AWP_Min_DMG:set(v.AWP_Min_DMG)
            Script_Data.Weapon.AWP_Scope_HC:set(v.AWP_Scope_HC)
            Script_Data.Weapon.AWP_Scope_Jump_HC:set(v.AWP_Scope_Jump_HC)
            Script_Data.Weapon.AWP_No_Scope_HC:set(v.AWP_No_Scope_HC)
            Script_Data.Weapon.AWP_No_Scope_Jump_HC:set(v.AWP_No_Scope_Jump_HC)
            Script_Data.Weapon.AWP_Visible_Enable:set(v.AWP_Visible_Enable)
            Script_Data.Weapon.AWP_Visible_DMG:set(v.AWP_Visible_DMG)
            Script_Data.Weapon.AWP_AutoWall_Enable:set(v.AWP_AutoWall_Enable)
            Script_Data.Weapon.AWP_AutoWall:set(v.AWP_AutoWall)
            Script_Data.Weapon.AWP_Head_Scale:set(v.AWP_Head_Scale)
            Script_Data.Weapon.AWP_Body_Scale:set(v.AWP_Body_Scale)

            Script_Data.Weapon.Tec_Max_DMG:set(v.Tec_Max_DMG)
            Script_Data.Weapon.Tec_Min_DMG:set(v.Tec_Min_DMG)
            Script_Data.Weapon.Tec_HC:set(v.Tec_HC)
            Script_Data.Weapon.Tec_Jump_HC:set(v.Tec_Jump_HC)
            Script_Data.Weapon.Tec_Visible_Enable:set(v.Tec_Visible_Enable)
            Script_Data.Weapon.Tec_Visible_DMG:set(v.Tec_Visible_DMG)
            Script_Data.Weapon.Tec_AutoWall_Enable:set(v.Tec_AutoWall_Enable)
            Script_Data.Weapon.Tec_AutoWall:set(v.Tec_AutoWall)
            Script_Data.Weapon.Tec_Head_Scale:set(v.Tec_Head_Scale)
            Script_Data.Weapon.Tec_Body_Scale:set(v.Tec_Body_Scale)
            Script_Data.Weapon.Tec_DT_Enhence:set(v.Tec_DT_Enhence)
            Script_Data.Weapon.Tec_DT_Cor:set(v.Tec_DT_Cor)
            Script_Data.Weapon.Tec_DT_Speed:set(v.Tec_DT_Speed)
            Script_Data.Weapon.Tec_DT_Charge:set(v.Tec_DT_Charge)

            Script_Data.Weapon.FN57_Max_DMG:set(v.FN57_Max_DMG)
            Script_Data.Weapon.FN57_Min_DMG:set(v.FN57_Min_DMG)
            Script_Data.Weapon.FN57_HC:set(v.FN57_HC)
            Script_Data.Weapon.FN57_Jump_HC:set(v.FN57_Jump_HC)
            Script_Data.Weapon.FN57_Visible_Enable:set(v.FN57_Visible_Enable)
            Script_Data.Weapon.FN57_Visible_DMG:set(v.FN57_Visible_DMG)
            Script_Data.Weapon.FN57_AutoWall_Enable:set(v.FN57_AutoWall_Enable)
            Script_Data.Weapon.FN57_AutoWall:set(v.FN57_AutoWall)
            Script_Data.Weapon.FN57_Head_Scale:set(v.FN57_Head_Scale)
            Script_Data.Weapon.FN57_Body_Scale:set(v.FN57_Body_Scale)
            Script_Data.Weapon.FN57_DT_Enhence:set(v.FN57_DT_Enhence)
            Script_Data.Weapon.FN57_DT_Cor:set(v.FN57_DT_Cor)
            Script_Data.Weapon.FN57_DT_Speed:set(v.FN57_DT_Speed)
            Script_Data.Weapon.FN57_DT_Charge:set(v.FN57_DT_Charge)

            Script_Data.Weapon.DP_Max_DMG:set(v.DP_Max_DMG)
            Script_Data.Weapon.DP_Min_DMG:set(v.DP_Min_DMG)
            Script_Data.Weapon.DP_HC:set(v.DP_HC)
            Script_Data.Weapon.DP_Jump_HC:set(v.DP_Jump_HC)
            Script_Data.Weapon.DP_Visible_Enable:set(v.DP_Visible_Enable)
            Script_Data.Weapon.DP_Visible_DMG:set(v.DP_Visible_DMG)
            Script_Data.Weapon.DP_AutoWall_Enable:set(v.DP_AutoWall_Enable)
            Script_Data.Weapon.DP_AutoWall:set(v.DP_AutoWall)
            Script_Data.Weapon.DP_Head_Scale:set(v.DP_Head_Scale)
            Script_Data.Weapon.DP_Body_Scale:set(v.DP_Body_Scale)
            Script_Data.Weapon.DP_DT_Enhence:set(v.DP_DT_Enhence)
            Script_Data.Weapon.DP_DT_Cor:set(v.DP_DT_Cor)
            Script_Data.Weapon.DP_DT_Speed:set(v.DP_DT_Speed)
            Script_Data.Weapon.DP_DT_Charge:set(v.DP_DT_Charge)

            Script_Data.Weapon.DE_Enable:set(v.DE_Enable)
            Script_Data.Weapon.R8_Enable:set(v.R8_Enable)
            Script_Data.Weapon.Auto_Enable:set(v.Auto_Enable)
            Script_Data.Weapon.Scout_Enable:set(v.Scout_Enable)
            Script_Data.Weapon.AWP_Enable:set(v.AWP_Enable)
            Script_Data.Weapon.Tec_Enable:set(v.Tec_Enable)
            Script_Data.Weapon.FN57_Enable:set(v.FN57_Enable)
            Script_Data.Weapon.DP_Enable:set(v.DP_Enable)

            --ui_a:set(v.a)
            --ui_b:set(v.b)
            common.add_notify("Config Import", "Config Import Success")
        else
            error("无效")
        end
    end
)]]