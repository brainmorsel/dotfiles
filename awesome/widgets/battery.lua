local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

return function (options)
    options = options or {}
    local adapter = options.adapter or "BAT0"
    local timeout = options.timeout or 30
    local limits = options.limits or {
        {25, 5},
        {12, 3},
        { 7, 1},
            {0}}

    local get_bat_state = function ()
        local fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")
        local fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
        local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
        local cur = fcur:read()
        local cap = fcap:read()
        local sta = fsta:read()
        fcur:close()
        fcap:close()
        fsta:close()
        local battery = math.floor(cur * 100 / cap)
        if sta:match("Charging") then
            dir = 1
        elseif sta:match("Discharging") then
            dir = -1
        else
            dir = 0
            battery = ""
        end
        return battery, dir
    end

    local getnextlim = function (num)
        for ind, pair in pairs(limits) do
            lim = pair[1]; step = pair[2]; nextlim = limits[ind+1][1] or 0
            if num > nextlim then
                repeat
                    lim = lim - step
                until num > lim
                if lim < nextlim then
                    lim = nextlim
                end
                return lim
            end
        end
    end

    local batclosure = function ()
        local nextlim = limits[1][1]
        return function ()
            local prefix = "⚡"
            local battery, dir = get_bat_state()
            if dir == -1 then
                dirsign = "↓"
                prefix = "B"
                if battery <= nextlim then
                    naughty.notify({title = "⚡ Beware! ⚡",
                                text = "Battery charge is low ( ⚡ "..battery.."%)!",
                                timeout = 7,
                                position = "bottom_right",
                                fg = beautiful.fg_focus,
                                bg = beautiful.bg_focus
                                })
                    nextlim = getnextlim(battery)
                end
            elseif dir == 1 then
                dirsign = "↑"
                nextlim = limits[1][1]
            else
                dirsign = ""
            end
            if dir ~= 0 then battery = battery.."%" end
            return " "..prefix.." "..dirsign..battery..""
        end
    end

    local w_text = wibox.widget.textbox()
    local bat_clo = batclosure(adapter)
    w_text:set_text(bat_clo())
    local battimer = timer({ timeout = timeout })
    battimer:connect_signal("timeout", function() w_text:set_text(bat_clo()) end)
    battimer:start()

    return w_text
end
