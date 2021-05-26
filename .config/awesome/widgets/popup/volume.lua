-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- volume.lua --> Volume notification bar for awesome wm
--

local pulsebar = require("lib.lain.widget.pulsebar")
local beautiful = require("beautiful")

local volume =
  pulsebar {
  notification_preset = {
    font = beautiful.font
  }
}

awesome.connect_signal(
  "popup::volume",
  function()
    volume.notify()
  end
)
