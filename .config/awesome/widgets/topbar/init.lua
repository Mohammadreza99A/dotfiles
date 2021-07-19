-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- init.lua --> entry file of topbar in awesome wm
--
local awful = require('awful')
require('awful.autofocus')
local wibox = require('wibox')
local beautiful = require('beautiful')

local widget_container = beautiful.widget_container

awful.screen.connect_for_each_screen(function(s)
    s.mypromptbox = awful.widget.prompt()

    s.mywibox = awful.wibar({
        position = 'top',
        screen = s
    })

    s.systray = wibox.container.margin(require('widgets.topbar.systray'), 5, 5)

    s.mywibox:setup{
        layout = wibox.layout.stack,
        {
            {
                -- Left widgets
                wibox.container.margin(require('widgets.topbar.menu'), 0, 0, 3, 3),
                require('widgets.topbar.taglist')(s),
                require('widgets.topbar.tasklist')(s),
                require("widgets.topbar.spotify")({
                    font = beautiful.widget_font
                }),
                s.mypromptbox,
                layout = wibox.layout.fixed.horizontal
            },
            nil,
            {
                -- Right widgets
                widget_container(require('widgets.topbar.net')),
                widget_container(require('widgets.topbar.fs')),
                widget_container(require('widgets.topbar.memory'), 5, 40),
                widget_container(require('widgets.topbar.cpu')),
                widget_container(require('widgets.topbar.battery')),
                widget_container(wibox.container.margin(require('widgets.topbar.clock')()), 5, 35),
                widget_container(wibox.container.margin(require('widgets.topbar.layoutbox'), 0, 0, 3, 3), 15, 10),
                s.systray,
                require('widgets.popup.exit_screen').widget,
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
        }
    }
end)
