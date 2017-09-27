
class nginx {
  file {'/var/www':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  file { '/var/www/index.html':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0755',
    source => 'puppet:///modules/nginx/index.html',
  }
  file {' /etc/nginx':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  file { ' /etc/nginx/nginx.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0755',
    source => 'puppet:///modules/nginx/nginx.conf',
  }  
}
