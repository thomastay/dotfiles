# Defined in - @ line 1
function apt-get --wraps='sudo apt-get' --description 'alias apt-get sudo apt-get'
  sudo apt-get $argv;
end
