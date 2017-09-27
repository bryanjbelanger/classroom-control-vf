package { 'memcached':
ensure => present,
before => File['/etc/sysconfig/memcached.conf'],
}

file { '/etc/sysconfig/memcached.conf':
ensure => file,
owner => 'root',
group => 'root',
mode => '0644',
source => 'puppet:///modules/memcached/memcached.conf',
notify => Service['memcached'],
}
service { 'memcached':
ensure => running,
enable => true,
}
