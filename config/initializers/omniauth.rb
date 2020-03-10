# frozen_string_literal: true

require "omniauth/strategies/ubx"

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger

  omniauth_config = Rails.application.secrets.dig(:omniauth)

  if omniauth_config[:cas].present?
    provider(
      OmniAuth::Strategies::UBX,
      setup: setup_provider_proc(:cas,
        host: :host
      )
    )
  end

end
