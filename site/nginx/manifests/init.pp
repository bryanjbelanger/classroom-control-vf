class nginx(
  Optional[String] $root = undef,
) inherits nginx::params {
 
  # if $root isn't set, then fall back to the platform default
  $docroot = $root ? {
    undef   => $default_docroot,
    default => $root,
  }
  # user the service will run as. Used in the nginx.conf.epp template
  $user = $facts['os']['family'] ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }
  File {
    owner => $owner,
    group => $group,
    mode  => '0664',
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
    ensure  => file,
    content => epp('nginx/nginx.conf.epp',
      {
        user    => $user,
        confdir => $confdir,
        logdir  => $logdir,
      }
    ),
    notify  => Service['nginx'],
  }
  file { "${confdir}/conf.d/default.conf":
    ensure  => file,
    content => epp('nginx/default.conf.epp',
      {
        docroot => $docroot,
      }
    ),
    notify  => Service['nginx'],
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
