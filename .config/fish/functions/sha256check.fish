function sha256check
echo (cat "$argv[1].sha256") $argv[1] | sha256sum --check
end
