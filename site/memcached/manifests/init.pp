class memcached {
  package { 'memcached': 
    ensure => present,
  }
  file {'/etc/sysconfig/memcached':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0755',
    source => 'puppet:///modules/memcached/memcached',
    notify => Service['memcached'],
  }
  service { 'memcached':
    ensure => running,
    enable => true,
    require => Package['memcached'],
    subscribe => File['/etc/sysconfig/memcached']
  }
}
