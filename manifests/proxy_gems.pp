# == Function: nexus_proxy::proxy_gems
#
# Define a Ruby Gems proxy repo in Nexus.
#
# === Parameters
#
# [*label*]
#   The Nexus 'label' property, a unique value to reference the repo.
# [*remote_storage*]
#   The URL of the remote repository.
#
# === Examples
#
# nexus_proxy::proxy_gems { 'rubygems':
#   label          => 'rubygems',
#   remote_storage => 'https://rubygems.org/',
# }
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
define nexus_proxy::proxy_gems($remote_storage, $label = $title) {
  nexus3_repository { $title:
    provider_type           => 'rubygems',
    type                    => 'proxy',
    write_policy            => 'read_only',
    remote_url              => $remote_storage,
    remote_auth_type        => 'none',
  }
}
