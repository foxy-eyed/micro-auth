# frozen_string_literal: true

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] => :settings do |_t, args|
    require "sequel/core"
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      db.extension :schema_dumper

      migrations = File.expand_path("../db/migrations", __dir__)
      Sequel::Migrator.run(db, migrations, target: args[:version]&.to_i)

      schema_file = File.join(File.expand_path("../db", __dir__), "schema.rb")
      File.write(schema_file, db.dump_schema_migration(same_db: true))
    end
  end

  desc "DB seed"
  task seed: :settings do
    require "sequel"
    require "sequel/extensions/seed"
    require_relative "../config/boot"
    Sequel::Seed.setup(ENV.fetch("RACK_ENV"))
    Sequel.extension :seed

    Sequel.connect(Settings.db.to_hash) do |db|
      Sequel::Seeder.apply(db, File.expand_path("../db/seeds", __dir__))
    end
  end
end
