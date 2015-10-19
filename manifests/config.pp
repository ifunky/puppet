# This is a private class called from init.pp to deal with configuring the applicaiton
#
# @param param1 Required.  Description of param1
# @param param2 Required.  Description of param2
#
class puppet::config {

  #$eyaml_config = [
  #  ':eyaml:',
  #  '   :datadir: ${::codedir}/hieradata/%{::environment}',
  #  '   :pkcs7_private_key: /etc/puppet/secure/keys/private_key.pkcs7.pem',
  #  '   :pkcs7_public_key: /etc/puppet/secure/keys/public_key.pkcs7.pem',
  #]

  class { 'hiera':
    hierarchy => [
      'node/%{::fqdn}',
      '%{::environment}',
      '%{::location}',
      '%{::flavour}',
      'common',
    ],

    backends => [
   #   'eyaml',
      'yaml',
    ],
    hiera_yaml     => "${::settings::confdir}/hiera.yaml",
    datadir        => '${::codedir}/hieradata/%{::environment}', #"/etc/puppet/hieradata/%{::environment}",
   # extra_config   => join($eyaml_config,"\n"),
    merge_behavior => 'deeper',
    require        => [Class['r10k'], Package['hiera-eyaml']],
  }

  ini_setting { 'dns_alt_names':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'master',
    setting => 'dns_alt_names',
    value   => "${fqdn} puppet d",
  }

  ini_setting { 'autosign':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'master',
    setting => 'autosign',
    value   => 'true',
  }

  ini_setting { 'init.config.javaheap':
    ensure  => present,
    path    => '/etc/sysconfig/puppetserver',
    section => '',
    setting => 'JAVA_ARGS',
    value   => "\"-Xms512m -Xmx512m -XX:MaxPermSize=256m\"",
  }

  ini_setting { 'trusted_server_facts':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'trusted_server_facts',
    value   => 'true',
  }

  ini_setting { 'strict_variables':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'strict_variables',
    value   => 'true',
  }

#  Puppet agent settings
  ini_setting { 'pluginsync':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'pluginsync',
    value   => 'false',
  }

  ini_setting { 'environment':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'environment',
    value   => "${environment}",
  }

  ini_setting { 'server':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'server',
    value   => $::fqdn,
  }

  ini_setting { 'autoflush':
    ensure   => present,
    path     => '/etc/puppetlabs/puppet/puppet.conf',
    section  => 'main',
    setting  => 'autoflush',
    value    => 'true',
  }

  ini_setting { 'report':
    ensure   => present,
    path     => '/etc/puppetlabs/puppet/puppet.conf',
    section  => 'main',
    setting  => 'report',
    value    => 'true',
  }

}