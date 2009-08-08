require 'rubygems'
require 'rake'
require 'ftools'
require 'spec'
require 'spec/rake/spectask'

desc "Runs all specs as default"
task :default => 'test:spec'

namespace :test do
  desc "Run all specs"
  Spec::Rake::SpecTask.new do |t|
    t.spec_files = FileList['spec/*_spec.rb']
    t.spec_opts = ['-u']
  end



  desc "Run all examples with RCov"
  Spec::Rake::SpecTask.new('rcov') do |t|
    t.spec_files = FileList['spec/*_spec.rb']
    t.rcov = true
    t.rcov_opts = ['--exclude', 'spec']
  end
end

namespace :gems do
  desc "Install gems"
  task :install do
    exec 'gem install activesupport'
  end
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ares"
    gem.summary = %Q{Simple ruby wrapper for Czech Ares service}
    gem.email = "pepe@gravastar.cz"
    gem.homepage = "http://github.com/pepe/ares"
    gem.authors = ["Josef Pospisil"]
    gem.description = "Simple library for querying Ares system in Czech republic with translation of labels."
    gem.add_dependency('activesupport', '>= 1.4.0')
    IGNORE = [/\.gitignore$/, /VERSION$/]
    gem.files.reject! { |f| IGNORE.any? { |re| f.match(re) } }
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
