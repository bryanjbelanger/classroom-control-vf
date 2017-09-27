
class skeleton {
  
  file { '/etc/skel/':
    ensure -> present,
    
  }

  file { '/etc/skel/':
    ensure => present,
    name => '.bashrc'
    source => puppet:///modules/skeleton/.bashrc
  }
}
