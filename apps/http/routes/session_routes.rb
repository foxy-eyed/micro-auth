# frozen_string_literal: true

module HTTP
  class SessionRoutes < Application
    post "/" do
      result = Auth::Sessions::Create.new.call(params)
      if result.success?
        session = result.value!
        meta = { token: JwtEncoder.new(Settings.app.secret).encode(uuid: session.uuid) }

        status 201
        json meta: meta
      else
        process_failure(result)
      end
    end

    get "/" do
      result = Auth::Sessions::Fetch.new.call(request.env["HTTP_AUTHORIZATION"])
      if result.success?
        session = result.value!
        meta = { user_id: session.user_id }

        status 200
        json meta: meta
      else
        process_failure(result)
      end
    end
  end
end
