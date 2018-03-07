require 'spec_helper'
describe 'nexus_proxy' do
  before :each do
    Puppet::Parser::Functions.newfunction(:generate, {:type => :rvalue}) { |args| 'HTTP/1.1 404 Not Found' }
  end

  context 'with defaults for all parameters' do
    it { should contain_nexus_repository('thirdparty').with(
      'label'         => '3rd party',
      'provider_type' => 'maven2',
      'type'          => 'hosted',
      'policy'        => 'release',
      'write_policy'  => 'allow_write_once',
      'browseable'    => true,
      'indexable'     => true,
      'exposed'       => true,
    ) }

    it { should contain_nexus_proxy__phantomjs('1.9.8') }
    it { should contain_nexus_proxy__phantomjs('2.1.1') }
    it { should contain_nexus_proxy__phantomjs('1.9.8') }
    it { should contain_nexus_proxy__phantomjs('2.1.1') }
    it { should contain_nexus_proxy__gradle('2.14.1') }
    it { should contain_nexus_proxy__gradle('3.5.1') }
    it { should contain_nexus_proxy__gradle('4.6') }
    it { should contain_nexus_proxy__node('8.10.0') }
    it { should contain_nexus_proxy__node('9.7.1') }
    it { should contain_nexus_proxy__grails('2.5.6') }
    it { should contain_nexus_proxy__grails('3.3.2') }

  end
end
