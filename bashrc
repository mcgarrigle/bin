THIS=$(realpath "${BASH_SOURCE}")
HERE=$(dirname "${THIS}")

function plugin {
  source "${HERE}/plugins/$1.sh"
}

plugin bash

path add "${HOME}/bin"

for APP in git docker libvirt terraform; do
  plugin "${APP}"
done

# get local environment

export BASHENV="${HOME}/.bashenv"
include "${BASHENV}"

plugin prompt
