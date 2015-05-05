# == Class sickbeard::install
#
# This class is called from sickbeard for install.
#
class sickbeard::install {
  ensure_resource('package', $sickbeard::package_name,
    { 'ensure' => 'present' })
}
