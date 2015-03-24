# == Defined Type sickbeard::repo::ppa
#
# This class is called from sickbeard for setup of repos.
#
define sickbeard::repo::ppa {
  $repo = regsubst(regsubst($title,'/','_'),':','')
  ensure_resource('apt::source', $repo,
    {'ensure' => 'present', 'location' => $title, 'repos' => 'main' })
}
