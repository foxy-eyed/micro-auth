# frozen_string_literal: true

class SessionContract < Dry::Validation::Contract
  params do
    required(:email).filled(::Types::Email)
    required(:password).filled(::Types::String)
  end
end
