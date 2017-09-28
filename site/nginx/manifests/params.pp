class nginx::params {
  case $facts['os']['family'] {
    'redhat','debian' : {
        $package = 'nginx'
        $owner = 'root'
        $group = 'root'
        $docroot = '/var/www'
        $confdir = '/etc/nginx'
        $blockdir = '/etc/nginx/conf.d'
        $logdir = '/var/log/nginx'
    }
  'windows' : {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $blockdir = 'C:/ProgramData/nginx/conf.d'
      $logdir = 'C:/ProgramData/nginx/logs'
  }
  default : {
    fail("Module ${module_name} is not supported on ${facts['os']['family']}")
  }
}

# Default to high-performance mode
$highperf = true

$user = $facts['os']['family'] ? {
   'redhat' => 'nginx',
  'debian' => 'www-data',
  'windows' => 'nobody',
  }
}

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
