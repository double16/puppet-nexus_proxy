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
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
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

  # TODO: Configure these in hiera
  nexus_proxy::phantomjs { '1.9.8': }
  nexus_proxy::phantomjs { '2.1.1': }
  nexus_proxy::gradle { '2.14.1': }
  nexus_proxy::gradle { '3.4.1': }
  nexus_proxy::node { '6.10.1': } # LTS
  nexus_proxy::node { '7.7.4': } # Current
  nexus_proxy::grails { '2.3.11': }
  nexus_proxy::grails { '2.5.6': }
}
