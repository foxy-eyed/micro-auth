# frozen_string_literal: true

Sequel.seed do
  def run
    users = []
    10.times do
      users << User.create(name: Faker::Name.name,
                           email: Faker::Internet.unique.email,
                           password: Faker::Alphanumeric.alpha(number: 8))
    end
    users.sample(5).each do |user|
      user.add_session(Session.new)
    end
  end
end
