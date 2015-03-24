# == Class sickbeard::install
#
# This class is called from sickbeard for install.
#
class sickbeard::install (
  $packages = hiera('::sickbeard::install::packages',
    $::sickbeard::defaults::packages),
) inherits sickbeard::defaults {
  ensure_resource('package', $packages,
    { 'ensure' => 'present' })
}
