# frozen_string_literal: true

class UserContract < Dry::Validation::Contract
  params do
    required(:name).filled(::Types::Name)
    required(:email).filled(::Types::Email)
    required(:password).filled(::Types::Password)
  end

  rule(:email) do
    key.failure("email already exists") unless User.find(email: value).nil?
  end
end
