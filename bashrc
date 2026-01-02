THIS=$(realpath "$BASH_SOURCE")
HERE=$(dirname "${THIS}")

for APP in bash git prompt docker terraform libvirt; do
  source "${HERE}/plugins/${APP}.sh"
done

export PATH="${HOME}/bin:${PATH}"

# get local environment

export BASHENV="${HOME}/.bashenv"
if [ -f "${BASHENV}" ]; then
  source "${BASHENV}"
fi
