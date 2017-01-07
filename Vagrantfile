# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.2"

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
	cat >install <<INSTALLSCRIPT
    # yum update will bring in docker >= 1.9 which we can't use
	#yum -y update

	# Get the development tools
	yum groupinstall -y 'Development Tools'
	yum install -y gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel sqlite-devel ruby ruby-devel git

    # Install puppet
    rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
    yum install -y puppet-agent
    /opt/puppetlabs/puppet/bin/puppet apply -e "package { 'rest-client': provider => 'puppet_gem' }"
    gem install --conservative --verbose librarian-puppet
    export PATH="/usr/local/bin:/usr/local/sbin:/opt/puppetlabs/bin:${PATH}"
    cd /vagrant/vagrant && librarian-puppet install "--path=/opt/puppetlabs/puppet/modules"
INSTALLSCRIPT
    chmod +x install
    sudo ./install
    mkdir -p /etc/facter/facts.d
    echo "vagrant_cache_dir=/tmp/vagrant-cache" > /etc/facter/facts.d/vagrant_cache_dir.txt

	# Apply the nexus_proxy module
    ln -sf /opt/puppetlabs/puppet /etc/puppet
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

    export PATH="/usr/local/bin:/usr/local/sbin:/opt/puppetlabs/bin:${PATH}"
	librarian-puppet install --verbose

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

