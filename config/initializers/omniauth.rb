if Rails.application.secrets.dig(:omniauth, :decathlon).present? && Rails.application.secrets.dig(:omniauth, :decathlon, :enabled)
  require "omniauth/strategies/decathlon"

  Devise.setup do |config|
    config.omniauth :decathlon,
                    Rails.application.secrets.dig(:omniauth, :decathlon, :client_id),
                    Rails.application.secrets.dig(:omniauth, :decathlon, :client_secret),
                    client_options: {
                      site: Rails.application.secrets.dig(:omniauth, :decathlon, :site_url)
                    },
                    scope: "openid email profile"
  end

  Decidim::User.omniauth_providers << :decathlon
end
