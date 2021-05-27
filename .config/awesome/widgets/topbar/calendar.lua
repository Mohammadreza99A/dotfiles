-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- calendar.lua --> Calendar widget for awesome wm
--

local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

-- calendar
local styles = {}

styles.month = {bg_color = '#00000000', border_width = 0, padding = 4}

styles.normal = {padding = dpi(7)}

styles.focus = {
    fg_color = beautiful.fg_normal,
    markup = function(t)
        return '<b>' .. t .. '</b>'
    end,
    bg_color = beautiful.bg_very_light,
    padding = dpi(7),
    shape = gears.shape.circle
}

styles.header = {
    fg_color = beautiful.fg_normal,
    bg_color = '#00000000',
    markup = function(t)
        return beautiful.markup_text(t, beautiful.font_xlarge_bold)
    end,
    shape = beautiful.widget_shape
}

styles.weekday = {
    fg_color = beautiful.fg_dark,
    markup = function(t)
        return string.upper(t)
    end
}

local function decorate_cell(widget, flag, date)
    if flag == 'monthheader' and not styles.monthheader then
        flag = 'header'
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = {
        year = date.year,
        month = (date.month or 1),
        day = (date.day or 1)
    }
    local weekday = tonumber(os.date('%w', os.time(d)))
    local default_bg = (weekday == 0 or weekday == 7) and '#00000000' or '#00000000'
    local ret =
        wibox.widget {
        {
            widget,
            margins = (props.padding or 0) + (props.border_width or 0),
            widget = wibox.container.margin
        },
        shape = props.shape,
        shape_border_color = props.border_color or default_bg,
        shape_border_width = props.border_width or 0,
        fg = props.fg_color or beautiful.fg_normal,
        bg = props.bg_color or default_bg,
        widget = wibox.container.background
    }
    return ret
end

local calendar =
    wibox.widget {
    date = os.date('*t'),
    font = beautiful.font,
    long_weekdays = false,
    start_sunday = false,
    fn_embed = decorate_cell,
    widget = wibox.widget.calendar.month
}

local calendar_widget =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    calendar,
    {
        {
            layout = wibox.layout.align.horizontal,
            expand = 'inside',
            nil,
            nil,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = beautiful.widget_margin,
                button_previous,
                button_next
            }
        },
        top = dpi(-15),
        widget = wibox.container.margin
    }
}

calendar_widget:buttons(
    awful.util.table.join(
        awful.button(
            {},
            4,
            function()
                local date = calendar:get_date()
                date.month = date.month + 1
                calendar:set_date(nil)
                calendar:set_date(date)
            end
        ),
        awful.button(
            {},
            5,
            function()
                local date = calendar:get_date()
                date.month = date.month - 1
                calendar:set_date(nil)
                calendar:set_date(date)
            end
        )
    )
)

return calendar_widget
