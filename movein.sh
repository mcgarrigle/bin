#!/usr/bin/env bash

# invoke with:
# curl -L bit.ly/shellin | bash

sudo yum install -y epel-release
sudo yum install -y vim git python3 tmux bash-completion tree yum-utils fastfetch curl util-linux-user

cd ${HOME}

if [ -d "bin" ]; then
  echo "bin exists ... skipping"
else
  git clone 'https://github.com/mcgarrigle/bin.git' "bin"
fi

echo -e '\n. ${HOME}/bin/bashrc\n' >> ~/.bashrc

sudo cp ${HOME}/bin/motd.sh /etc/profile.d/
sudo cp ${HOME}/bin/issue   /etc/

ln -sf ${HOME}/bin/vimrc     .vimrc
ln -sf ${HOME}/bin/tmux.conf .tmux.conf
