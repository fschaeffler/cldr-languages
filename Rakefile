require 'bundler/gem_tasks'

# make Travis CI compliant
require 'rspec/core/rake_task'

task :default => :spec

desc "Run the specs."
task :spec do
  RSpec::Core::RakeTask.new do |t|
    t.pattern = "spec/*/*_spec.rb"
  end
end