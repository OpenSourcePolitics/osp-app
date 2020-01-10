# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", git: "https://github.com/OpenSourcePolitics/decidim.git", branch: "alt/petition"
# gem "decidim-consultations", git: "https://github.com/OpenSourcePolitics/decidim.git", branch: "alt/petition"
gem "decidim-initiatives", git: "https://github.com/OpenSourcePolitics/decidim.git", branch: "alt/petition"

# gem "decidim", path: "../decidim"
# gem "decidim-consultations", path: "../decidim"
# gem "decidim-initiatives", path: "../decidim"

gem "decidim-term_customizer", git: "https://github.com/OpenSourcePolitics/decidim-module-term_customizer.git", branch: "0.dev"

# gem "omniauth-decidim", git: "https://github.com/OpenSourcePolitics/decidim.git"
# gem "decidim-omniauth_extras", git: "https://github.com/OpenSourcePolitics/decidim.git"
# gem "decidim-initiatives_extras", git: "https://github.com/OpenSourcePolitics/decidim.git"

# gem "omniauth-decidim", path: "../omniauth-decidim"
gem "decidim-omniauth_extras", path: "../decidim-module-omniauth_extras"
# gem "decidim-initiatives_extras", path: "../decidim-module-initiatives_extras"

# gem "decidim-blazer", path: "../decidim-module-blazer"

gem "bootsnap", "~> 1.3"

gem "puma", "~> 3.0"
gem "uglifier", "~> 4.1"

gem "faker", "~> 1.9"

# Avoid wicked_pdf require error
gem "wicked_pdf"
gem "wkhtmltopdf-binary"

gem "sprockets", "~> 3.7.2"

gem "ruby-saml", path: "../ruby-saml"
gem "omniauth-saml", path: "../omniauth-saml"

gem "dotenv-rails"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", git: "https://github.com/OpenSourcePolitics/decidim.git", branch: "alt/petition"
  # gem "decidim-dev", path: "../decidim"
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end

group :production do
  gem "sidekiq"
  gem "fog-aws"
  gem "dalli-elasticache"
end
