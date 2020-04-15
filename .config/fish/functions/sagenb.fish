# Defined in /tmp/fish.S0gfVl/sagenb.fish @ line 1
function sagenb
    sage --notebook=jupyter > (mktemp) &
end
