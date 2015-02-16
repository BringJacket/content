require "rake"
require "rspec/core/rake_task"

task :default => :build
task :build => :test

desc "Runs all tests"
task :test => :spec

desc "Run all rspec tests"
begin
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/**/*_spec.rb"
  end
rescue LoadError => e
  raise e
  task :spec do
    $stderr.puts "Please install rspec: `gem install rspec`"
  end
end

task :environment do
  require_relative "app/env"
end

namespace :db do
  desc 'Migrate the database (destroys data)'
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate(
      'app/db/migrate', 
      ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    )
  end
end