-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- cpu.lua --> CPU widget for awesome wm
--

local beautiful = require("beautiful")
local wibox = require("wibox")
local cpu = require("lib.lain.widget.cpu")

local cpuicon =
    wibox.widget {
    font = beautiful.widget_font,
    widget = wibox.widget.textbox
}
cpuicon.markup = beautiful.widget_icon_markup("")
local cpu =
    cpu(
    {
        settings = function()
            widget:set_markup(beautiful.widget_text_markup(cpu_now.usage .. "%"))
        end
    }
)

local cpu_widget =
    wibox.widget {
    cpuicon,
    cpu,
    layout = wibox.layout.fixed.horizontal
}

return cpu_widget
