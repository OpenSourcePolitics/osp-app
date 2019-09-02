# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
end

if Rails.application.secrets.dig(:omniauth, :facebook).present?
  Devise.setup do |config|
    config.omniauth :facebook,
      Rails.application.secrets.omniauth[:facebook][:app_id],
      Rails.application.secrets.omniauth[:facebook][:app_secret],
      scope: 'email',
      info_fields: 'email'
  end
end

if Rails.application.secrets.dig(:omniauth, :google_oauth2).present?
  Devise.setup do |config|
    config.omniauth :google_oauth2,
      Rails.application.secrets.omniauth[:google_oauth2][:client_id],
      Rails.application.secrets.omniauth[:google_oauth2][:client_secret],
      scope: ['email']
  end
end

if Rails.application.secrets.dig(:omniauth, :twitter).present?
  Devise.setup do |config|
    config.omniauth :twitter,
      Rails.application.secrets.omniauth[:twitter][:api_key],
      Rails.application.secrets.omniauth[:twitter][:api_secret],
      x_auth_access_type: 'read'
  end
end

if Rails.application.secrets.dig(:omniauth, :saml).present? && Rails.application.secrets.dig(:omniauth, :saml, :enabled)
  require "omniauth-saml"

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
        last_name: ['givenName', 'last_name', 'lastname', 'lastName']
      },
      idp_cert_fingerprint: Rails.application.secrets.dig(:omniauth, :saml, :idp_cert_fingerprint),
      idp_cert_fingerprint_validator: lambda { |fingerprint| fingerprint },
      idp_cert: Rails.application.secrets.dig(:omniauth, :saml, :idp_cert)
  end

  Decidim::User.omniauth_providers << :saml
end
