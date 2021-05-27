-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- net.lua --> Net widget for awesome wm
--

local beautiful = require('beautiful')
local wibox = require('wibox')
local net = require('lib.lain.widget.net')

local neticon =
    wibox.widget {
    font = beautiful.widget_font,
    widget = wibox.widget.textbox
}
neticon.markup = beautiful.widget_icon_markup('直')
local net =
    net(
    {
        settings = function()
            widget:set_markup(beautiful.widget_text_markup(net_now.received .. '  ' .. net_now.sent))
        end
    }
)

local net_widget =
    wibox.widget {
    neticon,
    net,
    layout = wibox.layout.fixed.horizontal
}

return net_widget
