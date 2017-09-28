class nginx (
String $package = $nginx::params::package,
String $owner = $nginx::params::owner,
String $group = $nginx::params::group,
String $docroot = $nginx::params::docroot,
String $confdir = $nginx::params::confdir,
String $blockdir = $nginx::params::blockdir,
String $logdir = $nginx::params::logdir,
String $user = $nginx::params::user,
Boolean $highperf = $nginx::params::highperf,
) inherits nginx::params {

File {
  owner => $owner,
  group => $group,
  mode => '0664',
  }
  package { $package:
  ensure => present,
  }
  file { [ $docroot, "${confdir}/conf.d" ]:
  ensure => directory,
  }
  file { "${docroot}/index.html":
  ensure => file,
  source => 'puppet:///modules/nginx/index.html',
  }
  file { "${confdir}/nginx.conf":
  ensure => file,
  content => epp('nginx/nginx.conf.epp',
  {
  user => $user,
  confdir => $confdir,
    logdir => $logdir,
  }),
  notify => Service['nginx'],
    }
  file { "${confdir}/conf.d/default.conf":
  ensure => file,
  content => epp('nginx/default.conf.epp',
    {
  docroot => $docroot,
  }),
  notify => Service['nginx'],
  }
  service { 'nginx':
  ensure => running,
  enable => true,
  }
    }

  # if $root isn't set, then fall back to the platform default
  $docroot = $root ? {
  undef => $default_docroot,
  default => $root,
  }
  File {
  owner => $owner,
  group => $group,
  mode => '0664',
}
  package { $package:
  ensure => present,
}
# docroot is either passed in or a default value
  nginx::vhost { 'default':
  docroot => $docroot,
  servername => $facts['fqdn'],
  }
  file { "${docroot}/vhosts":
  ensure => directory,
  }
  file { "${confdir}/nginx.conf":
  ensure => file,
  content => epp('nginx/nginx.conf.epp',
    {
    user => $user,
    logdir => $logdir,
    confdir => $confdir,
    blockdir => $blockdir,
    highperf => $highperf,
  }),
  require => Package[$package],
  notify => Service['nginx'],
  }
  service { 'nginx':
  ensure => running,
  enable => true,
  }
 }
