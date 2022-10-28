# frozen_string_literal: true

class User < Sequel::Model
  plugin :association_dependencies
  plugin :secure_password, include_validations: false

  one_to_many :sessions
  add_association_dependencies sessions: :delete
end
