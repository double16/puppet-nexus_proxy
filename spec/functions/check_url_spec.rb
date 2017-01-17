require 'spec_helper'

describe 'check_url' do
  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params().and_return(true) }
  it { is_expected.to run.with_params('bad url').and_return(false) }
  it { is_expected.to run.with_params('https://www.google.com').and_return(true) }
  it { is_expected.to run.with_params('http://www.nowhere.nada').and_return(false) }
  it { is_expected.to run.with_params('https://www.google.com', 'https://www.yahoo.com').and_return(true) }
  it { is_expected.to run.with_params('http://www.nowhere.nada', 'https://www.google.com').and_return(false) }
end
