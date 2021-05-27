-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- systray.lua --> Systray widget for awesome wm
--
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local awful = require("awful")

local systray = wibox.widget {
    {widget = wibox.widget.systray},
    left = dpi(6),
    right = dpi(6),
    widget = wibox.container.margin
}

local widget_systray = wibox.widget {
    {
        {
            {systray, layout = wibox.layout.fixed.horizontal},
            left = dpi(2),
            right = dpi(2),
            top = dpi(1),
            bottom = dpi(1),
            widget = wibox.container.margin
        },
        border_width = 2,
        widget = wibox.container.background
    },
    margins = dpi(2),
    widget = wibox.container.margin
}

return widget_systray
