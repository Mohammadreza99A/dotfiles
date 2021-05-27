-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- notifications.lua --> Naughty configs for awesome wm
--
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi

-- Default config
naughty.config.spacing = dpi(4)
naughty.config.padding = dpi(10)
naughty.config.defaults.margin = dpi(10)
naughty.config.defaults.border_width = 2
naughty.config.defaults.max_width = dpi(450)
naughty.config.defaults.max_height = dpi(80)
naughty.config.defaults.icon_size = 80
naughty.config.defaults.shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, dpi(8))
end

-- Presets
naughty.config.presets.low.timeout = 5
naughty.config.presets.normal.timeout = 6
