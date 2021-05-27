-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- signals.lua --> Handles signals in awesome wm
--
local awful = require("awful")
local beautiful = require("beautiful")

awful.screen.connect_for_each_screen(function(s)
    -- awful.tag({"➊", "➋", "➌", "➍", "➎"}, s, awful.layout.layouts[1])
    awful.tag({"1", "2", "3", "4", "5"}, s, awful.layout.layouts[1])
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- Make terminal in floating mode if it is spawned in tag 1
    if c.instance == "kitty" then
        if c.first_tag.index == 1 then
            c.floating = true
            awful.placement.centered(c)
        else
            c.floating = false
        end
    end

    -- ! TODO: Remove this as soon as we don't need it anymore
    if c.instance == "be.ac.ulb.infof307.g07.App" then
        c.floating = true
        awful.placement.centered(c)
    end
    -- !

    -- Make floating client to spawn in the center of the screen
    if c.floating then awful.placement.centered(c) end
end)

tag.connect_signal("request::screen", function(t)
    for s in screen do
        if s ~= t.screen and s.geometry.x == t.screen.geometry.x and
            s.geometry.y == t.screen.geometry.y and s.geometry.width ==
            t.screen.geometry.width and s.geometry.height ==
            t.screen.geometry.height then
            local t2 = awful.tag.find_by_name(s, t.name)
            if t2 then
                t:swap(t2)
            else
                t.screen = s
            end
            return
        end
    end
end)

-- set titlebar if it is activated
local get_titlebar = require("decorations.titlebar")
client.connect_signal("request::titlebars", get_titlebar)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus",
                      function(c) c.border_color = beautiful.border_focus end)

client.connect_signal("unfocus",
                      function(c) c.border_color = beautiful.border_normal end)
