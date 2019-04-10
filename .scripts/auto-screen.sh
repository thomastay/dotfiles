#!/bin/sh
set +x
#---- My personal preferences. Updates accordingly
#---- If there is one screen,
#---- Then display only one
#---- If not, display on the left

NUM_CONN=$(xrandr | grep -E "\bconnected" | wc -l)

if [ $NUM_CONN -eq 1 ]; then
    # We have one display
    xrandr --auto
elif [ $NUM_CONN -eq 2 ]; then
    xrandr --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output eDP-1 --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-2 --off
fi

~/.fehbg
~/.config/polybar/launch.sh &
