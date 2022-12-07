# frozen_string_literal: true

require_relative "../../lib/core/logger"

Sequel.connect(Settings.db.to_hash)

Sequel::Model.db.extension(:pagination)
Sequel::Model.db.loggers.push(Core::Logger.instance)
Sequel::Model.plugin :timestamps, update_on_create: true

Sequel.default_timezone = :utc
