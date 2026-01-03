SOH="\001"
STX="\002"

function colour {
  if [ "${_SHELL}" = "zsh" ]; then
    echo -e "%F{$1}"
  else
    echo -e "${SOH}\e[$2m${STX}"
  fi
}

function _define_colours {
  RESET="$(colour reset 39)"
  BLACK="$(colour black 30)"
  RED="$(colour red 31)"
  GREEN="$(colour green 32)"
  YELLOW="$(colour yellow 33)"
  BLUE="$(colour blue 34)"
  MAGENTA="$(colour magenta 35)"
  CYAN="$(colour cyan 36)"
  WHITE="$(colour white 37)"
}

function utf8 {
  printf "%b" "\u$1"
}

BOX_DOWN_LEFT="$(utf8 250C)"
BOX_UP_RIGHT="$(utf8 2514)"
BOX_HORIZONTAL="$(utf8 2500)"
BOX_VERTICAL="$(utf8 2502)"
BOX_LEFT_TEE="$(utf8 251C)"

function _os_name {
  local KERNEL=$(uname)

  if [ "${KERNEL}" = "Linux" ]; then
    . /etc/os-release
    echo "${ID}"
  else
    echo ${KERNEL}
  fi
}

function _shell_name {
  if [ -n "${SHELL}" ]; then
    echo $(basename "${SHELL}")
  else
    echo "bash"
  fi
}

function _distro_icon {
  case "$1" in
    alpine)   echo -n ${CYAN}$(utf8 f300) ;;
    raspbian) echo -n ${RED}$(utf8 f315) ;;
    rocky)    echo -n ${GREEN}$(utf8 f32b) ;;
    Darwin)   echo -n ${WHITE}$(utf8 f302) ;;
    *)        echo -n ${YELLOW}$(utf8 f31a) ;;
  esac
  echo -n ${RESET}
}

_SHELL=$(_shell_name)
_define_colours

OS=$(_os_name)
DISTRO_ICON=$(_distro_icon "${OS}")

function _bash_prompt_string {
  BRANCH="$(__git_branch)"
  echo -n "${BOX_DOWN_LEFT}${BOX_HORIZONTAL} "
  echo -n "${GREEN}\\u${RESET} "
  echo -n "[${DISTRO_ICON} \\h] "
  echo -n "\\T "
  echo -n "${YELLOW}\\w "
  echo -n "${CYAN}${BRANCH}${RESET}"
  echo -n "\\r\\n"
  echo -n "${BOX_VERTICAL}"
  echo -n "\\r\\n"
  echo -n "${BOX_UP_RIGHT}${BOX_HORIZONTAL} "
  echo -n "\\$ "  
}

function _zsh_prompt_string {
  BRANCH="$(__git_branch)"
  echo -n "${BOX_DOWN_LEFT}${BOX_HORIZONTAL} "
  echo -n "%F{green}%n%F{reset} "
  echo -n "[${DISTRO_ICON} %m] "
  echo -n "%T "
  echo -n "%F{yellow}%~ "
  echo -n "%F{cyan}${BRANCH}%F{reset}"
  echo -n "\\r\\n"
  echo -n "${BOX_VERTICAL}"
  echo -n "\\r\\n"
  echo -n "${BOX_UP_RIGHT}${BOX_HORIZONTAL} "
  echo -n "%# "  
}
        
PROMPT_COMMAND='PS1=$(_bash_prompt_string)'

function precmd {
  PROMPT=$(_zsh_prompt_string)
}
