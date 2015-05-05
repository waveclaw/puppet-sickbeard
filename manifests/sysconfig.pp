# == Class sickbeard::sysconifg
#
# This class is called from sickbeard for service config.
#
class sickbeard::sysconfig(
  $source       = undef,
  $content      = undef,
  $template     = undef,
){
  $_config_file = "${sickbeard::sysconfig_path}/sickbeard"
  $_user      = $sickbeard::user_name
  $_group     = $sickbeard::group_name
  $_data_path = $sickbeard::data_path
  $_pidfile   = $sickbeard::pidfile
  $_nice      = $sickbeard::nice
  $_options   = $sickbeard::options
  File {
    owner  => $_user,
    group  => $_group,
    mode   => '0750',
  }
  if $source != undef {
    file { $_config_file:
      ensure => file,
      source => $source,
    }
  } elsif $content != undef {
    file { $_config_file:
      ensure  => file,
      content => $content,
    }
  } elsif $template != undef {
    file { $_config_file:
      ensure  => file,
      content => $template,
    }
  } else {
    file { $_config_file:
      ensure  => file,
      content => template('sickbeard/sickbeard.erb'),
    }
  }
}
