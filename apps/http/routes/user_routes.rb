# frozen_string_literal: true

module HTTP
  class UserRoutes < Application
    post "/" do
      result = Auth::Users::Create.new.call(params)
      if result.success?
        status 201
      else
        process_failure(result)
      end
    end
  end
end
