
export OS=$(uname)

if [[ "$OS" == "Darwin" ]]; then
  export PATH=$PATH:/Applications/VirtualBox.app/Contents/MacOS
fi

if [[ "$OS" == "MINGW64_NT-6.3" ]]; then
  export PATH=$PATH:/c/Program\ Files/Oracle/VirtualBox  
fi

alias v='vboxmanage'
alias vl='vm-list'
alias va='vboxmanage list vms'
alias vr='vboxmanage list runningvms'

function vs {
  vboxmanage startvm "$1" --type headless
}

function vh {
  vboxmanage controlvm "$1" acpipowerbutton
}

function vx {
  vboxmanage controlvm "$1" poweroff
}

function vd {
  read -p "Are you sure? " -r
  echo
  if [[ $REPLY == 'yes' ]]; then
    vboxmanage controlvm "$1" poweroff
    sleep 5
    vboxmanage unregistervm "$1" --delete
  fi
}
