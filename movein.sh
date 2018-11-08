
yum install -y vim git tmux

git clone 'https://github.com/mcgarrigle/bin.git'

echo -e '\n. bin/bashrc\n' >> ~/.bashrc

ln -s bin/vimrc     .vimrc
ln -s bin/tmux.conf .tmux.conf

