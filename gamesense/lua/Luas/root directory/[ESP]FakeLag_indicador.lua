--ui
local ui_get = ui.get 
local new_combobox = ui.new_combobox
local new_checkbox = ui.new_checkbox
local new_slider = ui.new_slider
local set_visible = ui.set_visible
--user
local get_local_player = entity.get_local_player
local entity_get_prop = entity.get_prop
--draw
local circle_outline = client.draw_circle_outline
local draw_indicator = client.draw_indicator
local client_draw_text = client.draw_text
--client
local set_event_callback = client.set_event_callback
local set_callback = ui.set_callback

local fakelag_exploit = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local r_fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
local r_dt, r_dthk = ui.reference("RAGE", "Other", "Double tap")

local checkbox_FL_ind = new_checkbox("aa", "Fake lag", "Fake lag indicator")
local ui_color = ui.new_color_picker("aa", "Fake lag", "Desync color", "0", "115", "255", "255")
local checkbox_FL_debug = new_checkbox("aa", "Fake lag", "Detailed log")
local dragging = (function()local a={}local b,c,d,e,f,g,h,i,j,k,l,m,n,o;local p={__index={drag=function(self,...)local q,r=self:get()local s,t=a.drag(q,r,...)if q~=s or r~=t then self:set(s,t)end;return s,t end,set=function(self,q,r)local j,k=client.screen_size()ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res)end,get=function(self)local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}}function a.new(u,v,w,x)x=x or 10000;local j,k=client.screen_size()local y=ui.new_slider("AA", "Fake lag",u.." pos",0,x,v/j*x)local z=ui.new_slider("AA", "Fake lag","\n"..u.." pos 2",0,x,w/k*x)ui.set_visible(y,false)ui.set_visible(z,false)return setmetatable({name=u,x_reference=y,y_reference=z,res=x},p)end;function a.drag(q,r,A,B,C,D,E)if globals.framecount()~=b then c=ui.is_menu_open()f,g=d,e;d,e=ui.mouse_position()i=h;h=client.key_state(0x01)==true;m=l;l={}o=n;n=false;j,k=client.screen_size()end;if c and i~=nil then if(not i or o)and h and f>q and g>r and f<q+A and g<r+B then n=true;q,r=q+d-f,r+e-g;if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r))end end end;table.insert(l,{q,r,A,B})return q,r,A,B end;return a end)()

local hk_dragger = dragging.new("Ind", 100, 200)
local combo_box = new_combobox("aa", "Fake lag", "Visual text indicator", {"Pulsating", "Static"})
local alpha_value = new_slider("aa", "Fake lag", "Static alpha threshold", 1, 255, 255, true)

local First_CK = 0
local FL_0, FL_1, FL_2, FL_3 = 0,0,0,0
local test_flu_val = 0
local max_val, min_val = 0, 0
local limit_number = 14
local cir_r, cir_g, cir_b = 255, 255, 255
local chocked_fl, total_limit, absolute_limit = 0, 0, 0
local Status = ""
local ind_S_r, ind_S_g, ind_S_b = 0,0,0
local function run_fl(fl)
    if not ui_get(checkbox_FL_ind) then return end
    chocked_fl = fl.chokedcommands
    --find max val
    max_val = math.max(unpack({FL_0, FL_1, FL_2, FL_3}))
    --find min val
    min_val = math.min(unpack({FL_0, FL_1, FL_2, FL_3}))
    --

    --exploit reference
    limit_number = ui_get(fakelag_exploit) - 2
    if limit_number > 14 and max_val > 14 then
       cir_r, cir_g, cir_b = 245, 214, 255
    else
        cir_r, cir_g, cir_b = 255, 255, 255
    end
    --

    --fluctuate fix val
    test_flu_val = max_val - min_val 
    --

    --Total numbers
    total_limit = FL_0 + FL_1 + FL_2 + FL_3
    absolute_limit = (3*0.25) + (max_val / total_limit)
    --client.log(string.format("%.2f", absolute_limit))
    --
    
    -- resolver indicator
    if not ui_get(r_fakeduck) then
        if not ui_get(r_dthk) then
            if max_val <= 14 then
            	if max_val >= 0 and max_val <= 2 then
            		Status = "INACTIVE"
                elseif max_val >= 3 and max_val <= 3 then
                    Status = "LOW"

                elseif max_val <= 9 and test_flu_val <= 2 then
                    Status = "NOMINAL"

                elseif max_val >= 10 and test_flu_val <= 2 then

                    if max_val >= 14 and max_val <= 14 and First_CK >= 14 then
                        Status = "MAXIMIZED"
                    elseif max_val >= 10 and max_val <= 12 then
                        Status = "MAX-MINIMAL"
                    end

                elseif test_flu_val >= 2 and max_val >= 5 then

                    if test_flu_val >= 9 and test_flu_val <= 10 then
                        Status = "SHOT-BROKEN"
                    elseif test_flu_val >= 11 and test_flu_val <= 14 and absolute_limit < 1.29 then
                        Status = "SHOT-BROKEN"
                        ind_S_r, ind_S_g, ind_S_b = 126, 162, 237

                    elseif test_flu_val >= 14 and absolute_limit > 1.29 then
                        Status = "BREAK"

                    elseif test_flu_val >= 3 and test_flu_val <= 8 then
                        Status = "SHOT-BREAKING"
                    end          
            	end
            elseif max_val >= 15 then
                if test_flu_val > 10 then
                    Status = "EXPLOITED"
                elseif absolute_limit < 2 then
                    Status = "PEEKING"
                end
            end
        else
            Status = "DOUBLE TAP"
        end
    else
        Status = "FAKEDUCK"
    end
    --
end

--credits: sandvitch
local function fakelag_chock(c)

    if chocked_fl <= First_CK then
        FL_0 = FL_1
        FL_1 = FL_2
        FL_2 = FL_3
        FL_3 = First_CK
    end

    First_CK = chocked_fl
    -- testers
end
--

local uid_to_entindex = client.userid_to_entindex

local function get_userid(event)
    if not ui_get(checkbox_FL_ind) then return end

    local userid = event.entityid
    if userid == nil then
        return
    end

end

local function when_spawn(event)
    if not ui_get(checkbox_FL_ind) then return end

    if uid_to_entindex(event.userid) == get_local_player() then
        Status = "INACTIVE"
        First_CK = 0
        FL_0 = 0
        FL_1 = 0
        FL_2 = 0
        FL_3 = 0
    end

end

local timeon = 0
local log_detailed = ""
local logM, logMT, logF, logFT = "", "", "", ""
local spaced = ""
local log_text = ""
local log_ind = ""
local x, y = client.screen_size()
local centerx, centery = x * 0,5 , y * 0,5
local FL_ind = 0
local d_h = 17
local function indicator_paint(ctx)

    if ui_get(combo_box) ~= "Static" or not ui_get(checkbox_FL_ind) then
        ui.set_visible(alpha_value, false)
    elseif ui_get(combo_box) == "Static" then
        ui.set_visible(alpha_value, true)
    end

    if not ui_get(checkbox_FL_ind) then return end

    if entity_get_prop(get_local_player(), "m_lifeState") ~= 0 then return end

    if Status == "LOW" then
        ind_S_r, ind_S_g, ind_S_b = 255, 0, 0 -- vermelho
    elseif Status == "UPDATING..." then
        ind_S_r, ind_S_g, ind_S_b = 230, 161, 0 -- -- laranja         
    elseif Status == "INACTIVE" then
        ind_S_r, ind_S_g, ind_S_b = 255, 0, 0 -- -- vermelho
    elseif Status == "DOUBLE TAP" then
        ind_S_r, ind_S_g, ind_S_b = 237, 137, 146 -- -- vermelho  
    elseif Status == "FAKEDUCK" then
        ind_S_r, ind_S_g, ind_S_b = 187, 128, 255 -- -- vermelho    
    elseif Status == "SHOT-BROKEN" then
        ind_S_r, ind_S_g, ind_S_b = 126, 162, 237 -- verde
    elseif Status == "SHOT-BROKEN" then
        ind_S_r, ind_S_g, ind_S_b = 126, 162, 237 --verde
    elseif Status == "SHOT-BREAKING" then
        ind_S_r, ind_S_g, ind_S_b = 126, 162, 237 -- verde
    elseif Status == "F-LOW" then
        ind_S_r, ind_S_g, ind_S_b = 123, 180, 15 -- verde           
    elseif Status == "BREAK" then
        ind_S_r, ind_S_g, ind_S_b = 212, 86, 251 -- roxo                    
    elseif Status == "MAXIMIZED" then
        ind_S_r, ind_S_g, ind_S_b = 100, 217, 166 -- azul
    elseif Status == "MAX-MINIMAL" then
        ind_S_r, ind_S_g, ind_S_b = 100, 217, 166 -- azul
    elseif Status == "NOMINAL" then
        ind_S_r, ind_S_g, ind_S_b = 123, 180, 15 -- verde    
    elseif Status == "PEEKING" then
        ind_S_r, ind_S_g, ind_S_b = 237, 137, 146 -- -- vermelho   
    elseif Status == "EXPLOITED" then
        ind_S_r, ind_S_g, ind_S_b = 100, 217, 166 -- roxo +- claro                
    end

    local r, g, b, a = ui_get(ui_color)
    local white_anim = 1
    local pulse = 8 + math.sin(math.abs(-math.pi + (globals.realtime() * (0.6 / 1)) % (math.pi * 2))) * 12
    local alpha = 1 + math.sin(math.abs(-math.pi + globals.realtime() % (math.pi * 2))) * 219 
    local ind_r, ind_g, ind_b, ind_a = math.min(255, r + white_anim), math.min(255, g + white_anim),math.min(255, b + white_anim), math.min(255, a + white_anim) 

    local get_x, get_y = hk_dragger:get()
    local h, w = 18, 200
    client.draw_gradient(ctx, get_x, get_y-2, 40 + pulse*5, 2, ind_r, ind_g, ind_b, 255, 25, 25, 25, 5, true)   -- top
    client.draw_gradient(ctx, get_x, get_y, pulse, h+d_h, ind_r, ind_g, ind_b, 255, 25, 25, 25, 5, true)   --rosa pulse
    --client.draw_gradient(ctx, get_x + 5, get_y, w, 16, 0, 0, 0, 255, 10, 10, 10, 0, true)    -- top bar text
    --client.draw_gradient(ctx, get_x + 5, get_y+d_h, w, 16, 0, 0, 0, 255, 10, 10, 10, 0, true)    -- bottom bar text
    --client.draw_gradient(ctx, get_x + 5, get_y+14, (w / limit_number) * chocked_fl, 3, 20, 20, 20, 255, ind_r, ind_g, ind_b, ui_get(combo_box) == "Pulsating" and alpha or ui_get(alpha_value), true)    -- fakelag bar text
    --client.draw_gradient(ctx, get_x, get_y, w, h+d_h, 30, 30, 30, 200, 10, 10, 10, 10, true)        --interno
    client.draw_gradient(ctx, get_x, get_y + h+d_h, 120 + pulse*3, 2, ind_r, ind_g, ind_b, 255, 25, 25, 25, 20, true) -- bottom
    client.draw_gradient(ctx, get_x, get_y - 1, pulse, 1+h+d_h, ind_r, ind_g, ind_b, 255, 25, 25, 25, 5, true)      --rosa lado  
--128, 183, 255
    renderer.text(get_x + 8,get_y + 2, 128, 183, 255, 236, '', 0, "FAKE LAG")
    renderer.text(get_x + 60,get_y + 2, ind_S_r, ind_S_g, ind_S_b, ui_get(combo_box) == "Pulsating" and alpha or ui_get(alpha_value), '', 0, Status)
    renderer.text(get_x + 158,get_y + 2, 237, 137, 146, 217, '', 0, "8888")
    if ui_get(checkbox_FL_debug) then
        logM, logMT, logF, logFT = " M: ", max_val, "  F: ", test_flu_val
        hk_dragger:drag(w, h*2)
        d_h = 17
        renderer.text(get_x + 8,get_y + 20, 187, 128, 255, 255, '', 0,"HISTORY:")
        renderer.text(get_x + 60,get_y + 20, 200, 200, 200, 255, '', 0, string.format('%i-%i-%i-%i',FL_3,FL_2,FL_1,FL_0))
        renderer.text(get_x + 135,get_y + 20, 128, 183, 255, 255, '', 0, logM, logMT)
        renderer.text(get_x + 165,get_y + 20, 128, 183, 255, 255, '', 0, logF, logFT)
    else
        logM, logMT, logF, logFT = "", "", "", ""
        d_h = 0
        hk_dragger:drag(w, h*1.1)
    end
end

set_event_callback("run_command", run_fl)
set_event_callback("setup_command", fakelag_chock)
set_event_callback("run_command", get_userid)
set_event_callback("player_spawn", when_spawn)
set_event_callback("paint", indicator_paint)

local function m_visible()
    local act = ui_get(checkbox_FL_ind)
    ui.set_visible(ui_color, act)
    ui.set_visible(combo_box, act)
    ui.set_visible(alpha_value, act)
    ui.set_visible(checkbox_FL_debug, act)
end
m_visible()
set_callback(checkbox_FL_ind, m_visible)
