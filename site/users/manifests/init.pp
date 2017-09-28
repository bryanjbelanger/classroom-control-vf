class users {
  user { 'fundamentals':
    ensure => present, # Ensure the user exists
  }
}
