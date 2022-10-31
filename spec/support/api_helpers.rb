# frozen_string_literal: true

module ApiHelpers
  include Rack::Test::Methods

  def app
    @app ||= described_class
  end

  def response_status
    last_response.status
  end

  def response_json
    JSON.parse(last_response.body)
  end

  def auth_header_for(user)
    session = create(:session, user: user)
    token = JwtEncoder.new(Settings.app.secret).encode(uuid: session.uuid)
    "Bearer #{token}"
  end
end
