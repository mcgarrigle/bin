
alias r='rspec --format documentation'

function rs {
  rspec --format documentation spec/${1}_spec.rb
}
