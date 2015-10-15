# This is a private class called from init.pp to deal with the servce aspect of the application
#
# @param param1 Required.  Description of param1
# @param param2 Required.  Description of param2
#
class puppet::service {

  #if ! defined(Service['puppetserver') {
  #  service { $puppet_service_name:
  #    ensure => running,
  #  }
  #}

  service { 'puppetserver':
    ensure => running,
  }

}