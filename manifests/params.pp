# == Function: nexus_proxy::params
#
# Parameters for connecting to the Nexus server.
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy::params {
  if (file('/etc/puppet/nexus_rest.conf','/dev/null') != '') {
    $nexus_config = loadyaml('/etc/puppet/nexus_rest.conf')
    $nexus_base_url = regsubst($nexus_config['nexus_base_url'], '/$', '')
    $nexus_username = $nexus_config['admin_username']
    $nexus_password = $nexus_config['admin_password']
  } else {
    $nexus_base_url = 'http://localhost:8081/'
    $nexus_username = 'admin'
    $nexus_password = 'admin123'
  }
}
