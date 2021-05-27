-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- rules.lua --> Client rules for awesome wm
--
local awful = require("awful")
local beautiful = require("beautiful")

local keys = require("config.keys")

local rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            size_hints_honor = false, -- Remove gaps between terminals
            screen = awful.screen.preferred,
            callback = awful.client.setslave,
            placement = awful.placement.no_overlap +
                awful.placement.no_offscreen
        }
    }, -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq" -- Includes session name in class.
            },
            class = {
                "Arandr", "Gpick", "Kruler", "MessageWin", -- kalarm.
                "Sxiv", "Wpa_gui", "pinentry", "veromix", "xtightvncviewer",
                "xfce4-appearance-settings", "nitrogen", "Nitrogen",
                "galculator", "Galculator", "discord", "jetbrains-idea-ce",
                "insomnia", "Insomnia", "persepolis"
            },
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    }, -- Remove titlebars from normal clients and dialogs
    {
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = false}
    }, -- Add titlebar to some of the applications
    {
        rule_any = {class = {"discord", "be.ac.ulb.infof307.g07.App"}},
        properties = {titlebars_enabled = true}
    }
}

awful.rules.rules = rules
