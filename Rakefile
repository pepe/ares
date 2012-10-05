require 'rubygems'
require 'rake'
require 'ftools'
require 'rspec'
require 'rspec/core/rake_task'

desc "Runs all specs as default"
task :default => 'test:spec'

namespace :test do
  desc "Run all specs"
  RSpec::Core::RakeTask.new do |t|
    t.pattern = 'spec/erector/*_spec.rb'    
    t.rspec_opts = ['-u']
  end

  desc "Run all examples with RCov"
  RSpec::Core::RakeTask.new('rcov') do |t|
    t.pattern = 'spec/erector/*_spec.rb'    
    t.rcov = true
    t.rcov_opts = ['--exclude', 'spec']
  end
end

namespace :gems do
  desc "Install gems"
  task :install do
    exec 'gem install crack'
  end
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ares_cz"
    gem.summary = %Q{Simple ruby wrapper for Czech Ares service}
    gem.email = "josef.pospisil@laststar.eu"
    gem.homepage = "http://github.com/pepe/ares"
    gem.authors = ["Josef Pospisil"]
    gem.description = "Simple library for querying Ares system in Czech republic with translation of labels."
    gem.add_dependency('crack', '>= 0.1.4')
    IGNORE = [/\.gitignore$/, /VERSION$/]
    gem.files.reject! { |f| IGNORE.any? { |re| f.match(re) } }
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
