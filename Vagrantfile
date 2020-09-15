# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.8"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.network "forwarded_port", guest: 8081, host: 8081

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1500"
  end

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "1500"
    v.vmx["numvcpus"] = "2"
  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: <<-SHELL
    yum -y update

    # Get the development tools
    yum groupinstall -y 'Development Tools'
    yum install -y gcc-c++ glibc-headers openssl-devel readline readline-devel zlib zlib-devel libyaml-devel sqlite-devel git

    # Install puppet
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    yum -y install https://yum.puppetlabs.com/puppet-release-el-7.noarch.rpm
    yum install -y puppet-agent
    mkdir -p /etc/facter/facts.d
    echo "vagrant_cache_dir=/tmp/vagrant-cache" > /etc/facter/facts.d/vagrant_cache_dir.txt
    /opt/puppetlabs/puppet/bin/puppet apply -e "package { 'rest-client': provider => 'puppet_gem' }"
    /opt/puppetlabs/puppet/bin/gem install --conservative --verbose librarian-puppet
    export PATH="/usr/local/bin:/usr/local/sbin:/opt/puppetlabs/bin:${PATH}"
    echo "Configuring librarian-puppet tmp"
    /opt/puppetlabs/puppet/bin/librarian-puppet config tmp --global "/home/vagrant/.tmp"
    echo "librarian-puppet installing testing modules"
    ( cd /vagrant/vagrant && /opt/puppetlabs/puppet/bin/librarian-puppet install --verbose "--path=/etc/puppetlabs/code/modules" )

	# Apply the nexus_proxy module
  #  ln -sf /opt/puppetlabs/puppet /etc/puppet
	mkdir -p /home/vagrant/working
	cd /home/vagrant/working

    # The /home/vagrant/working/apply script will update the VM from the puppet module
    # for testing changes
    cat >apply <<APPLYFILE
#!/bin/sh -x
export PATH="/usr/local/bin:/usr/local/sbin:/opt/puppetlabs/bin:${PATH}"
rsync -r /vagrant/ /home/vagrant/working/modules/nexus_proxy/
puppet apply --modulepath=/home/vagrant/working/modules -e 'include nexus_proxy' "\\\$@"
APPLYFILE
    chmod +x apply

    # This section installs the modules the nexus_proxy module depends upon
	cat >Puppetfile <<PUPPETFILE
forge 'https://forgeapi.puppetlabs.com'
mod 'double16-nexus_proxy', :path => '/vagrant'
PUPPETFILE

    echo "librarian-puppet installing double16-nexus_proxy modules"
    export PATH="/usr/local/bin:/usr/local/sbin:/opt/puppetlabs/bin:${PATH}"
  	/opt/puppetlabs/puppet/bin/librarian-puppet install --verbose

  SHELL

  config.vm.provision "puppet" do |puppet|
    puppet.binary_path = "/opt/puppetlabs/bin"
    puppet.environment_path = "vagrant/environments"
    puppet.environment = "test"
    puppet.facter = {
      "vagrant_cache_dir" => "/tmp/vagrant-cache"
    }
  end

end

