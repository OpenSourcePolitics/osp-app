# frozen_string_literal: true

require 'omniauth/strategies/nyc'

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger

  omniauth_config = Rails.application.secrets.dig(:omniauth)

  if omniauth_config[:nyc].present?
    provider(
      OmniAuth::Strategies::NYC,
      setup: setup_provider_proc(:nyc,
        icon_path: :icon_path,
        idp_cert_fingerprint: :idp_cert_fingerprint,
        idp_cert: :idp_cert,
        certificate: :idp_cert,
        private_key: :idp_key,
        issuer: :issuer,
        authn_context: :authn_context,
        assertion_consumer_service_url: :assertion_consumer_service_url,
        idp_sso_target_url: :idp_sso_target_url,
        idp_slo_target_url: :idp_slo_target_url
      )
    )
  end
end
