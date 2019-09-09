# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
end

if Rails.application.secrets.dig(:omniauth, :france_connect).present? && Rails.application.secrets.dig(:omniauth, :france_connect, :enabled)
  require "omniauth_openid_connect"
  require "omniauth/strategies/france_connect"

  ::Devise.setup do |config|
    config.omniauth :france_connect, {
      name: "france_connect",
      issuer: "https://" + Rails.application.secrets.dig(:omniauth, :france_connect, :host),
      scope: [:openid],
      client_signing_alg: :HS256,
      client_auth_method: :body,
      client_options: {
        host: Rails.application.secrets.dig(:omniauth, :france_connect, :host),
        authorization_endpoint: '/api/v1/authorize',
        token_endpoint: '/api/v1/token',
        userinfo_endpoint: '/api/v1/userinfo',
        jwks_uri: '/api/v1/jwk',
        identifier: Rails.application.secrets.dig(:omniauth, :france_connect, :identifier),
        secret: Rails.application.secrets.dig(:omniauth, :france_connect, :secret),
        redirect_uri: Rails.application.secrets.dig(:omniauth, :france_connect, :redirect_uri)
      }
    }
  end

  Decidim::User.omniauth_providers << :france_connect
end
