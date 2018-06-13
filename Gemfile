# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", git: "https://github.com/OpenSourcePolitics/decidim.git", branch: "0.10-bosa-moderation"
# gem "decidim", path: "../decidim"

gem "decidim-polis", git: "https://github.com/OpenSourcePolitics/decidim-polis.git"

gem "decidim-export", git: "https://github.com/OpenSourcePolitics/decidim-user-export.git"

gem "high_voltage", "3.0.0"

gem "puma", "~> 3.0"
gem "uglifier", ">= 1.3.0"

gem "faker", "~> 1.8.4"

group :development, :test do
  gem "pry-byebug", platform: :mri

  gem "decidim-dev", git: "https://github.com/OpenSourcePolitics/decidim.git", branch: "0.10-bosa-moderation"
  # gem "decidim-dev", path: "../decidim"
  gem 'dotenv-rails'
end

group :development do
  gem "letter_opener_web", "~> 1.3.0"
  gem "listen", "~> 3.1.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end

group :production do
  gem 'passenger'
  gem 'fog-aws'
  gem 'dalli'
  gem 'sendgrid-ruby'
  gem 'newrelic_rpm'
  gem 'lograge', '~> 0.7.1'
  gem 'sentry-raven'
  gem 'sidekiq'
end
