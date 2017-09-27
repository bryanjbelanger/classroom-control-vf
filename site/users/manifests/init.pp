# ${modulepath}/site/users/manifests/init.pp

class users {
  users { 'fundamentals':
    ensure => present,
  }
}
