#!/usr/bin/env bash
# Adapted from http://www.pclinuxos.com/forum/index.php?topic=111155.0
#
# In case there is no active output (probably because the external output got disconnected)
# activate whatever is available

while true; do
	xStatus=`xrandr --current`
	activeOutputs=$(echo "$xStatus" | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
	activeCount=$(echo $activeOutputs | wc -w)

	if [ "$activeCount" -eq 0 ]; then
		xrandr --auto
        ~/.config/polybar/launch.sh
        ~/.fehbg
	fi

	sleep 5
done


