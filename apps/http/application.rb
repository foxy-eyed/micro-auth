# frozen_string_literal: true

module HTTP
  class Application < Sinatra::Base
    configure do
      register Sinatra::Namespace
      register Api::FailureProcessor

      set :app_file, File.expand_path("config.ru", __dir__)
    end

    configure :development do
      register Sinatra::Reloader

      set :show_exceptions, false
    end
  end
end
