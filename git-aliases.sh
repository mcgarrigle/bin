
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
alias gg='git pull'
alias gp='git push'
alias co='git checkout'
alias gd='git diff'
alias gr='git remote -v'
alias gl='git log --graph --pretty=oneline --abbrev-commit'
alias gk="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"

function fix {
  git add $1
  git commit -m 'updated $1'
}

