require 'spec_helper'
describe 'nexus_proxy' do

  context 'with defaults for all parameters' do
    it { should contain_class('nexus_proxy') }
  end
end
