# frozen_string_literal: true

module Decidim
  # Helper that provides methods to enable or disable omniauth buttons
  module OmniauthHelper
    # Public: returns true if the social provider is enabled
    def social_provider_enabled?(provider)
      current_organization.enabled_omniauth_providers.key?(provider.to_sym)
    end

    # Public: returns true if any provider is enabled
    def any_social_provider_enabled?
      current_organization.enabled_omniauth_providers.any?
    end

    # Public: normalize providers names to they can be used for buttons
    # and icons.
    def normalize_provider_name(provider)
      provider.to_s.titleize
    end

    # Public: icon for omniauth buttons
    def oauth_icon(provider)
      return unless social_provider_enabled?(provider)
      info = current_organization.enabled_omniauth_providers[provider]

      if info
        icon_path = info[:icon_path]
        return external_icon(icon_path) if icon_path

        name = info[:icon]
      end

      name ||= provider.to_s.split("_").first
      icon(name)
    end

    # Public: pretty print provider name
    def provider_name(provider)
      provider.to_s.gsub(/_|-/, " ").camelize
    end
  end
end
