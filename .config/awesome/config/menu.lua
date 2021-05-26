-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- menu.lua --> Right click and general menu for awesome wm
--

local menubar = require("menubar")

local freedesktop = require("lib.freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup")

local apps = require("config.apps")

local myawesomemenu = {
    {
        "hotkeys",
        function()
            return false, hotkeys_popup.show_help
        end,
        menubar.utils.lookup_icon("preferences-desktop-keyboard-shortcuts")
    },
    {"manual", apps.terminal .. " -e man awesome", menubar.utils.lookup_icon("system-help")},
    {"edit config", apps.gui_editor .. " " .. awesome.conffile, menubar.utils.lookup_icon("accessories-text-editor")},
    {"restart", awesome.restart, menubar.utils.lookup_icon("system-restart")}
}
local myexitmenu = {
    {
        "log out",
        function()
            awesome.quit()
        end,
        menubar.utils.lookup_icon("system-log-out")
    },
    {"suspend", "systemctl suspend", menubar.utils.lookup_icon("system-suspend")},
    {"hibernate", "systemctl hibernate", menubar.utils.lookup_icon("system-suspend-hibernate")},
    {"reboot", "systemctl reboot", menubar.utils.lookup_icon("system-reboot")},
    {"shutdown", "poweroff", menubar.utils.lookup_icon("system-shutdown")}
}
local mymainmenu =
    freedesktop.menu.build(
    {
        icon_size = 32,
        before = {
            {"Terminal", apps.terminal, menubar.utils.lookup_icon("utilities-terminal")},
            {"Browser", apps.browser, menubar.utils.lookup_icon("internet-web-browser")},
            {"Files", apps.filemanager, menubar.utils.lookup_icon("system-file-manager")}
        },
        after = {
            {"Awesome", myawesomemenu, "/usr/share/awesome/icons/awesome32.png"},
            {"Exit", myexitmenu, menubar.utils.lookup_icon("system-shutdown")}
        }
    }
)

menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it

return mymainmenu
