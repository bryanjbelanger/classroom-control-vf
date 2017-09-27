class memcached {
  package { 'memcached': 
    ensure => present,
  }
  file {'/etc/sysconfig/memcached':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
}
