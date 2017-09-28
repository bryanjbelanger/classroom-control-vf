class profile::base {
# This is where you can declare classes for all nodes.
# Example:
# class { 'my_class': }
$message = lookup('message')
notify { $message: }
}

