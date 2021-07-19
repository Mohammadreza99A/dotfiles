-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- layoutbox.lua --> Layoutbox widget for awesome wm
--

local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local clickable_container = require('widgets.clickable-container')
require('awful.autofocus')

local layoutbox = {}

layoutbox.layoutbox = awful.widget.layoutbox(s)
layoutbox.layoutbox:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                awful.layout.inc(1)
            end
        ),
        awful.button(
            {},
            3,
            function()
                awful.layout.inc(-1)
            end
        ),
        awful.button(
            {},
            4,
            function()
                awful.layout.inc(1)
            end
        ),
        awful.button(
            {},
            5,
            function()
                awful.layout.inc(-1)
            end
        )
    )
)

return wibox.widget {
    layoutbox.layoutbox,
    widget = clickable_container
}
