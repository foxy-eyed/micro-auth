# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { Faker::Alphanumeric.alpha(number: 8) }
  end
end
