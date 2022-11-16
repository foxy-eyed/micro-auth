# frozen_string_literal: true

module Auth
  module Sessions
    class Fetch < BaseService
      AUTH_TOKEN_PATTERN = /\ABearer (?<token>.+)\z/

      def call(auth_header)
        token = yield extract_token(auth_header)
        find_session(token["uuid"])
      end

      private

      def extract_token(auth_header)
        match_data = auth_header&.match(AUTH_TOKEN_PATTERN)
        matched_token = match_data&.named_captures&.fetch("token", nil)
        token = jwt_encoder.decode(matched_token)

        Success(token)
      rescue JWT::DecodeError
        Failure([:forbidden, "Invalid token"])
      end

      def find_session(uuid)
        session = Session.find(uuid: uuid)
        return Failure([:forbidden, "Invalid session"]) unless session

        Success(session)
      rescue PG::InvalidTextRepresentation
        Failure([:forbidden, "Invalid uuid"])
      end

      def jwt_encoder
        @jwt_encoder ||= JwtEncoder.new(Settings.app.secret)
      end
    end
  end
end
