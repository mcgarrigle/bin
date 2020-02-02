
alias dc='docker-compose'
alias di='docker images'
alias dp='docker ps --format "{{.ID}}:\t{{.Names}}\t{{.Image}}\t{{.Status}}"'
alias dn="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

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
