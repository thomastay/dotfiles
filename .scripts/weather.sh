#!/bin/bash

# break up by deg C or deg F, and then print the field before it
AWK_TEXT='/°(C|F)/ {printf $(NF-1) $(NF) }'

WEATHERSG=$(curl -s https://wttr.in/Singapore?0qm | awk $AWK_TEXT)
WEATHERA2=$(curl -s https://wttr.in/ann_arbor?0qm | awk $AWK_TEXT)
echo "Weather in Ann Arbor: $WEATHERA2"
echo "Weather in Singapore: $WEATHERSG"
