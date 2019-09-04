# frozen_string_literal: true

if Rails.application.secrets.dig(:omniauth, :rivp).present? && Rails.application.secrets.dig(:omniauth, :rivp, :enabled)
  require "omniauth/strategies/rivp"
  require "extends/app/commands/decidim/create_omniauth_registration_extend.rb"

  Devise.setup do |config|
    config.omniauth :rivp,
                    Rails.application.secrets.dig(:omniauth, :rivp, :authorization_uri),
                    Rails.application.secrets.dig(:omniauth, :rivp, :client_secret)
  end

  Decidim::User.omniauth_providers << :rivp
end
