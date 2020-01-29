# frozen_string_literal: true

require "omniauth/strategies/decidim"

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
  omniauth_config = Rails.application.secrets.dig(:omniauth)

  if omniauth_config[:decidim].present?
    provider(
      :decidim,
      setup: setup_provider_proc(:decidim, client_id: :client_id, client_secret: :client_secret, site: :site_url),
      scope: :public
    )
  end
end
