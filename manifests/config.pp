# == Class sickbeard::config
#
# This class is called from sickbeard for service config.
#
# (The actual sabndbz.ini file is in the profile::mediaserver module)
#
class sickbeard::config (
  $sysconf = hiera('sickbeard::config::sysconf', $::sickbeard::defaults::sysconf),
  $iniconf = hiera('sickbeard::config::iniconf', $::sickbeard::defaults::iniconf),
  $home    = hiera('sickbeard::config::home', $::sickbeard::defaults::home),
  $user    = hiera('sickbeard::config::user', $::sickbeard::defaults::user),
  $group   = hiera('sickbeard::config::group', $::sickbeard::defaults::group),
  $apikey  = hiera('sickbeard::config::apikey', $::sickbeard::defaults::apikey),
) inherits sickbeard::defaults {
  validate_hash($sysconf)
  validate_hash($iniconf)
  validate_string($home)
  validate_string($user)
  validate_string($group)
  validate_string($apikey)
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
  }
  $confpath = $sysconf['path']
  $confname = $sysconf['file']
  $conf = "${confpath}/${confname}"
  if has_key($sysconf, 'source') {
    file { $conf: source => $sysconf['source'], }
  } elsif has_key($sysconf, 'template') {
    file { $conf: content => template($sysconf['template']), }
  } else {
    notice('No source for configuration file, none will be used.')
  }
  $pathname = $iniconf['path']
  file { $pathname:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0750',
  }
  $basename = $iniconf['file']
  $inifile = "${pathname}/${basename}"
  if has_key($iniconf, 'source') {
    file { $inifile:
      source => $iniconf['source'],
      owner  => $user,
      group  => $group,
      mode   => '0600',
    }
  } elsif has_key($iniconf, 'template') {
    file { $inifile:
      content => template($iniconf['template']),
      owner   => $user,
      group   => $group,
      mode    => '0600',
    }
  } else {
    notice('No source for configuration file, none will be used.')
  }
}