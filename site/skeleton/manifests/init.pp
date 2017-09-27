class skeleton {

  file {'/etc/skel':
    ensure => 'directory',
    type => 'directory',
  }
}
