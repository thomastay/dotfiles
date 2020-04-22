# Defined in /tmp/fish.T5sN2W/find_cppref.fish @ line 2
function find_cppref --description 'finds a match in cppref, opens in browser. Usage: <keyword> [num_matches]'
    set pwd $PWD
    set doc_root ~/Downloads/cppreference/reference/en/cpp
    cd $doc_root
    if [ (count $argv) -gt 1 ]
        set num_matches $argv[2]
    else
        set num_matches 10
    end
    set matches (rg --count-matches $argv[1] | sort -t: -rnk2 | head -n $num_matches)
    for i in (seq (count $matches));
        echo $i \t$matches[$i]
    end
    while true
        echo "Select the link you wish to open (q to quit)"
        read match
        if string match -qr '^[1-9]\d*$' $match
            set filename (echo "$matches[$match]" | cut -d: -f1)
            echo $filename
            $BROWSER "$doc_root/$filename"
            break
        else if [ $match = "q" ]
            break
        else
            echo "Please enter a number. You entered $match"
        end
    end
    cd $pwd
end
