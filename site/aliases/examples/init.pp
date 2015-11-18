user { 'admin':
  ensure => present,
}

class { 'aliases':
  admin   => 'admin',
  require => User['admin'],
}

