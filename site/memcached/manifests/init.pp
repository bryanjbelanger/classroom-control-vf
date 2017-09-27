class memcached{
  package { 'memcached':
    ensure => present,
  }
  file { '/etc/sysconfig/memcached/memcached':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet:///modules/memcached',
    require => Package['memcached'],
    notify => Service['memcached'],
  }
  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}
