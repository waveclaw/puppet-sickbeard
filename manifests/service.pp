# == Class sickbeard::service
#
# This class is meant to be called from sickbeard.
# It ensure the service is running.
#
class sickbeard::service {

  service { $sickbeard::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
