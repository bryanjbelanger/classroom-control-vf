class nginx (
Optional[String] $root = undef,
Boolean $highperf = true,
) {
  case $facts['os']['family']{
    'redhat','debian' :{
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      #$docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
      
      # this will be used if we don't pass in a value
      $default_docroot = '/var/www'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      #$docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $logdir = 'C:/ProgramData/nginx/logs'

      # this will be used if we don't pass in a value
      $default_docroot = 'C:/ProgramData/nginx/html'
    }
    default : {
      fail("Module ${module_name} is not supported on ${facts['os']['family']}")
    }
  }
  
  # user the service will run as. Used in the nginx.conf.epp template
  $user = $facts['os']['family'] ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  }

  # if $root isn't set, then fall back to the platform default
  $docroot = $root ? {
    undef => $default_docroot,
    default => $root,
  }
  
  File {
    owner => $owner,
    group => $group,
    mode => '0775',
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
  file { '/var/www/index.html':
    ensure => 'file',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  # a fuller example, including permissions and ownership
  file { "${confdir}/nginx.conf":
    ensure => 'file',
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
