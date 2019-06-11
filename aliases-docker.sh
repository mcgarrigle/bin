
alias di='docker images'
alias dp='docker ps'
alias dn="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

function dr {
  image=$1; shift
  docker run -it --rm --mount type=bind,source=$HOME,target=/root "$image" $@
}

function de {
  container="$2"
  docker exec -it $1 ${container:=bash}
}
