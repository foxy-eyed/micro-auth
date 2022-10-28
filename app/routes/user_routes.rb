# frozen_string_literal: true

class UserRoutes < Application
  get "/" do
    result = { route: "user", status: "success" }
    json result.to_json
  end
end
