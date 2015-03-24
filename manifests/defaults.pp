# == Class sickbeard::defaults
#
# This class is meant to be called from sickbeard.
# It sets variables according to platform.
#
class sickbeard::defaults {
  $apikey = '"check https://localhost:9090/config/general/ for your apikey"'
  $user = 'sickbeard'
  $group = 'sickbeard'
  $iniconf = { 
    'file'     => 'config.ini', 
    'path'     => '/var/lib/sickbeard',
    'template' => 'sickbeard/sickbeard.ini.erb' 
  }
  $packages = 'sickbeard'
  $services = 'sickbeard'
  $sysconf = { 'file' => 'sickbeard', 
    'source' => 'puppet:///modules/sickbeard/sickbeard.sysconfig' }
  case $::osfamily {
    'Debian': {
      $repos = 'ppa:jcfp/ppa'
      $sysconf['path'] = '/etc/defaults'
    }
    'RedHat': {
      $repos    = [
        join([ 'https://dl.dropboxusercontent.com/u/14500830/SABnzbd',
          'RHEL-CentOS', $::os_maj_version], '/'),
        join([ 'http://dl.fedoraproject.org/pub/epel',
          $::os_maj_version, $::architecture ], '/'),
        join([ 'http://packages.atrpms.net/dist',
          "el${::os_maj_version}",'unrar','' ], '/')
      ]
      $sysconf['path'] = '/etc/sysconfig'
    }
    'Suse': {
      $repos    = [
        join([ 'http://download.opensuse.org/repositories',
          'Archiving/SLE_12'],'/'),
        join([ 'http://download.opensuse.org/repositories',
          'home:/waveclaw:/HTPC/SLE_12'],'/')
      ]
      $sysconf['path'] = '/etc/sysconfig'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
