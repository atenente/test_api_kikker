source "https://rubygems.org"

ruby "3.4.2"

gem "rails", "~> 8.0.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "rack-cors"
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rubocop-rails"
  gem "simplecov"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end
