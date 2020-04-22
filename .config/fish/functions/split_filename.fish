# Defined in /tmp/fish.6EDRqH/split_filename.fish @ line 2
function split_filename
    echo (string split -r -m1 . $argv[1])
end
