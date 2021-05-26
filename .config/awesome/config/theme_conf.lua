-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- themes_conf.lua --> Theme confs and names for awesome wm
--

local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
require("awful.autofocus")

local themes = {
    "nord" --1
}

local current_theme = 1

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), themes[current_theme]))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
        awful.spawn("xterm -e nitrogen --restore &")
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
end)

return themes[current_theme]
