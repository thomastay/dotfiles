set -x
for F in $(ls -A | grep -E "^\."); 
do
    ln -bs ~/dotfiles/$F ~
done

rm ~/.vimrc-win
rm ~/.git

cd ~
ln -s dotfiles/oftenforgotten.txt of

cd ~/.ssh
ln -sb config ../dotfiles/config
