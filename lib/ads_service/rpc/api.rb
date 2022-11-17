# frozen_string_literal: true

module AdsService
  module RPC
    module API
      def verify_session(session)
        payload = if session.nil?
                    { status: "unauthorized" }
                  else
                    { status: "success", user_id: session.user_id }
                  end
        publish(payload.to_json, type: "auth")
      end
    end
  end
end
