# frozen_string_literal: true

# Decidim::Verifications.unregister_workflow(:decidim)
# Decidim::Verifications.unregister_workflow(:saml)

Decidim::Verifications.unregister_workflow(:csv_census)
Decidim::Verifications.unregister_workflow(:id_documents)
Decidim::Verifications.unregister_workflow(:postal_letter)
Decidim::Verifications.unregister_workflow(:sms)

Decidim::Verifications.register_workflow(:france_connect_uid) do |workflow|
  workflow.engine = Decidim::Verifications::Omniauth::Engine
  workflow.admin_engine = Decidim::Verifications::Omniauth::AdminEngine
  workflow.omniauth_provider = :france_connect_uid
  workflow.anti_affinity = [:france_connect_profile]
end

Decidim::Verifications.register_workflow(:france_connect_profile) do |workflow|
  workflow.engine = Decidim::Verifications::Omniauth::Engine
  workflow.admin_engine = Decidim::Verifications::Omniauth::AdminEngine
  workflow.omniauth_provider = :france_connect_profile
  workflow.anti_affinity = [:france_connect_uid]
  workflow.minimum_age = 18
end
