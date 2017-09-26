# ${modulepath}/site/users/manifests/init.pp
Class user {

user { 'fundamentals':
ensure => present,
}
}
