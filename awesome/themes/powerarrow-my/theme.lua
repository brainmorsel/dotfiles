
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local os    = { getenv = os.getenv, execute = os.execute }
local widgets = require("widgets")

local C = {
    base03      = "#002b36",
    base02      = "#073642",
    base02_l    = "#094959",
    base01      = "#586e75",
    base00      = "#657b83",
    base0       = "#839496",
    base1       = "#93a1a1",
    base2       = "#eee8d5",
    base3       = "#fdf6e3",
    yellow      = "#b58900",
    orange      = "#cb4b16",
    red         = "#dc322f",
    magenta     = "#d33682",
    violet      = "#6c71c4",
    blue        = "#268bd2",
    cyan        = "#2aa198",
    green       = "#859900",
}

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-my"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "xos4 Terminus 14"
theme.taglist_font                              = "xos4 Terminus Bold 14"
theme.wibar_height                              = 24
theme.wibar_margin_bottom                       = 3
theme.fg_normal                                 = C.base01
theme.fg_focus                                  = C.base3
theme.fg_urgent                                 = C.base3
theme.bg_normal                                 = C.base2
theme.bg_focus                                  = C.yellow
theme.bg_urgent                                 = C.red
theme.border_width                              = 1
theme.border_normal                             = C.base2
theme.border_focus                              = theme.border_normal
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = C.base3
theme.tasklist_fg_focus                         = theme.bg_focus
theme.tasklist_spacing                          = 4
theme.tasklist_shape_border_width               = 0
theme.tasklist_shape_border_color               = theme.bg_normal
theme.tasklist_shape_border_width_focus         = 0
theme.tasklist_shape_border_color_focus         = theme.bg_focus
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
--theme.titlebar_bg_focus                         = "#00000000"
theme.titlebar_bg_focus                         = theme.bg_normal
theme.titlebar_bg_normal                        = theme.titlebar_bg_focus
theme.titlebar_fg_focus                         = theme.fg_focus
theme.titlebar_bar_normal                       = C.base0
theme.titlebar_bar_focus                        = theme.bg_focus
theme.menu_height                               = 16
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_centerfair                         = theme.dir .. "/icons/centerfair.png"
theme.layout_centerwork                         = theme.dir .. "/icons/centerwork.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.useless_gap                               = 1
theme.titlebar_close_button_normal              = gears.surface.load_from_shape (12, 12, gears.shape.circle, theme.titlebar_bar_normal)
theme.titlebar_close_button_focus               = gears.surface.load_from_shape (12, 12, gears.shape.circle, C.red)
theme.titlebar_minimize_button_normal           = theme.titlebar_close_button_normal
theme.titlebar_minimize_button_focus            = gears.surface.load_from_shape (12, 12, gears.shape.circle, C.yellow)
theme.titlebar_maximized_button_normal_inactive = theme.titlebar_close_button_normal
theme.titlebar_maximized_button_focus_inactive  = gears.surface.load_from_shape (12, 12, gears.shape.circle, C.green)
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.prompt_fg = theme.fg_focus
theme.prompt_bg = theme.bg_focus
theme.prompt_bg_cursor = theme.fg_focus

local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = wibox.widget.textclock(markup.font(theme.font, " <b>%H:%M</b> %a %b %d "))

-- Calendar
theme.cal = lain.widget.calendar({
    attach_to = { clock },
    icons = "",
    cal = "/usr/bin/env TERM=linux /usr/bin/cal --color=always",
    followtag = true,
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, "" .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, string.format("%2s%% ", cpu_now.usage)))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, "" .. math.floor(coretemp_now) .. "°C "))
    end
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    },
    followtag = true,
    settings = function()
        widget:set_markup(markup.font(theme.font, "" .. fs_now["/"].percentage .. "% "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, " AC "))
                baticon:set_image(theme.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, "" .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_image(theme.widget_ac)
        end
    end
})

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font(theme.font,
                          markup(C.green, "" .. net_now.received)
                          .. " " ..
                          markup(C.cyan, "" .. net_now.sent .. " ")))
    end
})

local volumeicon = wibox.widget.imagebox(theme.widget_vol)
local volume = lain.widget.pulse {
    settings = function()
        vlevel = math.floor((volume_now.left + volume_now.right) / 2) .. "% "
        if volume_now.muted == "yes" then
            vlevel = " M  "
        end
        widget:set_markup(markup.font(theme.font, vlevel))
    end
}
volume.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 2, function() -- middle click
        os.execute(string.format("pactl set-sink-volume %d 100%%", volume.device))
        volume.update()
    end),
    awful.button({}, 3, function() -- right click
        os.execute(string.format("pactl set-sink-mute %d toggle", volume.device))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("pactl set-sink-volume %d +1%%", volume.device))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("pactl set-sink-volume %d -1%%", volume.device))
        volume.update()
    end)
))

function shape_powerline_left(cr, width, height)
    return gears.shape.powerline(cr, width, height, -height/2)
end

function container_arrow(widget, direction)
    local margin = (theme.wibar_height - (theme.wibar_margin_bottom * 2)) / 2 - 4
    local direction = direction or "right"
    local shape = gears.shape.powerline
    if direction == "left" then
        shape = shape_powerline_left
    end
    return {
        {
            widget,
            widget = wibox.container.margin,
            left = margin,
            right = margin,
        },
        widget = wibox.container.background,
        bg = C.base3,
        shape = shape,
    }
end

function powerline_bar(widgets)
    local direction = widgets["direction"] or "right"
    local definitions = {
        layout = wibox.layout.fixed.horizontal,
    }

    for index, widget in ipairs(widgets) do
        if math.fmod(index, 2) == 0 then
            widget = container_arrow(widget, direction)
        end
        if direction == "right" then
            table.insert(definitions, widget)
        else
            table.insert(definitions, 1, widget)
        end
    end

    return definitions
end

function with_icon(icon, widget)
    return {
        icon,
        {
            widget,
            widget = wibox.container.margin,
            bottom = 2,
        },
        layout = wibox.layout.fixed.horizontal,
    }
end

--[[
theme.taglist_shape = function (cr, width, height)
    return gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, theme.wibar_height / 4)
end

theme.promptbox_shape = function (cr, width, height)
    return gears.shape.rounded_rect(cr, width, height, theme.wibar_height / 4)
end
]]--
theme.tasklist_shape = function (cr, width, height)
    --return gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, theme.wibar_height / 4)
    return gears.shape.rectangle(cr, width, height)
end


function wrap_in_margin(wrapped_widget, left, right, top, bottom)
    return {
        wrapped_widget,
        widget = wibox.container.margin,
        top = top,
        bottom = bottom,
        left = left,
        right = right,
    }
end


theme.titlebar_fun = function (c)
    gears.surface.apply_shape_bounding(c, gears.shape.partially_rounded_rect, true, true, false, false, 4)
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    local titlebar = wibox.container.background(
        wibox.widget.textbox(),
        theme.titlebar_bar_normal
    )
    titlebar.shape = gears.shape.rounded_bar


    local button_close = awful.widget.button()
    button_close.forced_width = 32

    awful.titlebar(c, {size = 17}) : setup {
        { -- Left
            wrap_in_margin(awful.titlebar.widget.iconwidget(c), 1, 2),
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            buttons = buttons,
            wrap_in_margin(titlebar, 0, 4, 4, 5),
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            widget = wibox.container.margin,
            right = 4,
            {
                wrap_in_margin(awful.titlebar.widget.maximizedbutton(c), 2, 2, 2, 3),
                wrap_in_margin(awful.titlebar.widget.minimizebutton (c), 2, 2, 2, 3),
                wrap_in_margin(awful.titlebar.widget.closebutton(c), 2, 0, 2, 3),
                layout = wibox.layout.fixed.horizontal()
            },
        },
        layout = wibox.layout.align.horizontal
    }

    c._titlebar = titlebar
end
client.connect_signal("focus", function(c)
    if c._titlebar == nil then return end
    c._titlebar.bg = theme.titlebar_bar_focus
end)
client.connect_signal("unfocus", function(c)
    if c._titlebar == nil then return end
    c._titlebar.bg = theme.titlebar_bar_normal
end)
client.connect_signal("property::geometry", function (c)
    if not c.fullscreen then
        gears.timer.delayed_call(function()
            gears.surface.apply_shape_bounding(c, gears.shape.partially_rounded_rect, true, true, false, false, 8)
        end)
    end
end)


function theme.at_screen_connect(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt{prompt = " Run: "}
    s.mypromptbox:set_shape(theme.promptbox_shape)
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    local tasklist_layout = wibox.layout.flex.horizontal()
    tasklist_layout.max_widget_size = 400
    s.mytasklist = awful.widget.tasklist(
        s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, {}, nil, tasklist_layout)

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = theme.wibar_height,
        bg = theme.bg_normal.."ff",
        fg = theme.fg_normal,
    })
    --s.mywibox:struts({ top = theme.wibar_height + 4 })

    s.systray = wibox.widget.systray()
    s.systray.opacity = 0.1

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widget
            layout = wibox.layout.fixed.horizontal,
            {
                s.mytaglist,
                widget = wibox.container.margin,
                bottom = theme.wibar_margin_bottom,
                left = 4,
            },
            {
                s.mypromptbox,
                widget = wibox.container.margin,
                top = 1,
                bottom = 1,
                left = 2,
                right = 2,
            },
        },
        { -- Middle widget
            s.mytasklist,
            widget = wibox.container.margin,
            top = 0,
        },
        { -- Right widget
            layout = wibox.layout.fixed.horizontal,
            {
                s.systray,
                widget = wibox.container.margin,
                top = 1,
                left = 4,
                right = 4,
                bottom = 1,
            },
            {
                widget = wibox.container.margin,
                top = theme.wibar_margin_bottom,
                bottom = theme.wibar_margin_bottom,
                {
                    layout = wibox.layout.fixed.horizontal,
                    powerline_bar {
                        direction = "left",
                        s.mylayoutbox,
                        {
                            widgets.keyboardlayout:new(),
                            widget = wibox.container.margin,
                            bottom = 2,
                        },
                        {
                            clock,
                            widget = wibox.container.margin,
                            bottom = 2,
                        },
                        with_icon(volumeicon, volume.widget),
                        with_icon(baticon, bat.widget),
                        with_icon(fsicon, theme.fs.widget),
                        with_icon(tempicon, temp.widget),
                        with_icon(cpuicon, cpu.widget),
                        with_icon(memicon, mem.widget),
                        with_icon(neticon, net.widget),
                    },
                },
            },
        },
    }
end

return theme
