# == Class sickbeard::service
#
# This class is meant to be called from sickbeard.
# It ensure the service is running.
#
class sickbeard::service (
  $services = hiera('sickbeard::service::services',
    $::sickbeard::defaults::services),
) inherits sickbeard::defaults {

  service { [$services]:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
