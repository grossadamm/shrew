require 'rubygems'
require 'bundler/setup'

desc 'Default: run specs'
task default: :spec

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

Bundler::GemHelper.install_tasks

APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'