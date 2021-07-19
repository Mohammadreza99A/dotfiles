-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- theme.lua --> Theme configs for nord theme in awesome wm
--

local wibox = require('wibox')
local gears = require('gears')
local dpi = require('beautiful.xresources').apply_dpi
local markup = require('lib.lain.util.markup')

local theme = {}

theme.icons_dir = os.getenv('HOME') .. '/.config/awesome/themes'
theme.wallpaper = os.getenv('HOME') .. '/.config/awesome/themes/nord/wally.png'

-- {{{ Fonts
theme.font = 'UbuntuMono Nerd Font 12.5'
theme.font_bold = 'UbuntuMono Nerd Font Bold 12.5'
theme.font_name = 'UbuntuMono Nerd Font'
theme.widget_font = 'UbuntuMono Nerd Font 12.5'
theme.font_small_bold = 'UbuntuMono Nerd Font Bold 11'
theme.font_small = 'UbuntuMono Nerd Font 11'
theme.font_xsmall = 'UbuntuMono Nerd Font 10'
theme.font_xsmall = 'UbuntuMono Nerd Font Light 10'
theme.font_large = 'UbuntuMono Nerd Font 17'
theme.font_xlarge = 'UbuntuMono Nerd Font 20'
theme.font_large_bold = 'UbuntuMono Nerd Font Bold 17'
theme.font_xlarge_bold = 'UbuntuMono Nerd Font Bold 20'
theme.font_3xlarge_bold = 'UbuntuMono Nerd Font Bold 48'
-- }}}

-- {{{ Colors
theme.fg_normal = '#d8dee9'
theme.fg_focus = '#88C0D0'
theme.fg_urgent = '#D08770'
theme.fg_dark = '#ECEFF4'
theme.bg_dark = '#474f63'
theme.bg_normal = '#2E3440'
theme.bg_focus = '#3B4252'
theme.bg_urgent = '#3B4252'
theme.bg_light = '#232530'
theme.bg_very_light = '#2e303e'

theme.font_color_light = '#FEFEFE'
theme.font_color_dark = '#1A1C23'

theme.blue = '#81A1C1'
theme.blue_light = '#5E81AC'
theme.cyan = '#8FBCBB'
theme.cyan_light = '#6BE6E6'
theme.green = '#a3be8c'
theme.green_light = '#3FDAA4'
theme.purple = '#EE64AE'
theme.purple_light = '#F075B7'
theme.red = '#bf616a'
theme.red_light = '#d08770'
theme.yellow = '#ebcb8b'
theme.yellow_light = '#FBC3A7'
theme.purple = '#b48ead'
-- }}}

-- {{{ Borders
theme.useless_gap = dpi(3)
theme.border_width = dpi(2)
theme.border_normal = '#3B4252'
theme.border_focus = theme.blue_light
theme.border_marked = '#D08770'
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus = '#3B4252'
theme.titlebar_bg_normal = '#2E3440'
theme.titlebar_fg_focus = theme.fg_focus
-- }}}

-- {{{ Widgets
theme.widget_shape = gears.shape.rounded_rect
theme.bg_widget = theme.green
theme.fg_widget = theme.blue
theme.wibar_height = dpi(28)
theme.widget_margin = dpi(6)
theme.widget_text_color = '#111111'
theme.widget_space = markup.fontfg(theme.font, theme.widget_text_color, ' ')
theme.widget_text_markup = function(text, color)
    return markup.fontfg(theme.widget_font, color or theme.widget_text_color, markup.bold(text))
end
theme.widget_icon_markup = function(icon)
    return theme.widget_space .. markup.fontfg(theme.widget_font, theme.widget_text_color, icon) .. theme.widget_space
end
-- }}}

--- {{{ Markup
theme.markup_text = function(text, font)
    return "<span font='" .. font .. "'>" .. text .. '</span> '
end
--- }}}

-- {{{ Taglists
-- theme.taglist_spacing = 7
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_fg_urgent = theme.red_light
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_occupied = theme.green
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_empty = theme.blue
theme.taglist_bg_urgent = theme.bg_normal
theme.taglist_fg_focus = '#EBCB8B'
theme.taglist_font = 'SauceCodePro Nerd Font 13'
-- }}}

-- {{{ Tasklists
theme.tasklist_bg_normal = theme.titlebar_bg_focus
theme.tasklist_bg_focus = theme.bg_light
theme.tasklist_disable_icon = false
theme.tasklist_disable_task_name = true
theme.tasklist_plain_task_name = true
-- }}}

-- {{{ Notifications
theme.notification_border_color = theme.blue
---}}}

-- {{{ Menu
theme.menu_height = dpi(25)
theme.menu_width = dpi(200)
-- }}}

-- {{{ Systray
theme.systray_icon_spacing = dpi(5)
theme.bg_systray = theme.bg_dark
-- }}}

-- {{{ Widgets container
local color1 = theme.fg_widget
local color2 = theme.bg_widget
local current_color = theme.bg_widget

function theme.widget_container(widget, marL, marR)
    if current_color == color1 then
        current_color = color2
    else
        current_color = color1
    end
    return wibox.container.margin(
        wibox.container.background(
            wibox.container.margin(widget, marL or 5, marR or 40),
            current_color,
            gears.shape.rounded_bar
        ),
        -30,
        0
    )
end

function theme.make_pill(w, c)
    return wibox.widget {
        wibox.container.margin(w, 10, 10),
        bg = c or theme.bg_dark,
        shape = gears.shape.rounded_bar,
        widget = wibox.container.background
    }
end
-- }}}

-- {{{ Icons
theme.awesome_icon = theme.icons_dir .. '/icons/awesome.png'
theme.arch_icon = theme.icons_dir .. '/icons/arch.png'
theme.layout_tile = theme.icons_dir .. '/icons/tile.svg'
theme.layout_tileleft = theme.icons_dir .. '/icons/tileleft.png'
theme.layout_tilebottom = theme.icons_dir .. '/icons/tilebottom.png'
theme.layout_tiletop = theme.icons_dir .. '/icons/tiletop.png'
theme.layout_floating = theme.icons_dir .. '/icons/floating.svg'
theme.titlebar_close_button_focus = theme.icons_dir .. '/icons/titlebar/close_focus.png'
theme.titlebar_close_button_normal = theme.icons_dir .. '/icons/titlebar/close_normal.png'
theme.titlebar_ontop_button_focus_active = theme.icons_dir .. '/icons/titlebar/ontop_focus_active.png'
theme.titlebar_ontop_button_normal_active = theme.icons_dir .. '/icons/titlebar/ontop_normal_active.png'
theme.titlebar_ontop_button_focus_inactive = theme.icons_dir .. '/icons/titlebar/ontop_focus_inactive.png'
theme.titlebar_ontop_button_normal_inactive = theme.icons_dir .. '/icons/titlebar/ontop_normal_inactive.png'
theme.titlebar_sticky_button_focus_active = theme.icons_dir .. '/icons/titlebar/sticky_focus_active.png'
theme.titlebar_sticky_button_normal_active = theme.icons_dir .. '/icons/titlebar/sticky_normal_active.png'
theme.titlebar_sticky_button_focus_inactive = theme.icons_dir .. '/icons/titlebar/sticky_focus_inactive.png'
theme.titlebar_sticky_button_normal_inactive = theme.icons_dir .. '/icons/titlebar/sticky_normal_inactive.png'
theme.titlebar_floating_button_focus_active = theme.icons_dir .. '/icons/titlebar/floating_focus_active.png'
theme.titlebar_floating_button_normal_active = theme.icons_dir .. '/icons/titlebar/floating_normal_active.png'
theme.titlebar_floating_button_focus_inactive = theme.icons_dir .. '/icons/titlebar/floating_focus_inactive.png'
theme.titlebar_floating_button_normal_inactive = theme.icons_dir .. '/icons/titlebar/floating_normal_inactive.png'
theme.titlebar_maximized_button_focus_active = theme.icons_dir .. '/icons/titlebar/maximized_focus_active.png'
theme.titlebar_maximized_button_normal_active = theme.icons_dir .. '/icons/titlebar/maximized_normal_active.png'
theme.titlebar_maximized_button_focus_inactive = theme.icons_dir .. '/icons/titlebar/maximized_focus_inactive.png'
theme.titlebar_maximized_button_normal_inactive = theme.icons_dir .. '/icons/titlebar/maximized_normal_inactive.png'
theme.icon_crop = theme.icons_dir .. '/icons/image-crop.svg'
theme.icon_screen = theme.icons_dir .. '/icons/computer.svg'
theme.icon_window = theme.icons_dir .. '/icons/window.svg'
theme.icon_add = theme.icons_dir .. '/icons/add.svg'
theme.icon_minus = theme.icons_dir .. '/icons/minus.svg'
theme.icon_times = theme.icons_dir .. '/icons/remove.svg'
theme.icon_screenhost_taken = theme.icons_dir .. '/icons/camera-photo-icon.svg'
theme.icon_camera = theme.icons_dir .. '/icons/camera-photo.svg'
-- }}}

return theme
