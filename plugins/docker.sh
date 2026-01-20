alias di='docker images'
alias dp='docker ps --format "{{.ID}}:\t{{.Names}}\t{{.Image}}\t{{.Status}}"'
alias dn="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

# -------------------------------------
# docker context management
#
# bugs around local context causing loops
# forces use of DOCKER_HOST instead as it
# is safe in all circumstances

export CONTEXTS="{}"
export CONTEXT
export DOCKER_HOST

function _list_contexts {
  echo "current: $CONTEXT $DOCKER_HOST"
  echo
  local LIST=$(_bash_get_pairs "${CONTEXTS}")
  echo "${LIST}"
}

function _default_context {
  local VAL=$(_bash_get_key "${CONTEXTS}" "$1")
  if [ "${VAL}" = "null" ]; then
    echo "$1 not known"
  else
    CONTEXT="$1"
    DOCKER_HOST="${VAL}"
  fi
}

function _set_context {
  CONTEXTS=$(_bash_set_key "${CONTEXTS}" "$1" "$2")
}

function context {
  if [[ $# == 0 ]]; then
    _list_contexts
  elif [[ $# == 1 ]]; then
    _default_context "$1"
    echo $CONTEXT $DOCKER_HOST
  else
    _set_context "$1" "$2"
  fi
}

context local unix:///var/run/docker.sock  
_default_context "local"

# -------------------------------------

function _branch {
  if [ -d .git ]; then
    git rev-parse --abbrev-ref HEAD
  fi
}

function _project_name {
  if [ -f compose-project ]; then
    cat compose-project
    return
  fi
  if [ -n "${COMPOSE_PROJECT_NAME}" ]; then
    echo "${COMPOSE_PROJECT_NAME}"
    return
  fi
  _branch
}

alias dc=context

function dr {
  image=$1; shift
  docker run -it -P --rm --mount type=bind,source=$HOME,target=/root "$image" $@
}

function db {
  image=$1; shift
  docker run -d -P --rm --mount type=bind,source=$HOME,target=/root "$image" $@
}

function de {
  cmd="$2"
  docker exec -it $1 ${cmd:=bash}
}

# ---------------------------------------------------
# allow dr/db to complete lists of images
#

_dr_completions()
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  COMPREPLY=($(compgen -W "$(docker images --format '{{.Repository}}')" -- "${COMP_WORDS[1]}"))
}

complete -F _dr_completions dr
complete -F _dr_completions db

# ---------------------------------------------------
# allow de to complete lists of running containers
#

_de_completions()
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  COMPREPLY=($(compgen -W "$(docker ps --format '{{.Names}}')" -- "${COMP_WORDS[1]}"))
}

complete -F _de_completions de
