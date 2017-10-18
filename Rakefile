# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

begin
    require 'rubygems'
    require 'cucumber'
    require 'cucumber/rake/task'
    
    Cucumber::Rake::Task.new(:features) do |t|
      t.cucumber_opts = "features --format pretty"
    end
rescue LoadError
end

require 'rake/testtask'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end