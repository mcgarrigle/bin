
function _tf {
  op="$1"
  shift
  terraform $op $@
}

function tfp {
  _tf plan $*
}

function tfa {
  _tf apply $* --auto-approve
}

function tfs {
  _tf show
}
