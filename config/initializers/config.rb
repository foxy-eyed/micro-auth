# frozen_string_literal: true

setting_files = Config.setting_files(
  File.expand_path("..", __dir__),
  ENV.fetch("RACK_ENV")
)

Config.load_and_set_settings(setting_files)
