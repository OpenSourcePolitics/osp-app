# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
  # OmniAuth.config.allowed_request_methods = %i[get post delete]
end


# if Rails.application.secrets.dig(:omniauth, :france_connect_uid).present? && Rails.application.secrets.dig(:omniauth, :france_connect_uid, :enabled)
#   ::Devise.setup do |config|
#     config.omniauth :france_connect_uid,
#       Rails.application.secrets.dig(:omniauth, :france_connect_uid, :identifier),
#       Rails.application.secrets.dig(:omniauth, :france_connect_uid, :secret),
#       Rails.application.secrets.dig(:omniauth, :france_connect_uid, :host)
#   end
#
#   Decidim::User.omniauth_providers << :france_connect_uid
# end
#
# if Rails.application.secrets.dig(:omniauth, :france_connect_profile).present? && Rails.application.secrets.dig(:omniauth, :france_connect_profile, :enabled)
#   ::Devise.setup do |config|
#     config.omniauth :france_connect_profile,
#       Rails.application.secrets.dig(:omniauth, :france_connect_profile, :identifier),
#       Rails.application.secrets.dig(:omniauth, :france_connect_profile, :secret),
#       Rails.application.secrets.dig(:omniauth, :france_connect_profile, :host)
#   end
#
#   Decidim::User.omniauth_providers << :france_connect_profile
# end

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
      scope: [:openid, :email, :identite_pivot],
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

if Rails.application.secrets.dig(:omniauth, :decidim).present? && Rails.application.secrets.dig(:omniauth, :decidim, :enabled)
  ::Devise.setup do |config|
    config.omniauth :decidim,
      Rails.application.secrets.dig(:omniauth, :decidim, :client_id),
      Rails.application.secrets.dig(:omniauth, :decidim, :client_secret),
      Rails.application.secrets.dig(:omniauth, :decidim, :site_url),
      scope: :public
  end

  Decidim::User.omniauth_providers << :decidim
end

if Rails.application.secrets.dig(:omniauth, :saml).present? && Rails.application.secrets.dig(:omniauth, :saml, :enabled)
  Devise.setup do |config|
    config.omniauth :saml,
      idp_sso_target_url: Rails.application.secrets.dig(:omniauth, :saml, :idp_sso_target_url),
      assertion_consumer_service_url: Rails.application.secrets.dig(:omniauth, :saml, :assertion_consumer_service_url),
      authn_context: Rails.application.secrets.dig(:omniauth, :saml, :authn_context),
      issuer: Rails.application.secrets.dig(:omniauth, :saml, :issuer),
      protocol_binding: "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST",
      authn_context_comparison: "minimum",
      authn_force: false,
      idp_slo_target_url: Rails.application.secrets.dig(:omniauth, :saml, :idp_slo_target_url),
      name_identifier_format: "urn:oasis:names:tc:SAML:2.0:nameid-format:transient",
      uid_attribute: "urn:be:fedict:iam:attr:fedid",
      attribute_service_name: 'Eidas extra attributes',
      attribute_statements: {
        name: ['uid','name'],
        email: ['mail', 'email'],
        first_name: ['surname', 'first_name', 'firstname', 'firstName'],
        last_name: ['givenName', 'last_name', 'lastname', 'lastName'],
        default_locale: ['locale', 'urn:be:fedict:iam:attr:locale'],
        locale: ['PrefLanguage', 'pref_language', 'preflanguage', 'locale', 'urn:be:fedict:iam:attr:locale'],
        nickname: ['uid'],
        rrn: ['egovNRN', 'egovnrn', 'egov_nrn', 'nrn', 'rrn'],
        authentication_method: ['authenticationmethod'],
        authentication_level: ['urn:be:fedict:iam:attr:authenticationmethod'],
        authentication_context: ['urn:be:fedict:iam:attr:context']
      },
      idp_cert_fingerprint: Rails.application.secrets.dig(:omniauth, :saml, :idp_cert_fingerprint),
      idp_cert_fingerprint_validator: lambda { |fingerprint| fingerprint },
      idp_cert: Rails.application.secrets.dig(:omniauth, :saml, :idp_cert)
  end

  Decidim::User.omniauth_providers << :saml
end
