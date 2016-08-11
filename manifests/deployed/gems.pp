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
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy::deployed::gems {
  nexus_proxy::proxy_gems { 'rubygems':
    remote_storage => 'https://rubygems.org',
  }

  # TODO: pick up repositories list from all instances of `nexus_proxy::proxy_gems`
  Nexus_proxy::Proxy_gems <| |> ->
  nexus_repository_group { 'gems':
    label         => 'Ruby Gems Repositories',
    provider_type => 'rubygems',
    exposed       => true,
    repositories  => [
      'rubygems',
    ],
  }

}
