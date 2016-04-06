# == Class: nexus_proxy::deployed::npm
#
# Configures default NPM repositories available on the Internet and makes
# then all available under the '/content/groups/npm-all' Nexus repository URL.
#
# === Authors
#
# Patrick Double <pat@patdouble.com>
#
# === Copyright
#
# Copyright 2016 Patrick Double <pat@patdouble.com>, unless otherwise noted.
#
class nexus_proxy::deployed::npm {

	nexus_proxy::proxy_npm { 'npmjs':
	  remote_storage => 'https://registry.npmjs.org/',
	}

# TODO: pick up repositories list from all instances of `nexus_proxy::proxy_npm`
	nexus_repository_group { 'npm-all':
	  label           => 'npm-all',
	  provider_type   => 'npm',
	  exposed         => true,
	  repositories    => [
						  'npmjs',
						 ],
	}

}

