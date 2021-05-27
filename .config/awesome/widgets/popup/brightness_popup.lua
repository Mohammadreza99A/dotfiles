-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- brightness_popup.lua --> Brightness popup bar for awesome wm
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

local brightness_low_icon = gears.color.recolor_image(gears.surface
                                                          .load_uncached(
                                                          gears.filesystem
                                                              .get_configuration_dir() ..
                                                              "themes/icons/brightness/brightness-low.png"),
                                                      beautiful.fg_dark)
local brightness_high_icon = gears.color.recolor_image(gears.surface
                                                           .load_uncached(
                                                           gears.filesystem
                                                               .get_configuration_dir() ..
                                                               "themes/icons/brightness/brightness-high.png"),
                                                       beautiful.fg_dark)

local brightness_icon = wibox.widget {widget = wibox.widget.imagebox}

local brightness_adjust = wibox({
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
})

local brightness_bar = wibox.widget {
    widget = wibox.widget.progressbar,
    shape = gears.shape.rounded_bar,
    color = beautiful.fg_focus,
    background_color = beautiful.bg_light,
    max_value = 100,
    value = 0
}
brightness_adjust:setup{
    layout = wibox.layout.align.vertical,
    -- wibox.container.margin(brightness_icon),
    -- wibox.container.margin(brightness_bar, dpi(14), dpi(20), dpi(20), dpi(20))
    {
        wibox.container.margin(brightness_bar, dpi(14), dpi(20), dpi(20),
                               dpi(20)),
        forced_height = offsety * 0.75,
        direction = "east",
        layout = wibox.container.rotate
    },
    wibox.container.margin(brightness_icon)
}

local hide_brightness_adjust = gears.timer {
    timeout = 4,
    autostart = true,
    callback = function() brightness_adjust.visible = false end
}

awesome.connect_signal("popup::brightness", function()
    local file = io.popen("sleep 0.2 && xbacklight -get")
    local stdout = file:read("*all")
    file:close()

    local brightness_level = tonumber(stdout)
    brightness_bar.value = brightness_level
    if (brightness_level < 50) then
        brightness_icon:set_image(brightness_low_icon)
    else
        brightness_icon:set_image(brightness_high_icon)
    end

    if brightness_adjust.visible then
        hide_brightness_adjust:again()
    else
        brightness_adjust.visible = true
        hide_brightness_adjust:start()
    end
end)
