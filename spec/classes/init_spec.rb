require 'spec_helper'
describe 'nexus_proxy' do
  before :each do
    Puppet::Parser::Functions.newfunction(:generate, {:type => :rvalue}) { |args| 'HTTP/1.1 404 Not Found' }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('nexus_proxy') }
  end
end
