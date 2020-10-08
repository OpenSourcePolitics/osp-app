# frozen_string_literal: true

require 'omniauth-saml'

module OmniAuth
  module Strategies
    class NYC < OmniAuth::Strategies::SAML
      option :name, :nyc

      option :origin_param, 'redirect_url'

      option :authn_context_comparison, 'minimum'
      option :name_identifier_format, 'urn:oasis:names:tc:SAML:2.0:nameid-format:persistent'
      option :attribute_statements,
             name: %w[name],
             email: %w[mail email],
             first_name: %w[givenName],
             last_name: %w[sn],
             nickname: ['uid', 'guid']
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

       info do
         found_attributes = options.attribute_statements.map do |key, values|
           attribute = find_attribute_by(values)
           [key, attribute]
         end

         hash_attributes = Hash[found_attributes]

         hash_attributes["name"] = "#{hash_attributes["first_name"]} #{hash_attributes["last_name"]}"

         if hash_attributes["first_name"].present? && hash_attributes["last_name"].present?
           hash_attributes["nickname"] = "#{hash_attributes["first_name"].split(" ").first}#{hash_attributes["last_name"][0]}".downcase
         end
       end

    end
  end
end

OmniAuth.config.add_camelization 'nyc', 'NYC'
