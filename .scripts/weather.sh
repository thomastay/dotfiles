WEATHERSG=$(curl -s https://wttr.in/Singapore?0?q | awk '/°(C|F)/ {printf $(NF-1) $(NF) " ("a")"} /,/ {a=$0}')
WEATHERA2=$(curl -s https://wttr.in/ann_arbor?0?q | awk '/°(C|F)/ {printf $(NF-1) $(NF) " ("a")"} /,/ {a=$0}')
echo "Weather in Singapore: $WEATHERSG"
echo "Weather in Ann Arbor: $WEATHERA2"
