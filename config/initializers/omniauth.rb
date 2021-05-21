# frozen_string_literal: true

require "omniauth/strategies/france_connect_uid"
require "omniauth/strategies/france_connect_profile"

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
  omniauth_config = Rails.application.secrets.dig(:omniauth)

  if omniauth_config[:france_connect_uid].present?
    provider(
      :france_connect_uid,
      setup: setup_provider_proc(:france_connect_uid,
        site: :site,
        client_id: :client_id,
        client_secret: :client_secret,
        end_session_endpoint: :end_session_endpoint,
        icon_path: :icon_path,
        button_path: :button_path,
        provider_name: :provider_name,
        minimum_age: :minimum_age
      )
    )
  end

  if omniauth_config[:france_connect_profile].present?
    provider(
      :france_connect_profile,
      setup: setup_provider_proc(:france_connect_profile,
        site: :site,
        client_id: :client_id,
        client_secret: :client_secret,
        end_session_endpoint: :end_session_endpoint,
        icon_path: :icon_path,
        button_path: :button_path,
        provider_name: :provider_name,
        minimum_age: :minimum_age
      )
    )
  end
end

# if Rails.application.secrets.dig(:omniauth, :france_connect_uid).present? && Rails.application.secrets.dig(:omniauth, :france_connect_uid, :enabled)
#   ::Devise.setup do |config|
#     config.omniauth :france_connect_uid, {
#       name: "france_connect_uid",
#       issuer: "https://" + Rails.application.secrets.dig(:omniauth, :france_connect_uid, :host),
#       scope: [:openid],
#       client_signing_alg: :HS256,
#       client_auth_method: :body,
#       acr_values: "eidas1" ,
#       client_options: {
#         host: Rails.application.secrets.dig(:omniauth, :france_connect_uid, :host),
#         authorization_endpoint: '/api/v1/authorize',
#         token_endpoint: '/api/v1/token',
#         userinfo_endpoint: '/api/v1/userinfo',
#         jwks_uri: '/api/v1/jwk',
#         end_session_endpoint: '/api/v1/logout',
#         identifier: Rails.application.secrets.dig(:omniauth, :france_connect_uid, :identifier),
#         secret: Rails.application.secrets.dig(:omniauth, :france_connect_uid, :secret),
#         redirect_uri: Rails.application.secrets.dig(:omniauth, :france_connect_uid, :redirect_uri)
#       }
#     }
#   end
#
#   Decidim::User.omniauth_providers << :france_connect_uid
# end
#
# if Rails.application.secrets.dig(:omniauth, :france_connect_profile).present? && Rails.application.secrets.dig(:omniauth, :france_connect_profile, :enabled)
#   ::Devise.setup do |config|
#     config.omniauth :france_connect_profile, {
#       name: "france_connect_profile",
#       issuer: "https://" + Rails.application.secrets.dig(:omniauth, :france_connect_profile, :host),
#       # scope: [:openid, :email, :given_name, :family_name, :preferred_username, :birthdate],
#       scope: [:openid, :email, :given_name, :family_name, :birthdate],
#       client_signing_alg: :HS256,
#       client_auth_method: :body,
#       acr_values: "eidas1" ,
#       client_options: {
#         host: Rails.application.secrets.dig(:omniauth, :france_connect_profile, :host),
#         authorization_endpoint: '/api/v1/authorize',
#         token_endpoint: '/api/v1/token',
#         userinfo_endpoint: '/api/v1/userinfo',
#         jwks_uri: '/api/v1/jwk',
#         end_session_endpoint: '/api/v1/logout',
#         identifier: Rails.application.secrets.dig(:omniauth, :france_connect_profile, :identifier),
#         secret: Rails.application.secrets.dig(:omniauth, :france_connect_profile, :secret),
#         redirect_uri: Rails.application.secrets.dig(:omniauth, :france_connect_profile, :redirect_uri)
#       }
#     }
#   end
#
#   Decidim::User.omniauth_providers << :france_connect_profile
# end
