-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- fs.lua --> Filesystem widget for awesome wm
--

local beautiful = require("beautiful")
local wibox = require("wibox")
local fs = require("lib.lain.widget.fs")

local fsicon =
    wibox.widget {
    font = beautiful.widget_font,
    widget = wibox.widget.textbox
}
fsicon.markup = beautiful.widget_icon_markup("")
local fsroothome =
    fs(
    {
        timeout = 120,
        showpopup = "off",
        settings = function()
            widget:set_markup(
                beautiful.widget_text_markup(string.format("%.1f %s", fs_now["/home"].free, fs_now["/home"].units))
            )
        end
    }
)

local fs_widget =
    wibox.widget {
    fsicon,
    fsroothome,
    layout = wibox.layout.fixed.horizontal
}

return fs_widget
