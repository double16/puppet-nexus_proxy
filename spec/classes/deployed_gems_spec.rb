require 'spec_helper'
describe 'nexus_proxy' do
  before :each do
    Puppet::Parser::Functions.newfunction(:generate, {:type => :rvalue}) { |args| 'HTTP/1.1 404 Not Found' }
  end

  context 'with defaults for all parameters' do
    it { should contain_nexus_proxy__proxy_gems('rubygems').with(
      'remote_storage' => 'https://rubygems.org/',
    ) }

    it { should contain_nexus_repository_group('gems').with(
      'provider_type' => 'rubygems',
      'exposed'       => true,
      'repositories'  => ['rubygems'],
    ) }
  end

  context 'with extra repos' do
    let(:params) { { 'gems_extra_repos' => ['releases', 'snapshots'] } }
    it { should contain_nexus_repository_group('gems').with(
      'provider_type' => 'rubygems',
      'exposed'       => true,
      'repositories'  => ['releases', 'snapshots', 'rubygems'],
    ) }
  end
end
