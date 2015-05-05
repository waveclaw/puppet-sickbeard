# == Class: sickbeard
#
# Full description of class sickbeard here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class sickbeard (
  $repo_name        = $::sickbeard::defaults::repo_name,
  $user_name        = $::sickbeard::defaults::user_name,
  $group_name       = $::sickbeard::defaults::group_name,
  $data_path        = $::sickbeard::defaults::data_path,
  $pidfile          = $::sickbeard::defaults::pidfile,
  $nice             = $::sickbeard::defaults::nice,
  $options          = $::sickbeard::defaults::options,
  $webuser          = $::sickbeard::defaults::webuser,
  $webpass          = $::sickbeard::defaults::webpass,
  $apikey           = $::sickbeard::defaults::apikey,
  $root_path        = $::sickbeard::defaults::root_path,
  $tv_download_path = $::sickbeard::defaults::tv_download_path,
  $servers          = $::sickbeard::defaults::servers,
  $sabnzbd          = $::sickbeard::defaults::sabnzbd,
  $plex             = $::sickbeard::defaults::plex,
  $newznab          = $::sickbeard::defaults::newznab,
  $package_name     = $::sickbeard::defaults::package_name,
  $service_name     = $::sickbeard::defaults::service_name,
  $sysconfig_path   = $::sickbeard::defaults::sysconfig_path,
) inherits ::sickbeard::defaults {

  validate_string($user_name)
  validate_string($group_name)
  validate_string($options)
  validate_string($webuser)
  validate_string($webpass)
  validate_string($apikey)
  validate_string($tv_download_path)
  #validate_integer($nice)
  validate_absolute_path($pidfile)
  validate_absolute_path($data_path)
  validate_absolute_path($root_path)
  validate_absolute_path($sysconfig_path)
  validate_hash($servers)
  validate_hash($sabnzbd)
  validate_hash($plex)
  validate_hash($newznab)
  #$package_name
  #$service_name

  class { '::sickbeard::users': } ->
  class { '::sickbeard::repo': } ->
  class { '::sickbeard::install': } ->
  class { '::sickbeard::sysconfig': } ->
  class { '::sickbeard::config': } ->
  class { '::sickbeard::service': } ->
  Class['::sickbeard']

  Class [ '::sickbeard::sysconfig', '::sickbeard::config' ] ~>
  Class [ '::sickbeard::service' ]
}
