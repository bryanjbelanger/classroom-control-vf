class profile::base {
  #notify { "Hello, my name is ${::hostname}": }
  notify { lookup($message): }
}
