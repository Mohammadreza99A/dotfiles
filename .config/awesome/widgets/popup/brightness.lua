-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- brightness.lua --> Brightness notification bar for awesome wm
--

local naughty = require("naughty")
local beautiful = require("beautiful")
local awful = require("awful")
local apps = require("config.apps")

local brightness_notif_preset = {
  font = beautiful.font,
  timeout = 5
}

local brightness_notif = nil

local function show_brightness_notif()
  local file = io.popen("sleep 0.2 && " .. apps.screen_brightness)
  local s = file:read("*all")
  file:close()
  local wib, tot = awful.screen.focused().mywibox, 20
  if wib then
    if wib.position == "left" or wib.position == "right" then
      tot = wib.width
    else
      tot = wib.height
    end
  end
  local int = math.modf((tonumber(s) / 100) * tot)
  brightness_notif_preset.text = string.format("%s%s%s%s", "[", string.rep("|", int), string.rep(" ", tot - int), "]")
  brightness_notif_preset.title = "Brightness Level - " .. tonumber(string.format("%.1f", s)) .. "%"
  if not brightness_notif then
    brightness_notif =
      naughty.notify {
      preset = brightness_notif_preset,
      destroy = function()
        brightness_notif = nil
      end
    }
  else
    naughty.replace_text(brightness_notif, brightness_notif_preset.title, brightness_notif_preset.text)
  end
end

awesome.connect_signal(
  "popup::brightness",
  function()
    show_brightness_notif()
  end
)
