# == Function: nexus_proxy::proxy_m2
#
# Define a Maven2 proxy repo in Nexus.
#
# === Parameters
#
# [*label*]
#   The Nexus 'label' property, a unique value to reference the repo.
# [*remote_storage*]
#   The URL of the remote repository.
# [*policy*]
#   The policy for which versions to allow, 'release' or 'snapshot'. Defaults
#   to 'release'.
#
# === Examples
#
# nexus_proxy::proxy_m2 { 'central':
#   label          => 'Central',
#   remote_storage => 'https://repo1.maven.org/maven2/',
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
define nexus_proxy::proxy_m2($label = $title, $remote_storage, $policy = 'release') {
  nexus_repository { $title:
    label                   => $label,
    provider_type           => 'maven2',
    type                    => 'proxy',
    policy                  => $policy,
    write_policy            => 'read_only',
    remote_storage          => $remote_storage,
    remote_download_indexes => true,
    remote_auto_block       => true,
    remote_file_validation  => true,
    remote_checksum_policy  => 'warn',
    browseable              => true,
    indexable               => true,
    exposed                 => true,
  }
}
