class profile::base {
  $message = lookup('message')
  notify { $message: }
}
