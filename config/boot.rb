# frozen_string_literal: true

require "bundler/setup"

Bundler.require(:default, ENV.fetch("RACK_ENV"))

def require_dir(path)
  Dir[File.expand_path(path, __dir__)].each { |f| require f }
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "app"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require_dir("../lib/**/*.rb")
require_dir("../config/initializers/*.rb")
require_dir("../config/**/*.rb")
require_dir("../app/**/*.rb")
