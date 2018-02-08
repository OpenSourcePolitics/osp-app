require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DevelopmentApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    Decidim.menu :menu do |menu|
      current_organization.navbar_links.each do |navbar_link|
        menu.item translated_attribute(navbar_link.title),
                  navbar_link.link,
                  position: navbar_link.weight,
                  active: :exact,
                  target: navbar_link.target
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
