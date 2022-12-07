# frozen_string_literal: true

task settings: :environment do
  require "config"
  require_relative "../config/initializers/config"
end
