-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- clock.lua --> Clock widget for awesome wm
-- which is clickable and launches a popup with calendar and weather widgets inside
--

local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local clickable_container = require('widgets.clickable-container')

local create_clock = function()
    local clock_format = nil
    clock_format = beautiful.widget_text_markup('%I:%M %p')

    local clock_widget = wibox.widget.textclock(clock_format, 30)

    clock_widget =
        wibox.widget {
        {
            {clock_widget, widget = clickable_container},
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(6),
            right = dpi(6),
            widget = wibox.container.margin
        },
        margins = dpi(2),
        widget = wibox.container.margin
    }

    local s = awful.screen.focused()
    local popup_height = s.geometry.height - (beautiful.wibar_height + dpi(10))
    local time_format = beautiful.markup_text('%I:%M', beautiful.font_3xlarge_bold)
    local date_formate = beautiful.widget_text_markup(' %A, %B, %d ', '#D8DEE9')
    local time = wibox.container.place(wibox.widget.textclock(time_format, 30))
    local date = wibox.container.place(wibox.widget.textclock(date_formate, 30))

    local date_time =
        wibox.widget {
        {time, date, layout = wibox.layout.fixed.vertical},
        margins = dpi(20),
        widget = wibox.container.margin
    }
    local calendar =
        awful.popup {
        ontop = true,
        visible = false,
        bg = '#00000000',
        border_width = dpi(2),
        border_color = beautiful.fg_focus,
        shape = beautiful.widget_shape,
        placement = function(w)
            awful.placement.bottom_right(
                w,
                {
                    margins = {
                        left = 0,
                        top = beautiful.wibar_height + dpi(5),
                        bottom = 5,
                        right = dpi(5)
                    }
                }
            )
        end,
        widget = {
            {
                {
                    date_time,
                    {
                        wibox.container.margin(require('widgets.topbar.calendar'), 8, 16, 16, 16),
                        bg = beautiful.bg_focus,
                        shape = beautiful.widget_shape,
                        widget = wibox.container.background
                    },
                    {top = dpi(20), widget = wibox.container.margin},
                    {
                        {
                            require('widgets.topbar.weather'),
                            margins = dpi(16),
                            widget = wibox.container.margin
                        },
                        bg = beautiful.bg_focus,
                        shape = beautiful.widget_shape,
                        widget = wibox.container.background
                    },
                    {top = dpi(20), widget = wibox.container.margin},
                    {
                        require('widgets.popup.screenshot'),
                        margins = dpi(16),
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.vertical
                },
                top = dpi(30),
                bottom = dpi(30),
                left = dpi(25),
                right = dpi(25),
                widget = wibox.container.margin
            },
            bg = beautiful.bg_normal,
            forced_height = popup_height,
            widget = wibox.container.background
        }
    }

    clock_widget:connect_signal(
        'button::press',
        function(self, _, _, button)
            if button == 1 then
                if calendar.visible then
                    calendar.visible = not calendar.visible
                else
                    calendar.visible = true
                end
            end
        end
    )

    awesome.connect_signal(
        'calendar::show',
        function()
            calendar.visible = true
        end
    )

    awesome.connect_signal(
        'calendar::hide',
        function()
            calendar.visible = false
        end
    )

    return clock_widget
end

return create_clock
