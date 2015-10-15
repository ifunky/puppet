# This manifest installs PuppetDB with basic settings
#
# @listen_address Required.  HTTP listen address, defaults to all IPs
#
class puppet::puppetdb::install (
  $listen_address = '0.0.0.0')
{

  package { 'deltarpm':
    ensure   => 'installed',
    provider => 'yum',
  }

  class { 'puppetdb':
    listen_address => $listen_address,
    require        => Package['deltarpm']
  }

  class { 'puppetdb::master::config':
    require => Class['puppetdb']
  }

}