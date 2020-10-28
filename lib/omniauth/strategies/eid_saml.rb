# frozen_string_literal: true

require "omniauth-saml"

module OmniAuth
  module Strategies
    class EidSaml < OmniAuth::Strategies::SAML

      option :name, :saml

      option :origin_param, "redirect_url"

      option :authn_context_comparison, "minimum"
      option :name_identifier_format, "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
      option :uid_attribute, "urn:be:fedict:iam:attr:fedid"
      option :attribute_service_name, 'Eidas extra attributes'
      option :attribute_statements, {
        name: ['uid','name'],
        email: ['mail', 'email'],
        first_name: ['surname', 'first_name', 'firstname', 'firstName'],
        last_name: ['givenName', 'last_name', 'lastname', 'lastName'],
        default_locale: ['locale', 'urn:be:fedict:iam:attr:locale'],
        locale: ['PrefLanguage', 'pref_language', 'preflanguage', 'locale', 'urn:be:fedict:iam:attr:locale'],
        nickname: ['uid'],
        rrn: ['egovNRN', 'egovnrn', 'egov_nrn', 'nrn', 'rrn'],
        # authentication_method: ['authenticationmethod'],
        # authentication_level: ['urn:be:fedict:iam:attr:authenticationmethod'],
        # authentication_context: ['urn:be:fedict:iam:attr:context']
      }
      option :idp_cert_fingerprint_validator, lambda { |fingerprint| fingerprint }
      option :force_authn, true

    end
  end
end

OmniAuth.config.add_camelization 'saml', 'SAML'
