# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format pretty"
  end

  task :features => 'db:test:prepare'
rescue LoadError
  desc 'Cucumber rake task not available'
  task :features do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end

task default: [:spec, :teaspoon, :features]

desc "Start the server"
task "server", [:port] do |t, args|
    default_port = "$PORT"
    host = "$IP"

    port_arg = args.port
    port = port_arg ? port_arg : default_port

    puts "Start server: http://#{host}:#{port}/"
    start_server_cmd = "rails server -p #{port} -b #{host}"

    sh start_server_cmd
end