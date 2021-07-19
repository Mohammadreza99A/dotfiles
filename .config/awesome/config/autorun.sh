#!/usr/bin/env bash

# Mohammadreza Amini
# https://github.com/Mohammadreza99A
# autostart.sh --> Autostart script for awesome wm
#

## run (only once) processes which spawn with the same name
function run() {
  if ! pgrep -f $1; then
    $@ &
  fi
}

## Restore Wallpaper
run nitrogen --restore

## Start Compositing Manager
run picom -b --config .config/picom/picom.conf 

## Enable Super Keys
run xcape -e 'Super_L=Super_L|Control_L|Escape'

## Start network, bleutooth and volume applets
run nm-applet
#run blueman-applet
run pa-applet --disable-notifications

## Start clipboard utility
run copyq

# idle watcher
if (command -v xidlehook && ! pgrep xidlehook); then
  xidlehook --not-when-audio --timer 600 'systemctl suspend' '' &
fi

if (command -v gnome-keyring-daemon && ! pgrep gnome-keyring-d); then
  gnome-keyring-daemon --daemonize --login &
fi
if (command -v lxpolkit && ! pgrep lxpolkit); then
  lxpolkit &
fi
