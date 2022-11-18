# frozen_string_literal: true

module Core
  module Logger
    module_function

    def instance
      @instance ||= build_logger
    end

    def build_logger
      logger = Ougai::Logger.new(logger_io, level: Settings.logger.level)
      logger.before_log = lambda do |data|
        data[:service] = { name: Settings.app.name }
        data[:request_id] ||= Thread.current[:request_id]
      end
      logger
    end

    def logger_io
      log_path = File.join(File.expand_path("../..", __dir__), Settings.logger.log_path)
      ENV["RACK_ENV"] == "development" ? $stdout : log_path
    end
  end
end
