class nginx {
  #ensure package is present
  package { 'nginx':
    ensure => present,
  }
  # create a directory
  file { '/var/www':
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  # ensure index.html exists
  file { '/var/www/index.html':
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/index.html',
  }
  # a fuller example, including permissions and ownership
  file { '/etc/nginx/nginx.conf':
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
    file { '/etc/nginx/conf.d':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  # a fuller example, including permissions and ownership
  file { '/etc/nginx/conf.d/default.conf':
    owner => 'root',
    group => 'root',
    mode => '0664',
    ensure => 'file',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
