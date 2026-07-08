#!/usr/bin/env bash

# invoke with:
# curl -L bit.ly/shellin | bash

sudo yum install -y epel-release
sudo yum install -y vim git tmux bash-completion yum-utils

cd ${HOME}

if [ -d "bin" ]; then
  echo "bin exists ... skipping"
else
  git clone 'https://github.com/mcgarrigle/bin.git' "bin"
fi

echo -e '\n. ${HOME}/bin/bashrc\n' >> ~/.bashrc

ln -sf ${HOME}/bin/vimrc     .vimrc
ln -sf ${HOME}/bin/tmux.conf .tmux.conf
