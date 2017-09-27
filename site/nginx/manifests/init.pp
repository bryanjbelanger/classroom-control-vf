class nginx {

  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  $user_service_runs_as = $facts['os']['family'] ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
  }

  package {'nginx':
    ensure => present,
  }
  
  file {'/var/www':
    ensure => 'directory',
  }
  
  file {'/var/www/index.html':
    ensure => 'file',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    #source => 'puppet:///modules/nginx/nginx.conf',
    content => epp(ngnix/nginx.conf.epp, {user_service_runs_as => $user_service_runs_as }),
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  file { '/etc/nginx/conf.d':
    ensure => directory,
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
