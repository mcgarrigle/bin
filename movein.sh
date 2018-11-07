
yum install -y vim git

git clone 'https://github.com/mcgarrigle/bin.git'

echo -e '\n. bin/bashrc\n' >> ~/.bashrc

ln -s bin/vimrc .vimrc

