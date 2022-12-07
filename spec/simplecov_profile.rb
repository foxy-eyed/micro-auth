# frozen_string_literal: true

require "simplecov"

# SimpleCov.minimum_coverage 90

SimpleCov.profiles.define "custom_profile" do
  add_filter "/config/"
  add_filter "/db/"
  add_filter "/spec/"
end
