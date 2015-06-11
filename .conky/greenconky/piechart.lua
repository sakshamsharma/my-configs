 
--[[PIE CHART WIDGET BY WLOURF v1.2 26 may 2010

This widget draw a pie chart or a ring in a conky window.
More info on the parameters with pictures on this page :
http://u-scripts.blogspot.com/2010/04/pie-chart-widget.html


v1.0 10/04/2010  original release
v1.1 15/05/2010  the parameters are in a table (pie_settings), only the values in pie_settings.tableV are mandatory
                 added an option to draw values like a ring (type_arc="l")
v1.2 26/05/2010     add inverse_l parameter (for type_arc="l")
                 bug fix : line_lgth problem
                 read_df function improved
]]

require 'cairo'


--main function
function conky_main_pie()
    if conky_window==nil then return end

    --flag used in this script to display or not text informations
    local file = io.open("/tmp/flag-conky-pie","r")    
    io.close()
    flag_show_text=(file ~= nil)




-- ------------------PARAMETERS TO SET-----------------------
    --all parameters are explained in CIRCLE for RAM bellow
    --theses parameters are called many times so I put them into variables
    local font_name,font_size="FreeSans",14
--    local col0,col1,col2=0x0033FF,0x3300FF,0x6600FF
    local col0,col1,col2=0x333333,0x000000,0x222222
    local colbg=0x222222
        
    --for the clock
    local temp = os.date("*t")
    local hour=temp.hour
    if hour>12 then hour=hour-12 end
    local hpc,mpc,spc=hour/12,temp.min/60,temp.sec/60

    
    pie_settings= {

        {--CIRCLE 3 : DISK SPACE
            tableV=read_df(false,true),
            xc=640,
            yc=460 ,
            int_radius=133,
            radius=240,
            type_arc="r",
            proportional=False,
            first_angle=-180,
            gradient_effect=false,
            last_angle=-120,
            show_text=true,
	    extend_line=true,
            line_lgth=-110,
	    line_space=15,
            txt_format="&amp;l &amp;n",
            font_color=colbg,    
            tablebg={            
                {colbg,0.1},
                },
            tablefg={            
                {col0,1},
                {col1,1},
                {col2,1},
                },
        },        


         {--CIRCLE 3 : INTERNET SPEED
            tableV={
	      	{"lan dl","downspeedf","eth0",9000,"kb/s"},
                {"lan ul","upspeedf","eth0",1000,"kb/s"},
                {"wlan dl","downspeedf","wlan0",9000,"kb/s"},
                {"wlan ul","upspeedf","wlan0",1000,"kb/s"},

                },
            xc=640,
            yc=458 ,
            int_radius=133,
            radius=240,
            type_arc="r",
            proportional=false,
            first_angle=-40,
            gradient_effect=false,
            last_angle=-0,
            show_text=true,
            line_lgth=-110,
	    line_space=15,
            txt_format="&amp;l &amp;v",
            font_color=colbg,    
            tablebg={            
                {colbg,0.1},
                },
            tablefg={            
                {col0,1},
                {col1,1},
                {col2,1},
                },
        },   
        {--CIRCLE 3 : CPU
            tableV={
                {"core 2","cpu","cpu 2",100,"%"},
                {"core 1","cpu","cpu 1",100,"%"},
                {"cpu total","cpu","cpu 0",100,"%"},
                },
            xc=640,
            yc=458 ,
            int_radius=133,
            radius=240,
            type_arc="r",
            proportional=false,
            first_angle=-80,
            gradient_effect=false,
            last_angle=-50,
            show_text=true,
            line_lgth=120,
	    line_space=15,
            txt_format="&amp;l &amp;v",
            font_color=colbg,    
            tablebg={            
                {colbg,0.1},
                },
            tablefg={            
                {col0,1},
                {col1,1},
                {col2,1},
                },
        }, 	

        {--CIRCLE 3 : MEMORY
            tableV={
	        {"swap","swapperc",0,100,"%"},
                {"mem","memperc","",100,"%"},
                },
            xc=640,
            yc=460 ,
            int_radius=133,
            radius=250,
            type_arc="r",
            proportional=false,
            first_angle=-110,
            gradient_effect=false,
            last_angle=-90,
            show_text=true,
            line_lgth=100,
	    line_space=15,
            txt_format="&amp;l &amp;v", 
            font_color=colbg,    
            tablebg={            
                {colbg,0.1},
                },
            tablefg={            
                {col0,1},
                {col1,1},
                {col2,1},
                },
        },
	
	
	
	
        {--CERCLE 2 : ARC 3 = IP ADRESS (invisible circle)
            tableV={
--                 {conky_parse("${addr wlan0}").."  ","",0,100,""},
-- 	        {conky_parse("${addr eth0}").."  ","",0,100,""},
--                {conky_parse("192.168.0.1").."  ","",0,100,""},
                },
            xc=100,
            yc=250+5,
            int_radius=0,
            radius=1,
            first_angle=210,
            last_angle=330,
            type_arc="r",
            line_lgth=10,
            line_width=0,
            show_text=true,
            txt_format="&amp;l",
            font_color=colbg,
            tablebg={
                {col2,0},
                },
            tablefg={            
                {col2,1},
                },
                
        },    
        
    

        {--CIRCLE  5 : MEMORY : ram
        --I wrote all the possibles parameters available for the script, only tableV is mandatory
            -- table of labels and values {{label,conky_variable,conky_argument,convert to Go-Mo-Ko units (true/false) or unit}, 
            -- this table is mandatory, others parameters are optionals
            tableV={
--                 {"mem","memperc","",100,"%"},
                },
            --to know disk space, use this line 
            --    tableV=read_df(false,true),    
            --[[ another example
            tableV={ {"cpu0","cpu","cpu0",100,"%"},
                    {"cpu1","cpu","cpu1",100,"%"},
                    {"fan","","${exec sensors | grep 'CPU Fan' | cut -c13-16}",2000," rpm"},
                    {"temp","","${exec sensors | grep 'Sys Temp' | cut -c15-17}",100,"°C"},
                    {"some stuff","",75.5,100,"°C"}
                    },
            ]]                        
            xc=50,                    -- x center of the pie, default = conky_window.width/2
            yc=700,                    -- y center of the pie, default = conky_window.height/2
            int_radius=30,        -- internal radius in pixel, default = conky_window.width/6
            radius=45,            -- external radius in pixel, default = conky_window.width/4
            first_angle=0,        -- first angle of the pie (in degrees), default=0
            last_angle=360,            -- last angle of the pie (in degrees), default=360
            type_arc="l",            -- fill the arc in a linear way (ring) or radial way (pie), values l or r, default=l
            inverse_l_arc=false,    -- inverse arc for rings (true/false), default=false
            proportional=false,        -- display proportional sectors (true/false); default =false
            gradient_effect=true,     -- gradient effect (true/false), default=true
            line_lgth=50,            -- length for horizontal line (from radius to end of line), default=radius
            line_width=0,            -- width of line, default=1
            line_space=10,            -- vertical space between two lines, default=10 pixels
            extend_line=true,       -- grow up the line (true/false) if length of text> line_lgth, default=true
            nb_decimals=0,            -- number of decimals for numbers, default=1
            show_text=true,-- display text (true/false), default=true
            txt_font=font_name,        -- font, default "Japan"
            font_size=12,            -- font size, default=12
            font_color=colbg,    -- font color (for gradient) or nil (for constant color), default = nil
            font_alpha=0.5,            -- font alpha, default=1
            txt_offset=1,            -- space between text and line, default=1
            txt_format="&amp;l &amp;v",        -- string for formatting text, possibles values are :  default = "&amp;l : &amp;v"
                        -- &amp;l for label
                        -- &amp;o for occupied percentage
                        -- &amp;f for free percentage
                        -- &amp;v for value 
                        -- &amp;n for free value (non-occupied)    
                        -- &amp;m for max value
                        -- &amp;p for percentage value of full graph
            tablebg={            -- table of tables of colours for background {colors,alpha}
                {colbg,0.5},
                },
            tablefg={            -- table of tables of colours for foreground {colors,alpha}
                {col2,1},
                },
        },                                
      
        


        





        


    
       
    }
-------------------END OF PARAMETERS ---------------


    local w=conky_window.width
    local h=conky_window.height
    local cs=cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, w, h)
    cr=cairo_create(cs)

    if tonumber(conky_parse('${updates}'))>5 then
        for i in pairs(pie_settings) do
            draw_pie(pie_settings[i])
        end
    end

    cairo_destroy(cr)
end



function string:split(delimiter)
--source for the split function : http://www.wellho.net/resources/ex.php4?item=u108/split
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( self, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end


function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function size_to_text(size,nb_dec)
    local txt_v
    if nb_dec<0 then nb_dec=0 end
    size = tonumber(size)
    if size>1024*1024*1024*1024 then
        txt_v=string.format("%."..nb_dec.."f TB",size/1024/1024/1024/1024)
    elseif size>1024*1024*1024 then
        txt_v=string.format("%."..nb_dec.."f GB",size/1024/1024/1024)
    elseif size>1024*1024 then 
        txt_v=string.format("%."..nb_dec.."f MB",size/1024/1024)
    elseif size>1024 then 
        txt_v=string.format("%."..nb_dec.."f KB",size/1024)
    else
        txt_v=string.format("%."..nb_dec.."f B",size)
    end
    return txt_v
end



function read_df(show_media,sort_table)
    --read output of command df and return arrays of value for files systems
    --reurn array of table {file syst, "", occupied space , total space , convert to G, M, K ...}
    
    local f = io.popen("df")

    local results={}

    while true do
         local line = f:read("*l")
         if line == nil then break end
         while string.match(line,"  ") do
             line=string.gsub(line,"  "," ")
         end
        local arr_l=string.split(line," ")
        local match = string.match(arr_l[1],"/")
        
        if string.match(arr_l[1],"/") then
            if not show_media then arr_l[6]=string.gsub(arr_l[6],"/media/","",1) end
            table.insert(results,{arr_l[6],"",(arr_l[2]-arr_l[4])*1024,arr_l[2]*1024,true})
        end
    end

    f:close()
    
    if sort_table then
        --how to sort table into table?
        local flagS=true
        while flagS do
            for k=2, #results do 
                flagS=false
                if tonumber(results[1][3])>tonumber(results[2][3]) then
                    local tmpV = results[1]
                    results[1] = results[2]
                    results[2] = tmpV
                    flagS=true
                end
                if tonumber(results[k][3])<tonumber(results[k-1][3]) then
                    local tmpV = results[k-1]
                    results[k-1] = results[k]
                    results[k] = tmpV
                    flagS=true
                end
            end
        end
    end
    
    return results --array {file syst, occupied space , total space }
end


function draw_pie(t)
    
    if t.tableV==nil then 
        print ("No input values ...") 
        return
    else
        tableV=t.tableV
    end

    if t.xc==nil then t.xc=conky_window.width/2 end
    if t.yc==nil then t.yc=conky_window.height/2 end
    if t.int_radius ==nil then t.int_radius =conky_window.width/6 end
    if t.radius ==nil then t.radius =conky_window.width/4 end
    if t.first_angle==nil then t.first_angle =0 end
    if t.last_angle==nil then t.last_angle=360 end
    if t.proportional==nil then t.proportional=false end
    if t.tablebg==nil then t.tablebg={{0xFFFFFF,0.5},{0xFFFFFF,0.5}} end
    if t.tablefg==nil then t.tablefg={{0xFF0000,1},{0x00FF00,1}} end
    if t.gradient_effect==nil then t.gradient_effect=true end
    if t.show_text==nil then t.show_text=true end
    if t.line_lgth==nil then t.line_lgth=t.int_radius end
    if t.line_space==nil then t.line_space=10 end
    if t.line_width==nil then t.line_width=1 end
    if t.extend_line==nil then t.extend_line=true end
    if t.txt_font==nil then t.txt_font="monofur" end
    if t.font_size==nil then t.font_size=16 end
    --if t.font_color==nil then t.font_color=0xFFFFFF end
    if t.font_alpha==nil then t.font_alpha = 1 end
    if t.txt_offset==nil then t.txt_offset = 1 end
    if t.txt_format==nil then t.txt_format = "&amp;l : &amp;v" end
    if t.nb_decimals==nil then t.nb_decimals=0 end
    if t.type_arc==nil then t.type_arc="l" end
    if t.inverse_l_arc==nil then t.inverse_l_arc=false end
    
    
    local function draw_sector(tablecolor,colorindex,pc,lastAngle,angle,radius,int_radius,gradient_effect,type_arc,inverse_l_arc)
        --draw a portion of arc
        radiuspc=(radius-int_radius)*pc+int_radius
        angle0=lastAngle
        val=1
        if type_arc=="l" then 
            val=pc;radiuspc=radius
        end
        angle1=angle*val

        if type_arc=="l" and inverse_l_arc then 

            cairo_save(cr)
    
            cairo_rotate(cr,angle0+angle)
            
            if gradient_effect then        
                local pat = cairo_pattern_create_radial (0,0, int_radius, 0,0,radius)
                cairo_pattern_add_color_stop_rgba (pat, 0, rgb_to_r_g_b(tablecolor[colorindex][1],0))
                cairo_pattern_add_color_stop_rgba (pat, 0.5, rgb_to_r_g_b(tablecolor[colorindex][1],tablecolor[colorindex][2]))
                cairo_pattern_add_color_stop_rgba (pat, 1, rgb_to_r_g_b(tablecolor[colorindex][1],0))
                cairo_set_source (cr, pat)
                cairo_pattern_destroy(pat)
            else
                cairo_set_source_rgba(cr,rgb_to_r_g_b(tablecolor[colorindex][1],tablecolor[colorindex][2]))
            end
            cairo_move_to(cr,0,-int_radius)
            cairo_line_to(cr,0,-radiuspc)
            cairo_rotate(cr,-math.pi/2)
        
            cairo_arc_negative(cr,0,0,radiuspc,0,-angle1)
            cairo_rotate(cr,-math.pi/2-angle1)
            cairo_line_to(cr,0,int_radius)
            cairo_rotate(cr,math.pi/2)
            cairo_arc(cr,0,0,int_radius,0,angle1)
            cairo_close_path (cr);
            cairo_fill(cr)

            cairo_restore(cr)
        else
        
            cairo_save(cr)
    
            cairo_rotate(cr,angle0)

            if gradient_effect then        
                local pat = cairo_pattern_create_radial (0,0, int_radius, 0,0,radius)
                cairo_pattern_add_color_stop_rgba (pat, 0, rgb_to_r_g_b(tablecolor[colorindex][1],0))
                cairo_pattern_add_color_stop_rgba (pat, 0.5, rgb_to_r_g_b(tablecolor[colorindex][1],tablecolor[colorindex][2]))
                cairo_pattern_add_color_stop_rgba (pat, 1, rgb_to_r_g_b(tablecolor[colorindex][1],0))
                cairo_set_source (cr, pat)
                cairo_pattern_destroy(pat)
            else
                cairo_set_source_rgba(cr,rgb_to_r_g_b(tablecolor[colorindex][1],tablecolor[colorindex][2]))
            end
            cairo_move_to(cr,0,-int_radius)
            cairo_line_to(cr,0,-radiuspc)
            cairo_rotate(cr,-math.pi/2)
        
            cairo_arc(cr,0,0,radiuspc,0,angle1)
            cairo_rotate(cr,angle1-math.pi/2)
            cairo_line_to(cr,0,int_radius)
            cairo_rotate(cr,math.pi/2)
            cairo_arc_negative(cr,0,0,int_radius,0,-angle1)
            cairo_close_path (cr);
            cairo_fill(cr)

            cairo_restore(cr)
        end
        

    end

    function draw_lines(idx,nbArcs,angle,table_colors,idx_color,adjust,line_lgth,length_txt,txt_offset,radius,line_width,line_space,font_color,font_alpha)
        --draw lines
        
        local x0=radiuspc*math.sin(lastAngle+angle/2)
        local y0=-radiuspc*math.cos(lastAngle+angle/2)
        local x1=1.2*radius*math.sin(lastAngle+angle/2)
        local y1=-1.2*radius*math.cos(lastAngle+angle/2)

        local x2=line_lgth
        local y2=y1
        local x3,y3=nil,nil
        if x0<=0 then
            x2=-x2
        end

        if adjust then
            if x0>0 and x2-x1<length_txt then x2=x1+length_txt end
            if x0<=0 and x1-x2<length_txt then x2=x1-length_txt end            
        end 
        
        if idx>1 then
            local dY = math.abs(y2-lastPt2[2])
            if dY < line_space and lastPt2[1]*x1>0 then
                if x0>0 then
                    y2 = line_space+lastPt2[2]
                else
                    y2 = -line_space+lastPt2[2]
                end
                if (y2>y1 and x0>0) or (y2<y1 and x0<0 )  then
                    --x3 is for vertical segment if needed
                    x3,y3=x2,y2                    
                    x2=x1
                    if x3>0 then x3=x3+txt_offset end
                else
                    Z=intercept({x0,y0},{x1,y1},{0,y2},{1,y2})
                    x1,y1=Z[1],Z[2]
                end
            end
        else
            --remind x2,y2 of first value
            x2first,y2first = x2,y2
        end

        if font_color==nil then
            cairo_set_source_rgba(cr,rgb_to_r_g_b(table_colors[idx_color][1],table_colors[idx_color][2]))
        else
            local pat = cairo_pattern_create_linear (x2,y2, x0,y0)
            cairo_pattern_add_color_stop_rgba (pat, 0, rgb_to_r_g_b(font_color,font_alpha))
            cairo_pattern_add_color_stop_rgba (pat, 1, rgb_to_r_g_b(table_colors[idx_color][1],table_colors[idx_color][2]))
            cairo_set_source (cr, pat)
            cairo_pattern_destroy(pat)
        end

        
        cairo_move_to(cr,x0,y0)
        cairo_line_to(cr,x1,y1)
        cairo_line_to(cr,x2,y2)
        if x3~=nil then 
            cairo_line_to(cr,x3,y3)
            x2,y2=x3,y3    
        end
        cairo_set_line_width(cr,line_width)
        cairo_stroke(cr)
        --lastAngle=lastAngle+angle
        return {x2,y2}
    end
    
    function intercept(p11,p12,p21,p22)
        --calculate interscetion of two lines and return coordinates
        a1=(p12[2]-p11[2])/(p12[1]-p11[1])

        a2=(p22[2]-p21[2])/(p22[1]-p21[1])

        b1=p11[2]-a1*p11[1]

        b2=p21[2]-a2*p21[1]

        X=(b2-b1)/(a1-a2)

        Y=a1*X+b1
        return {X,Y}
    end

    --some checks
    if t.first_angle>=t.last_angle then
        local tmp_angle=t.last_angle
        --t.last_angle=t.first_angle
        --t.first_angle=tmp_angle
        print ("inversed angles")
    end

    if t.last_angle-t.first_angle>360 and t.first_angle>0 then
        t.last_angle=360+t.first_angle
        print ("reduce angles")
    end
    
    if t.last_angle+t.first_angle>360 and t.first_angle<=0 then
        t.last_angle=360+t.first_angle
        print ("reduce angles")
    end
    
    if t.int_radius<0 then t.int_radius =0 end
    if t.int_radius>t.radius then
        local tmp_radius=t.radius
        t.radius=t.int_radius
        t.int_radius=tmp_radius
        print ("inversed angles")
    end
    if t.int_radius==t.radius then
        t.int_radius=0
        print ("int radius set to 0")
    end    
    --end of checks
    
    cairo_save(cr)
    cairo_translate(cr,t.xc,t.yc)
    cairo_set_line_join (cr, CAIRO_LINE_JOIN_ROUND)
    cairo_set_line_cap (cr, CAIRO_LINE_CAP_ROUND)
    
    local nbArcs=#tableV
    local anglefull= (t.last_angle-t.first_angle)*math.pi/180
    local fullsize = 0
    for i= 1,nbArcs do
        fullsize=fullsize+tableV[i][4]
    end

    local cb,cf,angle=0,0,anglefull/nbArcs
    lastAngle=t.first_angle*math.pi/180
    lastPt2={nil,nil}

    for i =1, nbArcs do
        if t.proportional then
            angle=tableV[i][4]/fullsize*anglefull
        end
        --set colours
        cb,cf=cb+1,cf+1
        if cb>#t.tablebg then cb=1 end
        if cf>#t.tablefg then cf=1 end
        
        if tableV[i][2]~="" then
            str=string.format('${%s %s}',tableV[i][2],tableV[i][3])
        else
            str = tableV[i][3]
        end
        str=conky_parse(str)
        value=tonumber(str)
        if value==nil then value=0 end
    
        --draw sectors
        draw_sector(t.tablebg,cb,1,lastAngle,angle,t.radius,t.int_radius,t.gradient_effect,t.type_arc,t.inverse_l_arc)
        --print (t.tablefg,cf,tableV[i][2],tableV[i][3],lastAngle,angle,t.radius,t.int_radius)
        --print (cf,tableV[i],tableV[i][2],tableV[i][3])
        draw_sector(t.tablefg,cf,value/tableV[i][4],lastAngle,angle,t.radius,t.int_radius,t.gradient_effect,t.type_arc,t.inverse_l_arc)

        if t.show_text then
            --draw text
            local txt_l   = tableV[i][1]
            local txt_opc = round(100*value/tableV[i][4],t.nb_decimals).."%%"
            local txt_fpc = round(100*(tableV[i][4]-value/tableV[i][4]),t.nb_decimals).."%%"
            local txt_ov,txt_fv,txt_max
            if tableV[i][5]==true then
                txt_ov  = size_to_text(value,t.nb_decimals)
                txt_fv  = size_to_text(tableV[i][4]-value,t.nb_decimals)
                txt_max = size_to_text(tableV[i][4],t.nb_decimals)
            else
                if tableV[i][5]=="%" then tableV[i][5]="%%" end
                txt_ov=string.format("%."..t.nb_decimals.."f ",value)..tableV[i][5]
                txt_fv=string.format("%."..t.nb_decimals.."f",tableV[i][4]-value)..tableV[i][5]
                txt_max=string.format("%."..t.nb_decimals.."f",tableV[i][4])..tableV[i][5]
            end
            txt_pc = string.format("%."..t.nb_decimals.."f",100*tableV[i][4]/fullsize).."%%"
            local txt_out = t.txt_format
            txt_out = string.gsub(txt_out,"&amp;l",txt_l)  --label
            txt_out = string.gsub(txt_out,"&amp;o",txt_opc)--occ. %
            txt_out = string.gsub(txt_out,"&amp;f",txt_fpc)--free %
            txt_out = string.gsub(txt_out,"&amp;v",txt_ov) --occ. value
            txt_out = string.gsub(txt_out,"&amp;n",txt_fv) --free value
            txt_out = string.gsub(txt_out,"&amp;m",txt_max)--max
            txt_out = string.gsub(txt_out,"&amp;p",txt_pc)--percent
            
            local te=cairo_text_extents_t:create()
            cairo_set_font_size(cr,t.font_size)
            cairo_select_font_face(cr, t.txt_font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
            cairo_text_extents (cr,txt_out,te)

            --draw lines 
            lastPt2=draw_lines(i,nbArcs,angle,t.tablefg,cf,t.extend_line,t.line_lgth+t.radius, 
                    te.width + te.x_bearing,t.txt_offset,t.radius,t.line_width,t.line_space,t.font_color,t.font_alpha)    
        
            local xA=lastPt2[1]
            local yA=lastPt2[2]-t.line_width-t.txt_offset
            if xA>0 then xA = xA-(te.width + te.x_bearing) end
            cairo_move_to(cr,xA,yA)
            cairo_show_text(cr,txt_out)
        end
        
        lastAngle=lastAngle+angle
    end
    cairo_restore(cr)
end


--[[END OF PIE CHART WIDGET]]