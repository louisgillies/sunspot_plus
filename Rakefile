require 'rubygems'
require 'rake'
gem 'rspec', '1.3.0'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "sunspot_plus"
    gem.summary = %Q{Extensions for outoftime's sunspot gem.}
    gem.description = %Q{A library of extensions for outoftime's sunspot gem for solr indexing server. Using the session adapter design pattern to add support for:
      1) delayed_job to move indexing commits out of process.
    }
    gem.email = "louisgillies@yahoo.co.uk"
    gem.homepage = "http://github.com/playgood/sunspot_plus"
    gem.authors = ["Louis Gillies"]
    gem.add_dependency "sunspot"
    gem.add_dependency "delayed_job"
    gem.add_development_dependency "rspec", "1.3.0"
    gem.add_development_dependency "yard", ">= 0"
    gem.require_paths = ["lib"]
    gem.files = FileList['lib/**/*.rb']
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
