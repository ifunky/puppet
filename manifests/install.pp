# This is a private class called from init.pp to deal with installing.
#
# @param param1 Required.  Description of param1
# @param param2 Required.  Description of param2
#
class puppet::install {

  package { 'deep_merge':
    ensure   => 'installed',
    provider => 'gem',
  }

  package {'highline':
    ensure   => installed,
    provider => 'gem',
  }

  package { 'hiera-eyaml':
    ensure   => installed,
    provider => 'gem',
    require  => Package['highline']
  }

  package {'puppetserver':
    ensure => 'installed',
  }

  notify {"${::settings::environmentpath }":}
  notify {"${::settings::codedir}":}

  notify { "git repo: ${puppet::control_repo_url}  ": }

  class { 'r10k':
    version     => '1.5.1',
    configfile  => '/etc/r10k.yaml',
    sources => {
      'puppet' => {
        'remote'  => $puppet::control_repo_url,
        'basedir' => '/etc/puppetlabs/code/environments', #"${::settings::environmentpath }",
        'prefix'  => false,
      },
      'hiera' => {
        'remote'  => $puppet::hiera_repo_url,
        'basedir' => "${::settings::codedir}/environments",
        'prefix'  => false,
      },
    },
    manage_modulepath => false,
    require  => Package["puppetserver"]
    #,    notify   => Service["puppetserver"]
  }

}