# frozen_string_literal: true

Sequel.seed do
  def run
    users = create_users(10)
    users.sample(5).each { |user| create_session(user) }
  end

  def create_users(count)
    users = []
    count.times do
      users << User.create(name: Faker::Name.name, email: Faker::Internet.unique.email,
                           password: Faker::Alphanumeric.alpha(number: 8))
    end
    users
  end

  def create_session(user)
    user.add_session(Session.new)
  end
end
