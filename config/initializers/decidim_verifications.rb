# frozen_string_literal: true

require "decidim/verifications/omniauth/ubx_action_authorizer"

Decidim::Verifications.unregister_workflow(:csv_census)
Decidim::Verifications.unregister_workflow(:id_documents)
Decidim::Verifications.unregister_workflow(:postal_letter)
Decidim::Verifications.unregister_workflow(:sms)

Decidim::Verifications.register_workflow(:cas) do |workflow|
  workflow.engine = Decidim::Verifications::Omniauth::Engine
  workflow.admin_engine = Decidim::Verifications::Omniauth::AdminEngine
  workflow.omniauth_provider = :cas
end

Decidim::Verifications.register_workflow(:cas_student) do |workflow|
  workflow.engine = Decidim::Verifications::Omniauth::Engine
  workflow.admin_engine = Decidim::Verifications::Omniauth::AdminEngine
  workflow.action_authorizer = "Decidim::Verifications::Omniauth::UbxActionAuthorizer"
  workflow.omniauth_provider = :cas
end
