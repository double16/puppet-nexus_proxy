# == Function: nexus_proxy::gradle
#
# Install a Gradle distribution into the thirdparty Nexus repo. Both the 'bin'
# and 'all' distributions are installed. The 'all' distribution allows an IDE
# to provide code completion, etc.
#
# === Parameters
#
# [*version*]
#   The Gradle version, such as "2.12".
#
# === Examples
#
# nexus_proxy::gradle { '2.12': }
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
define nexus_proxy::gradle($version = $title) {
  nexus_proxy::thirdparty { "org/gradle/wrapper/${version}/gradle-${version}-all.zip":
    remote_url => "https://downloads.gradle.org/distributions/gradle-${version}-all.zip",
  }
  nexus_proxy::thirdparty { "org/gradle/wrapper/${version}/gradle-${version}-bin.zip":
    remote_url => "https://downloads.gradle.org/distributions/gradle-${version}-bin.zip",
  }
}
