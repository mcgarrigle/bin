THIS=$(realpath "${BASH_SOURCE}")
HERE=$(dirname "${THIS}")

function path {
  if [ "$1" == "add" ]; then
    export PATH=$2:$PATH
  else
    echo $PATH | tr ':' '\n'
  fi
}

function include {
  test -f "$1" && source "$1"
}

path add "${HOME}/bin"

# get local environment

export BASHENV="${HOME}/.bashenv"
include "${BASHENV}"

for APP in bash git prompt docker terraform libvirt; do
  source "${HERE}/plugins/${APP}.sh"
done
