require 'puppetlabs_spec_helper/module_spec_helper'
require 'simplecov'
SimpleCov.start
at_exit { RSpec::Puppet::Coverage.report! }
