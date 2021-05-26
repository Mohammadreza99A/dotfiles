-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- volume_popup.lua --> Volume popup bar for awesome wm
--

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- local offsetx = 100 -- bottom center
-- local offsety = 280 -- bottom center
local offsetx = dpi(56) -- east
local offsety = dpi(256) -- east
local screen = awful.screen.focused()

local volume_low_icon =
    gears.color.recolor_image(
    gears.surface.load_uncached(gears.filesystem.get_configuration_dir() .. "themes/icons/volume/volume-low.png"),
    beautiful.fg_dark
)
local volume_high_icon =
    gears.color.recolor_image(
    gears.surface.load_uncached(gears.filesystem.get_configuration_dir() .. "themes/icons/volume/volume-high.png"),
    beautiful.fg_dark
)
local volume_off_icon =
    gears.color.recolor_image(
    gears.surface.load_uncached(gears.filesystem.get_configuration_dir() .. "themes/icons/volume/volume-off.png"),
    beautiful.fg_dark
)

local volume_icon =
    wibox.widget {
    widget = wibox.widget.imagebox
}

local volume_adjust =
    wibox(
    {
        screen = awful.screen.focused(),
        -- x = (screen.geometry.width / 2) - (offsetx / 2) - 50,
        -- y = screen.geometry.height - offsety,
        -- width = offsetx * 2,
        -- height = offsety - 30,
        x = screen.geometry.width - offsetx,
        y = (screen.geometry.height / 2) - (offsety / 2),
        width = dpi(48),
        height = offsety,
        bg = beautiful.bg_normal,
        border_width = 2,
        border_color = beautiful.cyan,
        shape = gears.shape.rounded_rect,
        visible = false,
        ontop = true
    }
)

local volume_bar =
    wibox.widget {
    widget = wibox.widget.progressbar,
    shape = gears.shape.rounded_bar,
    color = beautiful.fg_focus,
    background_color = beautiful.bg_light,
    max_value = 100,
    value = 0
}

volume_adjust:setup {
    layout = wibox.layout.align.vertical,
    -- wibox.container.margin(volume_icon),
    -- wibox.container.margin(volume_bar, dpi(14), dpi(20), dpi(20), dpi(20))

    {
        wibox.container.margin(volume_bar, dpi(14), dpi(20), dpi(20), dpi(20)),
        forced_height = offsety * 0.75,
        direction = "east",
        layout = wibox.container.rotate
    },
    wibox.container.margin(volume_icon)
}

local hide_volume_adjust =
    gears.timer {
    timeout = 4,
    autostart = true,
    callback = function()
        volume_adjust.visible = false
    end
}

awesome.connect_signal(
    "popup::volume",
    function()
        local file = io.popen("sleep 0.2 && amixer -D pulse sget Master")
        local stdout = file:read("*all")
        file:close()

        local mute = string.match(stdout, "%[(o%D%D?)%]") -- \[(o\D\D?)\] - [on] or [off]
        local volume = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
        volume = tonumber(string.format("%3d", volume))

        local volume_level = tonumber(volume)
        volume_bar.value = volume_level
        if mute == "off" then
            volume_icon:set_image(volume_off_icon)
            volume_bar.value = 0
        elseif (volume_level > 50) then
            volume_icon:set_image(volume_high_icon)
        elseif (volume_level > 5) then
            volume_icon:set_image(volume_low_icon)
        end

        if volume_adjust.visible then
            hide_volume_adjust:again()
        else
            volume_adjust.visible = true
            hide_volume_adjust:start()
        end
    end
)
