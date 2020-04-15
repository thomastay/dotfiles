#!/bin/bash
WEATHERSG=$(curl -s https://wttr.in/Singapore?0qm | awk '/°(C|F)/ {printf $(NF-1) $(NF) " ("a")"} /,/ {a=$0}')
WEATHERA2=$(curl -s https://wttr.in/ann_arbor?0qm | awk '/°(C|F)/ {printf $(NF-1) $(NF) " ("a")"} /,/ {a=$0}')
echo "Weather in Ann Arbor: $WEATHERA2"
echo "Weather in Singapore: $WEATHERSG"
