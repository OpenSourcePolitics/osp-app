# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
  # OmniAuth.config.allowed_request_methods = %i[get post delete]
  # Logger.new(STDOUT)
  OneLogin::RubySaml::Logging.logger = Rails.logger
end

if Rails.application.secrets.dig(:omniauth, :saml).present? && Rails.application.secrets.dig(:omniauth, :saml, :enabled)
  Devise.setup do |config|
    config.omniauth :saml,
      idp_sso_target_url: Rails.application.secrets.dig(:omniauth, :saml, :idp_sso_target_url),
      assertion_consumer_service_url: Rails.application.secrets.dig(:omniauth, :saml, :assertion_consumer_service_url),
      authn_context: Rails.application.secrets.dig(:omniauth, :saml, :authn_context),
      issuer: Rails.application.secrets.dig(:omniauth, :saml, :issuer),
      # protocol_binding: "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST",
      authn_context_comparison: "minimum",
      force_authn: false,
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
