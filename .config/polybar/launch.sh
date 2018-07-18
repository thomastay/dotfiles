#!/bin/bash

# Terminate already running bar instances
killall -q polybar

#Pause until polybar closes
sleep 1

# Launch bar1 and bar2
polybar Main &
