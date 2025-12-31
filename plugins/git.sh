
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gc='git commit -m'
alias gf='git diff-tree --no-commit-id --name-status -r'
alias gg='git pull'
alias gp='git push'
alias co='git checkout'
alias gr='git remote -v'
alias gl="git --no-pager log --pretty=format:'%C(bold)%h %ci %C(magenta)%ae %C(cyan)%s%C(reset)' --abbrev-commit --max-count=20; echo"
alias gll="git --no-pager log --pretty=format:'%C(bold)%h %ci %C(magenta)%ae %C(cyan)%s%C(reset)' --abbrev-commit; echo"
alias glt='git --no-pager log --pretty=oneline --abbrev-commit --max-count=20'
alias gk="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"

function gd {
  if [ -t 1 ]; then
    git diff --color
  else
    git diff
  fi
}

function fix {
  git add $1
  git commit -m "updated $1"
}

function fixup {
  git reset --soft HEAD~1
  git commit --amend -C HEAD
}

function __git_branch {
  local BRANCH
  BRANCH=$(git describe --contains --all HEAD 2> /dev/null)
  if [ "$?" = "0" ]; then
    echo "(${BRANCH})"
  else
    echo ""
  fi
}
