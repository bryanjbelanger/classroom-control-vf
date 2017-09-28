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
  #ensure package is present
  package { $package:
    ensure => present,
  }

  # create a directory
  file { [ $docroot, "${confdir}/conf.d" ]:
    ensure => 'directory',
  }
  
  # ensure index.html exists
  file { "${docroot}/index.html":
    ensure => 'file',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  # a fuller example, including permissions and ownership
  file { "${confdir}/nginx.conf":
    ensure => 'file',
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
