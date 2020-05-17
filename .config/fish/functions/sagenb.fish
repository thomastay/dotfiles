# Defined in /home/thomas/.config/fish/functions/sagenb.fish @ line 2
function sagenb
    sage --notebook=jupyter 2&>1 (mktemp) &
end
