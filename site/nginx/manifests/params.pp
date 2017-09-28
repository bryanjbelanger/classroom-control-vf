class nginx::params {
case $facts['os']['family'] {
'RedHat','debian' : {
$package = 'nginx'
$owner = 'root'
$group = 'root'
$docroot = '/var/www'
$confdir = '/etc/nginx'
$blockdir = '/etc/nginx/conf.d'
$logdir = '/var/log/nginx'
}
'windows' : {
$package = 'nginx-service'
$owner = 'Administrator'
$group = 'Administrators'
$docroot = 'C:/ProgramData/nginx/html'
$confdir = 'C:/ProgramData/nginx'
$blockdir = 'C:/ProgramData/nginx/conf.d'
$logdir = 'C:/ProgramData/nginx/logs'
}
default : {
fail("Module ${module_name} is not supported on ${facts['os']['family']}")
}
}
# Default to high-performance mode
$highperf = true
$user = $facts['os']['family'] ? {
'RedHat' => 'nginx',
'Debian' => 'www-data',
'windows' => 'nobody',
}
}
