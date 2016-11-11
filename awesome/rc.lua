-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

local runonce = require("runonce")

-- Themes define colours, icons, and wallpapers
beautiful.init("/home/zy/.config/awesome/theme/theme.lua")

naughty.config.presets.normal.opacity = 0.8
naughty.config.presets.low.opacity = 0.8
naughty.config.presets.critical.opacity = 0.8

-- My custom widgets
local widgets = require("widgets")

-- Awesome Pulseaudio Widget
--local APW = require("apw/widget")

-- {{{ Error handling
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- This is used later as the default terminal and editor to run.
--terminal = "sakura"
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"

media = {
	play = "yy-music toggle",
	stop = "yy-music stop",
	next = "yy-music next",
	prev = "yy-music prev",
	volUp = "yy-volume up",
	volDown = "yy-volume down",
	volMute = "yy-volume mute",
}

screen_locker = "dm-tool lock"
screen_locker = "yy-lockscreen"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.max,
--    awful.layout.suit.floating,
}
-- }}}

local dualscreen_mode = false
if screen.count() == 2 then dualscreen_mode = true end


-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tags[1] = awful.tag({ "s", "w", "m", "d", "w", "g" }, 1, layouts[2])
if dualscreen_mode then
  tags[2] = awful.tag({ "1", "2", "3" }, 2, layouts[2]) -- second screen with max layout
end

awful.layout.set(layouts[1], tags[1][5])
-- }}}

-- {{{ Wibox
-- Create the wibox on main screen
wb_wibox = awful.wibox({ position = "top", screen = 1, height = 18 })
-- Init widgets:
wb_promptbox = awful.widget.prompt()

wb_taglist_buttons = awful.util.table.join(
                     awful.button({ }, 1, awful.tag.viewonly),
                     awful.button({ modkey }, 1, awful.client.movetotag),
                     awful.button({ }, 3, awful.tag.viewtoggle),
                     awful.button({ modkey }, 3, awful.client.toggletag),
                     awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                     awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                     )
-- first screen
wb_taglist = awful.widget.taglist(1, awful.widget.taglist.filter.all, wb_taglist_buttons)
if dualscreen_mode then
    wb_taglist_second = awful.widget.taglist(2, awful.widget.taglist.filter.all, {})
end

wb_tasklist = {}
wb_tasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
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
wb_tasklist = awful.widget.tasklist(1, awful.widget.tasklist.filter.currenttags, wb_tasklist.buttons,
    {})
--	{ bg_focus = beautiful.bg_normal, fg_focus = beautiful.bg_focus })


-- Widgets that are aligned to the left
local left_layout = wibox.layout.fixed.horizontal()
left_layout:add(wb_promptbox)

-- Widgets that are aligned to the right
local right_layout = wibox.layout.fixed.horizontal()
right_layout:add(wibox.widget.systray())
--right_layout:add(APW)
right_layout:add(awful.widget.textclock())
right_layout:add(widgets.kbdlayout())
--right_layout:add(widgets.battery())
right_layout:add(wb_taglist)
right_layout:add(awful.widget.layoutbox(1))
if dualscreen_mode then
    right_layout:add(wb_taglist_second)
    right_layout:add(awful.widget.layoutbox(2))
end

-- Now bring it all together (with the tasklist in the middle)
local layout = wibox.layout.align.horizontal()
layout:set_left(left_layout)
layout:set_middle(wb_tasklist)
layout:set_right(right_layout)

wb_wibox:set_widget(layout)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
--    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
--    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "Return", function () wb_promptbox:run() end),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Screen lock
    awful.key({ modkey }, "z", function () awful.util.spawn(screen_locker, false) end),

    awful.key({ modkey }, "r", function () run_or_raise("urxvt -name ranger -e ranger", { instance = "ranger" }) end),
    awful.key({ modkey }, "e", function () run_or_raise("urxvt -name tmuxmain -e tmux-start.sh main", { instance = "tmuxmain" }) end),
    awful.key({ modkey }, "d", function () run_or_raise("urxvt -name tmuxdev -e tmux-start.sh dev", { instance = "tmuxdev" }) end),
    awful.key({ modkey }, "w", function () run_or_raise("firefox", { class = "Firefox" }) end),

    awful.key({ }, "Print", function () 
        awful.util.spawn("scrot '%Y-%m-%d_%H-%M-%S_$wx$h.png' -e 'mv $f ~/tmp/'", false) end),

    -- Volume control
    --awful.key({ modkey }, "-", APW.Down),
    --awful.key({ modkey }, "=", APW.Up),

    -- Media keys
    awful.key({ }, "XF86AudioStop",     function () awful.util.spawn(media.stop, false) end),
    awful.key({ }, "XF86AudioPlay",     function () awful.util.spawn(media.play, false) end),
    awful.key({ }, "XF86AudioNext",     function () awful.util.spawn(media.next, false) end),
    awful.key({ }, "XF86AudioPrev",     function () awful.util.spawn(media.prev, false) end),
    awful.key({ }, "XF86AudioMute",        function () awful.util.spawn(media.volMute, false) end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn(media.volDown, false) end),
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn(media.volUp, false) end),
    -- Media fallback
    awful.key({ modkey }, "Up",    function () awful.util.spawn(media.stop, false) end),
    awful.key({ modkey }, "Down",  function () awful.util.spawn(media.play, false) end),
    awful.key({ modkey }, "Right", function () awful.util.spawn(media.next, false) end),
    awful.key({ modkey }, "Left",  function () awful.util.spawn(media.prev, false) end),
    awful.key({ modkey }, "F10",   function () awful.util.spawn(media.volMute, false) end),
    awful.key({ modkey }, "F11",   function () awful.util.spawn(media.volDown, false) end),
    awful.key({ modkey }, "F12",   function () awful.util.spawn(media.volUp, false) end),
    -- Other keys
    awful.key({ }, "XF86MonBrightnessUp",function () awful.util.spawn("xbacklight +10", false) end),
    awful.key({ }, "XF86MonBrightnessDown",function () awful.util.spawn("xbacklight -10", false) end),
    awful.key({ }, "XF86TouchpadToggle",function () end),
    awful.key({ }, "XF86Display",       function () end),
    awful.key({ }, "XF86WLAN",          function () end),
    awful.key({ }, "XF86WebCam",        function () end),
    awful.key({ }, "XF86ScreenSaver",   function () end),
    awful.key({ }, "XF86Launch6",       function () end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "w",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
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
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },

    { rule = { instance = "plugin-container" },
      properties = { floating = true, border_width = 0 } },
    -- Gimp tweaks
    { rule = { class = "Gimp" },
      properties = { tag = tags[1][6], switchtotag = true } },
    { rule = { class = "Gimp", role = "gimp-toolbox" },
      properties = { floating = true, size_hints_honor = false },
      callback = function(c)
        rule_move_to_edge_of_workarea(c, { left = 220 })
      end
    },
    { rule = { class = "Gimp", role = "gimp-dock" },
      properties = { floating = true, size_hints_honor = false },
      callback = function (c)
        rule_move_to_edge_of_workarea(c, { right = 200 })
      end
    },

    { rule_any = { instance = { "Navigator", "zim" } },
      properties = { tag = tags[1][2], switchtotag = false } },

    { rule_any = { instance = { "spacefm" } },
      properties = { tag = tags[1][1], },
    },

--[[
    { rule = { instance = "gajim", role = "roster" },
      properties = { floating = true, size_hints_honor = false },
      callback = function (c)
        rule_move_to_edge_of_workarea(c, { right = 200 })
      end
    },
]]
-- [[
    { rule = { name = "the.invoice - Skype™" },
      properties = { floating = true, size_hints_honor = false },
      callback = function (c)
        rule_move_to_edge_of_workarea(c, { left = 300 })
        g = c:geometry()
        g.x = 0
        c:geometry(g)
      end
    },
--]]
    { rule = { instance = "gajim" },
      properties = { tag = tags[1][3] } },
    { rule = { instance = "skype" },
      properties = { tag = tags[1][3] } },

    { rule = { class = "Smplayer" },
      callback = function (c) if dualscreen_mode then awful.client.movetoscreen(c, 2) end end },

    { rule = { class = "URxvt" },
      properties = { size_hints_honor = false } },
}
-- }}}



-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    -- floating windows on top
    local function floating (c) c.ontop = awful.client.floating.get(c) end
    floating(c)
    c:connect_signal("property::floating", floating)

    if c.transient_for == client.focus then
        client.focus = c
        c:raise()
    end

	-- TODO: Вынести в одтельный модуль.
    local smartborders_enabled = true
    local smartborders_blacklist = { instance = "plugin-container" }
    if smartborders_enabled then
        local smart_borders_inside_handler = false
        local smart_borders = function (c)
            if smart_borders_inside_handler then return end
            -- TODO: Пока работает только для одного правила, передалать для любого количества.
            if awful.rules.match(c, smartborders_blacklist) then return end
            smart_borders_inside_handler = true
            if not c then return end
            local wg = screen[c.screen].workarea
            local cg = c:geometry()
            if wg.width == cg.width + c.border_width*2 and wg.height == cg.height + c.border_width*2 then
                c.border_width = 0
            else
                c.border_width = beautiful.border_width
            end
            smart_borders_inside_handler = false
        end
        smart_borders(c)
        c:connect_signal("property::geometry", function () smart_borders(c) end)
    end

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

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
  c:raise()
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}

function rule_move_to_edge_of_workarea (c, struts)
    local s = c.screen
    local workarea = screen[s].workarea
    local g = { x = workarea.x, width = workarea.width, y = workarea.y, height = workarea.height }

    if     struts.left then
        g.width = struts.left
    elseif struts.right then
        g.width = struts.right
        g.x = workarea.width - struts.right
    elseif struts.top then
        g.height = struts.top
    elseif struts.bottom then
        g.height = struts.bottom
        g.y = workarea.height - struts.bottom
    end
    c:struts(struts)
    c:geometry(g)
end


--- Spawns cmd if no client can be found matching properties
-- If such a client can be found, pop to first tag where it is visible, and give it focus
-- @param cmd the command to execute
-- @param properties a table of properties to match against clients.  Possible entries: any properties of the client object
function run_or_raise(cmd, properties)
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   for i, c in pairs(clients) do
      --make an array of matched clients
      if match(properties, c) then
         n = n + 1
         matched_clients[n] = c
         if c == focused then
            findex = n
         end
      end
   end
   if n > 0 then
      local c = matched_clients[1]
      -- if the focused window matched switch focus to next in list
      if 0 < findex and findex < n then
         c = matched_clients[findex+1]
      end
      local ctags = c:tags()
      if #ctags == 0 then
         -- ctags is empty, show client on current tag
         local curtag = awful.tag.selected()
         awful.client.movetotag(curtag, c)
      else
         -- Otherwise, pop to first tag client is visible on
         awful.tag.viewonly(ctags[1])
      end
      -- And then focus the client
      client.focus = c
      c:raise()
      return
   end
   awful.util.spawn(cmd)
end

-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v and not table2[k]:find(v) then
         return false
      end
   end
   return true
end


-- disable startup-notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end


-- autostart:
runonce.run "dex -a -e Awesome"
