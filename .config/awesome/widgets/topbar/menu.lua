-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- menu.lua --> Menu widget for awesome wm
--

local wibox = require('wibox')
local beautiful = require('beautiful')
local awful = require('awful')

return wibox.container.background(
    wibox.container.margin(
        awful.widget.launcher(
            {
                image = beautiful.arch_icon,
                menu = require('config.menu')
            }
        ),
        10,
        10
    ),
    beautiful.bg_normal
)
