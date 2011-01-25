$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'sunspot'
require 'sunspot_plus'
require 'sunspot/session_proxy/abstract_session_proxy'
require 'spec'
require 'spec/autorun'
require 'helpers/delayed_job_stub'

Spec::Runner.configure do |config|
  
end
