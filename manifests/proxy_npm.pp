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
  nexus_repository { $title:
    label                   => $label,
    provider_type           => 'npm',
    type                    => 'proxy',
    remote_storage          => $remote_storage,
    remote_auto_block       => true,
    remote_file_validation  => true,
    browseable              => true,
    exposed                 => true,
    indexable               => false,
    write_policy            => 'read_only',
    remote_download_indexes => false,
    remote_checksum_policy  => 'ignore',
    remote_artifact_max_age => 0,
    remote_metadata_max_age => 0,
  }
}

