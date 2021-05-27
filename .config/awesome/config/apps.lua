-- Mohammadreza Amini
-- https://github.com/Mohammadreza99A
-- apps.lua --> Most frequently useed apps for awesome wm
--

return {
    terminal = 'kitty',
    editor = 'nvim',
    gui_editor = 'gedit',
    browser = 'brave',
    filemanager = 'pcmanfm',
    screen_brightness = 'xbacklight',
    volume_control = 'amixer',
    code_editor = 'code',
    run_launcher = '/usr/bin/rofi -show drun -modi drun',
    multimedia = 'vlc',
    screenshot_selection = "sleep 0.1 && scrot -s '/home/mohammadreza/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png'",
    screenshot_screen = "sleep 0.1 && scrot '/home/mohammadreza/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png'",
    clipboard = 'copyq menu'
}
