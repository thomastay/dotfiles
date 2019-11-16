#!/bin/bash
cp -b ~/dotfiles/tmuxp/nim.yml ~/dotfiles/tmuxp/$1.yml
sed -i "s/nim_tutorial/$1/g" ~/dotfiles/tmuxp/$1.yml
sed -i "s/nim/$1/g" ~/dotfiles/tmuxp/$1.yml
vim ~/dotfiles/tmuxp/$1.yml
