# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# transport
gem "bunny"
gem "puma"
gem "rack-contrib"
gem "sinatra", require: "sinatra/base"
gem "sinatra-contrib"

# business logic
gem "config"
gem "dry-monads"
gem "dry-types"
gem "dry-validation"
gem "jwt"

# persistence
gem "pg"
gem "sequel"
gem "sequel_secure_password"

# other
gem "rack-ougai"
gem "rack-request-id"
gem "rake"

group :test, :development do
  gem "faker"
  gem "rubocop", require: false
  gem "rubocop-rspec"
  gem "sequel-seed"
end

group :test do
  gem "database_cleaner-sequel"
  gem "factory_bot"
  gem "rack-test"
  gem "rspec"
  gem "simplecov", require: false
end
