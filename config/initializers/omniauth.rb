# frozen_string_literal: true

require 'omniauth/strategies/gardian_websso'

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger

  omniauth_config = Rails.application.secrets.dig(:omniauth)

  if omniauth_config[:gardian_websso].present?
    provider(
      OmniAuth::Strategies::GardianWebSSO,
      setup: setup_provider_proc(:gardian_websso,
        site: :site,
        client_id: :client_id,
        client_secret: :client_secret,
        callback_url: :callback_url,
        acr_values: :acr_values
      )
    )
  end
end
