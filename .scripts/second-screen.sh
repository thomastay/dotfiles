#!/bin/bash

MON1=eDP-1
MON2=HDMI-1
RES1="2560x1440"
RES2="1920x1080"
#Note - This assumes that RES1 is higher than RES2. If not, please do modify it accordingly. 

monitor_mode="INTERNAL"
xrandr --output $MON1 --off --output $MON2 --mode 1920x1080 --primary --pos 0x0 --dpi 120

echo "$monitor_mode" > /tmp/monitor_mode.dat
~/.config/polybar/launch.sh
~/.fehbg
