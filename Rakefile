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
