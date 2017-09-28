class nginx (
Optional[String] $root = undef,
Boolean $highperf = true,
) {
case $facts['os']['family'] {
'redhat','debian' : {
$package = 'nginx'
$owner = 'root'
$group = 'root'
# $docroot = '/var/www'
$confdir = '/etc/nginx'
$blockdir = '/etc/nginx/conf.d'
$logdir = '/var/log/nginx'
# this will be used if we don't pass in a value
$default_docroot = '/var/www'
}
'windows' : {
$package = 'nginx-service'
$owner = 'Administrator'
$group = 'Administrators'
# $docroot = 'C:/ProgramData/nginx/html'
$confdir = 'C:/ProgramData/nginx'
$blockdir = 'C:/ProgramData/nginx/conf.d'
$logdir = 'C:/ProgramData/nginx/logs'
# this will be used if we don't pass in a value
$default_docroot = 'C:/ProgramData/nginx/html'
}
default : {
fail("Module ${module_name} is not supported on ${facts['os']['family']}")
}
}
# user the service will run as. Used in the nginx.conf.epp template
$user = $facts['os']['family'] ? {
'redhat' => 'nginx',
'debian' => 'www-data',
'windows' => 'nobody',
}
# if $root isn't set, then fall back to the platform default
$docroot = $root ? {
undef => $default_docroot,
default => $root,
}
File {
owner => $owner,
group => $group,
mode => '0664',
}
package { $package:
ensure => present,
}
# docroot is either passed in or a default value
nginx::vhost { 'default':
docroot => $docroot,
servername => $facts['fqdn'],
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

