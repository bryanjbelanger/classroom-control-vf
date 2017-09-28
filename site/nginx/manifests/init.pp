class nginx (
String $package = $nginx::params::package,
String $owner = $nginx::params::owner,
String $group = $nginx::params::group,
String $docroot = $nginx::params::docroot,
String $confdir = $nginx::params::confdir,
String $blockdir = $nginx::params::blockdir,
String $logdir = $nginx::params::logdir,
String $user = $nginx::params::user,
Boolean $highperf = $nginx::params::highperf,
) inherits nginx::params {
File {
owner => $owner,
group => $group,
mode => '0664',
}
package { $package:
ensure => present,
}

file { "${docroot}/vhosts":
ensure => directory,
}
file { "${confdir}/nginx.conf":
ensure => file,
content => epp('nginx/nginx.conf.epp',
{
user => $user,
logdir => $logdir,
confdir => $confdir,
blockdir => $blockdir,
highperf => $highperf,
}),
require => Package[$package],
notify => Service['nginx'],
}
service { 'nginx':
ensure => running,
enable => true,
}
}
