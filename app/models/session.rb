# frozen_string_literal: true

class Session < Sequel::Model
  plugin :uuid

  many_to_one :user
end
