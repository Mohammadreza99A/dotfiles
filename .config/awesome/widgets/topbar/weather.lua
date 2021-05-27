-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- weather.lua --> Weather widget for awesome wm
--
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local filesystem = gears.filesystem
local json = require("lib.json")

local icon_dir = filesystem.get_configuration_dir() .. "/themes/icons/weather/"

local GET_FORECAST_CMD = [[bash -c "curl -s --show-error -X GET '%s'"]]

local settings = {
    openweathermap_api_key = "bf45bf455cd1656ac6fc31b8aef272f1",
    openweathermap_coordinates = {
        "50.850", -- lat
        "4.349" -- lng
    }
}

local icon_map = {
    ["01d"] = "clear-sky",
    ["02d"] = "few-clouds",
    ["03d"] = "scattered-clouds",
    ["04d"] = "broken-clouds",
    ["09d"] = "shower-rain",
    ["10d"] = "rain",
    ["11d"] = "thunderstorm",
    ["13d"] = "snow",
    ["50d"] = "mist",
    ["01n"] = "clear-sky-night",
    ["02n"] = "few-clouds-night",
    ["03n"] = "scattered-clouds-night",
    ["04n"] = "broken-clouds-night",
    ["09n"] = "shower-rain-night",
    ["10n"] = "rain-night",
    ["11n"] = "thunderstorm-night",
    ["13n"] = "snow-night",
    ["50n"] = "mist-night"
}

local current_weather_widget = wibox.widget {
    {
        {
            id = "icon",
            image = icon_dir .. "weather-showers.png",
            resize = true,
            forced_height = dpi(128),
            forced_width = dpi(128),
            widget = wibox.widget.imagebox
        },
        {
            {
                {
                    id = "description",
                    text = "Mostly cloudy",
                    font = beautiful.font_small_bold,
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.fixed.vertical
            },
            widget = wibox.container.place
        },
        spacing = dpi(5),
        layout = wibox.layout.fixed.vertical
    },
    nil,
    {
        {
            {
                id = "tempareture_current",
                markup = "20<sup><span>°</span></sup>",
                align = "right",
                font = beautiful.font_3xlarge_bold,
                widget = wibox.widget.textbox
            },
            {
                id = "feels_like",
                markup = "Feels like 19<sup><span>°</span></sup>",
                font = beautiful.font_small,
                widget = wibox.widget.textbox
            },
            {
                id = "humidity",
                text = "Humidity: 80%",
                font = beautiful.font_small,
                widget = wibox.widget.textbox
            },
            spacing = dpi(5),
            layout = wibox.layout.fixed.vertical
        },
        widget = wibox.container.place
    },
    spacing = dpi(5),
    layout = wibox.layout.align.horizontal
}

local hourly_widget = function()

    local widget = wibox.widget {
        {
            {
                id = "time",
                text = "12PM",
                font = beautiful.font_small,
                widget = wibox.widget.textbox
            },
            widget = wibox.container.place
        },
        {
            {
                id = "icon",
                image = icon_dir .. "weather-clear-sky.png",
                resize = true,
                forced_height = dpi(32),
                forced_width = dpi(32),
                widget = wibox.widget.imagebox
            },
            widget = wibox.container.place
        },
        {
            {
                id = "tempareture",
                markup = "1<sup><span>°</span></sup>",
                font = beautiful.font_small,
                widget = wibox.widget.textbox
            },
            widget = wibox.container.place
        },
        spacing = dpi(-3),
        layout = wibox.layout.fixed.vertical
    }

    widget.update = function(result)
        local time = widget:get_children_by_id("time")[1]
        local icon = widget:get_children_by_id("icon")[1]
        local temp = widget:get_children_by_id("tempareture")[1]
        temp:set_markup(math.floor(result.temp) .. "<sup><span>°</span></sup>")
        time:set_text(os.date('%I%p', tonumber(result.dt)))
        icon.image = icon_dir .. icon_map[result.weather[1].icon] .. ".png"
        icon:emit_signal("widget::redraw_needed")
    end
    return widget
end

local hourly_widget_1 = hourly_widget()
local hourly_widget_2 = hourly_widget()
local hourly_widget_3 = hourly_widget()
local hourly_widget_4 = hourly_widget()
local hourly_widget_5 = hourly_widget()

local weather_widget = wibox.widget {
    {
        text = "Weather",
        font = beautiful.font_xlarge_bold,
        align = "center",
        widget = wibox.widget.textbox
    },
    current_weather_widget,
    {
        hourly_widget_1,
        hourly_widget_2,
        hourly_widget_3,
        hourly_widget_4,
        hourly_widget_5,
        spacing = dpi(20),
        layout = wibox.layout.fixed.horizontal
    },
    spacing = dpi(32),
    layout = wibox.layout.fixed.vertical
}

local coordinates = settings.openweathermap_coordinates

local api_key = settings.openweathermap_api_key
local show_hourly_forecast = true
local show_daily_forecast = true
local units = "metric"

local url = ('https://api.openweathermap.org/data/2.5/onecall' .. '?lat=' ..
                coordinates[1] .. '&lon=' .. coordinates[2] .. '&appid=' ..
                api_key .. '&units=' .. units .. '&exclude=minutely' ..
                (show_hourly_forecast == false and ',hourly' or '') ..
                (show_daily_forecast == false and ',daily' or ''))

awful.widget.watch(string.format(GET_FORECAST_CMD, url), 300,
                   function(_, stdout, stderr)
    if stderr == '' then
        local result = json.decode(stdout)
        -- Current weather setup
        local icon = current_weather_widget:get_children_by_id('icon')[1]
        local description = current_weather_widget:get_children_by_id(
                                "description")[1]
        local humidity =
            current_weather_widget:get_children_by_id("humidity")[1]
        local temp_current = current_weather_widget:get_children_by_id(
                                 "tempareture_current")[1]
        local feels_like = current_weather_widget:get_children_by_id(
                               "feels_like")[1]
        icon.image = icon_dir .. icon_map[result.current.weather[1].icon] ..
                         ".png"
        icon:emit_signal("widget::redraw_needed")
        description:set_text(result.current.weather[1].description:gsub("^%l",
                                                                        string.upper))
        humidity:set_text("Humidity: " .. result.current.humidity .. "%")
        temp_current:set_markup(math.floor(result.current.temp) ..
                                    "<sup><span>°</span></sup>")
        feels_like:set_markup("Feels like: " ..
                                  math.floor(result.current.feels_like) ..
                                  "<sup><span>°</span></sup>")
        -- Hourly widget setup
        hourly_widget_1.update(result.hourly[1])
        hourly_widget_2.update(result.hourly[2])
        hourly_widget_3.update(result.hourly[3])
        hourly_widget_4.update(result.hourly[4])
        hourly_widget_5.update(result.hourly[5])
    end
end)

return weather_widget

