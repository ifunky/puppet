# ADD A GOOD DESCRIPTION OF WHAT THIS MODULE DOES
#
# @example when declaring the class
#   class { 'puppet' }
#
# @param ensure Required. Must be 'present' or 'absent
# @param example_path Required.  Path to somewhere
#
# @author Dan @ iFunky.net
class puppet ()  inherits puppet::params {

  #validate_re($ensure,['^(present|absent)$'], 'ERROR: You must specify present or absent')
  #validate_absolute_path($example_path)

  #if (empty($example_path)){
  #  fail 'ERROR:: example_path was not specified'
  #}

  case downcase($::osfamily) {
    'redhat': {
      class { '::puppet::install': } ->
      class { '::puppet::config': } ~>
      class { '::puppet::service': } ->
      Class['::puppet']

      include ::puppet::puppetdb::install
    }
    default: {
      fail('ERROR:: This module only works on RHEL based systems at the moment.')
    }
  }
}
