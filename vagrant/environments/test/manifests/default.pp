
$docker_version = $::operatingsystem ? { 'Ubuntu' => '1.10.3-0~trusty', 'CentOS' => '1.10.3-1.el7.centos', default => '1.10.3' }
class { '::docker':
  version      => $docker_version,
  docker_users => [ 'vagrant' ],
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

