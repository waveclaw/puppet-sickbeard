# == Class sickbeard::repo
#
# This class is called from sickbeard for setup of repos.
#
class sickbeard::repo(
  $repos = hiera('sickbeard::repo::repos', $::sickbeard::defaults::repos),
) inherits sickbeard::defaults {
  case $::osfamily {
    'Debian': {
      sickbeard::repo::ppa { [$repos]: }
    }
    'RedHat': {
      sickbeard::repo::yum { [$repos]: }
    }
    'Suse': {
      sickbeard::repo::zyp { [$repos]: }
    }
    default: { }
  }
}
