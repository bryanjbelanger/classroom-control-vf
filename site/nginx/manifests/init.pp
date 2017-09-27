#Add content

class nginx {

  file { 'document':
    ensure => directory,
  }
  
  file {'document/index.html':
    ensure = > file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file {'document/default.conf':
    ensure = > file,
    source => 'puppet:///modules/nginx/default.conf',
  }
 
   file {'document/nginx.conf':
    ensure = > file,
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
}
