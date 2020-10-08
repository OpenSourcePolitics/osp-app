# frozen_string_literal: true

require 'omniauth-saml'

module OmniAuth
  module Strategies
    class NYC < OmniAuth::Strategies::SAML
      option :name, :nyc

      option :origin_param, 'redirect_url'

      option :authn_context_comparison, 'minimum'
      option :name_identifier_format, 'urn:oasis:names:tc:SAML:2.0:nameid-format:persistent'
      option :attribute_service_name, 'Eidas extra attributes'
      option :attribute_statements,
             name: %w[uid name],
             email: %w[mail email],
             first_name: %w[surname first_name firstname firstName],
             last_name: %w[givenName last_name lastname lastName],
             # default_locale: ['locale', 'urn:be:fedict:iam:attr:locale'],
             locale: ['PrefLanguage', 'pref_language', 'preflanguage', 'locale', 'urn:be:fedict:iam:attr:locale'],
             nickname: ['uid'],
             rrn: %w[egovNRN egovnrn egov_nrn nrn rrn]
      # authentication_method: ['authenticationmethod'],
      # authentication_level: ['urn:be:fedict:iam:attr:authenticationmethod'],
      # authentication_context: ['urn:be:fedict:iam:attr:context']
      option :idp_cert_fingerprint_validator, -> (fingerprint) { fingerprint }
      option :force_authn, true
      option :security,
             authn_requests_signed: true, # Enable or not signature on AuthNRequest
             logout_requests_signed: true, # Enable or not signature on Logout Request
             logout_responses_signed: true, # Enable or not signature on Logout Response
             want_assertions_signed: false, # Enable or not the requirement of signed assertion
             metadata_signed: true, # Enable or not signature on Metadata
             digest_method: XMLSecurity::Document::SHA1,
             signature_method: XMLSecurity::Document::RSA_SHA1,
             embed_sign: false

    end
  end
end

OmniAuth.config.add_camelization 'nyc', 'NYC'
