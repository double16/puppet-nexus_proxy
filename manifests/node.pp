# == Function: nexus_proxy::node
#
# Install a Node.js distribution into the thirdparty Nexus repo.
#
# === Parameters
#
# [*version*]
#   The Node.js version, such as "4.3.2".
#
# === Examples
#
# nexus_proxy::node { '4.3.2': }
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
define nexus_proxy::node($version = $title) {
  nexus_proxy::thirdparty { "org/nodejs/node/${version}/node-${version}-linux-x64.tar.gz":
    remote_url => "https://nodejs.org/dist/v${version}/node-v${version}-linux-x64.tar.gz",
  }
  nexus_proxy::thirdparty { "org/nodejs/node/${version}/node-${version}-linux-x86.tar.gz":
    remote_url => "https://nodejs.org/dist/v${version}/node-v${version}-linux-x86.tar.gz",
  }
  nexus_proxy::thirdparty { "org/nodejs/node/${version}/node-${version}-darwin-x64.tar.gz":
    remote_url => "https://nodejs.org/dist/v${version}/node-v${version}-darwin-x64.tar.gz",
  }
  nexus_proxy::thirdparty { "org/nodejs/node/${version}/node-${version}-win-x64.exe":
    remote_url => "https://nodejs.org/dist/v${version}//win-x64/node.exe",
  }
  nexus_proxy::thirdparty { "org/nodejs/node/${version}/node-${version}-win-x64.lib":
    remote_url => "https://nodejs.org/dist/v${version}/win-x64/node.lib",
  }
  nexus_proxy::thirdparty { "org/nodejs/node/${version}/node-${version}-win-x86.exe":
    remote_url => "https://nodejs.org/dist/v${version}/win-x86/node.exe",
  }
  nexus_proxy::thirdparty { "org/nodejs/node/${version}/node-${version}-win-x86.lib":
    remote_url => "https://nodejs.org/dist/v${version}/win-x86/node.lib",
  }
}

