THIS=$(realpath "${BASH_SOURCE}")
HERE=$(dirname "${THIS}")

function include {
  test -f "$1" && source "$1"
}

for APP in bash git prompt docker terraform libvirt; do
  source "${HERE}/plugins/${APP}.sh"
done

export PATH="${HOME}/bin:${PATH}"

# get local environment

export BASHENV="${HOME}/.bashenv"
include "${BASHENV}"
