## site.pp ##

# Mike commit

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Disable filebucket by default for all File resources:
File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  #include ::users
  #include role::classroom
  #include ::skeleton
  include users::admins
  #notify { "Hello, my name name is ${::hostname}": }
  #file { '/etc/motd':
  #  ensure => file,
  #  owner => 'root',
  #  group => 'root',
  #  mode => '0644',
  #  content => "Today I learned what it means to be a puppet.\n",
  #}
  exec { 'cowsay':
    command => "cowsay 'Welcome to ${::fqdn}!' > /etc/motb",
    path => '/usr/local/bin',
    creates => '/etc/motd',
  }
  if $facts['is_virtual'] == 'true' {
    $vmname = capitalize($::virtual)
    notify { "This is a ${vmname} virtual machine.": }
  }
}
