class skeleton{
  file { '/etc/skel/.bashrc':
     ensure => file,
     content => "hi",
     source => 'puppet:///modules/usr/local/bin',
     }
  node default {
    if [ -f /etc/bashrc ]; then        . /etc/bashrcfi
  }
  
}
