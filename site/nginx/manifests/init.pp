class nginx {
  #ensure package is present
  package { 'nginx':
    ensure => present,
  }
  # create a directory
  file { '/var/www':
    ensure => 'directory',
  }

  # a fuller example, including permissions and ownership
  file { '/etc/nginx/nginx.conf':
    ensure => 'file',
    source => 'puppet:///modules/nginx/nginx.conf'
  }
  
  # a fuller example, including permissions and ownership
  file { '/etc/nginx/conf.d/default.conf':
    ensure => 'file',
    source => 'puppet:///modules/nginx/nginx.conf'
  }
    # a fuller example, including permissions and ownership
  file { '/etc/nginx/conf.d/default.conf':
    ensure => 'file',
    source => 'puppet:///modules/nginx/index.html'
  }
  file { '/etc/nginx/conf.d':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
