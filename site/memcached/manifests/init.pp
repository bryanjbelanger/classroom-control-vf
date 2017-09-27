class memcached{
  package { 'memcached':
    ensure => present,
  }
  file { '/etc/sysconfig/memcached':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet:///modules/memcached/memcached',
    require => Package['memcached'],
    notify => Service['memcached'],
  }
  service { 'memcached':
    ensure => running,
    enable => true,
  }
}
