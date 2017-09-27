class skeleton{
  file { '/etc/skel/.bashrc':
     ensure => file,
     content => "hi",
     }
}
