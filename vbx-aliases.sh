
alias v='vboxmanage'
alias vs='vboxmanage startvm'
alias vl='vm-list'
alias va='vboxmanage list vms'
alias vr='vboxmanage list runningvms'

function vs {
  vboxmanage startvm "$1" --type headless
}

function vh {
  vboxmanage controlvm "$1" acpipowerbutton
}

function vd {
  vboxmanage controlvm "$1" poweroff
  sleep 5
  vboxmanage unregistervm "$1" --delete
}
