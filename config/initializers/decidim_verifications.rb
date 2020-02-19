# frozen_string_literal: true

Decidim::Verifications.unregister_workflow(:csv_census)
Decidim::Verifications.unregister_workflow(:id_documents)
Decidim::Verifications.unregister_workflow(:postal_letter)
Decidim::Verifications.unregister_workflow(:sms)


# Decidim::Verifications.register_workflow(:decidim) do |workflow|
#   workflow.engine = Decidim::Verifications::Omniauth::Engine
#   workflow.admin_engine = Decidim::Verifications::Omniauth::AdminEngine
#   workflow.omniauth_provider = :decidim
#   # workflow.anti_affinity = [:decidim]
#   # workflow.minimum_age = 18
# end

Decidim::Verifications.register_workflow(:cas) do |workflow|
  workflow.engine = Decidim::Verifications::Omniauth::Engine
  workflow.admin_engine = Decidim::Verifications::Omniauth::AdminEngine
  workflow.action_authorizer = "Decidim::Verifications::Omniauth::UbxActionAuthorizer"
  # workflow.form = "Decidim::Verifications::Omniauth::OmniauthAuthorizationForm"
  workflow.omniauth_provider = :cas
  # workflow.anti_affinity = [:decidim]
  # workflow.minimum_age = 18
end
