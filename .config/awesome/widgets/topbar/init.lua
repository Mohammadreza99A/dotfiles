-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- init.lua --> entry file of topbar in awesome wm
--

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")

local widget_container = beautiful.widget_container

-- {{{ Topbar
awful.screen.connect_for_each_screen(
    function(s)
        s.mypromptbox = awful.widget.prompt()

        s.mywibox = awful.wibar({position = "top", screen = s})

        s.systray =
            wibox.container.background(
            wibox.container.margin(wibox.widget.systray(), 15, 10, 1, 1),
            beautiful.bg_normal,
            gears.shape.rounded_bar
        )

        s.logout_popup =
            require("widgets.popup.logout").widget {
            phrases = {"Exit!", "Goodbye!", "See you soon!"},
            icon_margin = 16,
            icon_size = 40,
            bg_color = beautiful.bg_light
        }

        s.mywibox:setup {
            layout = wibox.layout.stack,
            {
                {
                    -- Left widgets
                    wibox.container.background(
                        wibox.container.margin(
                            awful.widget.launcher(
                                {
                                    image = beautiful.awesome_icon,
                                    menu = require("config.menu")
                                }
                            ),
                            10,
                            20
                        ),
                        beautiful.bg_normal,
                        gears.shape.rounded_bar
                    ),
                    wibox.container.background(
                        wibox.container.margin(require("widgets.topbar.taglist")(s), -20, 30),
                        beautiful.bg_normal,
                        gears.shape.rounded_bar
                    ),
                    wibox.container.margin(require("widgets.topbar.tasklist")(s), -30, 30),
                    s.mypromptbox,
                    layout = wibox.layout.fixed.horizontal
                },
                nil,
                {
                    -- Right widgets
                    widget_container(require("widgets.topbar.net")),
                    widget_container(require("widgets.topbar.fs")),
                    widget_container(require("widgets.topbar.memory"), 5, 40),
                    widget_container(require("widgets.topbar.cpu")),
                    widget_container(require("widgets.topbar.battery")),
                    widget_container(require("widgets.topbar.clock"), 10, 10),
                    s.systray,
                    require("widgets.topbar.layoutbox"),
                    s.logout_popup,
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.align.horizontal
            }
        }
    end
)
-- }}}
