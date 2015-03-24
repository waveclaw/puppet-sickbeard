# == Defined Type sickbeard::repo::zyp
#
# This class is called from sickbeard for setup of repos.
#
define sickbeard::repo::zyp {
    $repo = regsubst(regsubst($title,'/','_','G'),':','','G')
    ensure_resource('zypprepo', $repo, { baseurl => $title })
}
