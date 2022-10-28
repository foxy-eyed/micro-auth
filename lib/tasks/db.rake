# frozen_string_literal: true

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |_t, args|
    Sequel.connect(Settings.db.to_hash) do |db|
      migrations = File.expand_path("../../db/migrations", __dir__)
      Sequel::Migrator.run(db, migrations, target: args[:version]&.to_i)
    end
  end
end
