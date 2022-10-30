# frozen_string_literal: true

require "sinatra/extension"

module Api
  module FailureProcessor
    include Api::ErrorSerializer
    include Dry::Monads[:result]

    extend Sinatra::Extension

    helpers do
      def process_failure(result)
        case result
        in Failure[:unprocessable_entity, errors]
          status 422
          json ErrorSerializer.from_contract(errors)
        in Failure[:db_error, error]
          status 500
          json ErrorSerializer.from_message(error)
        end
      end
    end
  end
end