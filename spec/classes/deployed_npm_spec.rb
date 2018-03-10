require 'spec_helper'
describe 'nexus_proxy' do
  before :each do
    Puppet::Parser::Functions.newfunction(:generate, {:type => :rvalue}) { |args| 'HTTP/1.1 404 Not Found' }
  end

  context 'with defaults for all parameters' do
    it { should contain_nexus_proxy__proxy_npm('npmjs').with(
      'remote_storage' => 'https://registry.npmjs.org/',
    ) }

    it { should contain_nexus_repository_group('npm-all').with(
      'provider_type' => 'npm',
      'exposed'       => true,
      'repositories'  => ['npmjs'],
    ) }
  end

  context 'with extra repos' do
    let(:params) { { 'npm_extra_repos' => ['releases', 'snapshots'] } }
    it { should contain_nexus_repository_group('npm-all').with(
      'provider_type' => 'npm',
      'exposed'       => true,
      'repositories'  => ['releases', 'snapshots', 'npmjs'],
    ) }
  end
end
