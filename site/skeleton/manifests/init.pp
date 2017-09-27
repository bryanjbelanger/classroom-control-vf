class skeleton {
  # create a directory
  file { '/etc/skel':
    ensure => 'directory',
  }

  # a fuller example, including permissions and ownership
  file { '/etc/skel/.bashrc':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
    source => 'puppet:///modules/skeleton/.bashrc'
  }
}
