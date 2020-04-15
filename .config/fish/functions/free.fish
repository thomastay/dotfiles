# Defined in - @ line 1
function free --wraps='free -h' --description 'alias free free -h'
 command free -h $argv;
end
