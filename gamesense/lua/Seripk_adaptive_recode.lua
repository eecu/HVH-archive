local client_latency, client_set_clan_tag, client_log, client_timestamp, client_userid_to_entindex, client_trace_line, client_set_event_callback, client_screen_size, client_trace_bullet, client_color_log, client_system_time, client_delay_call, client_visible, client_exec, client_eye_position, client_set_cvar, client_scale_damage, client_draw_hitboxes, client_get_cvar, client_camera_angles, client_draw_debug_text, client_random_int, client_random_float = client.latency, client.set_clan_tag, client.log, client.timestamp, client.userid_to_entindex, client.trace_line, client.set_event_callback, client.screen_size, client.trace_bullet, client.color_log, client.system_time, client.delay_call, client.visible, client.exec, client.eye_position, client.set_cvar, client.scale_damage, client.draw_hitboxes, client.get_cvar, client.camera_angles, client.draw_debug_text, client.random_int, client.random_float
local entity_get_player_resource, entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_is_dormant, entity_get_steam64, entity_get_player_name, entity_hitbox_position, entity_get_game_rules, entity_get_all, entity_set_prop, entity_is_alive, entity_get_player_weapon, entity_get_prop, entity_get_players, entity_get_classname = entity.get_player_resource, entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.is_dormant, entity.get_steam64, entity.get_player_name, entity.hitbox_position, entity.get_game_rules, entity.get_all, entity.set_prop, entity.is_alive, entity.get_player_weapon, entity.get_prop, entity.get_players, entity.get_classname
local globals_realtime, globals_absoluteframetime, globals_tickcount, globals_lastoutgoingcommand, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.tickcount, globals.lastoutgoingcommand, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers
local ui_new_slider, ui_new_combobox, ui_reference, ui_is_menu_open, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_set_callback, ui_set, ui_new_checkbox, ui_new_hotkey, ui_new_button, ui_new_multiselect, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.is_menu_open, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.set_callback, ui.set, ui.new_checkbox, ui.new_hotkey, ui.new_button, ui.new_multiselect, ui.get
local renderer_circle_outline, renderer_rectangle, renderer_gradient, renderer_circle, renderer_text, renderer_line, renderer_measure_text, renderer_indicator, renderer_world_to_screen = renderer.circle_outline, renderer.rectangle, renderer.gradient, renderer.circle, renderer.text, renderer.line, renderer.measure_text, renderer.indicator, renderer.world_to_screen
local math_ceil, math_tan, math_cos, math_sinh, math_pi, math_max, math_atan2, math_floor, math_sqrt, math_deg, math_atan, math_fmod, math_acos, math_pow, math_abs, math_min, math_sin, math_log, math_exp, math_cosh, math_asin, math_rad = math.ceil, math.tan, math.cos, math.sinh, math.pi, math.max, math.atan2, math.floor, math.sqrt, math.deg, math.atan, math.fmod, math.acos, math.pow, math.abs, math.min, math.sin, math.log, math.exp, math.cosh, math.asin, math.rad
local table_sort, table_remove, table_concat, table_insert = table.sort, table.remove, table.concat, table.insert
local find_material = materialsystem.find_material
local string_find, string_format, string_gsub, string_len, string_gmatch, string_match, string_reverse, string_upper, string_lower, string_sub = string.find, string.format, string.gsub, string.len, string.gmatch, string.match, string.reverse, string.upper, string.lower, string.sub
local ipairs, assert, pairs, next, tostring, tonumber, setmetatable, unpack, type, getmetatable, pcall, error = ipairs, assert, pairs, next, tostring, tonumber, setmetatable, unpack, type, getmetatable, pcall, error
local clipboard = require 'gamesense/clipboard'
local base64 = require 'gamesense/base64'
local csgo_weapons = require("gamesense/csgo_weapons")
local vector = require('vector')
local ui_mouse_position = ui.mouse_position
local client_key_state = client.key_state

local gui_handler,adp,utils = {},{},{}
local animate =(function()local b={}local c=function(d,e)local f=12;return d+(e-d)*globals_frametime()*f end;local g=function(d,e)return d+(e-d)*globals_frametime()*8 end;b.new_notify=function(h,i,j,k)if k~=nil then if k then return g(h,i)else return g(h,j)end else return g(h,i)end end;b.new=function(h,i,j,k)if k~=nil then if k then return c(h,i)else return c(h,j)end else return c(h,i)end end;b.new_color=function(l,m,n,k)if k~=nil then if k then l.r=c(l.r,m.r)l.g=c(l.g,m.g)l.b=c(l.b,m.b)l.a=c(l.a,m.a)else l.r=c(l.r,n.r)l.g=c(l.g,n.g)l.b=c(l.b,n.b)l.a=c(l.a,n.a)end else l.r=c(l.r,m.r)l.g=c(l.g,m.g)l.b=c(l.b,m.b)l.a=c(l.a,m.a)end;return{r=l.r,g=l.g,b=l.b,a=l.a}end;b.new_flash=function(o,p,q,r,s,t)local s=s or 1;local t=t or 0.1;if o<p+s then r=q elseif o>q-s then r=p end;return o+(r-o)*t*globals_absoluteframetime()*10 end;return b end)()
gui_handler.export={['number']={},['boolean']={},['table']={},['string']={}}gui_handler.call={}gui_handler.export_config=function()local a=function(b)b=ui_get(b)local c=""for d=1,#b do c=c..b[d]..(d==#b and""or",")end;if c==""then c="-"end;return c end;local c=""for d,e in pairs(gui_handler.export['number'])do c=c..tostring(ui_get(e))..'|'end;for d,e in pairs(gui_handler.export['string'])do c=c..ui_get(e)..'|'end;for d,e in pairs(gui_handler.export['boolean'])do c=c..tostring(ui_get(e))..'|'end;for d,e in pairs(gui_handler.export['table'])do c=c..a(e)..'|'end;clipboard.set(base64.encode(c,'base64'))end;gui_handler.load_config=function()local f=function(g,h)local i={}for c in string.gmatch(g,"([^"..h.."]+)")do i[#i+1]=string.gsub(c,"\n","")end;return i end;local j=function(c)if c=="true"or c=="false"then return c=="true"else return c end end;local k=f(base64.decode(clipboard.get(),'base64'),"|")local l=1;for d,e in pairs(gui_handler.export['number'])do ui_set(e,tonumber(k[l]))l=l+1 end;for d,e in pairs(gui_handler.export['string'])do ui_set(e,k[l])l=l+1 end;for d,e in pairs(gui_handler.export['boolean'])do ui_set(e,j(k[l]))l=l+1 end;for d,e in pairs(gui_handler.export['table'])do ui_set(e,f(k[l],','))l=l+1 end end;gui_handler.update_callbacks=function()for m,n in pairs(gui_handler.call)do if n~=nil then ui_set_visible(n.ref,n.conditon())end end end;gui_handler.new=function(n,o,...)if type(n)~='number'then print('unable to create new register,register should be a number')end;if type(n)=='number'then table_insert(gui_handler.export[type(ui_get(n))],n)end;if o==nil then o=function()return true end end;if gui_handler.call[n]==nil then gui_handler.call[n]={}end;gui_handler.call[n]={ref=n,conditon=function()return o end}gui_handler.update_callbacks()ui_set_callback(n,gui_handler.update_callbacks)return n end
local weapon_list ={"Global","Taser","Revolver","Pistol","Auto","Scout","AWP","Rifle","SMG","Shotgun","Deagle"}local weapon_idx={[1]=11,[2]=4,[3]=4,[4]=4,[7]=8,[8]=8,[9]=7,[10]=8,[11]=5,[13]=8,[14]=8,[16]=8,[17]=9,[19]=9,[23]=9,[24]=9,[25]=10,[26]=9,[27]=10,[28]=8,[29]=10,[30]=4,[31]=2,[32]=4,[33]=9,[34]=9,[35]=10,[36]=4,[38]=5,[39]=8,[40]=6,[60]=8,[61]=4,[63]=4,[64]=3}local damage_idx={[0]="Auto",[101]="HP + 1",[102]="HP + 2",[103]="HP + 3",[104]="HP + 4",[105]="HP + 5",[106]="HP + 6",[107]="HP + 7",[108]="HP + 8",[109]="HP + 9",[110]="HP + 10",[111]="HP + 11",[112]="HP + 12",[113]="HP + 13",[114]="HP + 14",[115]="HP + 15",[116]="HP + 16",[117]="HP + 17",[118]="HP + 18",[119]="HP + 19",[120]="HP + 20",[121]="HP + 21",[122]="HP + 22",[123]="HP + 23",[124]="HP + 24",[125]="HP + 25",[126]="HP + 26"}local name_to_num={["Global"]=1,["Taser"]=2,["Revolver"]=3,["Pistol"]=4,["Auto"]=5,["Scout"]=6,["AWP"]=7,["Rifle"]=8,["SMG"]=9,["Shotgun"]=10,["Deagle"]=11}    
local sc_weapon = { name_to_num["Scout"], name_to_num["Auto"], name_to_num["AWP"] }    local min_damage, last_weapon = "default", 0
local contains=function(b,c)if#b>0 then for d=1,#b do if b[d]==c then return true end end end;return false end
local step_fn =(function()local b={}local c=function(d,e,f)if d<e then d=e elseif d>f then d=f end;return d end;local g=0;b.step=function(e,f,h,i)local j=e;local k=f;local h=h;local l=globals_tickcount()%i;if l==i-1 then if g<k then g=g+h elseif g>=k then g=j end end;return c(g,j,k)end;return b end)()
local ragebot = {
    enabled = {ui_reference("RAGE", "Aimbot", "Enabled")},
    target_selection = ui_reference("RAGE", "Aimbot", "Target selection"),
    target_hitbox = ui_reference("RAGE", "Aimbot", "Target hitbox"),
    multipoint = {ui_reference("RAGE", "Aimbot", "Multi-point")},
    multipoint_scale = ui_reference("RAGE", "Aimbot", "Multi-point scale"),
    prefer_safepoint = ui_reference("RAGE", "Aimbot", "Prefer safe point"),
    force_safepoint = ui_reference("RAGE", "Aimbot", "Force safe point"),
    avoid_unsafe_hitboxes = ui_reference("RAGE", "Aimbot", "Avoid unsafe hitboxes"),
    automatic_fire = ui_reference("RAGE", "Other", "Automatic fire"),
    automatic_penetration = ui_reference("RAGE", "Other", "Automatic penetration"),
    silent_aim = ui_reference("RAGE", "Other", "Silent aim"),
    hitchance = ui_reference("RAGE", "Aimbot", "Minimum hit chance"),
    minimum_damage = ui_reference("RAGE", "Aimbot", "Minimum damage"),
    auto_scope = ui_reference("RAGE", "Aimbot", "Automatic scope"),
    reduce_aim_step = ui_reference("RAGE", "Other", "Reduce aim step"),
    maximum_fov = ui_reference("RAGE", "Other", "Maximum FOV"),
    log_misses_due_to_spread = ui_reference("RAGE", "Other", "Log misses due to spread"),
    low_fps_mitigations = ui_reference("RAGE", "Other", "Low FPS mitigations"),
    remove_recoil = ui_reference("RAGE", "Other", "Remove recoil"),
    accuracy_boost = ui_reference("RAGE", "Other", "Accuracy boost"),
    delay_shot = ui_reference("RAGE", "Other", "Delay shot"),
    quick_stop = {ui_reference("RAGE", "Aimbot", "Quick stop")},
    --quick_stop_options = ui_reference("RAGE", "Aimbot", "Quick stop options"),
    quick_peek_assist = {ui_reference("RAGE", "Other", "Quick peek assist")},
    quick_peek_assist_mode = {ui_reference("RAGE", "Other", "Quick peek assist mode")},
    quick_peek_assist_distance = ui_reference("RAGE", "Other", "Quick peek assist distance"),
    resolver = ui_reference("RAGE", "Other", "Anti-aim correction"),
    prefer_body_aim = ui_reference("RAGE", "Aimbot", "Prefer body aim"),
    prefer_body_aim_disablers = ui_reference("RAGE", "Aimbot", "Prefer body aim disablers"),
    force_body_aim = ui_reference("RAGE", "Aimbot", "Force body aim"),
    duck_peek_assist = ui_reference("RAGE", "Other", "Duck peek assist"),
    double_tap = {ui_reference("RAGE", "Aimbot", "Double tap")},
    double_tap_hitchance = ui_reference("RAGE", "Aimbot", "Double tap hit chance"),
    double_tap_fake_lag_limit = ui_reference("RAGE", "Aimbot", "Double tap fake lag limit"),
    double_tap_quick_stop = ui_reference("RAGE", "Aimbot", "Double tap quick stop"),
    ping_spike = {ui_reference("MISC", "miscellaneous", "ping spike")},
    --weapon_type = ui_reference("RAGE", "Weapon type", "Global"),
    baim_hitboxes = {3, 4, 5, 6},
    fake_lag_limit = ui_reference("AA", "Fake lag", "Limit")
}

local dragging_fn = function(b,c,d)return(function()local e={}local f,g,h,i,j,k,l,m,n,o,p,q,r,s;local t={__index={drag=function(self,...)local u,v=self:get()local w,x,q=e.drag(u,v,...)if u~=w or v~=x then self:set(w,x)end;return w,x,q end,status=function(self,...)local w,x=self:get()local y,z=e.status(w,x,...)return y end,set=function(self,u,v)local n,o=client_screen_size()ui_set(self.x_reference,u/n*self.res)ui_set(self.y_reference,v/o*self.res)end,get=function(self)local n,o=client_screen_size()return ui_get(self.x_reference)/self.res*n,ui_get(self.y_reference)/self.res*o end}}function e.new(y,z,A,B)B=B or 10000;local n,o=client_screen_size()local C=ui_new_slider("LUA","A",y.." window position",0,B,z/n*B)local D=ui_new_slider("LUA","A","\n"..y.." window position y",0,B,A/o*B)ui_set_visible(C,false)ui_set_visible(D,false)return setmetatable({name=y,x_reference=C,y_reference=D,res=B},t)end;function e.drag(u,v,E,F,G,H,I)local t="n"if globals_framecount()~=f then g=ui_is_menu_open()j,k=h,i;h,i=ui_mouse_position()m=l;l=client_key_state(0x01)==true;q=p;p={}s=r;r=false;n,o=client_screen_size()end;if g and m~=nil then if(not m or s)and l and j>u and k>v and j<u+E and k<v+F then r=true;u,v=u+h-j,v+i-k;if not H then u=math_max(0,math_min(n-E,u))v=math_max(0,math_min(o-F,v))end end end;if g and m~=nil then if j>u and k>v and j<u+E and k<v+F then if l then t="c"else t="o"end end end;table_insert(p,{u,v,E,F})return u,v,t,E,F end;function e.status(u,v,E,F,G,H,I)if globals_framecount()~=f then g=ui_is_menu_open()j,k=h,i;h,i=ui_mouse_position()m=l;l=true;q=p;p={}s=r;r=false;n,o=client_screen_size()end;if g and m~=nil then if j>u and k>v and j<u+E and k<v+F then return true end end;return false end;return e end)().new(b,c,d)end

adp.ui = {}
adp.setup = {}
adp.events = {}
adp.visuals = {}
local Globals = '\a6DF9B1FF'..'Globals: '..'\aFFFFFFC8'
local Weapons = '\a6DF9B1FF'..'Weapons: '..'\aFFFFFFC8'
local Visuals = '\a6DF9B1FF'..'Viusals: '..'\aFFFFFFC8'

adp.ui.master_switch = gui_handler.new(ui_new_checkbox('RAGE','Aimbot','\a6DF9B1FFAdaptive Weapons - @Aslier#1337'))
adp.ui.info_label1 = gui_handler.new(ui.new_label('RAGE','Aimbot','Current Update Time: 2022-10-16'))
adp.ui.master_combo = gui_handler.new(ui_new_combobox('RAGE','Aimbot',"         "..Globals..'Modifier',{'Info','Weapon Modifier','Viusals & Indicators'}))

adp.ui.wp_combo = gui_handler.new(ui_new_combobox('RAGE','Aimbot',"         "..Weapons..'Config Selection',{'Keybinds','Config Weapons'}))

adp.ui.kb_override_mode = gui_handler.new(ui_new_combobox('RAGE','Aimbot',Weapons..'Override Damage Mode',{"Override Select",'Override With Two Keys'}))
adp.ui.kb_override_dmg = ui_new_hotkey('RAGE','Aimbot',Weapons..'Damage Override')
adp.ui.kb_override_dmg1 = ui_new_hotkey('RAGE','Aimbot',Weapons..'Damage Override 1')
adp.ui.kb_override_dmg2 = ui_new_hotkey('RAGE','Aimbot',Weapons..'Damage Override 2')

adp.ui.kb_hc_override = ui_new_hotkey('RAGE','Aimbot',Weapons..'Hitchance Override')
adp.ui.kb_target_override = ui_new_hotkey('RAGE','Aimbot',Weapons..'Target Hitbox Override')
adp.ui.forcebaim_onlethal = gui_handler.new(ui_new_checkbox('RAGE','Aimbot',Weapons..'Force Body Aim On Lethal'))

adp.ui.empty_label0 = ui.new_label('RAGE','Aimbot'," ")
adp.ui.wp_select = gui_handler.new(ui_new_combobox('RAGE','Aimbot',"         "..Weapons..'Select Weapon',weapon_list))

adp.ui.rage = {}

local f = ''
for i, _ in pairs(weapon_list) do
    f = '\a6DF9B1FF'.._..": "..'\aFFFFFFC8'
    adp.ui.rage[i] = {
        enable_weapon = gui_handler.new(ui_new_checkbox('RAGE','Aimbot',f..'Enable')),
        acc = gui_handler.new(ui_new_combobox('RAGE','Aimbot', f..'Accuracy Boost', {"Low","Medium","High","Maximum"})),
        target_selection =  gui_handler.new(ui_new_combobox('RAGE','Aimbot', f..'Target Selection', {"Highest damage","Cycle", "Cycle (2x)", "Near crosshair", "Best hit chance"})),
        empty_label1 = gui_handler.new(ui.new_label('RAGE','Aimbot'," ")),
        feature_label = gui_handler.new(ui.new_label('RAGE','Aimbot',"         "..f..'Extra Features')),

        ex_mp = gui_handler.new(ui_new_multiselect('RAGE','Aimbot',f..'Multi-point Mode','Default','Override')),
        mp_select_override = gui_handler.new(ui_new_multiselect('RAGE','Aimbot',f..'Override Multi-point', "Head","Chest","Stomach","Arms","Legs","Feet")),
        mp_scale_override = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Override Multi-point Scale", 24, 100, 50,true, "%", 1, {[24]="Auto"})),

        ex_mp_point = gui_handler.new(ui_new_combobox('RAGE','Aimbot', f..'Multi-point Scale Mode','Default','Step','Random')),

        mp_step_min = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Step Multi-point Scale Min", 24, 100, 50,true, "%", 1, {[24]="Auto"})),
        mp_step_max = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Step Multi-point Scale Max", 24, 100, 50,true, "%", 1, {[24]="Auto"})),
        mp_step_value = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Step Multi-point Scale Value", 0, 100, 50,true, "%", 1)),
        mp_step_ticks = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Step Ticks", 1, 15, 7)),

        mp_random_min = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Random Multi-point Scale Min", 24, 100, 50,true, "%", 1, {[24]="Auto"})),
        mp_random_max = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Random Multi-point Scale Max", 24, 100, 50,true, "%", 1, {[24]="Auto"})),

        ex_hc = gui_handler.new(ui_new_multiselect('RAGE','Aimbot', f..'Hitchance Modifier',"In Air",'No Scoped','Override','Fake Duck','Double Tap')),

        hc_inair = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."In Air Hitchance",0, 100, 50,true,"%",1,{[0]="Off"})),
        hc_nosp = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."No Scope Hitchance",0, 100, 50,true,"%",1,{[0]="Off"})),
        hc_override = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Override Hitchance",0, 100, 50,true,"%",1,{[0]="Off"})),
        hc_fd = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Fake Duck Hitchance",0, 100, 50,true,"%",1,{[0]="Off"})),
        hc_dt = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Double Tap Hitchance",0, 100, 0,true,"%",1,{[0]="Off"})),

        ex_dmg = gui_handler.new(ui_new_multiselect('RAGE','Aimbot', f..'Damage Modifier','Override 1','Override 2')),

        ov_first = gui_handler.new(ui_new_slider('RAGE','Aimbot',  f..'Override Damage 1', 0,126,20,true,"",1,damage_idx)),
        ov_second = gui_handler.new(ui_new_slider('RAGE','Aimbot',  f..'Override Damage 2', 0,126,20,true,"",1,damage_idx)),

        empty_label2 = gui_handler.new(ui.new_label('RAGE','Aimbot'," ")),
        hitbox_label = gui_handler.new(ui.new_label('RAGE','Aimbot',"         "..f..'Hitbox Modifier')),
        target_hitbox = gui_handler.new(ui_new_multiselect('RAGE','Aimbot', f.."Target Hitbox Selection", "Head","Chest","Stomach","Arms","Legs","Feet")),
        target_hitbox_over = gui_handler.new(ui_new_multiselect('RAGE','Aimbot', f.."Target Hitbox Selection Override", "Head","Chest","Stomach","Arms","Legs","Feet")),

        avoid = gui_handler.new(ui_new_multiselect('RAGE','Aimbot', f.."Force Safepoint Selection", "Head","Chest","Stomach","Arms","Legs","Feet")),
        mp_select = gui_handler.new(ui_new_multiselect('RAGE','Aimbot', f.."Multi-point", "Head","Chest","Stomach","Arms","Legs","Feet")),

        empty_label3 = gui_handler.new(ui.new_label('RAGE','Aimbot'," ")),
        mp_default = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Multi-point scale", 24, 100, 50,true, "%", 1, {[24]="Auto"})),
        hc_default = gui_handler.new(ui_new_slider('RAGE','Aimbot', f.."Hitchance", 0, 100, 50,true,"%",1,{[0]="Off"})),
        dmg  = gui_handler.new(ui_new_slider('RAGE','Aimbot', f..'Minimum Damage',0,126,20,true,"",1,damage_idx)),
        empty_label4 = gui_handler.new(ui.new_label('RAGE','Aimbot'," ")),

        qs_label = gui_handler.new(ui.new_label('RAGE','Other',f..'Quick Stop Modifier')),

        quick =             gui_handler.new(ui_new_checkbox('RAGE','Other',f..'Quick Stop')),
        quick_options =     gui_handler.new(ui_new_multiselect('RAGE','Other', f..'Quick Stop Options', "Early", "Slow motion", "Duck", "Fake duck","Move between shots", "Ignore molotov","Taser", "Jump scout")),
        quick_dt_options =  gui_handler.new(ui_new_multiselect('RAGE','Other', f..'Double Tap Quick Stop Options',  "Slow motion", "Duck", "Move between shots" )),
        quick_nosp = gui_handler.new(ui_new_checkbox('RAGE','Other',f..'No Scoped Quick Stop')),
        quick_nosp_options =gui_handler.new(ui_new_multiselect('RAGE','Other', f.."No Scoped Quick Stop Options",   "Early", "Slow motion", "Duck", "Fake duck","Move between shots", "Ignore molotov","Taser", "Jump scout")),
        quick_dt_nosp_options =gui_handler.new(ui_new_multiselect('RAGE','Other', f.."Double Tap No Scoped Quick Stop Options",  "Slow motion", "Duck", "Move between shots" )),

        empty_label5 = gui_handler.new(ui.new_label('RAGE','Other'," ")),
        misc_label = gui_handler.new(ui.new_label('RAGE','Other',"         "..f.."Misc Modifier")),

        max_fov = gui_handler.new(ui_new_slider('RAGE','Other',f.."Maximum Fov",0,180,180,true,"°",1)),
        remove_recoil = gui_handler.new(ui_new_checkbox('RAGE','Other',f..'Remove Recoil')),
        slient_aim = gui_handler.new(ui_new_checkbox('RAGE','Other',f..'Slient Aim')),
        pbaim =              gui_handler.new(ui_new_checkbox('RAGE','Other', f.."Prefer Body Aim")),
        pbaim_disable =      gui_handler.new(ui_new_multiselect('RAGE','Other', f.."Prefer baim disablers","Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot")),
        presafe =            gui_handler.new(ui_new_checkbox('RAGE','Other',f.."Prefer Safepoint" )),
        presafe_dt =         gui_handler.new(ui_new_checkbox('RAGE','Other',f.."Prefer Safepoint On Double Tap" )),
        auto_fire =          gui_handler.new(ui_new_checkbox('RAGE','Other', f..'Automatic Fire')),
        auto_scope =         gui_handler.new(ui_new_checkbox('RAGE','Other', f..'Automatic Scope')),
        auto_wall =          gui_handler.new(ui_new_checkbox('RAGE','Other', f..'Automatic Penetration')),
        delay_shot =         gui_handler.new(ui_new_checkbox('RAGE','Other',f..'Delay Shot')),


    }

end


adp.ui.export_button = ui_new_button('RAGE','Aimbot',Globals..'Export Config To Clipboard',function ()
    gui_handler.export_config()
    print('Exported Config to Clipboard')
end)

adp.ui.load_button = ui_new_button('RAGE','Aimbot',Globals..'Load Config From Clipboard',function ()
    gui_handler.load_config()
    print('Loaded Config From Clipboard')
end)

adp.ui.esp_combo = gui_handler.new(ui_new_multiselect('RAGE','Aimbot',Visuals..'Register ESP Data','Force Body Aim','Enemy Yaw','Enemy Desync'))

adp.ui.ind_combo = gui_handler.new(ui_new_multiselect('RAGE','Aimbot',"         "..Visuals.."Indicator Options",'Damage','Hitchance','Keybinds'))
adp.ui.dmgind_mode = gui_handler.new(ui_new_combobox('RAGE','Aimbot',Visuals..'Indicator Mode',{"Scoped & Overrided","Always On",'Only Override'}))

adp.ui.ind_color1 = gui_handler.new(ui_new_color_picker('RAGE','Aimbot',"cr",102,230,164,255))
adp.ui.ind_color2 = gui_handler.new(ui_new_color_picker('RAGE','Aimbot',"cr2",255,255,255,255))
adp.ui.ind_font = gui_handler.new(ui_new_combobox('RAGE','Aimbot',Visuals..'Indicator Flags',{'-',"+"}))

local screen = {client_screen_size()}

local indicator_pos_ = gui_handler.new(ui_new_checkbox('RAGE','Aimbot',"Config Indicator Position"))
local temp_x =  gui_handler.new(ui_new_slider('RAGE','Aimbot',"DMG_TEMP_X",0,screen[1],screen[1]/2 + 20))
local temp_y =  gui_handler.new(ui_new_slider('RAGE','Aimbot',"DMG_TEMP_Y",0,screen[2],screen[2]/2 + 20))

local ptemp_x =  gui_handler.new(ui_new_slider('RAGE','Aimbot',"HC_TEMP_X",0,screen[1],screen[1]/2 + 40))
local ptemp_y =  gui_handler.new(ui_new_slider('RAGE','Aimbot',"HC_TEMP_Y",0,screen[2],screen[2]/2 + 40))

adp.ui.handle_visible = function ()
    local master_switch = ui_get(adp.ui.master_switch)
    local global_page = ui_get(adp.ui.master_combo) == 'Info' and master_switch
    local weapon_page = ui_get(adp.ui.master_combo) == 'Weapon Modifier' and master_switch
    local viusal_page = ui_get(adp.ui.master_combo) == 'Viusals & Indicators' and master_switch

    local wp_config = ui_get(adp.ui.wp_combo) == 'Config Weapons' and weapon_page
    local kb_config = ui_get(adp.ui.wp_combo) == 'Keybinds' and weapon_page

    local i = adp.ui
    ui_set_visible(i.master_combo,master_switch)
    ui_set_visible(i.export_button,global_page)
    ui_set_visible(i.load_button,global_page)
    ui_set_visible(i.info_label1 ,global_page)

   
    ui_set_visible(i.wp_combo,weapon_page)
    ui_set_visible(i.empty_label0,wp_config)

    ui_set_visible(i.forcebaim_onlethal,wp_config)

    ui_set_visible(i.kb_override_mode,kb_config)
    ui_set_visible(i.kb_override_dmg,kb_config and ui_get(i.kb_override_mode) == "Override Select")
    ui_set_visible(i.kb_override_dmg1,kb_config and ui_get(i.kb_override_mode) == "Override With Two Keys")
    ui_set_visible(i.kb_override_dmg2,kb_config and ui_get(i.kb_override_mode) == "Override With Two Keys")
    ui_set_visible(i.kb_hc_override,kb_config)
    ui_set_visible(i.kb_target_override,kb_config)
    ui_set_visible(i.wp_select,wp_config)

    ui_set_visible(i.esp_combo,viusal_page)
    ui_set_visible(i.ind_combo,viusal_page)
    ui_set_visible(i.ind_font,viusal_page)
    ui_set_visible(i.ind_color1,viusal_page)
    ui_set_visible(i.ind_color2,viusal_page)
    ui_set_visible(adp.ui.dmgind_mode,viusal_page)
    ui_set_visible(indicator_pos_,viusal_page)
    ui_set_visible(temp_x,viusal_page and ui_get(indicator_pos_))
    ui_set_visible(temp_y,viusal_page and ui_get(indicator_pos_))
    ui_set_visible(ptemp_x,viusal_page and ui_get(indicator_pos_))
    ui_set_visible(ptemp_y,viusal_page and ui_get(indicator_pos_))
    for k, _ in pairs(weapon_list) do
        local active = ui_get(i.wp_select) == _
        ui_set_visible(i.rage[k].enable_weapon,wp_config and active)
        ui_set_visible(i.rage[k].acc,wp_config and active)
        ui_set_visible(i.rage[k].target_selection,wp_config and active)
        ui_set_visible(i.rage[k].empty_label1,wp_config and active)
        ui_set_visible(i.rage[k].feature_label,wp_config and active)
        ui_set_visible(i.rage[k].ex_mp,wp_config and active)
        ui_set_visible(i.rage[k].mp_select_override,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Override'))
        ui_set_visible(i.rage[k].mp_scale_override,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Override'))
        ui_set_visible(i.rage[k].ex_mp_point,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Default'))
        ui_set_visible(i.rage[k].mp_step_min,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Default') and ui_get(i.rage[k].ex_mp_point) == "Step")
        ui_set_visible(i.rage[k].mp_step_max,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Default') and ui_get(i.rage[k].ex_mp_point) == "Step") 
        ui_set_visible(i.rage[k].mp_step_value,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Default') and ui_get(i.rage[k].ex_mp_point) == "Step")
        ui_set_visible(i.rage[k].mp_step_ticks,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Default') and ui_get(i.rage[k].ex_mp_point) == "Step")
        ui_set_visible(i.rage[k].mp_random_min,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Default')  and ui_get(i.rage[k].ex_mp_point) == "Random")
        ui_set_visible(i.rage[k].mp_random_max,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Default')  and ui_get(i.rage[k].ex_mp_point) == "Random")
        ui_set_visible(i.rage[k].ex_hc,wp_config and active)
        ui_set_visible(i.rage[k].hc_inair,wp_config and active and contains(ui_get(i.rage[k].ex_hc),'In Air'))
        ui_set_visible(i.rage[k].hc_nosp,wp_config and active and contains(ui_get(i.rage[k].ex_hc),'No Scoped'))
        ui_set_visible(i.rage[k].hc_override,wp_config and active and contains(ui_get(i.rage[k].ex_hc),'Override'))
        ui_set_visible(i.rage[k].hc_fd,wp_config and active and contains(ui_get(i.rage[k].ex_hc),'Fake Duck'))
        ui_set_visible(i.rage[k].hc_dt,wp_config and active and contains(ui_get(i.rage[k].ex_hc),'Double Tap'))
        ui_set_visible(i.rage[k].ex_dmg,wp_config and active)
        ui_set_visible(i.rage[k].ov_first,wp_config and active and contains(ui_get(i.rage[k].ex_dmg),'Override 1'))
        ui_set_visible(i.rage[k].ov_second,wp_config and active and contains(ui_get(i.rage[k].ex_dmg),'Override 2'))
        ui_set_visible(i.rage[k].empty_label2,wp_config and active)
        ui_set_visible(i.rage[k].hitbox_label,wp_config and active)
        ui_set_visible(i.rage[k].target_hitbox,wp_config and active)
        ui_set_visible(i.rage[k].target_hitbox_over,wp_config and active)
        ui_set_visible(i.rage[k].avoid,wp_config and active)
        ui_set_visible(i.rage[k].mp_select,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Default'))
        ui_set_visible(i.rage[k].empty_label3,wp_config and active)
        ui_set_visible(i.rage[k].mp_default,wp_config and active and contains(ui_get(i.rage[k].ex_mp),'Default') and ui_get(i.rage[k].ex_mp_point) == "Default")
        ui_set_visible(i.rage[k].hc_default,wp_config and active)
        ui_set_visible(i.rage[k].dmg,wp_config and active)
        ui_set_visible(i.rage[k].empty_label4,wp_config and active)
        ui_set_visible(i.rage[k].qs_label,wp_config and active)
        ui_set_visible(i.rage[k].quick,wp_config and active)
        ui_set_visible(i.rage[k].quick_options,wp_config and active and ui_get(i.rage[k].quick))
        ui_set_visible(i.rage[k].quick_dt_options,wp_config and active and ui_get(i.rage[k].quick))
        ui_set_visible(i.rage[k].quick_nosp,wp_config and active and ui_get(i.rage[k].quick) and k == sc_weapon[2])
        ui_set_visible(i.rage[k].quick_nosp_options,wp_config and active and ui_get(i.rage[k].quick) and k == sc_weapon[2] and ui_get(i.rage[k].quick_nosp))
        ui_set_visible(i.rage[k].quick_dt_nosp_options,wp_config and active and ui_get(i.rage[k].quick) and k == sc_weapon[2] and ui_get(i.rage[k].quick_nosp))
        ui_set_visible(i.rage[k].empty_label5,wp_config and active)
        ui_set_visible(i.rage[k].misc_label,wp_config and active)
        ui_set_visible(i.rage[k].max_fov,wp_config and active)
        ui_set_visible(i.rage[k].remove_recoil,wp_config and active)
        ui_set_visible(i.rage[k].slient_aim,wp_config and active)
        ui_set_visible(i.rage[k].pbaim,wp_config and active)
        ui_set_visible(i.rage[k].pbaim_disable,wp_config and active and ui_get(i.rage[k].pbaim))
        ui_set_visible(i.rage[k].presafe,wp_config and active)
        ui_set_visible(i.rage[k].presafe_dt,wp_config and active)
        ui_set_visible(i.rage[k].auto_fire,wp_config and active)
        ui_set_visible(i.rage[k].auto_scope,wp_config and active)
        ui_set_visible(i.rage[k].auto_wall,wp_config and active)
        ui_set_visible(i.rage[k].delay_shot,wp_config and active)

    end

end

adp.ui.handle_visible()


local active_idx = 1

local ovr_key_state
local ovr_selected = 0
local ovr_add_disabled

local is_lethal = function(player)
    local local_player = entity_get_local_player()
    if local_player == nil or not entity_is_alive(local_player) then return end
    local local_origin = vector(entity_get_prop(local_player, "m_vecAbsOrigin"))
    local distance = local_origin:dist(vector(entity_get_prop(player, "m_vecOrigin")))
    local enemy_health = entity_get_prop(player, "m_iHealth")

    local weapon_ent = entity_get_player_weapon(entity_get_local_player())
    if weapon_ent == nil then return end
    
    local weapon_idx = entity_get_prop(weapon_ent, "m_iItemDefinitionIndex")
    if weapon_idx == nil then return end
    
    local weapon = csgo_weapons[weapon_idx]
    if weapon == nil then return end

    if not ui_get(adp.ui.forcebaim_onlethal) then return end

    local dmg_after_range = (weapon.damage * math.pow(weapon.range_modifier, (distance * 0.002))) * 1.25
    local armor = entity_get_prop(player,"m_ArmorValue")
    local newdmg = dmg_after_range * (weapon.armor_ratio * 0.5)
    if dmg_after_range - (dmg_after_range * (weapon.armor_ratio * 0.5)) * 0.5 > armor then
        newdmg = dmg_after_range - (armor / 0.5)
    end
    return newdmg >= enemy_health
end



local function set_og_menu(state)
    ui_set_visible(ragebot.target_selection,state)
    ui_set_visible(ragebot.target_hitbox,state)
    ui_set_visible(ragebot.multipoint[1],state)
    ui_set_visible(ragebot.multipoint_scale,state)
    ui_set_visible(ragebot.prefer_safepoint,state)
    ui_set_visible(ragebot.force_safepoint,state)
    ui_set_visible(ragebot.avoid_unsafe_hitboxes,state)
    ui_set_visible(ragebot.automatic_fire,state)
    ui_set_visible(ragebot.automatic_penetration,state)
    ui_set_visible(ragebot.silent_aim,state)
    ui_set_visible(ragebot.hitchance,state)
    ui_set_visible(ragebot.remove_recoil,state)
    ui_set_visible(ragebot.accuracy_boost,state)
    ui_set_visible(ragebot.minimum_damage,state)
    ui_set_visible(ragebot.auto_scope,state)
    ui_set_visible(ragebot.automatic_penetration,state)
    ui_set_visible(ragebot.reduce_aim_step,state)
    ui_set_visible(ragebot.maximum_fov,state)
    ui_set_visible(ragebot.quick_stop[1],state)
    ui_set_visible(ragebot.quick_stop[2],state)
    ui_set_visible(ragebot.quick_stop[3],state)
    ui_set_visible(ragebot.delay_shot,state)
    ui_set_visible(ragebot.double_tap_quick_stop,state)
    --ui_set_visible(ragebot.weapon_type,state)
    ui_set_visible(ragebot.prefer_body_aim,state)
    ui_set_visible(ragebot.prefer_body_aim_disablers,state)
end

local setup_force = function()
    local enemies = entity_get_players(true)
    for i = 1, #enemies do
        if enemies[i] == nil then return end
        local value = is_lethal(enemies[i]) and "Force" or "-"
        plist.set(enemies[i], "Override prefer body aim", value)
    end
end

local cache = {"dmgm","key1on","key2on","key1t","key2t","dmgs"}

adp.setup.handle_config = function()

 


    local handle_ovr = function()
        local ovr_k_temp = ui_get(adp.ui.kb_override_dmg)

        if ui_get(adp.ui.kb_override_mode) == 'Override Select' then
            if ovr_k_temp ~= ovr_key_state then 
                if ovr_add_disabled then 
                    ovr_selected = ovr_selected == 0 and 1 or 0
                else
                    ovr_selected = ovr_selected ~= 2 and ovr_selected + 1 or 0
                end
                ovr_key_state = ovr_k_temp
            end
        elseif ui_get(adp.ui.kb_override_mode) == 'Override With Two Keys'  then
            --paste from future weapon @credit gio
            local _key1 = {ui_get(adp.ui.kb_override_dmg1)}
            local _key2 = {ui_get(adp.ui.kb_override_dmg2)}
            local _key1_value,_key2_value,_key1_mode,_key2_mode
        
            if _key1[3] ~= nil then
                _key1_value = client.key_state(_key1[3])
                _key1_mode = _key1[2] == 2
            end
            if _key2[3] ~= nil then
                _key2_value = client.key_state(_key2[3])
                _key2_mode = _key2[2] == 2
            end
        
            if not _key1_mode and not _key2_mode then
                if _key1_value and not _key2_value then
                    ovr_selected = 1
                    cache["key1on"] = true
                    cache["key2on"] = false
                elseif _key2_value and not _key1_value then
                    ovr_selected = 2
                    cache["key1on"] = false
                    cache["key2on"] = true
                elseif _key2_value and _key1_value then
                    if cache["key2on"] then
                        ovr_selected = 1
                    elseif cache["key1on"] then
                        ovr_selected = 2
                    end
                else
                    ovr_selected = 0
                end

            else
                if _key1_value and cache["key1t"] then
                    if cache["dmgm"] == 1 then
                        cache["dmgm"] = 0
                        cache["dmgs"] = false
                    else
                        cache["dmgm"] = 1
                        cache["dmgs"] = true
                    end
                    cache["key1t"] = false
                elseif _key2_value and cache["key2t"] then
                    if cache["dmgm"] == 2 then
                        cache["dmgm"] = 0
                        cache["dmgs"] = false
                    else
                        cache["dmgm"] = 2
                        cache["dmgs"] = true
                    end
                    cache["key2t"] = false
                end
        
                if _key1_value == false then
                    cache["key1t"] = true
                end
        
                if _key2_value == false then
                    cache["key2t"] = true
                end
                
                if cache["dmgm"] == 0 then
                    ovr_selected = 0
                elseif cache["dmgm"] == 1 then
                    ovr_selected = 1
                elseif cache["dmgm"] == 2 then
                    ovr_selected = 2
                end
            end  
        end
    end
    

    handle_ovr()

end

adp.setup.set_config = function(args)
    local rage = adp.ui.rage
    local g = adp.ui
    local i = ui_get(rage[args].enable_weapon) and args or 1 
    local target_hitbox = ui_get(rage[i].target_hitbox)
    local target_hitbox_over = ui_get(rage[i].target_hitbox_over)

    if #target_hitbox == 0 then
        ui_set(rage[i].target_hitbox,"Head")
    end

    if #target_hitbox_over == 0 then
        ui_set(rage[i].target_hitbox_over,"Head")
    end

    local onground = (bit.band(entity_get_prop(entity_get_local_player(), "m_fFlags"), 1) == 1)
    local is_scoped = entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_zoomLevel" ) 
    local hitchance =
    (contains(ui_get(rage[i].ex_hc),'Override') and ui_get(g.kb_hc_override) and ui_get(rage[i].hc_override) )or --Override hitchance
    (contains(ui_get(rage[i].ex_hc),'Fake Duck') and ui_get(ragebot.duck_peek_assist) and ui_get(rage[i].hc_fd)) or -- Fakeduck hitchance
    (not onground and contains(ui_get(rage[i].ex_hc),'In Air') and ui_get(rage[i].hc_inair))  or -- air hitchance
    ((is_scoped == 0 and contains(ui_get(rage[i].ex_hc),'No Scoped') and contains(sc_weapon,i) and ui_get(rage[i].hc_nosp))) or -- noscoped hitchance 
    ui_get(rage[i].hc_default) -- hitchance                                             
    local is_dt = ui_get(ragebot.double_tap[1]) and ui_get(ragebot.double_tap[2])
    local mp = 
    (ovr_selected ~= 0 and ui_get(rage[i].mp_select_override)) or
    ui_get(rage[i].mp_select) 
    local default_mp,step_mp,random_mp = ui_get(rage[i].ex_mp_point) == "Default",ui_get(rage[i].ex_mp_point) == "Step",ui_get(rage[i].ex_mp_point) == "Random"
    local get_step_value = step_fn.step(ui_get(rage[i].mp_step_min),ui_get(rage[i].mp_step_max),ui_get(rage[i].mp_step_value),ui_get(rage[i].mp_step_ticks))
    local get_random_value = math.random(ui_get(rage[i].mp_random_min),ui_get(rage[i].mp_random_max))
    local mp_value = 
    (ovr_selected ~= 0 and ui_get(rage[i].mp_scale_override)) or
    (step_mp and get_step_value) or
    (random_mp and get_random_value) or 
    ui_get(rage[i].mp_default) 

    local dt_presafe = ui_get(rage[i].presafe_dt) and is_dt
    local presafe = ui_get(rage[i].presafe) and not is_dt or dt_presafe
 

    local avoid_hitbox = ui_get(rage[i].avoid)
    local quick_stop_value = {ui_get(rage[i].quick),ui_get(rage[i].quick_options) }
    local quick_stop_value_dt = ui_get(rage[i].quick_dt_options)

    if i == sc_weapon[2] then
        quick_stop_value = is_scoped == 0 
        and 
        {ui_get(rage[i].quick_nosp),ui_get(rage[i].quick_nosp_options)} 
        or {ui_get(rage[i].quick),ui_get(rage[i].quick_options)}
        quick_stop_value_dt = is_scoped == 0 and ui_get(rage[i].quick_dt_nosp_options) or ui_get(rage[i].quick_dt_options)
    end
    local damage_val = ui_get(rage[i].dmg)

    if ovr_selected == 0 then
        damage_val = ui_get(rage[i].dmg)
    else
        ovr_add_disabled = ui_get(rage[i].ov_second) == -1 
        damage_val = ovr_add_disabled and ui_get(rage[i].ov_first) or 
        (ovr_selected == 1 and ui_get(rage[i].ov_first) or ui_get(rage[i].ov_second))
    end

    ui_set(ragebot.target_selection, ui_get(rage[i].target_selection))
    ui_set(ragebot.automatic_fire, ui_get(rage[i].auto_fire))
    ui_set(ragebot.automatic_penetration, ui_get(rage[i].auto_wall))
    ui_set(ragebot.silent_aim ,ui_get(rage[i].slient_aim))
    ui_set(ragebot.maximum_fov ,ui_get(rage[i].max_fov))
    ui_set(ragebot.remove_recoil ,ui_get(rage[i].remove_recoil))
    ui_set(ragebot.accuracy_boost, ui_get(rage[i].acc))
    local thb_val = ui_get(g.kb_target_override) and ui_get(rage[i].target_hitbox_over) or ui_get(rage[i].target_hitbox)

    ui_set(ragebot.target_hitbox, thb_val)
    ui_set(ragebot.multipoint[1], mp)
    ui_set(ragebot.multipoint_scale, mp_value)
    ui_set(ragebot.avoid_unsafe_hitboxes, avoid_hitbox)
    ui_set(ragebot.prefer_safepoint, presafe)
    ui_set(ragebot.auto_scope, ui_get(rage[i].auto_scope))
    ui_set(ragebot.hitchance, hitchance)
    ui_set(ragebot.minimum_damage, damage_val)
    ui_set(ragebot.quick_stop[1], quick_stop_value[1])
    ui_set(ragebot.quick_stop[2],'Always on')
    ui_set(ragebot.quick_stop[3], quick_stop_value[2])
    ui_set(ragebot.double_tap_quick_stop, quick_stop_value_dt)
    ui_set(ragebot.prefer_body_aim, ui_get(rage[i].pbaim))
    ui_set(ragebot.prefer_body_aim_disablers, ui_get(rage[i].pbaim_disable))
    ui_set(ragebot.delay_shot, ui_get(rage[i].delay_shot))
    ui_set(ragebot.double_tap_hitchance, ui_get(rage[i].hc_dt))

    
    active_idx = i
    set_og_menu(false)

end



local local_player

adp.setup.call = function ()

    
    local_player = entity_get_local_player()

    if local_player == nil then
        return
    end

    local weapon_id = bit.band(entity_get_prop(entity_get_player_weapon(local_player), "m_iItemDefinitionIndex"), 0xFFFF)

    if weapon_id == nil then
        return
    end

    local wpn_text = weapon_list[weapon_idx[weapon_id]]
    local g = adp.ui


    if wpn_text ~= nil then
        if last_weapon ~= weapon_id then
            ui_set(g.wp_select, ui_get(g.rage[weapon_idx[weapon_id]].enable_weapon) and wpn_text or "Global")
            last_weapon = weapon_id
        end
        adp.setup.set_config(weapon_idx[weapon_id])
    else
        if last_weapon ~= weapon_id then
            ui_set(g.wp_select, "Global")
            last_weapon = weapon_id
        end
        adp.setup.set_config(1)
    end
    
end


adp.visuals.v = {
    alpha1 = 0,
    alpha2 = 0,
    alpha3 = 0,
    alpha4 = 0,
    pX = 0,
    pY = 0,
    pW = 0,

    dmg_a = 0,
    dmg_a2 = 0
}

adp.visuals.render = function ()
    
    if local_player == nil or not entity_is_alive(local_player) then
        return
    end

    local function gradient_text(r1, g1, b1, a1, r2, g2, b2, a2, text)
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
    end
    

    local r_damage = contains(ui_get(adp.ui.ind_combo),'Damage')
    local r_hitchance = contains(ui_get(adp.ui.ind_combo),'Hitchance')
    local r_keybind = contains(ui_get(adp.ui.ind_combo),'Keybinds')

    local screen = {client_screen_size()}
    local sx,sy = screen[1],screen[2]
    local cx,cy =  sx/2,sy/2 




    local flags = (ui_get(adp.ui.ind_font) == '-' and '-') or (ui_get(adp.ui.ind_font) == '+' and '')

    local damage = ui_get(ragebot.minimum_damage)
    local hitchance = ui_get(ragebot.hitchance)
    local r,g,b,a = ui_get(adp.ui.ind_color1 )
    local r1,g1,b1,a1 = ui_get(adp.ui.ind_color2)

    local is_scoped = entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_zoomLevel" ) ~= 0


    adp.visuals.v.alpha3 = animate.new(adp.visuals.v.alpha3,1,0,is_scoped or ovr_selected ~= 0)
    if damage == 0 then
        damage = "AUTO"
    end

    if hitchance == 0 then
        hitchance = "OFF"
    end

    local text_sizex , text_sizey = renderer_measure_text(flags,'DMG:')

    local mouse_x,mouse_y = ui.mouse_position()
    local x,y = ui_get(temp_x),ui_get(temp_y)
    local px,py = ui_get(ptemp_x),ui_get(ptemp_y)

    if ui_is_menu_open() and client.key_state(0x1) and mouse_x > x and mouse_x < x + 100 and mouse_y > y and mouse_y < y + 25 then
        ui_set(temp_x,mouse_x - 50)
        ui_set(temp_y,mouse_y - 12)
    end

    if ui_is_menu_open() and client.key_state(0x1) and mouse_x > px and mouse_x < px + 100 and mouse_y > py and mouse_y < py + 25 then
        ui_set(ptemp_x,mouse_x - 50)
        ui_set(ptemp_y,mouse_y - 12)
    end







    if r_damage then
        if ui_get(adp.ui.dmgind_mode) == "Scoped & Overrided" then
            renderer_text(cx +5,cy - 15,r,g,b,adp.visuals.v.alpha3 * 255,flags,0,'DMG:')
            renderer_text(cx + 5 + text_sizex + 3,cy - 15,255,255,255,adp.visuals.v.alpha3 * 255,flags,0,damage)
        elseif ui_get(adp.ui.dmgind_mode) == "Only Override" then
            if ovr_selected ~= 0 then
                renderer_text(x,y,255,255,255,255,flags,0,damage)
            end
        elseif ui_get(adp.ui.dmgind_mode) == "Always On" then
            renderer_text(x,y,255,255,255,255,flags,0,damage)

        end


   
    end
    if r_hitchance then

        if ui_get(adp.ui.dmgind_mode) == "Scoped & Overrided" then
            renderer_text(cx +5,cy - 15 -(r_damage and math_floor(12 * adp.visuals.v.alpha3) or 0),r,g,b,adp.visuals.v.alpha3 * 255,flags,0,'HC:')
            renderer_text(cx + text_sizex,cy - 15-(r_damage and math_floor(12 * adp.visuals.v.alpha3) or 0),255,255,255,adp.visuals.v.alpha3 * 255,flags,0,hitchance)
        elseif ui_get(adp.ui.dmgind_mode) == "Only Override" then
            if ui_get(adp.ui.kb_hc_override) then
                renderer_text(px,py,255,255,255,255,flags,0,hitchance)
            end
        elseif ui_get(adp.ui.dmgind_mode) == "Always On" then
            renderer_text(px,py,255,255,255,255,flags,0,hitchance)

        end
        
    end

    adp.visuals.v.alpha1 = animate.new(adp.visuals.v.alpha1,1,0,ui_get(adp.ui.kb_hc_override))
    adp.visuals.v.alpha2 = animate.new(adp.visuals.v.alpha2,1,0,ui_get(adp.ui.kb_target_override))

    local text_1 = gradient_text(r,g,b,a*adp.visuals.v.alpha1,r1,g1,b1,a1*adp.visuals.v.alpha1,"HITCHANCE OVER")
    local text_2 = gradient_text(r,g,b,a*adp.visuals.v.alpha2,r1,g1,b1,a1*adp.visuals.v.alpha2,"HITBOX OVER")
    
    if adp.visuals.v.alpha2 >= 0.01 then
        renderer_indicator(255,255,255,255 * adp.visuals.v.alpha2,text_2)

    end
    if adp.visuals.v.alpha1 >= 0.01 then
        renderer_indicator(255,255,255,255 *adp.visuals.v.alpha1,text_1)
    end



    local tsx, tsy = renderer_measure_text('-','SERIPK ADAPTIVE')
    local alpha = math.floor(
        math.sin(math.abs(-math.pi + (globals_curtime() * (1.25 / .75)) % (math.pi * 2))) * 255
    )
    --renderer_text(cx - tsx/2 + 1,screen[2] - tsy*2,r,g,b,a,'-',0,'SERIPK')
    --renderer_text(cx ,screen[2] - tsy*2,r1,g1,b1,a1 * alpha,'-',0,'ADAPTIVE')

end

local shutdown = function()
    set_og_menu(true)
end

adp.events.handle_events = function()
    for key, value in pairs(gui_handler.call) do
        ui_set_callback(value.ref,adp.ui.handle_visible)
    end
    ui_set_callback(adp.ui.export_button,adp.ui.handle_visible)
    ui_set_callback(adp.ui.load_button,adp.ui.handle_visible)
    ui_set_callback(adp.ui.export_button,gui_handler.export_config)
    ui_set_callback(adp.ui.load_button,gui_handler.load_config)

    client_set_event_callback('paint',adp.visuals.render)
    client_set_event_callback('paint_ui',adp.setup.handle_config)
    client_set_event_callback('setup_command',adp.setup.call)
    client_set_event_callback('run_command',setup_force)

    client_set_event_callback('shutdown',shutdown)

    client.register_esp_flag("FORCE", 114,156,191, function(ent)
         return contains(ui_get(adp.ui.esp_combo),'Force Body Aim') and ui_get(adp.ui.forcebaim_onlethal) and plist.get(ent, "Override prefer body aim") == "Force"
    end)
    


    client.register_esp_flag('', 245,245,170, function(player)
        if entity_is_enemy(player) then
            return contains(ui_get(adp.ui.esp_combo),'Enemy Yaw') ,"Y: "..math.floor(entity_get_prop(player, 'm_flPoseParameter', 12) * 180 -90)
         end
    end)
    

    client.register_esp_flag('', 245,245,245, function(player)
        if entity_is_enemy(player) then
            return contains(ui_get(adp.ui.esp_combo),'Enemy Desync'),'D: ' ..math.floor(entity_get_prop(player, 'm_flPoseParameter', 11) * 120 -60)
        end
    end)


end


adp.events.handle_events()
