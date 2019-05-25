#
# invoke with:
# curl -L bit.ly/shellin | bash

yum install -y epel-release
yum install -y vim git tmux bash-completion yum-utils

git clone 'https://github.com/mcgarrigle/bin.git'

echo -e '\n. $HOME/bin/bashrc\n' >> ~/.bashrc

ln -s bin/vimrc     .vimrc
ln -s bin/tmux.conf .tmux.conf
