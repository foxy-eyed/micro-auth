# frozen_string_literal: true

module Users
  class Create
    include Dry::Monads[:result, :try]
    include Dry::Monads::Do.for(:call)

    def initialize(contract = UserContract.new)
      @contract = contract
    end

    def call(params)
      attributes = yield validate_contract(params)
      create_user(attributes.to_h)
    end

    private

    attr_reader :contract

    def validate_contract(params)
      contract.call(params)
              .to_monad
              .or { |result| Failure([:unprocessable_entity, result.errors.to_h]) }
    end

    def create_user(attributes)
      Try[Sequel::Error] { User.create(**attributes) }.to_result
                                                      .or { |result| Failure([:db_error, result.exception.message]) }
    end
  end
end
