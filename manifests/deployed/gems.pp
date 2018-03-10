# == Class: nexus_proxy::deployed::gems
#
# Configures default Ruby Gems repositories available on the Internet and makes
# then all available under the '/content/groups/gems' Nexus repository URL.
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016-2018 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy::deployed::gems(
  $extra_repos = []
) {

  $default_repos = {
    'rubygems' => {
      'remote_storage' => 'https://rubygems.org/',
    }
  }

  $repos = merge($default_repos, lookup('nexus_proxy::proxy_gems', Data, 'hash', {}))
  unless empty($repos) {
    ensure_resources('nexus_proxy::proxy_gems', $repos)
    $names = unique($extra_repos + keys($repos))

    Nexus_proxy::Proxy_gems <| |>
    ->nexus_repository_group { 'gems':
      label         => 'Ruby Gems Repositories',
      provider_type => 'rubygems',
      exposed       => true,
      repositories  => $names,
    }
  }
}
