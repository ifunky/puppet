# This is a private class called from init.pp to deal with the servce aspect of the application
#
# @param param1 Required.  Description of param1
# @param param2 Required.  Description of param2
#
class puppet::service {

  #service { 'puppetserver':
  #  ensure    => running,
  #  require   => Class[puppet::config],
  #  subscribe => [
  #    Class[puppet::config],
  #  ]
  #}

  # Due to the puppetserver service taking a long time to start and the service resource not supporting timeout
  exec { 'restart puppetserver':
    command   => "/bin/systemctl restart  puppetserver",
    cwd       => "${::settings::confdir}",
    require   => Class[puppet::config],
    subscribe => [ Class[puppet::config] ],
    before    => Service['puppetdb'],
    timeout   => 300
  }

}