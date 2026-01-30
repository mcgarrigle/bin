export SHELL="/bin/zsh"
export PATH="$HOME/bin:$PATH"
export EDITOR=vim
export CLICOLOR=1

alias ll="ls -la"
alias vi="nvim"
alias vim="nvim"
alias f="find . -name"
alias cls="clear && printf '\033[3J'"

function include {
  test -f "$1" && source "$1"
}

if [ -z "${proxy}" ]; then
  export proxy="http://127.0.0.1:9090"
fi

# change to directory that exists somewhere rooted
# at $HOME

function _dir_below {
  find $HOME -type d -name "$1" 2> /dev/null | head -1
}

function c {
  cd $(_dir_below "$1")
}

function p0 {
  unset http_proxy
  unset https_proxy
}

function p1 {
  export http_proxy=$proxy
  export https_proxy=$proxy
}

function root {
  local HOST="$1"; shift
  if [ -z "$1" ]; then
    ssh -t "${HOST}" sudo -i
  else
    ssh -T "${HOST}" sudo $@
  fi
}

function contains {
  [ -z "${2##*$1*}" ]
}

for APP in git prompt; do
  source "${HOME}/bin/plugins/${APP}.sh"
done

if [ "$(uname -s)" = "Darwin" ]; then
  eval $(brew shellenv)
fi
