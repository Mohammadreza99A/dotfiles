-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- taglist.lua --> Taglist widget for awesome wm
--

local awful = require('awful')
local gears = require('gears')
local gfs = gears.filesystem
local wibox = require('wibox')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local get_taglist = function(s)
    -- Taglist buttons
    local taglist_buttons =
        gears.table.join(
        awful.button(
            {},
            1,
            function(t)
                t:view_only()
            end
        ),
        awful.button(
            {modkey},
            1,
            function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end
        ),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button(
            {modkey},
            3,
            function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end
        ),
        awful.button(
            {},
            4,
            function(t)
                awful.tag.viewnext(t.screen)
            end
        ),
        awful.button(
            {},
            5,
            function(t)
                awful.tag.viewprev(t.screen)
            end
        )
    )

    -- The actual png icons
    -- I do have the svgs, but inkscape does a better job of scaling
    local ghost = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'themes/icons/ghost.png')
    local ghost_icon = gears.color.recolor_image(ghost, beautiful.fg_focus)
    local dot = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'themes/icons/dot.png')
    local dot_icon = gears.color.recolor_image(dot, beautiful.cyan)
    local pacman = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'themes/icons/pacman.png')
    local pacman_icon = gears.color.recolor_image(pacman, beautiful.green)

    -- Function to update the tags
    local update_tags = function(self, c3)
        local imgbox = self:get_children_by_id('icon_role')[1]
        if c3.selected then
            imgbox.image = pacman_icon
        elseif #c3:clients() == 0 then
            imgbox.image = dot_icon
        else
            imgbox.image = ghost_icon
        end
    end

    local pac_taglist =
        awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {shape = gears.shape.rectangle},
        layout = {spacing = 0, layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {id = 'icon_role', widget = wibox.widget.imagebox},
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            widget = wibox.container.background,
            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end
        },
        buttons = taglist_buttons
    }

    return beautiful.make_pill(pac_taglist)
end

return get_taglist
