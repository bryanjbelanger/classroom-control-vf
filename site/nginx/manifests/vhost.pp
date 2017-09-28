define nginx::vhost (
$port = '80',
$servername = $title,
$docroot = "${nginx::docroot}/vhosts/${title}",
) {
File {
owner => $nginx::owner,
group => $nginx::group,
mode => '0664',
}
# Hack to work around lack of DNS. Not for production use!
host { $title:
ip => $facts['ipaddress'],
}
file { "nginx-vhost-${title}":
ensure => file,
path => "${nginx::confdir}/conf.d/${title}.conf",
content => epp('nginx/vhost.conf.epp',
{
port => $port,
docroot => $docroot,
servername => $servername,
title => $title,
}),
notify => Service['nginx'],
}
file { $docroot:
ensure => directory,
before => File["nginx-vhost-${title}"],
}
file { "${docroot}/index.html":
ensure => file,
content => epp('nginx/index.html.epp',
{
servername => $servername,
}),
}
}
