#!/bin/sh
#
# ~/.xinitrc
# Executed by startx (run your window manager from here)

# Set up screens and set background
if [ `xrandr | grep -c ' connected '` -eq 2 ]; then # dual-monitor
    if [ `xrandr | grep VGA-1 | grep -c ' connected '` -eq 1 ]; then
        xrandr --output LVDS-1 --auto --primary --output VGA-1 --auto --right-of LVDS-1
    fi
    if [ `xrandr | grep DVI-1 | grep -c ' connected '` -eq 1 ]; then
        xrandr --output LVDS-1 --auto --primary --output DVI-1 --auto --right-of LVDS-1
    fi
    feh --bg-tile ~/Wallpapers/tile8.jpg    
#    xsetroot -solid \#cccccc
else
    xrandr --output LVDS-1 --auto --primary --output VGA-1 --off --output DVI-1 --off
fi

xrdb -merge /home/saksham/.Xresources
eval `dbus-launch --auto-syntax`
/home/saksham/.myscripts/touchpad.sh
exec xmonad
#exec i3
