-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- keys.lua --> Key bindings for awesome wm
--

local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')
local mymainmenu = require('config.menu')
local apps = require('config.apps')

local modkey = 'Mod4'
local altkey = 'Mod1'

local keys = {}

keys.globalkeys =
    gears.table.join(
    awful.key(
        {modkey},
        's',
        hotkeys_popup.show_help,
        {
            description = 'show help',
            group = 'awesome'
        }
    ), -- Tag mouvement
    awful.key({modkey}, 'Left', awful.tag.viewprev, {description = 'view previous', group = 'tag'}),
    awful.key(
        {modkey},
        'Right',
        awful.tag.viewnext,
        {
            description = 'view next',
            group = 'tag'
        }
    ),
    awful.key({modkey}, 'Escape', awful.tag.history.restore, {description = 'go back', group = 'tag'}),
    -- Client focus manipulation
    awful.key(
        {modkey},
        'j',
        function()
            awful.client.focus.byidx(1)
        end,
        {description = 'focus next by index', group = 'client'}
    ),
    awful.key(
        {modkey},
        'k',
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = 'focus previous by index', group = 'client'}
    ),
    awful.key(
        {modkey},
        'w',
        function()
            mymainmenu:show()
        end,
        {
            description = 'show main menu',
            group = 'awesome'
        }
    ), -- Layout manipulation
    awful.key(
        {modkey, 'Shift'},
        'j',
        function()
            awful.client.swap.byidx(1)
        end,
        {description = 'swap with next client by index', group = 'client'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'k',
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = 'swap with previous client by index', group = 'client'}
    ),
    awful.key(
        {modkey, 'Control'},
        'j',
        function()
            awful.screen.focus_relative(1)
        end,
        {description = 'focus the next screen', group = 'screen'}
    ),
    awful.key(
        {modkey, 'Control'},
        'k',
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = 'focus the previous screen', group = 'screen'}
    ),
    awful.key(
        {modkey},
        'u',
        awful.client.urgent.jumpto,
        {
            description = 'jump to urgent client',
            group = 'client'
        }
    ),
    awful.key(
        {modkey},
        'Tab',
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'go back', group = 'client'}
    ),
    -- Multimedia keys to control Spotify
    awful.key(
        {},
        'XF86AudioPlay',
        function()
            awful.util.spawn_with_shell('playerctl play-pause')
        end,
        {description = 'Play/Resume music on Spotify', group = 'Multimedia'}
    ),
    awful.key(
        {},
        'XF86AudioNext',
        function()
            awful.util.spawn_with_shell('playerctl next')
        end,
        {description = 'Next music on Spotify', group = 'Multimedia'}
    ),
    awful.key(
        {},
        'XF86AudioPrev',
        function()
            awful.util.spawn_with_shell('playerctl previous')
        end,
        {description = 'Previous music on Spotify', group = 'Multimedia'}
    ),
    -- Volume control
    awful.key(
        {},
        'XF86AudioRaiseVolume',
        function()
            awful.util.spawn(apps.volume_control .. ' set Master 5%+')
            awesome.emit_signal('popup::volume')
        end
    ),
    awful.key(
        {},
        'XF86AudioLowerVolume',
        function()
            awful.util.spawn(apps.volume_control .. ' set Master 5%-')
            awesome.emit_signal('popup::volume')
        end
    ),
    awful.key(
        {},
        'XF86AudioMute',
        function()
            awful.util.spawn(apps.volume_control .. ' set Master toggle')
            awesome.emit_signal('popup::volume')
        end
    ), -- Brightness
    awful.key(
        {},
        'XF86MonBrightnessDown',
        function()
            awful.util.spawn(apps.screen_brightness .. ' -dec 10')
            awesome.emit_signal('popup::brightness')
        end
    ),
    awful.key(
        {},
        'XF86MonBrightnessUp',
        function()
            awful.util.spawn(apps.screen_brightness .. ' -inc 10')
            awesome.emit_signal('popup::brightness')
        end
    ), -- Standard program
    awful.key({modkey, 'Control'}, 'r', awesome.restart, {description = 'reload awesome', group = 'awesome'}),
    awful.key(
        {modkey, 'Shift'},
        'q',
        awesome.quit,
        {
            description = 'quit awesome',
            group = 'awesome'
        }
    ),
    awful.key(
        {modkey},
        'l',
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = 'increase master width factor', group = 'layout'}
    ),
    awful.key(
        {modkey},
        'h',
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = 'decrease master width factor', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'h',
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = 'increase the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'l',
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = 'decrease the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'h',
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = 'increase the number of columns', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'l',
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = 'decrease the number of columns', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'space',
        function()
            awful.layout.inc(-1)
        end,
        {
            description = 'select previous',
            group = 'layout'
        }
    ),
    awful.key(
        {modkey},
        'Return',
        function()
            awful.spawn(apps.terminal)
        end,
        {description = 'open a terminal', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'b',
        function()
            awful.spawn(apps.browser)
        end,
        {description = 'launch Browser', group = 'launcher'}
    ),
    awful.key(
        {modkey, altkey},
        'e',
        function()
            awful.spawn(apps.code_editor)
        end,
        {description = 'launch VS Code', group = 'launcher'}
    ),
    awful.key(
        {modkey, 'Control'},
        'Escape',
        function()
            awful.spawn(apps.run_launcher)
        end,
        {description = 'launch app launcher', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'd',
        function()
            awful.spawn(
                string.format(
                    "dmenu_run -i -h 30 -nb '%s' -nf '%s' -sb '%s' -sf '%s' -fn SauceCodeProNerdFont:bold:pixelsize=16",
                    beautiful.bg_normal,
                    beautiful.fg_normal,
                    beautiful.bg_focus,
                    beautiful.fg_focus
                )
            )
        end,
        {description = 'launch dmenu', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'v',
        function()
            awful.spawn(apps.multimedia)
        end,
        {description = 'launch multimedia app', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'c',
        function()
            awful.spawn(apps.clipboard)
        end,
        {description = 'launch clipboard app', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'e',
        function()
            awful.spawn(apps.filemanager)
        end,
        {description = 'launch filemanager', group = 'launcher'}
    ),
    awful.key(
        {},
        'Print',
        function()
            awesome.emit_signal('screenshot::show')
        end,
        {description = 'capture a screenshot', group = 'screenshot'}
    ),
    awful.key(
        {'Control'},
        'Print',
        function()
            awesome.emit_signal('screenshot::show')
        end,
        {
            description = 'capture a screenshot of active window',
            group = 'screenshot'
        }
    ),
    awful.key(
        {modkey, 'Control'},
        'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = 'restore minimized', group = 'client'}
    ), -- Prompt
    awful.key(
        {modkey},
        'r',
        function()
            awful.screen.focused().mypromptbox:run()
        end,
        {description = 'run prompt', group = 'launcher'}
    ),
    awful.key(
        {modkey},
        'ö',
        function()
            awful.prompt.run {
                prompt = 'Run Lua code: ',
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. '/history_eval'
            }
        end,
        {description = 'lua execute prompt', group = 'awesome'}
    ),
    -- System controls
    awful.key(
        {modkey, altkey, 'Control'},
        's',
        function()
            awful.util.spawn('systemctl suspend')
        end,
        {description = 'Put to sleep', group = 'system'}
    ),
    awful.key(
        {modkey},
        '=',
        function()
            awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
        end,
        {description = 'Toggle systray visibility', group = 'custom'}
    )
)

keys.clientkeys =
    gears.table.join(
    awful.key(
        {modkey},
        'f',
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = 'toggle fullscreen', group = 'client'}
    ),
    awful.key(
        {modkey},
        'q',
        function(c)
            c:kill()
        end,
        {
            description = 'close',
            group = 'client'
        }
    ),
    awful.key(
        {modkey, 'Control'},
        'space',
        awful.client.floating.toggle,
        {description = 'toggle floating', group = 'client'}
    ),
    awful.key(
        {modkey, 'Control'},
        'Return',
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = 'move to master', group = 'client'}
    ),
    awful.key(
        {modkey},
        'o',
        function(c)
            c:move_to_screen()
        end,
        {description = 'move to screen', group = 'client'}
    ),
    awful.key(
        {modkey},
        't',
        function(c)
            c.ontop = not c.ontop
        end,
        {description = 'toggle keep on top', group = 'client'}
    ),
    awful.key(
        {modkey},
        'n',
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = 'minimize', group = 'client'}
    ),
    awful.key(
        {modkey},
        'm',
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = '(un)maximize', group = 'client'}
    ),
    awful.key(
        {modkey, 'Control'},
        'm',
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = '(un)maximize vertically', group = 'client'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'm',
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = '(un)maximize horizontally', group = 'client'}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keys.globalkeys =
        gears.table.join(
        keys.globalkeys, -- View tag only.
        awful.key(
            {modkey},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = 'view tag #' .. i, group = 'tag'}
        ),
        -- Toggle tag display.
        awful.key(
            {modkey, 'Control'},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = 'toggle tag #' .. i, group = 'tag'}
        ),
        -- Move client to tag.
        awful.key(
            {modkey, 'Shift'},
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = 'move focused client to tag #' .. i, group = 'tag'}
        ),
        -- Toggle tag on focused client.
        awful.key(
            {modkey, 'Control', 'Shift'},
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = 'toggle focused client on tag #' .. i, group = 'tag'}
        )
    )
end

keys.clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            client.focus = c
            c:raise()
            mymainmenu:hide()
        end
    ),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)

-- Mous bindings
root.buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                mymainmenu:hide()
            end
        ),
        awful.button(
            {},
            3,
            function()
                mymainmenu:toggle()
            end
        ),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)
    )
)

awful.button(
    {modkey},
    1,
    function(c)
        c.maximized_horizontal = false
        c.maximized_vertical = false
        c.maximized = false
        c.fullscreen = false
        awful.mouse.client.move(c)
    end
)

root.keys(keys.globalkeys)

return keys
