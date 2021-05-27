-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- memory.lua --> Memory widget for awesome wm
--

local beautiful = require('beautiful')
local wibox = require('wibox')
local mem = require('lib.lain.widget.mem')

local memicon =
    wibox.widget {
    font = beautiful.widget_font,
    widget = wibox.widget.textbox
}
memicon.markup = beautiful.widget_icon_markup('﬙')
local mem =
    mem(
    {
        settings = function()
            widget:set_markup(beautiful.widget_text_markup(mem_now.used .. ' Mb'))
        end
    }
)

local memory_widget =
    wibox.widget {
    memicon,
    mem,
    layout = wibox.layout.fixed.horizontal
}

return memory_widget
