class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  
  #ensure package is present
  package { 'nginx':
    ensure => present,
  }
  
  # create a directory
  file { [ '/var/www', '/etc/nginx/conf.d' ]:
    ensure => 'directory',
  }
  
  # ensure index.html exists
  file { '/var/www/index.html':
    ensure => 'file',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  # a fuller example, including permissions and ownership
  file { '/etc/nginx/nginx.conf':
    ensure => 'file',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  # a fuller example, including permissions and ownership
  file { '/etc/nginx/conf.d/default.conf':
    ensure => 'file',
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
