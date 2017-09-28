class profile::base {
  #notify { "Hello, my name is ${::hostname}": }
  $message = lookup('message')
  notify { $message: }
}
