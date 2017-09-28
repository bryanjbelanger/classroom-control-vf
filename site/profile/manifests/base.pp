class profile::base {
  $message = lookup('message')
  notify { "Hello, my name is ${::hostname}": }
  notify { $message: }
}
