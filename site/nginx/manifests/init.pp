class nignx {
  ensure => nignx,
  ensure => '/site/nginx/files/index.html',
  ensure => 'puppet://module/site/nginx',
  
}
