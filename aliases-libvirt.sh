# ---------------------------------------------------
# allow console to complete lists of running domains
#

console()
{
  virsh console --domain "$1"
}

_console_completions()
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  COMPREPLY=($(compgen -W "$(virsh list --name)" -- "${COMP_WORDS[1]}"))
}

complete -F _console_completions console
