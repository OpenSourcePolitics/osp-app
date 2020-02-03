# frozen_string_literal: true

Decidim::Verifications.register_workflow(:dummy_authorization_handler) do |workflow|
  workflow.form = "DummyAuthorizationHandler"
  # workflow.action_authorizer = "DummyActionAuthorizer"
end

# Decidim::Verifications.register_workflow(:decidim) do |workflow|
#   workflow.engine = Decidim::Verifications::Omniauth::Engine
#   workflow.admin_engine = Decidim::Verifications::Omniauth::AdminEngine
#   # workflow.form = "Decidim::Verifications::Omniauth::OmniauthAuthorizationForm"
#   workflow.omniauth_provider = :decidim
#   workflow.expires_in = 1.month
# end

Decidim::Verifications.register_workflow(:saml) do |workflow|
  workflow.engine = Decidim::Verifications::Omniauth::Engine
  workflow.admin_engine = Decidim::Verifications::Omniauth::AdminEngine
  # workflow.form = "Decidim::Verifications::Omniauth::OmniauthAuthorizationForm"
  workflow.omniauth_provider = :saml
end
