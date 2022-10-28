# frozen_string_literal: true

class SessionRoutes < Application
  post "/" do
    result = { route: "create session", status: "success" }
    json result.to_json
  end

  get "/" do
    result = { route: "get session", status: "success" }
    json result.to_json
  end
end
