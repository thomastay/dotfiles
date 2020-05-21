set -x
for F in $(ls -A | grep -E "^\."); 
do
    ln -bs ~/dotfiles/$F ~
done

cd ~
ln -s dotfiles/oftenforgotten of

cd ~/.ssh
ln -sb config ../dotfiles/config
