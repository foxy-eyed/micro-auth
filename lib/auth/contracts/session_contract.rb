# frozen_string_literal: true

module Auth
  class SessionContract < BaseContract
    params do
      required(:email).filled(Auth::Types::Email)
      required(:password).filled(Auth::Types::String)
    end
  end
end
