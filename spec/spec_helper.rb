$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'sunspot'
require 'sunspot_matchers'
require 'sunspot_plus'
require 'sunspot/session_proxy/abstract_session_proxy'
require 'rspec'
require 'helpers/delayed_job_stub'

RSpec.configure do |config|
  config.before do
    Sunspot.session = SunspotMatchers::SunspotSessionSpy.new(Sunspot.session)
  end
  config.include SunspotMatchers
end

