# frozen_string_literal: true

require "omniauth/strategies/eid_saml"

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
  OneLogin::RubySaml::Logging.logger = Rails.logger

  omniauth_config = Rails.application.secrets.dig(:omniauth)

  if omniauth_config[:saml].present?
    provider(
      :saml,
      setup: setup_provider_proc(:saml,
        provider_name: :provider_name,
        icon_path: :icon_path,
        idp_cert_fingerprint: :idp_cert_fingerprint,
        idp_cert: :idp_cert,
        certificate: :idp_cert,
        private_key: :idp_key,
        client_secret: :client_secret,
        issuer: :issuer,
        authn_context: :authn_context,
        assertion_consumer_service_url: :assertion_consumer_service_url,
        idp_sso_target_url: :idp_sso_target_url,
        idp_slo_target_url: :idp_slo_target_url
      ),
      authn_context_comparison: "minimum",
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
      force_authn: true,
      security: {
        authn_requests_signed: true,     # Enable or not signature on AuthNRequest
        logout_requests_signed:  true,     # Enable or not signature on Logout Request
        logout_responses_signed:  true,     # Enable or not signature on Logout Response
        want_assertions_signed:  true,     # Enable or not the requirement of signed assertion
        metadata_signed:  true,     # Enable or not signature on Metadata
        digest_method:  XMLSecurity::Document::SHA1,
        signature_method:  XMLSecurity::Document::RSA_SHA1,
        embed_sign:  false
      }
    )
  end
end
