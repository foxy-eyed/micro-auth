# frozen_string_literal: true

module Api
  module ErrorSerializer
    extend self

    def from_messages(error_messages, meta: {})
      error_messages = Array(error_messages)
      { errors: build_errors(error_messages, meta) }
    end
    alias from_message from_messages

    def from_contract(errors)
      { errors: build_contract_errors(errors) }
    end

    private

    def build_errors(error_messages, meta)
      error_messages.map { |message| build_error(message, meta) }
    end

    def build_contract_errors(errors)
      errors.map do |key, messages|
        messages.map do |message|
          error = build_error(message)
          error[:source] = { pointer: "/data/attributes/#{key}" }
          error
        end
      end.flatten
    end

    def build_error(message, meta = {})
      error = { detail: message }
      error[:meta] = meta unless meta.empty?
      error
    end
  end
end
