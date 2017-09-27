class skeleton {

  file { 'etc/skel':
    ensure => directory,
  }
  
  file {'etc/skel/.bashrc':
    ensure = > file,
    source => 'puppet:///modules/sudo/baschrc',
  }
}
