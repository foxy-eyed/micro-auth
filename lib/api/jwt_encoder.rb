# frozen_string_literal: true

class JwtEncoder
  def initialize(secret)
    @secret = secret
  end

  def encode(payload)
    JWT.encode(payload, @secret)
  end

  def decode(token)
    JWT.decode(token, @secret).first
  end
end
