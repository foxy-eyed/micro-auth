# frozen_string_literal: true

module Auth
  module Sessions
    class Create < BaseService
      def initialize(contract = SessionContract.new)
        super(contract)
      end

      def call(params)
        attributes = yield validate_contract(params)
        user = yield authenticate(attributes)
        create_session(user)
      end

      private

      def authenticate(attributes)
        user = User.find(email: attributes[:email])

        if user&.authenticate(attributes[:password])
          Success(user)
        else
          Failure([:unauthorized, "Authentication failed: wrong email or password"])
        end
      end

      def create_session(user)
        session = Session.new
        Try[Sequel::Error] { user.add_session(session) }.to_result
                                                        .or { |result| Failure([:db_error, result.exception.message]) }
      end
    end
  end
end
