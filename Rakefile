require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "sunspot_plus"
  gem.summary = %Q{Extensions for outoftime's sunspot gem.}
  gem.description = %Q{A library of extensions for outoftime's sunspot gem for solr indexing server. Using the session adapter design pattern to add support for:
    1) delayed_job to move indexing commits out of process.
    Support for case insensitive sort fields by creating indexed copy of fields transformed for sort.
  }
  gem.email = "louisgillies@yahoo.co.uk"
  gem.homepage = "http://github.com/playgood/sunspot_plus"
  gem.authors = ["Louis Gillies"]
  # gem.add_dependency "sunspot"
  # gem.add_dependency "delayed_job"
  gem.add_development_dependency "rspec", "1.3.0"
  gem.add_development_dependency "yard", ">= 0"
  gem.require_paths = ["lib"]
  gem.files = FileList['lib/**/*.rb']
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new

