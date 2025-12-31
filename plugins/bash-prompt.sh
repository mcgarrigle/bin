SOH="\001"
STX="\002"

function colour {
  echo -e "${SOH}\e[$1m${STX}"
}

RESET="$(colour 39)"
BLACK="$(colour 30)"
RED="$(colour 31)"
GREEN="$(colour 32)"
YELLOW="$(colour 33)"
BLUE="$(colour 34)"
MAGENTA="$(colour 35)"
CYAN="$(colour 36)"
LIGHT_GRAY="$(colour 37)"
DARK_GRAY="$(colour 90)"
LIGHT_RED="$(colour 91)"
LIGHT_GREEN="$(colour 92)"
LIGHT_YELLOW="$(colour 93)"
LIGHT_BLUE="$(colour 94)"
LIGHT_MAGENTA="$(colour 95)"
LIGHT_CYAN="$(colour 96)"
WHITE="$(colour 97)"

function utf8 {
  printf "%b" "\u$1"
}

BOX_DOWN_LEFT="$(utf8 250C)"
BOX_UP_RIGHT="$(utf8 2514)"
BOX_HORIZONTAL="$(utf8 2500)"
BOX_VERTICAL="$(utf8 2502)"
BOX_LEFT_TEE="$(utf8 251C)"

. /etc/os-release

function _distro_icon {
  case "${ID}" in

    "alpine")
      echo -n ${CYAN}$(utf8 f300)
      ;;

    "raspbian")
      echo -n ${RED}$(utf8 f315)
      ;;

    "rocky")
      echo -n ${GREEN}$(utf8 f32b)
      ;;

    *)
      echo -n ${YELLOW}$(utf8 f31a)
      ;;

  esac
  echo ${RESET}
}

DISTRO_ICON=$(_distro_icon)

function _prompt_string {
  BRANCH="$(__git_branch)"
  echo -n "${BOX_DOWN_LEFT}${BOX_HORIZONTAL} "
  echo -n "${GREEN}\\u${RESET} "
  echo -n "[${DISTRO_ICON} \\h] "
  echo -n "\\T "
  echo -n "${YELLOW}\\w "
  echo -n "${CYAN}${BRANCH}${RESET}"
  echo
  echo -n "${BOX_VERTICAL}"
  echo
  echo -n "${BOX_UP_RIGHT}${BOX_HORIZONTAL} "
  echo -n "\\$ "  
}
        
PROMPT_COMMAND='PS1=$(_prompt_string)'
