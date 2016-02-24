---------------------------
-- Default awesome theme --
---------------------------

-- Solarized Colors:
local S = {}
-- Common
S.yellow     = "#b58900"
S.orange     = "#cb4b16"
S.red        = "#dc322f"
S.magenta    = "#d33682"
S.violet     = "#6c71c4"
S.blue       = "#268bd2"
S.cyan       = "#2aa198"
S.green      = "#859900"

-- Dark
S.base03     = "#002b36"
S.base02     = "#073642"
S.base01     = "#586e75"
S.base00     = "#657b83"
S.base0      = "#839496"
S.base1      = "#93a1a1"
S.base2      = "#eee8d5"
S.base3      = "#fdf6e3"


theme = {}

theme.font          = "Terminus (TTF) 12"

theme.bg_normal     = S.base03
theme.bg_focus      = S.base02
theme.bg_urgent     = S.green
theme.bg_minimize   = S.base03

theme.fg_normal     = S.base0
theme.fg_focus      = S.green
theme.fg_urgent     = S.base03
theme.fg_minimize   = S.base01

theme.border_width  = "1"
theme.border_normal = theme.bg_normal
theme.border_focus  = S.green
theme.border_marked = S.cyan

theme.tasklist_disable_icon = true

theme_path = os.getenv("HOME") .. "/.config/awesome/theme"
theme.msgs_icon = theme_path .. "/icons/new-messages.png"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme_path .. "/taglist/squaref.png"
theme.taglist_squares_unsel = theme_path .. "/taglist/square.png"

theme.tasklist_floating_icon = theme_path .. "/tasklist/floating.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path .. "/submenu.png"
theme.menu_height = "18"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme_path .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_path .. "/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_path .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_path .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_path .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_path .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_path .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_path .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_path .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_path .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_path .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_path .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_path .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_path .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_path .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_path .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_path .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme_path .. "/titlebar/maximized_focus_active.png"

theme.wallpaper = theme_path .. "/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = theme_path .. "/layouts/fairh.png"
theme.layout_fairv = theme_path .. "/layouts/fairv.png"
theme.layout_floating  = theme_path .. "/layouts/floating.png"
theme.layout_magnifier = theme_path .. "/layouts/magnifier.png"
theme.layout_max = theme_path .. "/layouts/max.png"
theme.layout_fullscreen = theme_path .. "/layouts/fullscreen.png"
theme.layout_tilebottom = theme_path .. "/layouts/tilebottom.png"
theme.layout_tileleft   = theme_path .. "/layouts/tileleft.png"
theme.layout_tile = theme_path .. "/layouts/tile.png"
theme.layout_tiletop = theme_path .. "/layouts/tiletop.png"
theme.layout_spiral  = theme_path .. "/layouts/spiral.png"
theme.layout_dwindle = theme_path .. "/layouts/dwindle.png"

theme.awesome_icon = theme_path .. "/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
