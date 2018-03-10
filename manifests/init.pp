# == Class: nexus_proxy
#
# Configure Nexus for proxying via types of repos. The repos can be defined
# via hiera or puppet.
#
# === Parameters
#
# [*m2_extra_repos*]
#   Extra proxy names to add to the 'public' Maven group. This is necessary
#   when Puppet (or something else beside hiera) is used to define a proxy.
#
# [*npm_extra_repos*]
#   Extra proxy names to add to the 'npm-all' NPM group. This is necessary
#   when Puppet (or something else beside hiera) is used to define a proxy.
#
# [*gems_extra_repos*]
#   Extra proxy names to add to the 'gems' RubyGems group. This is necessary
#   when Puppet (or something else beside hiera) is used to define a proxy.
#
# === Variables
#
# No variables.
#
# === Examples
#
#  include nexus_proxy
#
#    OR
#
#  class { 'nexus_proxy': }
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016-2018 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy(
  $m2_extra_repos = [],
  $npm_extra_repos = [],
  $gems_extra_repos = [],
) {

  class { 'nexus_proxy::deployed::m2':
    extra_repos => $m2_extra_repos,
  }

  class { 'nexus_proxy::deployed::npm':
    extra_repos => $npm_extra_repos,
  }

  class { 'nexus_proxy::deployed::gems':
    extra_repos => $gems_extra_repos,
  }

  include nexus_proxy::deployed::thirdparty
}
