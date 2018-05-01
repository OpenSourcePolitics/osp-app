Devise.setup do |config|
  if Rails.application.secrets.dig(:omniauth, :saml).present?
    config.omniauth :saml,
      idp_sso_target_url: Rails.application.secrets.omniauth[:saml][:idp_sso_target_url],
      assertion_consumer_service_url: Rails.application.secrets.omniauth[:saml][:assertion_consumer_service_url],
      authn_context: Rails.application.secrets.omniauth[:saml][:authn_context],
      issuer: Rails.application.secrets.omniauth[:saml][:issuer],
      protocol_binding: Rails.application.secrets.omniauth[:saml][:protocol_binding],
      authn_context_comparison: Rails.application.secrets.omniauth[:saml][:authn_context_comparison],
      authn_force: Rails.application.secrets.omniauth[:saml][:authn_force],
      idp_slo_target_url: Rails.application.secrets.omniauth[:saml][:idp_slo_target_url],
      name_identifier_format: Rails.application.secrets.omniauth[:saml][:name_identifier_format],
      uid_attribute: Rails.application.secrets.omniauth[:saml][:uid_attribute],
      idp_cert_fingerprint: Rails.application.secrets.omniauth[:saml][:idp_cert_fingerprint],
      idp_cert_fingerprint_validator: lambda { |fingerprint| fingerprint },
      idp_cert: Rails.application.secrets.omniauth[:saml][:idp_cert]
  end

  if Rails.application.secrets.dig(:omniauth, :facebook).present?
    config.omniauth :facebook,
      Rails.application.secrets.omniauth[:facebook][:app_id],
      Rails.application.secrets.omniauth[:facebook][:app_secret],
      scope: Rails.application.secrets.omniauth[:facebook][:scope],
      info_fields: Rails.application.secrets.omniauth[:facebook][:info_fields]
  end

end
