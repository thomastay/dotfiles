#!/bin/bash
#########################################
#  This file cycles between four modes  #
#       - Extend Desktop                #
#       - External only                 #
#       - Clone Desktop                 #
#       - Extend Desktop                #
#########################################

MON1=eDP-1
MON2=HDMI-1
RES1="2560x1440"
RES2="1920x1080"
#Note - This assumes that RES1 is higher than RES2. If not, please do modify it accordingly. 

#   Reads the data from the config file which tells it which config to go to 
#   next
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
    monitor_mode="EXTEND"

# otherwise read the value from the file
else
    monitor_mode=`cat /tmp/monitor_mode.dat`
fi

#   Checks if there is one or two monitors attached
xStatus=`xrandr`
connectedOutputs=$(echo "$xStatus" | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
activeOutput=$(echo "$xStatus" | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/" | head -n1)
connectionCount=$(echo $connectedOutputs | wc -w)

if [ "$connectionCount" -gt 1 ]; then
    ## Then we have a dual display, and so we go ahead
    if [ $monitor_mode = "EXTEND" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output $MON1 --mode $RES1 --dpi 192 --output $MON2 --mode $RES2 --panning "$RES2+2560+0" --right-of $MON1
        #2560 is the width of $MON1
    elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $MON1 --off --output $MON2 --mode 1920x1080 --primary --pos 0x0 --dpi 120
    elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="CLONES"
        xrandr --output $MON1 --primary --dpi 192 --auto --output $MON2 --off
    else
        monitor_mode="EXTEND"
        xrandr --output $MON1 --mode $RES2 --output $MON2 --mode $RES2 --same-as $MON1
    fi
    echo "$monitor_mode" > /tmp/monitor_mode.dat
else
    ## We only have one display, so just use the normal one
    xrandr --output $MON1 --primary --mode $RES1 --auto --dpi 192
fi

~/.fehbg
~/.config/polybar/launch.sh
