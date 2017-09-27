class skeleton{
  file { '/etc/skel/.bashrc':
     ensure => file,
     source => 'puppet:///modules/skeleton/bashrc',
     }
  file { 'etc/skel/
    ensure => directory,
    }
 
}
