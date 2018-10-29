local math     = { ceil  = math.ceil,
                   floor = math.floor,
                   max   = math.max }
local screen   = screen
local tonumber = tonumber

local centerfair = { name = "centerfair" }

function centerfair.arrange(p)
    local t = p.tag or screen[p.screen].selected_tag
    local wa = p.workarea
    local cls = p.clients

    if #cls == 0 then return end

    -- Layout with fixed number of vertical columns (read from nmaster).
    -- Cols are centerded until there is nmaster columns, then windows
    -- are stacked in the slave columns, with at most ncol clients per
    -- column if possible.

    -- with nmaster=3 and ncol=1 you'll have
    --        (1)                (2)                (3)
    --   +---+---+---+      +-+---+---+-+      +---+---+---+
    --   |   |   |   |      | |   |   | |      |   |   |   |
    --   |   | 1 |   |  ->  | | 1 | 2 | | ->   | 1 | 2 | 3 |  ->
    --   |   |   |   |      | |   |   | |      |   |   |   |
    --   +---+---+---+      +-+---+---+-+      +---+---+---+

    --        (4)                (5)
    --   +---+---+---+      +---+---+---+
    --   |   |   | 3 |      |   | 2 | 4 |
    --   + 1 + 2 +---+  ->  + 1 +---+---+
    --   |   |   | 4 |      |   | 3 | 5 |
    --   +---+---+---+      +---+---+---+

    -- How many vertical columns? Read from nmaster on the tag.
    local num_x = tonumber(centerfair.nmaster) or t.master_count
    local ncol  = tonumber(centerfair.ncol) or t.column_count

    if num_x <= 2 then num_x = 2 end
    if ncol  <= 1 then ncol  = 1 end

    local master_width = wa.width * t.master_width_factor
    local width = math.floor((wa.width - master_width) / (num_x - 1))

    if #cls < num_x then
        -- Less clients than the number of columns, let's center it!
        local offset_x = wa.x + (wa.width - (master_width + (#cls - 1)*width)) / 2
        for i = 1, #cls do
            local g = { y = wa.y }
            if i == 1 then
                g.width = master_width
                g.x = offset_x
            else
                g.width  = width
                g.x = offset_x + master_width + (i - 2) * width
            end
            g.height = wa.height
            if g.width < 1 then g.width = 1 end
            if g.height < 1 then g.height = 1 end
            p.geometries[cls[i]] = g
        end
    else
        -- More clients than the number of columns, let's arrange it!
        -- Master client deserves a special treatement
        local g = {}
        g.width = wa.width - (num_x - 1)*width
        g.height = wa.height
        if g.width < 1 then g.width = 1 end
        if g.height < 1 then g.height = 1 end
        g.x = wa.x
        g.y = wa.y
        p.geometries[cls[1]] = g

        -- Treat the other clients

        -- Compute distribution of clients among columns
        local num_y = {}
        local remaining_clients = #cls-1
        local ncol_min = math.ceil(remaining_clients/(num_x-1))

        if ncol >= ncol_min then
            for i = (num_x-1), 1, -1 do
                if (remaining_clients-i+1) < ncol then
                    num_y[i] = remaining_clients-i + 1
                else
                    num_y[i] = ncol
                end
                remaining_clients = remaining_clients - num_y[i]
            end
        else
            local rem = remaining_clients % (num_x-1)
            if rem == 0 then
                for i = 1, num_x-1 do
                    num_y[i] = ncol_min
                end
            else
                for i = 1, num_x-1 do
                    num_y[i] = ncol_min - 1
                end
                for i = 0, rem-1 do
                    num_y[num_x-1-i] = num_y[num_x-1-i] + 1
                end
            end
        end

        -- Compute geometry of the other clients
        local nclient = 2 -- we start with the 2nd client
        local wx = g.x + g.width
        for i = 1, (num_x-1) do
            local height = math.floor(wa.height / num_y[i])
            local wy = wa.y
            for j = 0, (num_y[i]-2) do
                local g = {}
                g.x = wx
                g.y = wy
                g.height = height
                g.width = width
                if g.width < 1 then g.width = 1 end
                if g.height < 1 then g.height = 1 end
                p.geometries[cls[nclient]] = g
                nclient = nclient + 1
                wy = wy + height
            end
            local g = {}
            g.x = wx
            g.y = wy
            g.height = wa.height - (num_y[i] - 1)*height
            g.width = width
            if g.width < 1 then g.width = 1 end
            if g.height < 1 then g.height = 1 end
            p.geometries[cls[nclient]] = g
            nclient = nclient + 1
            wx = wx + width
        end
    end
end

return centerfair
