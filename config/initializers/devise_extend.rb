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
      attribute_service_name: 'Eidas extra attributes',
      attribute_statements: {
        name: ['uid','name'],
        email: ['mail', 'email'],
        first_name: ['surname', 'first_name', 'firstname', 'firstName'],
        last_name: ['givenName', 'last_name', 'lastname', 'lastName']
      },
      idp_cert_fingerprint: Rails.application.secrets.omniauth[:saml][:idp_cert_fingerprint],
      idp_cert_fingerprint_validator: lambda { |fingerprint| fingerprint },
      idp_cert: Rails.application.secrets.omniauth[:saml][:idp_cert]
  end

  if Rails.application.secrets.dig(:omniauth, :facebook).present?
    config.omniauth :facebook,
      Rails.application.secrets.omniauth[:facebook][:app_id],
      Rails.application.secrets.omniauth[:facebook][:app_secret],
      secure_image_url: true,
      scope: 'email',
      info_fields: 'email'
  end

  if Rails.application.secrets.dig(:omniauth, :google_oauth2).present?
    config.omniauth :google_oauth2,
      Rails.application.secrets.omniauth[:google_oauth2][:client_id],
      Rails.application.secrets.omniauth[:google_oauth2][:client_secret],
      scope: ['email']
  end

  if Rails.application.secrets.dig(:omniauth, :twitter).present?
    config.omniauth :twitter,
      Rails.application.secrets.omniauth[:twitter][:api_key],
      Rails.application.secrets.omniauth[:twitter][:api_secret],
      x_auth_access_type: 'read'
  end

end
