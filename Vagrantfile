# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.2"

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
	yum groupinstall -y 'development tools'
	yum install -y gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel sqlite-devel ruby ruby-devel git

    # Install puppet, nexus_rest only works with puppet 3.x ATM, 2016-04-26
    gem install --conservative puppet -v 3.8.6 --verbose
    gem install --conservative --verbose librarian-puppet
    export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"
    cd /vagrant/vagrant && librarian-puppet install "--path=$(/usr/local/bin/puppet master --configprint modulepath | cut -d : -f 1)"
INSTALLSCRIPT
    chmod +x install
    sudo ./install

	# Apply the nexus_proxy module
	mkdir -p /home/vagrant/working
	cd /home/vagrant/working

    # The /home/vagrant/working/apply script will update the VM from the puppet module
    # for testing changes
    cat >apply <<APPLYFILE
#!/bin/sh -x
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"
rsync -r /vagrant/ /home/vagrant/working/modules/nexus_proxy/
puppet apply --modulepath=/home/vagrant/working/modules -e 'include nexus_proxy' "\\\$@"
APPLYFILE
    chmod +x apply

    # This section installs the modules the nexus_proxy module depends upon
	cat >Puppetfile <<PUPPETFILE
forge 'http://forge.puppetlabs.com'
mod 'double16-nexus_proxy', :path => '/vagrant'
PUPPETFILE

    export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"
	librarian-puppet install --verbose

  SHELL

  config.vm.provision "puppet" do |puppet|
    puppet.binary_path = "/usr/local/bin"
    puppet.environment_path = "vagrant/environments"
    puppet.environment = "test"
  end

end

