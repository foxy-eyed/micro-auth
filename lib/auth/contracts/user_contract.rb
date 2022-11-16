# frozen_string_literal: true

module Auth
  class UserContract < BaseContract
    params do
      required(:name).filled(Auth::Types::Name)
      required(:email).filled(Auth::Types::Email)
      required(:password).filled(Auth::Types::Password)
    end

    rule(:email) do
      key.failure("email already exists") unless User.find(email: value).nil?
    end
  end
end
