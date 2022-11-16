# frozen_string_literal: true

module Auth
  class Session < Sequel::Model
    plugin :uuid

    many_to_one :user
  end
end
