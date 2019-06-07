
alias di='docker images'
alias dp='docker ps'
alias dn="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

function dr {
  image=$1; shift
  docker run -it --rm --mount type=bind,source=/root,target=/root "$image" $@
}
