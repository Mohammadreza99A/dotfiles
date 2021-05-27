-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- rc.lua --> awesome wm entry file
--

local awful = require('awful')

-- Use bash as shell for awful utils
awful.util.shell = 'bash'

-- Notifications config
require('config.notifications')

-- Error handling
require('config.errorhandling')

-- Layouts
require('config.layout')

-- Theme
require('config.theme_conf')

-- Widgets
require('widgets.init')

-- Key bindings
require('config.keys')

-- Rules
require('config.rules')

-- Decorations
require('decorations.init')

-- Signals
require('config.signals')

-- Garbage Collection
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)

-- Autostart
awful.spawn.with_shell('~/.config/awesome/config/autorun.sh')
