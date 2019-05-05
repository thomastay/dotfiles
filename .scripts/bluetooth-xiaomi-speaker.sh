#!/bin/bash

printf "%s" "power on" | bluetoothctl
printf "%s" "connect F4:4E:FD:E0:EF:56" | bluetoothctl

