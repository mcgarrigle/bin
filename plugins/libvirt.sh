# export LIBVIRT_DEFAULT_URI='qemu:///system'

# -------------------------------------
# hypervisor management

# https://docs.virtuozzo.com/libvirt-docs-5.6.0/html/uri.html

declare -A HYPERVISORS

HYPERVISORS[default]="qemu:///system"
# HYPERVISORS[smol]="qemu+ssh://${USER}@smol.mac.wales/system?keyfile=${HOME}/.ssh/id_rsa&sshauth=privkey&no_verify=1"
# HYPERVISORS[wee]="qemu+ssh://${USER}@wee.mac.wales/system?keyfile=${HOME}/.ssh/id_rsa&sshauth=privkey&no_verify=1"

function _list_hypervisors {
  local LIST=$(echo ${!HYPERVISORS[@]} | tr ' ' '\n' | sort)
  echo "current: $HYPERVISOR => $LIBVIRT_DEFAULT_URI"
  echo
  for KEY in ${LIST}; do
    echo "${KEY} => ${HYPERVISORS[$KEY]}"
  done
}

function _set_hypervisor {
  if [ -z ${HYPERVISORS[$1]} ]; then
    echo "$1 not known"
  else
    export HYPERVISOR="$1"
    export LIBVIRT_DEFAULT_URI=${HYPERVISORS[$1]}
  fi
}

function hypervisor {
  if [ -z "$1" ]; then
    _list_hypervisors
  else
    _set_hypervisor "$1"
    echo "$HYPERVISOR => $LIBVIRT_DEFAULT_URI"
  fi
}

_set_hypervisor "default"

# -------------------------------------

console()
{
  virsh console --domain "$1"
}

# ---------------------------------------------------
# allow console to complete lists of running domains
#

_console_completions()
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  COMPREPLY=($(compgen -W "$(virsh list --name)" -- "${COMP_WORDS[1]}"))
}

complete -F _console_completions console
