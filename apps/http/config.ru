# frozen_string_literal: true

require_relative "../../config/environment"
require_relative "../../config/boot"

use Rack::JSONBodyParser

map "/signup" do
  run HTTP::UserRoutes
end

map "/auth" do
  run HTTP::SessionRoutes
end
