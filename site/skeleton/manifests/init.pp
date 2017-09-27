class skeleton {

  file {'/etc/skel':
    ensure => 'directory',
    type => 'directory',
  }
  
  file {'/etc/skel/.bashrc':
    ensure => file,
    source => 'puppet:///modules/skeleton/files/.bashrc',
  }
}
