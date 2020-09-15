# == Class: nexus_proxy::deployed::thirdparty
#
# Configures some common development libraries to be installed in the thirdparty
# Nexus repo.
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016-2018 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy::deployed::thirdparty {
  nexus3_repository { 'thirdparty':
    provider_type  => 'maven2',
    type           => 'hosted',
    version_policy => 'release',
    write_policy   => 'allow_write_once',
  }
}
