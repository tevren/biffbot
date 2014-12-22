require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'dotenv/tasks'

desc 'Run supported specs'
RSpec::Core::RakeTask.new(:supported) do |task|
  task.pattern = 'spec/lib/supported/*_spec.rb'
  task.rspec_opts = ['--color', '--format', 'progress']
end

desc 'Run supported specs'
RSpec::Core::RakeTask.new(:unsupported) do |task|
  task.pattern = 'spec/lib/unsupported/*_spec.rb'
  task.rspec_opts = ['--color', '--format', 'progress']
end

desc 'Run rubocop tests'
task :rubocop do
  sh "bundle exec rubocop -c #{File.dirname(__FILE__)}/.rubocop.yml #{File.dirname(__FILE__)}"
end

task test: [:dotenv, :supported, :rubocop]
task default: [:test, :release]
