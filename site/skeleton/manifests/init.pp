class skeleton {

  file {'/etc/skel':
    ensure => 'file',
    type => 'directory',
  }
}
