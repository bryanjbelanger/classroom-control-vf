class memcached {
  package { 'memcached':
    ensure => present,
  }
  
  file { '/etc/sysconfig/memcached':
    ensure => file,
    source => 'puppet:///modules/memcached/memcached',
    require => Package['memcached'],
  }
  
  service { 'memcached':
    ensure => running,
    enabler => true,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}
