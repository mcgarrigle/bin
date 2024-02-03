# export LIBVIRT_DEFAULT_URI='qemu:///system'

# -------------------------------------
# hypervisor management

# https://docs.virtuozzo.com/libvirt-docs-5.6.0/html/uri.html

function hypervisor {
  export LIBVIRT_DEFAULT_URI="$1"
}

hypervisor "default"

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
