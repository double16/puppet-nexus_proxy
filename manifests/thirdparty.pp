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

  $nexus_thirdparty_path_exists = check_url("${nexus_proxy::params::nexus_base_url}/content/repositories/thirdparty/${nexus_thirdparty_path}")

  if !$nexus_thirdparty_path_exists {
    $remote_url_md5 = md5($remote_url)
    $path_to_cached = "${nexus_proxy::params::thirdparty_cache_dir}/nexus_proxy-thirdparty-${remote_url_md5}"

    remote_file { $path_to_cached:
      ensure => present,
      source => $remote_url,
      # 3 hours to account for a slow network
      #timeout => 10800,
    }
    ->exec { "${nexus_thirdparty_path} upload":
      path    => ['/usr/bin', '/usr/sbin'],
      command => "curl --silent --show-error --fail --upload-file ${path_to_cached} -u ${nexus_proxy::params::nexus_username}:${nexus_proxy::params::nexus_password} ${nexus_proxy::params::nexus_base_url}/content/repositories/thirdparty/${nexus_thirdparty_path}", # lint:ignore:140chars
      tries   => 3,
      require => Nexus_repository['thirdparty'],
    }
  }
}
