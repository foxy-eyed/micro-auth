# frozen_string_literal: true

module Auth
  class BaseService
    include Dry::Monads[:result, :do, :try]

    def initialize(contract = nil)
      @contract = contract
    end

    def call(_params)
      raise NotImplementedError
    end

    private

    attr_reader :contract

    def validate_contract(params)
      raise "Invalid contract passed to constructor" unless contract.is_a?(Dry::Validation::Contract)

      contract.call(params)
              .to_monad
              .or { |result| Failure([:unprocessable_entity, result.errors.to_h]) }
    end
  end
end
