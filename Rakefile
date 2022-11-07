# frozen_string_literal: true

require "rake"

# rubocop
require "rubocop/rake_task"
RuboCop::RakeTask.new(:rubocop)

# load custom tasks
Rake.add_rakelib "lib/tasks"

task :environment do
  ENV["RACK_ENV"] ||= "development"
end

task lint: %w[rubocop]
