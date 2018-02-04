
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

# vbox start

function vs {
  vboxmanage startvm "$1" --type headless
}

# vbox halt

function vh {
  vboxmanage controlvm "$1" acpipowerbutton
}

# vbox exit

function vx {
  vboxmanage controlvm "$1" poweroff
}

# vbox console

function vc {
  vboxmanage startvm "$1" --type separate
}

# vbox delete

function vd {
  read -p "Are you sure? " -r
  echo
  if [[ $REPLY == 'yes' ]]; then
    vboxmanage controlvm "$1" poweroff
    sleep 5
    vboxmanage unregistervm "$1" --delete
  else
    echo "delete aborted - answer 'yes' to confirm"
  fi
}

# vbox view

function vv {
  vboxmanage showvminfo "$1" --machinereadable
}

# vbox network restart

function vnr {
  vboxmanage natnetwork stop --netname "$1"
  vboxmanage natnetwork start --netname "$1"
}

function ssh {
  if [ -e ssh.config ]; then
    env ssh -F ssh.config $@
  else
    env ssh $@
  fi
}

function scp {
  if [ -e ssh.config ]; then
    env scp -F ssh.config $@
  else
    env scp $@
  fi
}

function ssh-copy-keys {
  host="$1"
  pkey="$(cat ~/.ssh/id_rsa.pub)"
  ssh $host "mkdir -p -m 700 ~/.ssh; echo '$pkey' > ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys"
  scp -p ~/.ssh/id_rsa* $host:~/.ssh
}

