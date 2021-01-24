
export PATH="$HOME/bin:$PATH"
export EDITOR=vim
export CLICOLOR=1

alias ll="ls -la"
alias vi="vim"
alias f="find . -name"

alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gc='git commit -m'
alias gg='git pull'
alias gp='git push'
alias co='git checkout'
alias gd='git diff'
alias gr='git remote -v'
alias gl="git --no-pager log --pretty=format:'%C(bold)%h %ci %C(magenta)%ae %C(cyan)%s%C(reset)' --abbrev-commit --max-count=20; echo"
alias gll="git --no-pager log --pretty=format:'%C(bold)%h %ci %C(magenta)%ae %C(cyan)%s%C(reset)' --abbrev-commit; echo"
alias glt='git --no-pager log --pretty=oneline --abbrev-commit --max-count=20'
alias gk="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"

function fix {
  git add $1
  git commit -m "updated $1"
}

function fixup {
  git reset --soft HEAD~1
  git commit --amend -C HEAD
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

function contains {
  [ -z "${2##*$1*}" ]
}
