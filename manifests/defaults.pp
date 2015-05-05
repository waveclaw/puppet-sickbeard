# == Class sickbeard::defaults
#
# This class is meant to be called from sickbeard.
# It sets variables according to platform.
#
class sickbeard::defaults {
  $user_name        = 'sickbeard'
  $group_name       = 'sickbeard'
  $data_path        = '/var/lib/sickbeard'
  $pidfile          = '/var/run/sickbeard/sickbeard.pid'
  $nice             = 10
  $options          = ''
  $webuser          = 'admin'
  $webpass          = 'admin'
  $apikey           =
    '"check https://localhost:8081/home/ for your apikey"'
  $root_path        = '/var/lib/sickbeard'
  $tv_download_path = 'Downloads'
  $servers          = {}
  $sabnzbd          = {}
  $plex             = {}
  $newznab          = {}
  $package_name     = 'sickbeard'
  $service_name     = 'sickbeard'
  case $::osfamily {
    'Debian': {
      $repo_name = 'ppa:jcfp/ppa'
      $sysconfig_path = '/etc/defaults'
    }
    'RedHat': {
      $repo_name = [
        join([ 'https://dl.dropboxusercontent.com/u/14500830/SABnzbd',
          'RHEL-CentOS', $::os_maj_version], '/'),
        join([ 'http://dl.fedoraproject.org/pub/epel',
          $::os_maj_version, $::architecture ], '/'),
        join([ 'http://packages.atrpms.net/dist',
          "el${::os_maj_version}",'unrar','' ], '/')
      ]
      $sysconfig_path = '/etc/sysconfig'
    }
    'Suse': {
      $repo_name = [
        join([ 'http://download.opensuse.org/repositories',
          'Archiving/SLE_12'],'/'),
        join([ 'http://download.opensuse.org/repositories',
          'home:/waveclaw:/HTPC/SLE_12'],'/')
      ]
      $sysconfig_path = '/etc/sysconfig'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
