require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DecidimAws
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = "Europe/Paris"
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]

    Decidim.unconfirmed_access_for = 0.days
    config.force_ssl = true

    # This needs to be set for correct images URLs in emails
    # DON'T FORGET to ALSO set this in `config/initializers/carrierwave.rb`
    # config.action_mailer.asset_host = ""

    # config.session_store :active_record_store,
    #   :key => '_decidim_session'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
