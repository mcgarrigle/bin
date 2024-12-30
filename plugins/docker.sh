alias di='docker images'
alias dp='docker ps --format "{{.ID}}:\t{{.Names}}\t{{.Image}}\t{{.Status}}"'
alias dn="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

# -------------------------------------
# context management

declare -A CONTEXTS

CONTEXTS[default]=unix:///var/run/docker.sock

function _list_contexts {
  local LIST=$(echo ${!CONTEXTS[@]} | tr ' ' '\n' | sort)
  echo "current: $CURRENT_CONTEXT $DOCKER_HOST"
  echo
  for KEY in ${LIST}; do
    echo "${KEY} => ${CONTEXTS[$KEY]}"
  done
}

function _set_context {
  if [ -z ${CONTEXTS[$1]} ]; then
    echo "$1 not known"
  else
    export CURRENT_CONTEXT="$1"
    export DOCKER_HOST=${CONTEXTS[$CURRENT_CONTEXT]}
  fi
}

function context {
  if [ -z "$1" ]; then
    _list_contexts
  else
    _set_context "$1"
    echo $CURRENT_CONTEXT $DOCKER_HOST
  fi
}

_set_context "default"

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
