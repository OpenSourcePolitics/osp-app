# frozen_string_literal: true

require "omniauth-saml"
require "savon"
require "akami"
require "onelogin/ruby-saml/utils"

module OmniAuth
  module Strategies
    class EidSaml < OmniAuth::Strategies::SAML

      option :name, :saml

      option :origin_param, "redirect_url"
      option :person_services, {
        proxy: ""
      }

      option :authn_context_comparison, "minimum"
      option :name_identifier_format, "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
      option :uid_attribute, "urn:be:fedict:iam:attr:fedid"
      option :attribute_service_name, 'Eidas extra attributes'
      option :attribute_statements, {
        name: ['uid','name'],
        email: ['mail', 'email'],
        first_name: ['surname', 'first_name', 'firstname', 'firstName'],
        last_name: ['givenName', 'last_name', 'lastname', 'lastName'],
        # default_locale: ['locale', 'urn:be:fedict:iam:attr:locale'],
        locale: ['PrefLanguage', 'pref_language', 'preflanguage', 'locale', 'urn:be:fedict:iam:attr:locale'],
        nickname: ['uid'],
        rrn: ['egovNRN', 'egovnrn', 'egov_nrn', 'nrn', 'rrn'],
        # authentication_method: ['authenticationmethod'],
        # authentication_level: ['urn:be:fedict:iam:attr:authenticationmethod'],
        # authentication_context: ['urn:be:fedict:iam:attr:context']
      }
      option :idp_cert_fingerprint_validator, lambda { |fingerprint| fingerprint }
      option :force_authn, true
      option :security, {
        authn_requests_signed: true,     # Enable or not signature on AuthNRequest
        logout_requests_signed:  true,     # Enable or not signature on Logout Request
        logout_responses_signed:  true,     # Enable or not signature on Logout Response
        want_assertions_signed:  true,     # Enable or not the requirement of signed assertion
        metadata_signed:  true,     # Enable or not signature on Metadata
        digest_method:  XMLSecurity::Document::SHA1,
        signature_method:  XMLSecurity::Document::RSA_SHA1,
        embed_sign:  false
      }

      info do
        found_attributes = options.attribute_statements.map do |key, values|
          attribute = find_attribute_by(values)
          [key, attribute]
        end

        Hash[found_attributes].merge(@person_response.presence || {})
      end

      def handle_response(raw_response, opts, settings)
        super(raw_response, opts, settings) do
          if @response_object.success?
            @person_response = person_services_request(options.merge(settings: settings), find_attribute_by(options.attribute_statements["rrn"]))
          end
          yield
        end
      end

      def person_services_request(opts, person_id)
        if opts.dig(:person_services, :wsdl).present?
          Rails.logger.debug "PersonServices request initiated for #{person_id}..."
          ps_client = Savon.client(
            wsdl: opts[:person_services][:wsdl],
            proxy: opts[:person_services][:proxy],

            log: true,
            logger: Rails.logger,
            pretty_print_xml: true,

            namespace_identifier: :v3,
            env_namespace: :soapenv,
            namespaces: {
              "xmlns:head" => "http://fsb.belgium.be/header"
            },

            soap_header: {
              "head:fsbHeader" => {
                "head:message_id" => person_id
              }
            },

            wsse_timestamp: true,
            wsse_signature: Akami::WSSE::Signature.new(
              Akami::WSSE::Certs.new(
                cert_string: format_cert(opts[:person_services][:cert] + opts[:person_services][:ca_cert]),
                private_key_string: format_private_key(opts[:person_services][:key]),
                private_key_password: opts[:person_services][:secret]
              ),{
                timestamp: true,
                created_at: _tmp_stp = Time.now - 10,
                expires_at: _tmp_stp + 300
              }
            ),

            # ssl_cert: OpenSSL::X509::Certificate.new(format_cert(opts[:person_services][:cert])),
            # ssl_ca_cert: OpenSSL::X509::Certificate.new(format_cert(opts[:person_services][:ca_cert])),
            # ssl_cert_key: OpenSSL::PKey::RSA.new(format_private_key(opts[:person_services][:key]), opts[:person_services][:secret])
          )
          begin
            # if ps_client.operations.include?(:echo)
            #   response = ps_client.call(:echo, message: person_id)
            # end

            if ps_client.operations.include?(:get_person)
              response = ps_client.call(:get_person, message: {
                user_context: {
                  person_number: person_id,
                  langage: "en"
                },
                person_number: person_id
              })
            end

            Rails.logger.debug response
            return response.body
          rescue => e
            Rails.logger.error "Could not operation :get_person in #{ps_client.operations} : #{e}"
            return {
              date_of_birth: Faker::Date.birthday(17, 65),
              address: Faker::Address.full_address,
              scope_id: Decidim::Scope.where("parent_id IS NOT NULL").order('RANDOM()').first.id
            }
          end
        end
      end

      # Return a properly formatted x509 certificate
      #
      # @param cert [String] The original certificate
      # @return [String] The formatted certificate
      #
      def format_cert(cert)
        OneLogin::RubySaml::Utils.format_cert(cert)
      end

      # Return a properly formatted private key
      #
      # @param key [String] The original private key
      # @return [String] The formatted private key
      #
      # Adapted from OneLogin::RubySaml::Utils.format_private_key
      # to manage encryption lines
      # see https://github.com/onelogin/ruby-saml/blob/c652374ddfee884f260bce2eb1eb1e63161304f6/lib/onelogin/ruby-saml/utils.rb#L66
      def format_private_key(key)
        # don't try to format an encoded private key or if is empty
        return key if key.nil? || key.empty? || key.match(/\x0d/)

        # is this an rsa key?
        rsa_key = key.match("RSA PRIVATE KEY")
        key = key.gsub(/\-{5}\s?(BEGIN|END)( RSA)? PRIVATE KEY\s?\-{5}/, "")

        encryption_headers = ""
        if key.match(/\S*\-\S*: \S*/)
          key.scan(/\S*\-\S*: \S*/).each do |header|
            encryption_headers += "#{header}\n"
            key = key.gsub(header, "")
          end
          encryption_headers += "\n"
        end
        key = key.gsub(/\n/, "")
        key = key.gsub(/\r/, "")
        key = key.gsub(/\s/, "")
        key = key.scan(/.{1,64}/)
        key = key.join("\n")
        key_label = rsa_key ? "RSA PRIVATE KEY" : "PRIVATE KEY"
        "-----BEGIN #{key_label}-----\n#{encryption_headers}#{key}\n-----END #{key_label}-----"
      end
    end
  end
end

OmniAuth.config.add_camelization 'saml', 'SAML'
