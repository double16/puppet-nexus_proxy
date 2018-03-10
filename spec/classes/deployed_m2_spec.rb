require 'spec_helper'
describe 'nexus_proxy' do
  before :each do
    Puppet::Parser::Functions.newfunction(:generate, {:type => :rvalue}) { |args| 'HTTP/1.1 404 Not Found' }
  end

  context 'with defaults for all parameters' do
    it { should contain_nexus_proxy__proxy_m2('central').with(
      'label'          => 'Central',
      'remote_storage' => 'https://repo1.maven.org/maven2/',
    ) }
    
    it { should contain_nexus_proxy__proxy_m2('jcenter').with(
      'remote_storage' => 'https://jcenter.bintray.com/',
    ) }

    it { should contain_nexus_proxy__proxy_m2('grails-core').with(
      'remote_storage' => 'https://repo.grails.org/grails/core/',
    ) }

    it { should contain_nexus_proxy__proxy_m2('grails-plugins').with(
      'remote_storage' => 'http://repo.grails.org/grails/plugins/',
    ) }

    it { should contain_nexus_repository_group('public').with(
      'provider_type' => 'maven2',
      'exposed'       => true,
      'repositories'  => ['thirdparty', 'central', 'jcenter', 'grails-core', 'grails-plugins'],
    ) }
  end

  context 'with extra repos' do
    let(:params) { { 'm2_extra_repos' => ['releases', 'snapshots'] } }
    it { should contain_nexus_repository_group('public').with(
      'provider_type' => 'maven2',
      'exposed'       => true,
      'repositories'  => ['thirdparty', 'releases', 'snapshots', 'central', 'jcenter', 'grails-core', 'grails-plugins'],
    ) }
  end
end
