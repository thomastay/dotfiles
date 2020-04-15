# Defined in - @ line 1
function scrot --wraps='scrot ~/Pictures/Screenshots/%b%d::%H%M%S.png' --description 'alias scrot scrot ~/Pictures/Screenshots/%b%d::%H%M%S.png'
 command scrot ~/Pictures/Screenshots/%b%d::%H%M%S.png $argv;
end
