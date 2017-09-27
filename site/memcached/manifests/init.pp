class memcached {
  package { 'memcached':
    ensure => present,
  }

  file { '/etc/sysconfig/memcached':
    require = Package['memcached'],
    source = 'puppet:///modules/memcached/memcached.conf',
  }

  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe = File['/etc/sysconfig/memcached']
  }
}
