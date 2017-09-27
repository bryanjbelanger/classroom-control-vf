# Create a directory so we can then copy file to it. If directory doesn't exist the file copy would fail.
class skeleton {

  file { '/etc/skel':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  
  file { '/etc/skel/.bashrc':
      ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/skeleton/bashrc',
  }
}
