# frozen_string_literal: true

class SessionRoutes < Application
  post "/" do
    result = Sessions::Create.new.call(params)
    if result.success?
      status 201
    else
      process_failure(result)
    end
  end

  get "/" do
    result = { route: "get session", status: "success" }
    json result.to_json
  end
end
