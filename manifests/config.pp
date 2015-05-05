# == Class sickbeard::config
#
# This class is called from sickbeard for service config.
#
class sickbeard::config(
  $config_file_source       = undef,
  $config_file_content      = undef,
  $config_file_template     = undef,
){
  # used in the template
  $_user             = $sickbeard::user_name
  $_group            = $sickbeard::group_name
  $_webuser          = $sickbeard::webuser
  $_webpass          = $sickbeard::webpass
  $_apikey           = $sickbeard::apikey
  $_root             = $sickbeard::root_path
  $_tv_download_path = $sickbeard::tv_download_path
  $_servers          = $sickbeard::servers
  $_sabnzbd          = $sickbeard::sabnzbd
  $_plex             = $sickbeard::plex
  $_newznab_data     = $sickbeard::newznab
  $_config_path      = $sickbeard::data_path
  $_config_file = "${_config_path}/config.ini"
  $_dirs = [
    $_config_path,
    "${_config_path}/Logs",
    "${_config_path}/cache",
  ]
  File {
    owner  => $_user,
    group  => $_group,
    mode   => '0750',
  }
  ensure_resource( 'file', $_dirs, {
    ensure => directory,
  })
  if $config_file_source != undef {
    file { $_config_file:
      ensure => file,
      source => $config_file_source,
    }
  } elsif $config_file_content != undef {
    file { $_config_file:
      ensure  => file,
      content => $config_file_content,
    }
  } elsif $config_file_template != undef {
    file { $_config_file:
      ensure  => file,
      content => $config_file_template,
    }
  } else {
    file { $_config_file:
      ensure  => file,
      content => template('sickbeard/sickbeard.ini.erb'),
    }
  }
}
