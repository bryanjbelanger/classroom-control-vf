class users::admins {
  users::managed_user { 'mike': }
  users::managed_user { 'sean':
  group => 'staff',
}
  users::managed_user { 'kevin':
  group => 'staff',
  }
  group { 'staff':
   ensure => present,
  }
}
