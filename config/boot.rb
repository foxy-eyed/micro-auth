# frozen_string_literal: true

require "bundler/setup"

Bundler.require(:default, ENV.fetch("RACK_ENV"))
