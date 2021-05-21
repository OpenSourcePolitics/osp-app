# frozen_string_literal: true

require "omniauth/strategies/france_connect_uid"
require "omniauth/strategies/france_connect_profile"

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
  # OmniAuth.config.allowed_request_methods = %i[get post delete]
end

if Rails.application.secrets.dig(:omniauth, :france_connect_uid).present? && Rails.application.secrets.dig(:omniauth, :france_connect_uid, :enabled)
  ::Devise.setup do |config|
    config.omniauth :france_connect_uid, {
      name: "france_connect_uid",
      issuer: "https://" + Rails.application.secrets.dig(:omniauth, :france_connect_uid, :host),
      scope: [:openid],
      client_signing_alg: :HS256,
      client_auth_method: :body,
      acr_values: "eidas1" ,
      client_options: {
        host: Rails.application.secrets.dig(:omniauth, :france_connect_uid, :host),
        authorization_endpoint: '/api/v1/authorize',
        token_endpoint: '/api/v1/token',
        userinfo_endpoint: '/api/v1/userinfo',
        jwks_uri: '/api/v1/jwk',
        end_session_endpoint: '/api/v1/logout',
        identifier: Rails.application.secrets.dig(:omniauth, :france_connect_uid, :identifier),
        secret: Rails.application.secrets.dig(:omniauth, :france_connect_uid, :secret),
        redirect_uri: Rails.application.secrets.dig(:omniauth, :france_connect_uid, :redirect_uri)
      }
    }
  end

  Decidim::User.omniauth_providers << :france_connect_uid
end

if Rails.application.secrets.dig(:omniauth, :france_connect_profile).present? && Rails.application.secrets.dig(:omniauth, :france_connect_profile, :enabled)
  ::Devise.setup do |config|
    config.omniauth :france_connect_profile, {
      name: "france_connect_profile",
      issuer: "https://" + Rails.application.secrets.dig(:omniauth, :france_connect_profile, :host),
      # scope: [:openid, :email, :given_name, :family_name, :preferred_username, :birthdate],
      scope: [:openid, :email, :given_name, :family_name, :birthdate],
      client_signing_alg: :HS256,
      client_auth_method: :body,
      acr_values: "eidas1" ,
      client_options: {
        host: Rails.application.secrets.dig(:omniauth, :france_connect_profile, :host),
        authorization_endpoint: '/api/v1/authorize',
        token_endpoint: '/api/v1/token',
        userinfo_endpoint: '/api/v1/userinfo',
        jwks_uri: '/api/v1/jwk',
        end_session_endpoint: '/api/v1/logout',
        identifier: Rails.application.secrets.dig(:omniauth, :france_connect_profile, :identifier),
        secret: Rails.application.secrets.dig(:omniauth, :france_connect_profile, :secret),
        redirect_uri: Rails.application.secrets.dig(:omniauth, :france_connect_profile, :redirect_uri)
      }
    }
  end

  Decidim::User.omniauth_providers << :france_connect_profile
end

Decidim::Verifications.unregister_workflow(:decidim)
Decidim::Verifications.unregister_workflow(:saml)
Decidim::Verifications.unregister_workflow(:csv_census)
Decidim::Verifications.unregister_workflow(:postal_letter)
Decidim::Verifications.unregister_workflow(:id_documents)
