-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- screenshot.lua --> Screenshot popup bar for awesome wm
--

local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local filesystem = require('gears').filesystem
local naughty = require('naughty')
local create_button = require('widgets.create-button')
local clickable_container = require('widgets.clickable-container')
local helpers = require('lib.helpers')
local dpi = beautiful.xresources.apply_dpi

local delay_sec = 0
local snap_area = 'area'

local snap_area_button = create_button.button_with_label('Selection', beautiful.icon_crop)
local snap_full_button = create_button.button_with_label('Screen', beautiful.icon_screen)
local snap_window = create_button.button_with_label('Window', beautiful.icon_window)
snap_area_button.bg = beautiful.bg_dark
snap_full_button.bg = beautiful.bg_focus
snap_window.bg = beautiful.bg_focus

snap_area_button:connect_signal(
    'button::press',
    function(self, _, _, button)
        if button == 1 then
            snap_area = 'area'
            self.bg = beautiful.bg_dark
            snap_full_button.bg = beautiful.bg_focus
            snap_window.bg = beautiful.bg_focus
        end
    end
)

snap_full_button:connect_signal(
    'button::press',
    function(self, _, _, button)
        if button == 1 then
            snap_area = 'screen'
            self.bg = beautiful.bg_dark
            snap_area_button.bg = beautiful.bg_focus
            snap_window.bg = beautiful.bg_focus
        end
    end
)

snap_window:connect_signal(
    'button::press',
    function(self, _, _, button)
        if button == 1 then
            snap_area = 'window'
            self.bg = beautiful.bg_dark
            snap_area_button.bg = beautiful.bg_focus
            snap_full_button.bg = beautiful.bg_focus
        end
    end
)

local button_capture =
    wibox.widget {
    widget = clickable_container,
    {
        widget = wibox.container.background,
        bg = beautiful.bg_focus,
        border_width = 2,
        border_color = beautiful.bg_dark,
        shape = gears.shape.rounded_bar,
        {
            widget = wibox.container.margin,
            left = dpi(10),
            right = dpi(10),
            top = dpi(6),
            bottom = dpi(6),
            {widget = wibox.widget.textbox, text = 'Take Screenshot'}
        }
    }
}

local btn_delay_num = function()
    local btn_plus =
        wibox.widget {
        {
            image = beautiful.icon_add,
            resize = true,
            forced_height = dpi(12),
            forced_width = dpi(12),
            widget = wibox.widget.imagebox
        },
        widget = clickable_container
    }

    local btn_minus =
        wibox.widget {
        {
            image = beautiful.icon_minus,
            resize = true,
            forced_height = dpi(12),
            forced_width = dpi(12),
            widget = wibox.widget.imagebox
        },
        widget = clickable_container
    }

    local value_text =
        wibox.widget {
        text = delay_sec,
        widget = wibox.widget.textbox
    }
    local btn_delay =
        wibox.widget {
        widget = clickable_container,
        {
            widget = wibox.container.background,
            bg = beautiful.bg_focus,
            border_width = 2,
            border_color = beautiful.bg_dark,
            shape = gears.shape.rounded_bar,
            {
                widget = wibox.container.margin,
                left = dpi(8),
                right = dpi(8),
                top = dpi(5),
                bottom = dpi(5),
                {
                    btn_minus,
                    value_text,
                    btn_plus,
                    spacing = dpi(15),
                    layout = wibox.layout.fixed.horizontal
                }
            }
        }
    }

    btn_plus:connect_signal(
        'button::press',
        function(_, _, _, button)
            if button == 1 then
                delay_sec = delay_sec + 1
                value_text:set_text(delay_sec)
            end
        end
    )

    btn_minus:connect_signal(
        'button::press',
        function(_, _, _, button)
            if button == 1 then
                if delay_sec < 1 then
                    return
                end
                delay_sec = delay_sec - 1
                value_text:set_text(delay_sec)
            end
        end
    )

    return btn_delay
end

local btn_close =
    wibox.widget {
    {
        widget = wibox.container.background,
        bg = beautiful.bg_focus,
        border_width = 2,
        border_color = beautiful.bg_dark,
        shape = gears.shape.circle,
        {
            widget = wibox.container.margin,
            margins = dpi(3),
            {
                image = beautiful.icon_times,
                resize = true,
                forced_height = dpi(18),
                forced_width = dpi(18),
                widget = wibox.widget.imagebox
            }
        }
    },
    widget = clickable_container
}

local row_top =
    wibox.widget {
    nil,
    button_capture,
    btn_close,
    layout = wibox.layout.align.horizontal
}

local row_middle =
    wibox.widget {
    snap_area_button,
    snap_full_button,
    snap_window,
    spacing = dpi(10),
    widget = wibox.layout.fixed.horizontal
}

local row_bottom =
    wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.bg_focus,
    shape = beautiful.widget_shape,
    {
        {
            {text = 'Delay in Seconds', widget = wibox.widget.textbox},
            nil,
            {
                btn_delay_num(),
                spacing = dpi(5),
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
        },
        margins = dpi(10),
        widget = wibox.container.margin
    }
}

local container =
    wibox.widget {
    {
        row_top,
        row_middle,
        row_bottom,
        spacing = dpi(10),
        layout = wibox.layout.fixed.vertical
    },
    margins = dpi(16),
    widget = wibox.container.margin
}

local maim_popup =
    awful.popup {
    widget = {
        widget = wibox.container.background,
        shape = beautiful.widget_shape,
        bg = beautiful.bg_normal,
        border_color = beautiful.red,
        container
    },
    border_color = beautiful.fg_focus,
    border_width = 2,
    ontop = true,
    visible = false,
    bg = beautiful.bg_normal,
    shape = gears.shape.rounded_rect,
    placement = awful.placement.centered
}

for s in screen do
    s.maim_popup = maim_popup
end

local hide_maim_popup = function()
    for s in screen do
        s.maim_popup.visible = not s.maim_popup.visible
    end
end

local show_maim_popup = function()
    for s in screen do
        s.maim_popup.visible = true
    end
end

local display_popup = function()
    for s in screen do
        if s.maim_popup.visible then
            hide_maim_popup()
        else
            show_maim_popup()
        end
    end
end

local take_screen_shot = function()
    helpers.sleep(.2)

    local screen_shot_dir = '~/Pictures/Screenshots/'

    if not filesystem.dir_readable(screen_shot_dir) then
        awful.spawn.with_shell('mkdir -p ' .. screen_shot_dir)
    end

    local file_name = os.date('%d-%m-%Y-%H:%M:%S') .. '.png'
    local command = ''
    if snap_area == 'area' then
        command = 'maim -s -d ' .. delay_sec .. ' ' .. screen_shot_dir .. file_name
    elseif snap_area == 'screen' then
        command = 'maim -d ' .. delay_sec .. ' ' .. screen_shot_dir .. file_name
    elseif snap_area == 'window' then
        command = 'maim -d ' .. delay_sec .. ' ' .. '-i $(xdotool getactivewindow) ' .. screen_shot_dir .. file_name
    end

    hide_maim_popup()
    helpers.sleep(delay_sec + 0.2)

    awful.spawn.easy_async_with_shell(
        command,
        function(_, _)
            naughty.notify {
                app_name = 'Screenshot Tool',
                icon = beautiful.icon_screenhost_taken,
                timeout = 10,
                title = 'Screenshot taken',
                text = 'Screenshot saved to ' .. screen_shot_dir .. file_name
            }

            show_maim_popup()
        end
    )
end

button_capture:connect_signal(
    'button::press',
    function(_, _, _, button)
        if button == 1 then
            take_screen_shot()
        end
    end
)

btn_close:connect_signal(
    'button::press',
    function(_, _, _, button)
        if button == 1 then
            hide_maim_popup()
        end
    end
)

local screen_shot_button = create_button.circle_big(beautiful.icon_camera)
local label = screen_shot_button:get_children_by_id('label')[1]
label:set_text('Take Shot')
screen_shot_button:connect_signal(
    'button::press',
    function(self, _, _, button)
        if button == 1 then
            display_popup()
        end
    end
)

awesome.connect_signal(
    'screenshot::show',
    function()
        display_popup()
    end
)

return screen_shot_button
