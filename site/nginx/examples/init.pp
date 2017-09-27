if $facts['os']['family'] == 'Windows' {
Package {
provider => chocolatey,
}
}
include nginx
