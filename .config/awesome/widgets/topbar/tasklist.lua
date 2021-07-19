-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- tasklist.lua --> Tasklist widget for awesome wm
--

local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
local wibox = require('wibox')
local beautiful = require('beautiful')

local get_tasklist = function(s)
    -- Tasklist buttons
    local tasklist_buttons =
        gears.table.join(
        awful.button(
            {},
            1,
            function(c)
                if c == client.focus then
                    c.minimized = true
                else
                    c:emit_signal('request::activate', 'tasklist', {raise = true})
                end
            end
        ),
        awful.button(
            {},
            3,
            function()
                awful.menu.client_list({theme = {width = 250}})
            end
        ),
        awful.button(
            {},
            4,
            function()
                awful.client.focus.byidx(1)
            end
        ),
        awful.button(
            {},
            5,
            function()
                awful.client.focus.byidx(-1)
            end
        )
    )

    local tasklist =
        awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 0,
            shape_border_color = beautiful.fg_light,
            shape = gears.shape.rounded_bar
        },
        layout = {
            spacing = 0,
            spacing_widget = {
                {
                    forced_width = 5,
                    shape = gears.shape.circle,
                    widget = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place
            },
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {id = 'icon_role', widget = wibox.widget.imagebox},
                        margins = 4,
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                left = 7,
                right = 7,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        }
    }

    local tasklist_widget =
        wibox.widget {
        {
            tasklist,
            bg = beautiful.tasklist_bg_normal,
            shape = gears.shape.rounded_bar,
            widget = wibox.container.background
        },
        right = 5,
        left = 5,
        widget = wibox.container.margin
    }

    return tasklist_widget
end

return get_tasklist
