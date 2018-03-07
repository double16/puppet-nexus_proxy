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
  nexus_repository { 'thirdparty':
    label         => '3rd party',
    provider_type => 'maven2',
    type          => 'hosted',
    policy        => 'release',
    write_policy  => 'allow_write_once',
    browseable    => true,
    indexable     => true,
    exposed       => true,
  }

  lookup('nexus_proxy::phantomjs', Data, 'unique', []).each |$version| {
    nexus_proxy::phantomjs { $version: }
  }

  lookup('nexus_proxy::gradle', Data, 'unique', []).each |$version| {
    nexus_proxy::gradle { $version: }
  }

  lookup('nexus_proxy::node', Data, 'unique', []).each |$version| {
    nexus_proxy::node { $version: }
  }

  lookup('nexus_proxy::grails', Data, 'unique', []).each |$version| {
    nexus_proxy::grails { $version: }
  }
}
