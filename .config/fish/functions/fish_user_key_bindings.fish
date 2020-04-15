# Defined in /tmp/fish.ENY74j/fish_user_key_bindings.fish @ line 2
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end
