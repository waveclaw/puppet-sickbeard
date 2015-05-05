# == Class sickbeard::repo
#
# This class is called from sickbeard for setup of repos.
#
class sickbeard::repo {
  if $sickbeard::repo_name != undef {
    case $::osfamily {
      'Debian': {
        # xfacts is broken
        # sickbeard::repo::ppa { $sickbeard::repo_name: }
      }
      'RedHat': {
        sickbeard::repo::yum { $sickbeard::repo_name: }
      }
      'Suse': {
        sickbeard::repo::zyp { $sickbeard::repo_name: }
      }
      default: { }
    }
  }
}
