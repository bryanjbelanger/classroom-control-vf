class memcached {

  package {'memcached':
    ensure => present,
  }
  
  file {'/etc/sysconfig/memcached':
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0755'
    source => 'puppet:///modules/memcached/memcached',
    require => Package['memcached'],
  }
  
  service {'memcachedd':
    ensure => 'running',
    enabled => 'true',
    subscribe => File['/etc/sysconfig/memcached'],
  }
  
}
