# == Function: nexus_proxy::proxy_npm
#
# Define a NPM (Node Package Manager) proxy repo in Nexus.
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
# nexus_proxy::proxy_npm { 'npmjs':
#   remote_storage => 'https://registry.npmjs.org/',
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
define nexus_proxy::proxy_npm($remote_storage, $label = $title) {
  nexus3_repository { $title:
    provider_type           => 'npm',
    type                    => 'proxy',
    remote_url              => $remote_storage,
    write_policy            => 'read_only',
    remote_auth_type        => 'none',
  }
}

