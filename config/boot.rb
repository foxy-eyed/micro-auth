# frozen_string_literal: true

require "bundler/setup"

Bundler.require(:default, ENV.fetch("RACK_ENV"))

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "app"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

# require File.join(File.expand_path("..", __dir__), "config/initializers/config")
# require File.join(File.expand_path("..", __dir__), "config/initializers/db")

Dir[File.expand_path("../config/**/*.rb", __dir__)].each { |f| require f }
Dir[File.expand_path("../lib/**/*.rb", __dir__)].each { |f| require f }
Dir[File.expand_path("../app/**/*.rb", __dir__)].each { |f| require f }
