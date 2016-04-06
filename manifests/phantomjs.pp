# == Function: nexus_proxy::phantomjs
#
# Install a phantomjs distribution into the thirdparty Nexus repo.
#
# === Parameters
#
# [*version*]
#   The Node.js version, such as "2.1.1".
#
# === Examples
#
# nexus_proxy::phantomjs { '2.1.1': }
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
define nexus_proxy::phantomjs($version = $title) {
  nexus_proxy::thirdparty { "ariya/phantomjs/phantomjs-${version}-linux-x86_64.tar.bz2":
    remote_url => "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${version}-linux-x86_64.tar.bz2",
  }
  nexus_proxy::thirdparty { "ariya/phantomjs/phantomjs-${version}-linux-i686.tar.bz2":
    remote_url => "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${version}-linux-i686.tar.bz2",
  }
  nexus_proxy::thirdparty { "ariya/phantomjs/phantomjs-${version}-macosx.zip":
    remote_url => "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${version}-macosx.zip",
  }
  nexus_proxy::thirdparty { "ariya/phantomjs/phantomjs-${version}-windows.zip":
    remote_url => "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${version}-windows.zip",
  }
}

