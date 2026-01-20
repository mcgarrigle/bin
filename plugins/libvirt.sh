# export LIBVIRT_DEFAULT_URI='qemu:///system'

# -------------------------------------
# hypervisor management

# https://docs.virtuozzo.com/libvirt-docs-5.6.0/html/uri.html

export HYPERVISORS='{}'
export HYPERVISOR
export LIBVIRT_DEFAULT_URI

function _list_hypervisors {
  echo "current: $HYPERVISOR => $LIBVIRT_DEFAULT_URI"
  echo
  _bash_get_pairs "${HYPERVISORS}"
}

function _set_hypervisor {
  HYPERVISORS=$(_bash_set_key "${HYPERVISORS}" "$1" "$2")
}

function _default_hypervisor {
  local VAL=$(_bash_get_key "${HYPERVISORS}" "$1")
  if [ "${VAL}" = "null" ]; then
    echo "$1 not known"
  else
    HYPERVISOR="$1"
    LIBVIRT_DEFAULT_URI=${VAL}
  fi
}

function hypervisor {
  if [ -z "$1" ]; then
    _list_hypervisors
  elif [ -z "$2" ]; then
    _default_hypervisor "$1"
    echo "$HYPERVISOR => $LIBVIRT_DEFAULT_URI"
  else
    _set_hypervisor "$1" "$2"
  fi
}

hypervisor "local" "qemu:///system"
_default_hypervisor "local"

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
