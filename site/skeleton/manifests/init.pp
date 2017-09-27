class skeleton{
  file { '/etc/skel/.bashrc':
     ensure => file,
     source => 'puppet:///modules/usr/local/bin',
     }
  file { 'etc/skel/
    ensure => directory,
    }
 
}
