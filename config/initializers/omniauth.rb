# frozen_string_literal: true

require "omniauth/strategies/ubx"

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger

  omniauth_config = Rails.application.secrets.dig(:omniauth)

  if omniauth_config[:cas].present?
    provider(
      :cas,
      setup: setup_provider_proc(:cas,
        host: :host
      )
    )
  end

end

# if Rails.application.secrets.dig(:omniauth, :cas).present? && Rails.application.secrets.dig(:omniauth, :cas, :enabled)
#   Devise.setup do |config|
#     config.omniauth :cas, host: Rails.application.secrets.dig(:omniauth, :cas, :host)
#   end
#
#   Decidim::User.omniauth_providers << :cas
# end
