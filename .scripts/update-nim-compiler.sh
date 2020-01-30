#/bin/bash
set -x

cd ~/.choosenim/toolchains/nim-#devel
git pull
nim c --skipUserCfg --skipParentCfg koch
./koch boot -d:release
./koch tools
cd ~
