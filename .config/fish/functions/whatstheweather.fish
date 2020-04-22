# Defined in /tmp/fish.FDnIsE/whatstheweather.fish @ line 2
function whatstheweather --description 'Print the weather'
    # break up by deg C or deg F, and then print the field before it
    set awk_text '/°(C|F)/ {printf $(NF-1) $(NF)}'

    for location in singapore canton,mi seattle  # change locations as you please
        echo "Weather in $location:" (curl -s "https://wttr.in/$location?0qm" | awk $awk_text)
    end
end
