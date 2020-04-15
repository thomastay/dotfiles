# Defined in - @ line 1
function apt --wraps='sudo apt' --description 'alias apt sudo apt'
  sudo apt $argv;
end
