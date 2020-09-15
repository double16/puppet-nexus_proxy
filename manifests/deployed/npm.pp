# == Class: nexus_proxy::deployed::npm
#
# Configures default NPM repositories available on the Internet and makes
# then all available under the '/content/groups/npm-all' Nexus repository URL.
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016-2018 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy::deployed::npm(
  $extra_repos = []
) {

  $default_repos = {
    'npmjs' => {
      'remote_storage' => 'https://registry.npmjs.org/',
    }
  }

  $repos = merge($default_repos, lookup('nexus_proxy::proxy_npm', Data, 'hash', {}))
  unless empty($repos) {
    ensure_resources('nexus_proxy::proxy_npm', $repos)
    $names = unique($extra_repos + keys($repos))

    Nexus_proxy::Proxy_npm <| |>
    ->nexus3_repository_group { 'npm-all':
      provider_type => 'npm',
      repositories  => $names,
    }
  }
}
