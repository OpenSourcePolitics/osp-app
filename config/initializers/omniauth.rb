# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger
end

if Rails.application.secrets.dig(:omniauth, :cas).present? && Rails.application.secrets.dig(:omniauth, :cas, :enabled)
  Devise.setup do |config|
    config.omniauth :cas, host: Rails.application.secrets.dig(:omniauth, :cas, :host)
  end

  Decidim::User.omniauth_providers << :cas
end
