# ${modulepath}/site/users/manifests/init.pp

class user {
  user { 'fundamentals':
    ensure => present,
  }
}
