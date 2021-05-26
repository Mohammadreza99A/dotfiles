-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- clock.lua --> Clock widget in awesome wm
--

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local calendar_widget = require("widgets.topbar.calendar")

-- Textclock
local clockicon =
    wibox.widget {
    font = beautiful.widget_font,
    widget = wibox.widget.textbox
}
clockicon.markup = beautiful.widget_icon_markup("")
local clock =
    awful.widget.watch(
    "date +'%a %d %b %R'",
    15,
    function(widget, stdout)
        widget:set_markup(beautiful.widget_text_markup(stdout))
    end
)

local cw =
    calendar_widget(
    {
        theme = "nord",
        radius = 8,
        placement = "top_right"
    }
)

clock:connect_signal(
    "button::press",
    function(_, _, _, button)
        if button == 1 then
            cw.toggle()
        end
    end
)

local clock_widget =
    wibox.widget {
    clockicon,
    clock,
    layout = wibox.layout.fixed.horizontal
}

return clock_widget
