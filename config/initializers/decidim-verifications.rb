# frozen_string_literal: true

require "decidim/verifications/omniauth/bosa_action_authorizer"

Decidim::Verifications.unregister_workflow(:csv_census)
Decidim::Verifications.unregister_workflow(:id_documents)
Decidim::Verifications.unregister_workflow(:postal_letter)
Decidim::Verifications.unregister_workflow(:sms)


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
  workflow.action_authorizer = "Decidim::Verifications::Omniauth::BosaActionAuthorizer"
  # workflow.form = "Decidim::Verifications::Omniauth::OmniauthAuthorizationForm"
  workflow.omniauth_provider = :saml
  workflow.minimum_age = 16
end
