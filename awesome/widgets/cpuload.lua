local wibox = require("wibox")

return function (options)
    options = options or { timeout = 1 }
    local w_text = wibox.widget.textbox()
    w_text:set_align("right")
    local jiffies = {}
    local activecpu = function ()
       local s = ""
       for line in io.lines("/proc/stat") do
           local cpu, newjiffies = string.match(line, "(cpu%d*) +(%d+)")
           if cpu and newjiffies then
               if not jiffies[cpu] then
                   jiffies[cpu] = newjiffies
               end
               --The string.format prevents your task list from jumping around
               --when CPU usage goes above/below 10%
               s = s .. "" .. cpu .. ": " ..  string.format("%03d", (newjiffies-jiffies[cpu]) / options.timeout) .. "%"
               jiffies[cpu] = newjiffies
               break -- only one now
           end
       end
       return s
    end

    local cputimer = timer({ timeout = options.timeout })
    cputimer:connect_signal("timeout", function() w_text:set_text(activecpu()) end)
    cputimer:start()

    return w_text
end
