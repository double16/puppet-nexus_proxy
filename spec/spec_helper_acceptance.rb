require 'beaker-rspec'
require 'beaker/puppet_install_helper'

UNSUPPORTED_PLATFORMS = ['windows', 'Darwin']

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'

  run_puppet_install_helper

  hosts.each do |host|
	on host, puppet('module install puppetlabs-stdlib')
	on host, puppet('module install atlassian-nexus_rest')
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      on host, "mkdir -p #{host['distmoduledir']}/nexus_proxy"
      %w(lib manifests templates metadata.json).each do |file|
        scp_to host, "#{proj_root}/#{file}", "#{host['distmoduledir']}/nexus_proxy"
      end
    end
  end
end
