
alias pp='puppet apply --verbose ~/site.pp'
alias pd='puppet apply --debug --verbose ~/site.pp'
alias pl='puppet parser validate'

function h {
  hiera -dc /etc/puppetlabs/puppet/hiera.yaml "$1" ::trusted.certname=$2 ::fqdn=$2 environment=production
}
