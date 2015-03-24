# == Defined Type sickbeard::repo::yum
#
# This class is called from sickbeard for setup of yum.
#
define sickbeard::repo::yum {
  $repo = regsubst(regsubst($title,'/','_','G'),':','','G')
  ensure_resource('yumrepo', $repo,
    {'ensure' => 'present', 'baseurl' => $title })
}
