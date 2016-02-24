local wibox = require("wibox")
local beautiful = require("beautiful")

-- Keyboard layout widget
return function ()
    local lts = {[0] = "EN", [1] = "RU"}
    local w_text = wibox.widget.textbox()
    local w_bg = wibox.widget.background()
    local w_margin = wibox.layout.margin()

    w_text:set_font("Terminus (TTF) Bold 12")
    w_text:set_align("center")
    w_text:set_text(lts[0])

    w_margin:set_margins(1)
    w_margin:set_widget(w_text)

    w_bg:set_bg("#00000000")
    w_bg:set_fg(beautiful.fg_normal)
    w_bg:set_widget(w_margin)

    dbus.request_name("session", "ru.gentoo.kbdd")
    dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
    dbus.connect_signal("ru.gentoo.kbdd", function(...)
        local data = {...}
        local layout = data[2]
        w_text:set_text(lts[layout])
    end)

    return w_bg
end
