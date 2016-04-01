# == Class: nexus_proxy::deployed::m2
#
# Configures default Maven2 repositories available on the Internet and makes
# then all available under the '/content/groups/public' Nexus repository URL.
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy::deployed::m2 {
	nexus_proxy::proxy_m2 { 'central':
	  label          => 'Central',
	  remote_storage => 'https://repo1.maven.org/maven2/',
	}

	nexus_proxy::proxy_m2 { 'central2':
	  label          => 'central.maven.org',
	  remote_storage => 'http://central.maven.org/maven2/',
	}

	nexus_proxy::proxy_m2 { 'grails-core':
	  remote_storage => 'https://repo.grails.org/grails/core/',
	}

	nexus_proxy::proxy_m2 { 'grails-plugins':
	  remote_storage => 'http://repo.grails.org/grails/plugins/',
	}

	nexus_proxy::proxy_m2 { 'gradle-plugins':
	  remote_storage => 'https://dl.bintray.com/gradle/gradle-plugins/',
	}

	nexus_proxy::proxy_m2 { 'jcenter':
	  remote_storage => 'https://jcenter.bintray.com/',
	}

	nexus_proxy::proxy_m2 { 'bintray-alkemist':
	  remote_storage => 'http://dl.bintray.com/alkemist/maven/',
	}

	nexus_proxy::proxy_m2 { 'saucelabs-m2':
	  remote_storage => 'http://repository-saucelabs.forge.cloudbees.com/release/',
	}

	nexus_proxy::proxy_m2 { 'ossrh':
	  remote_storage => 'https://oss.sonatype.org/content/repositories/snapshots',
	  policy => 'snapshot',
	}

# TODO: pick up repositories list from all instances of `nexus_proxy::proxy_m2`
	nexus_repository_group { 'public':
	  label           => 'Public Repositories',
	  provider_type   => 'maven2',
	  exposed         => true,
	  repositories    => [
						  'releases',
						  'snapshots',
						  'thirdparty',
						  'jcenter',
						  'central',
						  'grails-core',
						  'grails-plugins',
						  'gradle-plugins',
						  'central2',
						  'saucelabs-m2',
						  'bintray-alkemist',
						 ],
	}

}
