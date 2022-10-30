# frozen_string_literal: true

class UserRoutes < Application
  post "/" do
    result = Users::Create.new.call(params)
    if result.success?
      status 201
    else
      process_failure(result)
    end
  end
end
