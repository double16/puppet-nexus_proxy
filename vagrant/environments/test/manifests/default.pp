
$docker_version = $::operatingsystem ? {
  'Ubuntu' => '17.12.1~ce-0~ubuntu',
  'CentOS' => '17.12.1.ce-1.el7.centos',
  default  => '17.12.1-ce',
}

package { 'docker-engine': ensure => absent, }
->file { '/etc/sysctl.d/forwarding.conf':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => '# IP forwarding for Docker
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
',
}
->remote_file { '/etc/yum.repos.d/docker-ce.repo':
  source => 'https://download.docker.com/linux/centos/docker-ce.repo',
}
->package { ['device-mapper-persistent-data', 'lvm2']: }
->package { 'docker-ce':
  ensure => $docker_version,
}
->class { '::docker':
  manage_package              => false,
  use_upstream_package_source => false,
  docker_users                => [ 'vagrant' ],
}

docker::run { 'nexus':
  image => 'sonatype/nexus:oss',
  ports => ['8081:8081'],
}

file { '/etc/puppet/nexus_rest.conf':
  ensure  => file,
  source  => '/vagrant/vagrant/nexus_rest.conf',
  replace => false,
  owner   => 'root',
  group   => 'root',
  mode    => '0640',
}

package { 'rest-client':
  ensure   => installed,
  provider => gem,
}

