# == Function: nexus_proxy::thirdparty
#
# Installs an artifact from a remote URL into the thirdparty Nexus repository.
#
# === Parameters
#
# [*nexus_thirdparty_path*]
#   The destination path of the artifact in the Nexus repo. Can be almost
#   anything but it is recommended to follow a Maven2 like path.
# [*remote_url*]
#   The URL of the remote artifact.
#
# === Examples
#
# The nexus_proxy::gradle uses this class thus:
#   nexus_proxy::thirdparty { "org/gradle/wrapper/${version}/gradle-${version}-all.zip":
#     remote_url => "https://services.gradle.org/distributions/gradle-${version}-all.zip",
#   }
#
# Mac OS X update 10.11.4 should be installed thus:
#   nexus_proxy::thirdparty { 'com/apple/osx/10.11.4/osxupdcombo10.11.4.dmg':
#     remote_url => 'http://supportdownload.apple.com/download.info.apple.com/Apple_Support_Area/Apple_Software_Updates/Mac_OS_X/downloads/031-53824-20160321-fe6ca45c-ef80-11e5-a883-674ec3f08ae0/osxupdcombo10.11.4.dmg',
#   }
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
define nexus_proxy::thirdparty($remote_url, $nexus_thirdparty_path = $title) {
  include nexus_proxy::params
  exec { $nexus_thirdparty_path:
    path    => ['/usr/bin', '/usr/sbin'],
    command => "curl --fail --location --output /var/tmp/nexus_thirdparty.tmp ${remote_url} && curl --fail --upload-file /var/tmp/nexus_thirdparty.tmp -u ${nexus_proxy::params::nexus_username}:${nexus_proxy::params::nexus_password} ${nexus_proxy::params::nexus_base_url}/content/repositories/thirdparty/${nexus_thirdparty_path}",
    unless  => "curl -I --fail ${nexus_proxy::params::nexus_base_url}/content/repositories/thirdparty/${nexus_thirdparty_path}",
    tries   => 3,
    # 3 hours to account for the slow network
    timeout => 10800,
    require => Nexus_repository['thirdparty'],
  }
}

