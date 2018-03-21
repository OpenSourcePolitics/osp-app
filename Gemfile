# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", git: "https://github.com/OpenSourcePolitics/decidim.git", ref: '1b922d151160fca53b98a7fe4c87a80c0839ca41'

gem "decidim-export", git: "https://github.com/OpenSourcePolitics/decidim-user-export.git"

# Uncomment the following line if you want to use decidim-assemblies plugin
gem "decidim-assemblies", git: "https://github.com/OpenSourcePolitics/decidim.git", ref: '1b922d151160fca53b98a7fe4c87a80c0839ca41'

gem "puma", "~> 3.0"
gem "uglifier", ">= 1.3.0"

gem "faker", "~> 1.8.4"

group :development, :test do
  gem "pry-byebug", platform: :mri

  gem "decidim-dev", git: "https://github.com/OpenSourcePolitics/decidim.git", ref: '1b922d151160fca53b98a7fe4c87a80c0839ca41'
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
  gem 'lograge', "~>0.7.1"
  gem 'sentry-raven'
  gem 'sidekiq'
end
