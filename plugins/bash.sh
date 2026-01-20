alias ll="ls -la"
alias vi="nvim"
alias v=vim
alias f="find . -name"
alias cls="clear && printf '\033[3J'"
alias py="python3"

alias tm2='tmux new-session \; split-window -h -p 33 \; attach'
alias tm3='tmux new-session \; split-window -h -p 33 \; split-window -v \; attach'
alias tm='tm2'

export EDITOR=vim
export PS1='[\u@\h \W]\$ '

function path {
  if [ "$1" == "add" ]; then
    export PATH=$2:$PATH
  else
    echo $PATH | tr ':' '\n'
  fi
}

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
  unset HTTP_PROXY
  unset HTTPS_PROXY
}

function p1 {
  export http_proxy=$proxy
  export https_proxy=$proxy
  export HTTP_PROXY=$proxy
  export HTTPS_PROXY=$proxy
}

function contains {
  [ -z "${2##*$1*}" ]
}

function cert-show {
  openssl x509 -noout -issuer -subject -ext basicConstraints,keyUsage,extendedKeyUsage,subjectAltName -in "$1"
}

function cert-dump {
  openssl x509 -noout -text -in "$1"
}

function encrypt {
  openssl enc -e -base64 -aes-128-ctr -nopad -nosalt -k $MASTER_KEY
}

function decrypt {
  openssl enc -d -base64 -aes-128-ctr -nopad -nosalt -k $MASTER_KEY
}

function github-ssh-keys {
  mkdir --mode 0755 "${HOME}/.ssh"
  touch "${HOME}/.ssh/authorized_keys"
  curl https://github.com/$1.keys >> "${HOME}/.ssh/authorized_keys"
}

function _bash_set_key {
  echo "$1" | jq -c ".$2 = \"$3\""
}

function _bash_get_key {
  echo "$1" | jq -r ".$2"
}

function _bash_get_keys {
  echo "$1" | jq -r 'keys[]'
}

function _bash_get_pairs {
  echo "$1" | jq -r 'to_entries[] | [.key, .value] | @tsv'
}

# ---------------------------------
# s - ssh matching name in 
#     inventory

function s {
  ssh -q "$(_inventory | grep -h -m 1 $1 | cut -d' ' -f1)"
}

# extract inventory file removing comment lines

function _inventory {
  sed '/^#/d' "${HOME}/.inventory"
}

function _s_completions
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  if [ -z "$2" ]; then
    COMPREPLY=($(_inventory))
  else
    COMPREPLY=($(_inventory | grep -h $2 | cut -d' ' -f1))
  fi
}

complete -F _s_completions s
