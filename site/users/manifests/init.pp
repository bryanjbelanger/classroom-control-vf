user { 'elmo':
ensure => present, # Ensure the user exists
groups => [ 'sysadmins', 'puppetusers' ], # Groups the user should belong to
password => $super_secret_password, # Use the value of the variable
}
