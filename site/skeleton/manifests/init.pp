class skeleton{
  file { '/etc/skel/.bashrc':
     ensure => file,
     content => "hi",
     }
  node default {
    if [ -f /etc/bashrc ]; then        . /etc/bashrcfi
    include .bashrc
  }
}
