# == Class sickbeard::users
#
# This class is called from sickbeard for pre-install user setup.
#
class sickbeard::users {
  group { $sickbeard::group_name:
    ensure => present,
  }

  user { $::sickbeard::user_name:
    ensure           => present,
    comment          => 'Sick-Beard daemon',
    groups           => $sickbeard::group_name,
    home             => $sickbeard::group_name,
    password         => '!',
    password_max_age => '-1',
    password_min_age => '-1',
    shell            => '/bin/false',
  }

  Group[ $sickbeard::group_name ] ->
  User[ $sickbeard::user_name ]
}
