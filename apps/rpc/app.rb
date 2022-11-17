# frozen_string_literal: true

require_relative "../../config/environment"
require_relative "../../config/boot"
Dir[File.expand_path("consumers/**/*.rb", __dir__)].each { |f| require f }
