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
) {
  class { '::sickbeard::repo': } ->
  class { '::sickbeard::install': } ->
  class { '::sickbeard::config': } ~>
  class { '::sickbeard::service': } ->
  Class['::sickbeard']
}
