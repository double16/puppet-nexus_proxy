# == Class: nexus_proxy::deployed::m2
#
# Configures default Maven2 repositories available on the Internet and makes
# then all available under the '/content/groups/public' Nexus repository URL.
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016-2018 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy::deployed::m2(
  $extra_repos = []
) {

  $default_repos = {
    'central' => {
      'label' => 'Central',
      'remote_storage' => 'https://repo1.maven.org/maven2/',
    },
    'jcenter' => {
      'remote_storage' => 'https://jcenter.bintray.com/',
    }
  }

  $repos = merge($default_repos, lookup('nexus_proxy::proxy_m2', Data, 'hash', {}))
  unless empty($repos) {
    ensure_resources('nexus_proxy::proxy_m2', $repos)
    $names = unique(['thirdparty'] + $extra_repos + keys($repos))

    Nexus_proxy::Proxy_m2 <| |>
    ->nexus3_repository_group { 'public':
      provider_type => 'maven2',
      repositories  => $names,
    }
  }
}
