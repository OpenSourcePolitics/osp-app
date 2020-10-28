# frozen_string_literal: true

require "omniauth/strategies/eid_saml"

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
  OneLogin::RubySaml::Logging.logger = Rails.logger

  omniauth_config = Rails.application.secrets.dig(:omniauth)

  if omniauth_config[:saml].present?
    provider(
      OmniAuth::Strategies::EidSaml,
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
      )
    )
  end
end
