# == Function: nexus_proxy::grails
#
# Install a Grails 1.x or 2.x distribution into the thirdparty Nexus repo.
#
# === Parameters
#
# [*version*]
#   The Grails version, such as "2.5.4".
#
# === Examples
#
# nexus_proxy::grails { '2.5.4': }
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
define nexus_proxy::grails($version = $title) {
  nexus_proxy::thirdparty { "grails/grails-core/releases/download/v${version}/grails-${version}.zip":
    remote_url => "https://github.com/grails/grails-core/releases/download/v${version}/grails-${version}.zip",
  }
}
