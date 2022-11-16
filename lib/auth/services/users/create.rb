# frozen_string_literal: true

module Auth
  module Users
    class Create < BaseService
      def initialize(contract = UserContract.new)
        super(contract)
      end

      def call(params)
        attributes = yield validate_contract(params)
        create_user(attributes.to_h)
      end

      private

      def create_user(attributes)
        Try[Sequel::Error] { User.create(**attributes) }.to_result
                                                        .or { |result| Failure([:db_error, result.exception.message]) }
      end
    end
  end
end
