-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- battery.lua --> Battery widget for awesome wm
--

local beautiful = require("beautiful")
local wibox = require("wibox")
local bat = require("lib.lain.widget.bat")

local baticon =
    wibox.widget {
    font = beautiful.widget_font,
    widget = wibox.widget.textbox
}
baticon.markup = beautiful.widget_icon_markup("")
local bat =
    bat(
    {
        settings = function()
            if bat_now.status then
                if bat_now.status == "N/A" then
                    baticon.markup = beautiful.widget_icon_markup("")
                    widget:set_markup(beautiful.widget_text_markup(bat_now.perc .. "%"))
                elseif bat_now.status == "Charging" then
                    if bat_now.perc then
                        if bat_now.perc and tonumber(bat_now.perc) <= 20 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 30 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 40 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 60 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 80 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 90 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        else
                            baticon.markup = beautiful.widget_icon_markup("")
                        end
                    else
                        baticon.markup = beautiful.widget_icon_markup("")
                    end
                    widget:set_markup(beautiful.widget_text_markup(bat_now.perc .. "%"))
                else
                    if bat_now.perc then
                        if bat_now.perc and tonumber(bat_now.perc) <= 10 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 20 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 30 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 40 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 50 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 60 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 70 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 80 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        elseif bat_now.perc and tonumber(bat_now.perc) <= 90 then
                            baticon.markup = beautiful.widget_icon_markup("")
                        else
                            baticon.markup = beautiful.widget_icon_markup("")
                        end
                    end
                    widget:set_markup(beautiful.widget_text_markup(bat_now.perc .. "%"))
                end
            else
                widget:set_markup()
                baticon.markup = beautiful.widget_icon_markup("")
            end
        end
    }
)

local battery_widget =
    wibox.widget {
    baticon,
    bat,
    layout = wibox.layout.fixed.horizontal
}

return battery_widget
