require 'sunspot'
require 'sunspot_plus/session_proxy/delayed_job_session_proxy'
require 'sunspot_plus/session_proxy/silent_fail_session_proxy'
require 'sunspot_plus/session_proxy/delayed_job/indexing_job'
require 'sunspot_plus/session_proxy/delayed_job/safe_configuration'
require 'sunspot_plus/type/case_insensitive_sort_type'
require 'sunspot_plus/dsl/fields'
require 'sunspot_plus/dsl/query/case_insensitive_sort'

Sunspot::DSL::FieldQuery.extend SunspotPlus::DSL::Query::CaseInsensitiveSort