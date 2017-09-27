# Create a directory so we can then copy file to it. If directory doesn't exist the file copy would fail.
class skeleton {

  file { 'etc/skel':
    ensure => directory,
  }
  
  file {'etc/skel/.bashrc':
    ensure = > file,
    source => 'puppet:///modules/sudo/baschrc',
  }
}
