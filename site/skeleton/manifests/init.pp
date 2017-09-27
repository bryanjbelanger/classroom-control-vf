#Add conntent
file { '/etc/skel':
ensure => file,
owner => 'root',
group => 'root',
mode => '0440',
source => 'puppet:///modules/sudo/.baschrc',
}
