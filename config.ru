# frozen_string_literal: true

require_relative "config/environment"
require_relative "config/boot"

map "/login" do
  run UserRoutes
end

map "/auth" do
  run SessionRoutes
end
