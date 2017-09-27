
class nginx {
  package { 'nginx': 
    ensure => present,
  }
  File {
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  file {['/var/www','/etc/nginx','/etc/nginx/conf.d']:
    ensure => directory,
  }
  file { ['/var/www/index.html','/etc/nginx/nginx.conf','/etc/nginx/conf.d/default.conf']:
    ensure => file,
  }
  file {'/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',
  }
  file { '/etc/nginx/nginx.conf':
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  file { '/etc/nginx/conf.d':
    require => Package['nginx'],
    notify => Service['nginx'],
  }  
  file { '/etc/nginx/conf.d/default.conf':
    source => 'puppet:///modules/nginx/default.conf',
    notify => Service['nginx'],
    require => Package['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
