-- Standard awesome library  
require("awful")  
require("mouse")  
require("awful.autofocus")  
require("awful.rules")  
-- Theme handling library  
require("beautiful")  
-- Notification library  
require("naughty")  
require("vicious")  
--scratch.drop()   
require("scratch")  
require("drop_only")  
--require("mail-simple")   
--require("rodentbane")  
--run_or_raise() 一个窗口，  
require("aweror")  
--动态tags  
require("eminent")  
--文件列表  
--将所有窗口平铺到当前tag 然后可以用jkhl 移动焦点，回车后回到所选窗口所在的tag  
require("revelation")  
beautiful.init("/usr/share/awesome/themes/default/theme.lua")  
  
-- Default modkey.  
-- Usually, Mod4 is the key with a logo between Control and Alt.  
-- If you do not like this or do not have such a key,  
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.  
-- However, you can use another modifier like Mod1, but it may interact with others.  
local modkey = "Mod4"   
local altkey = "Mod1"   
local ctrlkey="Control"  
local shiftkey="Shift"  
--输入法  
awful.util.spawn_with_shell("pkill -9 fcitx ; fcitx")   
--运行urxvt 的后台进程urxvtd，然后用urxvtc 启动客户端，快速  
--awful.util.spawn_with_shell("pkill -9 urxvtd ; urxvtd -q -f -o ")  
terminal='urxvtc'  
--terminal='urxvtc "$@";if [ $? -eq 2 ]; then urxvtd -q -o -f; urxvtc "$@";fi'  
editor = os.getenv("EDITOR") or "nano"  
editor_cmd = terminal .. " -e " .. editor  
-- Table of layouts to cover with awful.layout.inc, order matters.  
layouts =  
   {  
   awful.layout.suit.tile,  
   awful.layout.suit.tile.bottom,  
   awful.layout.suit.tile.left,  
   awful.layout.suit.floating,  
   awful.layout.suit.magnifier  
   --    awful.layout.suit.tile.top,  
   --awful.layout.suit.spiral.dwindle  
   --awful.layout.suit.fair.horizontal,  
   --awful.layout.suit.spiral,  
   --awful.layout.suit.fair,  
   --    awful.layout.suit.max,  
   --   awful.layout.suit.max.fullscreen,  
}  
-- }}}  
--print("dddddddddd")  
-- {{{ Tags  
-- Define a tag table which hold all screen tags.  
tags = {}  
for s = 1, screen.count() do  
   tags[s] = awful.tag({ "Main",  "Web","Media","Java","Vbox","Gimp","Emacs"}, s,{ layouts[1],layouts[1],layouts[1],layouts[1],layouts[4],layouts[4]},layouts[1])  
end  
-- }}}  
myawesomemenu = {  
   { "manual", terminal .. " -e man awesome" },  
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },  
   { "restart", awesome.restart },  
   { "quit", awesome.quit }  
}  
TextEditorMenu = {  
   { "Gvim", "gvim" },  
   { "Evim普通文本编辑器", "evim" },  
   { "Emacs", "emacs" },  
}  
OpenOfficeMenu = {  
   { "OpenOffice", "ooffice " },  
   { "OpenOffice Writer(Word)", "ooffice -write" },  
   { "OpenOffice Calc(Excel)", "ooffice -calc" },  
   { "OpenOffice Impress", "ooffice -impress" },  
   { "OpenOffice Base(DataBase)", "ooffice -base" },  
   { "OpenOffice Draw", "ooffice -draw" },  
   { "OpenOffice Math", "ooffice -math" },  
   { "OpenOffice Print", "ooffice -printeradmin" },  
}  
TerminalMenu={  
   { "Xterm 终端", "xterm" },  
   { "Urxvt 终端", "urxvt" },  
   { "Mlterm 终端", "mlterm" },  
}  
mymainmenu = awful.menu({ items = {   
                             { "OpenOffice", OpenOfficeMenu, beautiful.awesome_icon },  
                             { "文本编辑器", TextEditorMenu, beautiful.awesome_icon },  
                             { " 终   端", TerminalMenu, beautiful.awesome_icon },  
                             { "stardict 翻译 词典", "stardict" },  
                             { "gpicview 图片浏览", "gpicview" },  
                             { "Gimp 图片编辑", "gimp" },  
                             { "VirtualBox 虚拟机", "VirtualBox" },  
                             { "PcManFM 资源管理器", "pcmanfm" },  
                             { "FireFox 浏览器 ", "firefox" },  
                             { "awesome", myawesomemenu, beautiful.awesome_icon },  
                             { "Shutdown", "sudo shutdown -h now" },  
                             { "Reboot", "sudo shutdown -r now" }  
                       }})  
mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu=mymainmenu})  
 function toggle_menu ()  
                        local cur_mouse_pos=mouse.coords()  
                              mouse.coords({x=0,y=0},true)  
                              mymainmenu:toggle()  
                              mouse.coords(cur_mouse_pos,true)  
end  
menuautoicon = widget({ type = "imagebox" })  
menuautoicon.image = image(beautiful.awesome_icon)  
menuautoicon:buttons(  
   awful.util.table.join(  
      awful.button({ }, 1, toggle_menu  )  
   )  
)  
mytextclock = awful.widget.textclock({ align = "right" },"<span color='green'>%Y-%m-%d</span> <span   color='yellow'>%H:%M</span>",1)  
--电池  
textbat=widget({type="textbox", name="textbat"})  
textbat.text="电量:"  
bat1 = awful.widget.progressbar()  
bat1:set_width(13)  
bat1:set_height(25)  
bat1:set_vertical(true)  
bat1:set_background_color("grey")  
bat1:set_border_color("#000000")  
bat1:set_color("green")  
--bat1:set_gradient_colors({ 'green', 'yellow', 'green' })  
--bat1:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })  
vicious.register(bat1, vicious.widgets.bat, "$2", 61, "BAT1")  
cpu = awful.widget.graph()  
cpu:set_width(50)  
cpu:set_height(25)  
cpu:set_border_color("grey")  
cpu:set_background_color("blue")  
cpu:set_color("yellow")  
--cpu:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })  
vicious.register(cpu, vicious.widgets.cpu, "$1")  
textVolume=widget({type="textbox", name="textVolume"})  
volumeButtons = awful.util.table.join(  
   awful.button({ }, 4, function()   
                           awful.util.spawn_with_shell("amixer -q -c 0 set Master unmute")  
                           awful.util.spawn_with_shell("amixer -q -c 0 set Master 5%+")  
                        end  ),  
   awful.button({ }, 5, function()  
                           awful.util.spawn_with_shell("amixer -q -c 0 set Master unmute")  
                           awful.util.spawn_with_shell("amixer -qc 0 set Master 5%-")  
                        end  ),  
   awful.button({ }, 3, function()  
                           awful.util.spawn_with_shell("amixer -q -c 0 set Master unmute")  
                           awful.util.spawn_with_shell("amixer -qc 0 set Master 5%-")  
                        end  ),  
   awful.button({ }, 1, function()  
                           local offcount=awful.util.pread("amixer  -c 0 set Master toggle |grep off|wc -l")  
                           if  string.match(offcount, "0") then   
                              awful.util.spawn_with_shell("amixer -qc 0 set Master 89%")  
                           else   
                              awful.util.spawn_with_shell("amixer -qc 0 set Master 0")  
                           end  
                        end  )  
)  
textVolume:buttons(volumeButtons)  
vicious.register(textVolume, vicious.widgets.volume, "<span color='red'>$2$1%</span>", 1, 'Master')  
volume = awful.widget.progressbar()  
volume:set_width(15)  
volume:set_height(25)  
volume:set_vertical(true)  
volume:set_background_color('#000000')  
volume:set_border_color('#999933')  
volume:set_color('green')  
volume:set_gradient_colors({ 'red', 'yellow', 'green' })  
vicious.register(volume, vicious.widgets.volume, '$1', 1, 'Master')  
-- Create a systray  
mysystray = widget({ type = "systray" })  
-- Create a wibox for each screen and add it  
mywibox = {}  
mypromptbox = {}  
mylayoutbox = {}  
mytaglist = {}  
mytaglist.buttons = awful.util.table.join(  
   awful.button({ }, 1, awful.tag.viewonly),  
   awful.button({ modkey }, 1, awful.client.movetotag),  
   awful.button({ }, 3, awful.tag.viewtoggle),  
   awful.button({ modkey }, 3, awful.client.toggletag),  
   awful.button({ }, 4, awful.tag.viewnext),  
   awful.button({ }, 5, awful.tag.viewprev)  
)  
mytasklist = {}  
--以下定义鼠标左键，右键，滚轮在任务栏上的事件  
mytasklist.buttons = awful.util.table.join(  
   awful.button({ }, 1, function (c)  
                           if not c:isvisible() then  
                              awful.tag.viewonly(c:tags()[1])  
                           end  
                           client.focus = c  
                           c:raise()  
                        end),  
   awful.button({ }, 3, function ()  
                           if taskMenuInstance then  
                              taskMenuInstance:hide()  
                              taskMenuInstance = nil  
                           else  
                              taskMenuInstance  = awful.menu.clients({ width=250 })  
                           end  
                        end),  
   awful.button({ }, 4, function ()  
                           awful.client.focus.byidx(1)  
                           if client.focus then client.focus:raise() end  
                        end),  
   awful.button({ }, 5, function ()  
                           awful.client.focus.byidx(-1)  
                           if client.focus then client.focus:raise() end  
                        end))  
for s = 1, screen.count() do  
   -- Create a promptbox for each screen modkey+R 运行对话框  
   mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })  
   -- Create an imagebox widget which will contains an icon indicating which layout we're using.  
   -- We need one layoutbox per screen. 布局图标  
   mylayoutbox[s] = awful.widget.layoutbox(s)  
   mylayoutbox[s]:buttons(awful.util.table.join(  
                             awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),  
                             awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),  
                             awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),  
                             awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end))  
                       )  
   -- Create a taglist widget显示所有的tag 如我的Main Vbox Java 4   
   mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)  
   -- Create a tasklist widget  
   mytasklist[s] = awful.widget.tasklist(function(c)  
                                            return awful.widget.tasklist.label.currenttags(c, s)  
                                         end, mytasklist.buttons)  
   -- Create the wibox  
   mywibox[s] = awful.wibox({ position = "top", screen = s })  
   -- Add widgets to the wibox - order matters  
   -- {{{ CPU USAGE  
     
   mywibox[s].widgets = {  
--      mylauncher,  
      menuautoicon,  
      mytaglist[s],  
      --w_imap,  
      mypromptbox[s],  
      mytextclock,battext,textbat,bat1,cpu,  volume,textVolume,  
      { mylayoutbox[s],  
        s == 1 and mysystray or nil,  
        mytasklist[s],  
        layout = awful.widget.layout.horizontal.rightleft },  
      layout = awful.widget.layout.horizontal.leftright  
   }  
end  
-- }}}  
-- {{{ Mouse bindings  
root.buttons(awful.util.table.join(  
                awful.button({ }, 1, function () mymainmenu:hide() end),  
                awful.button({ }, 3, function () mymainmenu:toggle() end),  
                awful.button({ }, 4, awful.tag.viewnext),  
                awful.button({ }, 5, awful.tag.viewprev)  
          ))  
-- }}}  
-- {{{ Key bindings  
globalkeys = awful.util.table.join(  
   --stardict 文本模式,要用到xsel sdcv  
   awful.key({ modkey }, "d", function ()  
                                 local f = io.popen("xsel -o")  
                                 local new_word = f:read("*a")  
                                 f:close()  
                                 if frame ~= nil then  
                                    naughty.destroy(frame)  
                                    frame = nil  
                                    if old_word == new_word then  
                                       return  
                                    end  
                                 end  
                                 old_word = new_word  
                                 local fc = ""  
                                 local f  = io.popen("sdcv -n --utf8-output -u '朗道英汉字典5.0' "..new_word)  
                                 for line in f:lines() do  
                                    fc = fc .. line .. '/n'  
                                 end  
                                 f:close()  
                                 frame = naughty.notify({ text = fc, timeout = 6, width = 320 ,icon="/usr/share/stardict/pixmaps/docklet_scan.png"})  
                              end),  
   --将所有窗口平铺到当前tag 然后可以用jkhl 移动焦点，回车后回到所选窗口所在的tag  
   awful.key({ modkey }, "w",  revelation.revelation),  
   awful.key({ modkey       }, "f",                   function () run_or_raise("firefox",{ class="Firefox",instance="Navigator"}) end),  
   awful.key({shiftkey      }, "XF86AudioLowerVolume", function ()  awful.util.spawn_with_shell("amixer -q -c 0 set Master 5%-")  end),  
   awful.key({shiftkey      }, "XF86AudioRaiseVolume", function ()  awful.util.spawn_with_shell("amixer -q -c 0 set Master 5%+")  end),  
   awful.key({              }, "XF86AudioRaiseVolume", function ()  awful.util.spawn_with_shell("amixer -q -c 0 set PCM 5%+")  end),  
   awful.key({              }, "XF86AudioLowerVolume", function ()  awful.util.spawn_with_shell("amixer -q -c 0 set PCM 5%-")  end),  
   --文本模式下的music 播放器  
   awful.key({      }, "F6", function ()  
                                local offcount=awful.util.pread("pgrep -f mocp |wc -l")  
                                if  string.match(offcount, "0") then   
                                   awful.util.spawn_with_shell("mocp -S ")  
                                end  
                                drop_only("urxvt -e mocp ","center","center",1024,700,false,1)  
                             end),  
   awful.key({      }, "F1", function () drop_only("urxvtc" ,"center","center",1024,700,false,1) end),  
   awful.key({      }, "F3", function () drop_only("gksu urxvtc", "center","center",900,600,false,1) end),  
   --   awful.key({      }, "Escape", function () drop_only.hideall() end),  
   awful.key({      }, "XF86AudioStop", function ()         awful.util.spawn_with_shell("mocp -s ")  end),  
   awful.key({      }, "XF86AudioPlay", function ()         awful.util.spawn_with_shell("mocp -G ")  end),  
   awful.key({      }, "XF86AudioNext", function ()         awful.util.spawn_with_shell("mocp -f ")  end),  
   awful.key({      }, "XF86AudioPrev", function ()         awful.util.spawn_with_shell("mocp -r ")  end),  
   --用键盘进行定位，移动指什  
   --awful.key({      }, "F4", function () rodentbane.start() end),  
   --锁屏，  
   awful.key({modkey,       }, "F12",      function () awful.util.spawn("xlock") end),  
   awful.key({modkey,       }, "t",        function () awful.util.spawn_with_shell(terminal) end),  
   awful.key({modkey,"Shift"}, "t",        function () awful.util.spawn_with_shell("sudo mlterm") end),  
   awful.key({modkey,       }, "e",        function () awful.util.spawn("pcmanfm") end  ),  
   awful.key({modkey,       }, "g",        function () awful.util.spawn("gimp") end  ),  
   awful.key({modkey,       }, "a",        function () awful.util.spawn("quodlibet") end  ),  
   awful.key({modkey,       }, "i",        function () awful.util.spawn("eclipse-3.5") end  ),  
   awful.key({modkey,       }, "m",        function () awful.util.spawn("myeclipse") end  ),  
   awful.key({modkey,       }, "s",        function () awful.util.spawn("stardict") end  ),  
   awful.key({              }, "Print",    function () awful.util.spawn("scrot  -e 'mv $f ~/shots;gpicview ~/shots/$f'") end  ),  
   awful.key({modkey,       }, "v",        function () awful.util.spawn("VirtualBox") end  ),  
   awful.key({modkey,       }, "x",        function () awful.util.spawn("VirtualBox  --comment xp --startvm b1d64578-b9a6-49a2-9b19-5916bfdd848f ") end  ),  
   awful.key({ modkey }, "n",   awful.tag.viewnext),  
   awful.key({ modkey }, "p",   awful.tag.viewprev),  
   awful.key({ modkey }, "Tab", awful.tag.history.restore),  
   --将每一个窗口与它的下一个窗口交换，同时把焦点放到主窗口上，也就是循环把窗口送到主窗口上  
   awful.key({ altkey,        }, "Tab",   function (c) awful.client.cycle(false,mouse.screen) client.focus=awful.client.getmaster() end),  
   --焦点切换  
   awful.key({ modkey,        }, "j",     function () awful.client.focus.byidx( 1) if client.focus then client.focus:raise() end end),  
   awful.key({ modkey,        }, "k",     function () awful.client.focus.byidx(-1) if client.focus then client.focus:raise() end end),  
   --对调焦点窗口与下一个窗口  
   awful.key({modkey,"Control"}, "j",     function () awful.client.swap.byidx(  1)    end),  
   awful.key({modkey,"Control"}, "k",     function () awful.client.swap.byidx( -1)    end),  
   awful.key({ modkey,        }, "u",     awful.client.urgent.jumpto),  
   -- Standard program  
   awful.key({modkey,"Control"}, "r",     awesome.restart),  
   awful.key({modkey,"Control"}, "q",     awesome.quit),  
   --多增加一列  
   --awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),  
   --awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),  
   awful.key({ modkey,        }, "space", function () awful.layout.inc(layouts,  1) end),  
   awful.key({ modkey,"Shift" }, "space", function () awful.layout.inc(layouts, -1) end),  
   awful.key({ modkey         }, "r",     function () mypromptbox[mouse.screen]:run() end)  
   --awful.key({ modkey, "Shift" }, "x",  
   --         function ()  
   --            awful.prompt.run({ prompt = "Run Lua code: " },  
   --           mypromptbox[mouse.screen].widget,  
   --          awful.util.eval, nil,  
   --         awful.util.getdir("cache") .. "/history_eval")  
   --    end)  
)  
clientkeys = awful.util.table.join(  
   --awful.key({ modkey }, "d", function (c) scratch.pad.set(c, 0.80, 0.80, true) end),  
   awful.key({ modkey,        }, "l",     function (c)  
                                             if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier then   
                                                awful.client.incwfact(-0.1)   
                                             end   
                                             awful.tag.incmwfact( 0.05)   end),  
   awful.key({ modkey,        }, "h",     function (c)   
                                             if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier then   
                                                awful.client.incwfact(0.1)  
                                             end   
                                             awful.tag.incmwfact( -0.05)   end),  
   awful.key({ modkey            }, "Next",  function () awful.client.moveresize( 20,  20, -40, -40) end),  
   awful.key({ modkey            }, "Prior", function () awful.client.moveresize(-20, -20,  40,  40) end),  
   awful.key({ modkey            }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),  
   awful.key({ modkey            }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),  
   awful.key({ modkey            }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),  
   awful.key({ modkey            }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),  
   awful.key({ modkey,          },  "q",    function (c) c:kill()                         end),  
   awful.key({ modkey,          },  "F4",    function (c) c:kill()                         end),  
   awful.key({ modkey, "Control"}, "space",  awful.client.floating.toggle                     ),  
   awful.key({ modkey,          }, "Return", function (c)   
                                                local master=awful.client.getmaster()  
                                                if    master ~=c    then  
                                                   c:swap(master)  
                                                else   
                                                   awful.client.swap.byidx(  1)   
                                                   client.focus=awful.client.getmaster()  
                                                end  
                                             end),  
   --awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),  
   --awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),  
   awful.key({             },       "F11",      function (c) c.fullscreen = not c.fullscreen  end),  
   awful.key({modkey,      },       "F11",      function (c) c.maximized_horizontal = not c.maximized_horizontal  
                                                   c.maximized_vertical   = not c.maximized_vertical  
                                                end)  
)  
-- Compute the maximum number of digit we need, limited to 9  
keynumber = 0  
for s = 1, screen.count() do  
   keynumber = math.min(9, math.max(#tags[s], keynumber));  
end  
-- Bind all key numbers to tags.  
-- Be careful: we use keycodes to make it works on any keyboard layout.  
-- This should map on the top row of your keyboard, usually 1 to 9.  
for i = 1, keynumber do  
   globalkeys = awful.util.table.join(globalkeys,  
                                      awful.key({ modkey }, "#" .. i + 9,  
                                                function ()  
                                                   local screen = mouse.screen  
                                                   if tags[screen][i] then  
                                                      awful.tag.viewonly(tags[screen][i])  
                                                   end  
                                                end),  
                                      awful.key({ modkey, "Control" }, "#" .. i + 9,  
                                                function ()  
                                                   local screen = mouse.screen  
                                                   if tags[screen][i] then  
                                                      awful.tag.viewtoggle(tags[screen][i])  
                                                   end  
                                                end),  
                                      awful.key({ modkey, "Shift" }, "#" .. i + 9,  
                                                function ()  
                                                   if client.focus and tags[client.focus.screen][i] then  
                                                      awful.client.movetotag(tags[client.focus.screen][i])  
                                                   end  
                                                end),  
                                      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,  
                                                function ()  
                                                   if client.focus and tags[client.focus.screen][i] then  
                                                      awful.client.toggletag(tags[client.focus.screen][i])  
                                                   end  
                                                end))  
end  
clientbuttons = awful.util.table.join(  
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),  
   awful.button({ modkey }, 1, awful.mouse.client.move),  
   awful.button({ modkey }, 3, awful.mouse.client.resize))  
-- Set keys  
root.keys(globalkeys)  
-- }}}  
-- {{{ Rules  
awful.rules.rules = {  
   -- All clients will match this rule.  
   { rule = { },                                         properties = { border_width = beautiful.border_width,  
                                                                        border_color = beautiful.border_normal,   
                                                                        focus = true,  
                                                                        size_hints_honor = false,  
                                                                        keys = clientkeys,   
                                                                        buttons = clientbuttons } },  
   --   { rule = {  class = "Emacs"},    properties = { tag=tags[1][7] }  },  
   { rule = { instance="Download", class = "Firefox"},    properties = { floating = true }, callback = awful.titlebar.add  },  
   { rule = {  class = "Firefox"},                        properties = { tag=tags[1][2] }  },  
   { rule = {  class = "Firefox",instance="Browser"},                        properties = { tag=tags[1][2],floating=true }  },  
   --{ rule = { class = "MPlayer"                   },     properties = {  } ,callback=awful.titlebar.add},  
   { rule = { class = "Xmessage"                },     properties = { floating = true, } },  
   { rule = { class = "Gxmessage"                   },     properties = { floating = true, },callback=awful.titlebar.add  },  
   { rule = { class = "Stardict"                },     properties = { focus=true }, callback  = awful.client.setslave  },  
   { rule = { class = "Gimp"                        },     properties = {  tag = tags[1][6]} },  
   { rule = { class = "Gimp",role="gimp-toolbok"    },     properties = {  tag = tags[1][6]} },  
   { rule = { class = "VirtualBox"              },     properties = {  tag = tags[1][5]} },  
   { rule = {class="MyEclipse Enterprise Workbench"},      properties = {  tag = tags[1][4]} },  
   { rule = { class = "Eclipse"                 },     properties = {  tag = tags[1][4]} },  
   { rule = {class="Quodlibet"                    }, properties = {tag=tags[1][3] }, callback = function(c) awful.client.setslave(c) end },  
   { rule = {class="XTerm"                    }, properties = { }, callback = function(c) awful.client.setslave(c) end },  
   { rule = {class="URxvt"                    }, properties = { }, callback = function(c) awful.client.setslave(c) end },  
   { rule = {class="mlterm"                    }, properties = { }, callback = function(c) awful.client.setslave(c) end }  
}  
-- }}}  
-- {{{ Signals  
-- Signal function to execute when a new client appears.  
client.add_signal("manage", function (c, startup)  
                               -- Add titlebar to floaters, but remove those from rule callback  
--                               if awful.client.floating.get(c) or awful.layout.get(c.screen) == awful.layout.suit.floating then  
                               if awful.client.floating.get(c)  then   
                                    awful.titlebar.add(c, {modkey = modkey})   
                               end  
                            -- Enable sloppy focus  
                            c:add_signal("mouse::enter", function(x)  
                                                            local cur_mouse_pos=mouse.coords()  
                                                            if cur_mouse_pos.x>2 then  
                                                               --人性化，因为当x处在屏幕慕边界处（mouse.x=0时，)  
                                                               --也会隐藏菜单，故，做个特殊处理）  
                                                               mymainmenu:hide()  
                                                            end  
                                                            if taskMenuInstance then  
                                                               taskMenuInstance:hide()--关闭任务栏列表，如果存在的话  
                                                               taskMenuInstance = nil  
                                                            end  
                                                            --鼠标进入，聚焦，此处注释掉了  
                                                            if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier  
                                                            and awful.client.focus.filter(c) then  
                                                            client.focus = c  
                                                         end  
                                                      end)  
                            if not startup then  
                               -- Set the windows at the slave,  
                               -- i.e. put it at the end of others instead of setting it master.  
                               -- awful.client.setslave(c)  
                               -- Put windows in a smart way, only if they does not set an initial position.  
                               if not c.size_hints.user_position and not c.size_hints.program_position then  
                                  awful.placement.no_overlap(c)  
                                  awful.placement.no_offscreen(c)  
                               end  
                            end  
                         end)  
client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)  
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)  
-- }}}  
  
-- 保持浮动窗口始终在上,当然浮动布局中除外  
for s = 1, screen.count() do screen[s]:add_signal("arrange", function ()  
                                                                local clients = awful.client.visible(s)  
                                                                local layout = awful.layout.getname(awful.layout.get(s))  
                                                                for _, c in pairs(clients) do -- Floaters are always on top  
                                                                   if   awful.client.floating.get(c) or layout == "floating" then  
                                                                      if not c.fullscreen   then   
                                                                         c.above       =  true   
                                                                      end  
                                                                   else           
                                                                      c.above       =  false   
                                                                   end  
                                                                end  
                                                             end)  
end  
--{{{ 壁纸，一个目录的图片作为壁纸  
x = 0  
-- setup the timer  
mytimer = timer { timeout = x }  
mytimer:add_signal("timeout", function()  
                                 -- tell awsetbg to randomly choose a wallpaper from your wallpaper directory  
                                 os.execute("awsetbg  -F  -r  /resource/system/image&")  
                                 -- stop the timer (we don't need multiple instances running at the same time)  
                                 mytimer:stop()  
                                 -- define the interval in which the next wallpaper change should occur in seconds  
                                 -- (in this case anytime between 3 and 6 minutes)  
                                 x = math.random( 3*60, 6*120)  
                                 --restart the timer  
                                 mytimer.timeout = x  
                                 mytimer:start()  
                              end)  
-- initial start when rc.lua is first run  
mytimer:start()  
---}}}  
function debug_(var)  
    naughty.notify({ text = var, timeout = 5 })  
end  
