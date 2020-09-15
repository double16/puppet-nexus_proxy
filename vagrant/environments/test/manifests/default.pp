
file { '/etc/sysctl.d/forwarding.conf':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => '# IP forwarding for Docker
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
',
}
->class { 'docker':
  docker_users => [ 'vagrant' ],
}

docker::run { 'nexus':
  image  => 'sonatype/nexus3:3.27.0',
  ports  => ['8081:8081'],
  detach => true,
  restart_service  => true,
}

file { '/etc/puppetlabs/nexus3_rest.conf':
  ensure  => file,
  source  => '/vagrant/vagrant/nexus_rest.conf',
  replace => false,
  owner   => 'root',
  group   => 'root',
  mode    => '0640',
}

# package { 'rest-client':
#   ensure   => installed,
#   provider => gem,
# }

