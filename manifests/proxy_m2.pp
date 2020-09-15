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
# Copyright 2016-2020 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
define nexus_proxy::proxy_m2($remote_storage, $label = $title, $policy = 'release') {
  nexus3_repository { $title:
    provider_type           => 'maven2',
    type                    => 'proxy',
    version_policy          => $policy,
    write_policy            => 'read_only',
    remote_url              => $remote_storage,
    remote_auth_type        => 'none',
  }
}
