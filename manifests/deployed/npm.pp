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
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy::deployed::npm {

  $default_repos = {
    'npmjs' => {
      'remote_storage' => 'https://registry.npmjs.org/',
    }
  }

  $repos = merge($default_repos, lookup('nexus_proxy::proxy_npm', Data, 'hash', {}))
  unless empty($repos) {
    ensure_resources('nexus_proxy::proxy_npm', $repos)
    $names = keys($repos)

    Nexus_proxy::Proxy_npm <| |>
    ->nexus_repository_group { 'npm-all':
      label         => 'npm-all',
      provider_type => 'npm',
      exposed       => true,
      repositories  => $names,
    }
  }
}
