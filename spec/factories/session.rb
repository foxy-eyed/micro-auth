# frozen_string_literal: true

FactoryBot.define do
  factory :session, class: Auth::Session do
    user
    uuid { SecureRandom.uuid }
  end
end
