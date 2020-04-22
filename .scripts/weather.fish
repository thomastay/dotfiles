#!/usr/bin/fish

# break up by deg C or deg F, and then print the field before it
set awk_text '/°(C|F)/ {printf $(NF-1) $(NF)}'

for location in singapore canton,mi
    echo "Weather in $location:" (curl -s "https://wttr.in/$location?0qm" | awk $awk_text)
end
