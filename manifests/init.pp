# ADD A GOOD DESCRIPTION OF WHAT THIS MODULE DOES
#
# @example when declaring the class
#   class { 'puppet' }
#
# @param ensure Required. Must be 'present' or 'absent
# @param example_path Required.  Path to somewhere
#
# @author Dan @ iFunky.net
class puppet (
  $ensure       = undef,
  $example_path = $puppet::params::example_path,
) inherits puppet::params {

  validate_re($ensure,['^(present|absent)$'], 'ERROR: You must specify present or absent')
  validate_absolute_path($example_path)

  if (empty($example_path)){
    fail 'ERROR:: example_path was not specified'
  }

  if (downcase($::osfamily) != 'windows') {
    fail 'ERROR:: This module will only work on Windows.'
  }

  case downcase($::osfamily) {
    'redhat': {
      class { '::puppet::install': } ->
      class { '::puppet::config': } ~>
      class { '::puppet::service': } ->
      Class['::puppet']
    }
    default: {
      fail('ERROR:: This module only works on RHEL based systems.')
    }
  }
}
