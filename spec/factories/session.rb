# frozen_string_literal: true

FactoryBot.define do
  factory :session do
    user
    uuid { SecureRandom.uuid }
  end
end
