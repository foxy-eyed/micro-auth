# frozen_string_literal: true

module Auth
  module Types
    include Dry.Types()

    Id = Params::Integer.constrained(gt: 0)
    Name = String.constrained(min_size: 1, max_size: 255, format: /\A\w+\z/)
    Email = Types.Constructor(String, &:downcase).constrained(format: URI::MailTo::EMAIL_REGEXP)
    Password = String.constrained(min_size: 8, max_size: 255, format: /\A[a-z0-9]+\z/i)
  end
end
