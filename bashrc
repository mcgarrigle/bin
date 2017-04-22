
alias ll="ls -la"
alias vi=vim
alias f="find . -name"

export PATH="/usr/local/bin:$HOME/bin:$PATH:bin"
export EDITOR=vim

source "git-aliases.sh"
source "vbx-aliases.sh"
source "ruby-aliases.sh"

proxy=http://127.0.0.1:9090

function p0 {
  unset http_proxy
  unset https_proxy
}

function p1 {
  export http_proxy=$proxy
  export https_proxy=$proxy
}

