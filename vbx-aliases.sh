

alias v=vboxmanage
alias vl='vboxmanage list vms'
alias vs='vboxmanage startvm'
alias vr='vboxmanage list runningvms'

function vh {
  vboxmanage controlvm "$1" acpipowerbutton
}

function vd {
  vboxmanage controlvm "$1" poweroff
  sleep 5
  vboxmanage unregistervm "$1" --delete
}
