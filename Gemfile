# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# transport
gem "puma"
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
gem "rake"

group :test, :development do
  gem "rubocop", require: false
  gem "rubocop-rspec"
end

group :test do
  gem "database_cleaner-sequel"
  gem "factory_bot"
  gem "rack-test"
  gem "rspec"
  gem "simplecov", require: false
end
