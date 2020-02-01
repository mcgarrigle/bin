
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

# allow de to complete lists of running containers

_de_completions()
{
  COMPREPLY=($(compgen -W "$(docker ps --format '{{.Names}}')" -- "${COMP_WORDS[1]}"))
}

complete -F _de_completions de
