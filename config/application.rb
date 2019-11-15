require_relative 'boot'

require 'rails/all'

# TODO : add missing dep to decidim-initiatives/lib/decidim/initiatives/engine.rb
# require "wicked_pdf"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DevelopmentApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.time_zone = "Europe/Paris"

    # This needs to be set for correct images URLs in emails
    # DON'T FORGET to ALSO set this in `config/initializers/carrierwave.rb`
    # config.action_mailer.asset_host = "https://participer.loire-atlantique.fr"

    config.after_initialize do
      if Decidim.geocoder.present?
        Geocoder.configure(
          lookup: :nominatim,
          :timeout  => 30
        )
      end
    end

    config.redirector.silence_sql_logs = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
