# frozen_string_literal: true

require 'omniauth-saml'
require 'savon'
require 'signer'
require 'nokogiri'

require 'pry'

module OmniAuth
  module Strategies
    class EidSaml < OmniAuth::Strategies::SAML
      option :name, :saml

      option :origin_param, 'redirect_url'

      option :authn_context_comparison, 'minimum'
      option :name_identifier_format, 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient'
      option :uid_attribute, 'urn:be:fedict:iam:attr:fedid'
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
             want_assertions_signed: true, # Enable or not the requirement of signed assertion
             metadata_signed: true, # Enable or not signature on Metadata
             digest_method: XMLSecurity::Document::SHA1,
             signature_method: XMLSecurity::Document::RSA_SHA1,
             embed_sign: false

      option :person_services_wsdl, nil
      option :person_services_cert, nil
      option :person_services_ca_cert, nil
      option :person_services_key, nil
      option :person_services_secret, nil
      option :person_services_proxy, nil
      option :person_services_fallback_rrn, nil

      option :enable_scope_mapping, false
      option :scope_mapping_level_id, nil

      info do
        found_attributes = options.attribute_statements.map do |key, values|
          attribute = find_attribute_by(values)
          [key, attribute]
        end

        hash_attributes = Hash[found_attributes]

        hash_attributes["name"] = "#{hash_attributes["last_name"]} #{hash_attributes["first_name"]}"

        if hash_attributes["first_name"].present? && hash_attributes["last_name"].present?
          hash_attributes["nickname"] = "#{hash_attributes["first_name"].split(" ").first}#{hash_attributes["last_name"][0]}".downcase
        end

        if @person_services_response.present?
          official_birth_date_day = @person_services_response.dig(:"v3:get_person_response", :"v2:basic_natural_person", :"v21:basic_person", :"v21:official_birth_date", :"v22:day")
          official_birth_date_month = @person_services_response.dig(:"v3:get_person_response", :"v2:basic_natural_person", :"v21:basic_person", :"v21:official_birth_date", :"v22:month")
          official_birth_date_year = "#{@person_services_response.dig(:"v3:get_person_response", :"v2:basic_natural_person", :"v21:basic_person", :"v21:official_birth_date", :"v22:century")}#{@person_services_response.dig(:"v3:get_person_response", :"v2:basic_natural_person", :"v21:basic_person", :"v21:official_birth_date", :"v22:year")}"

          if official_birth_date_day.present? && official_birth_date_month.present? && official_birth_date_year.present?
            hash_attributes["official_birth_date"] = Date.strptime("#{official_birth_date_day}/#{official_birth_date_month}/#{official_birth_date_year}", '%d/%m/%Y')
          end

          hash_attributes["postal_code"] = @person_services_response.dig(:"v3:get_person_response", :"v2:basic_natural_person", :"v1:address", :"v1:structured_address", :"v1:municipality", :"v11:code")
          hash_attributes["municipality"] = @person_services_response.dig(:"v3:get_person_response", :"v2:basic_natural_person", :"v1:address", :"v1:structured_address", :"v1:municipality", :"v11:description")
        end

        if ActiveModel::Type::Boolean.new.cast(options[:enable_scope_mapping]) && hash_attributes["postal_code"].present?
          scope = Decidim::Scope.find_by_code(hash_attributes["postal_code"])

          if options[:scope_mapping_level_id].present?
            scope = scope.part_of_scopes.find { |s| s.scope_type_id.to_s == options[:scope_mapping_level_id] }
          end

          hash_attributes["scope_id"] = scope.id
        end

        hash_attributes
      end

      def handle_response(raw_response, opts, settings)
        super(raw_response, opts, settings) do
          if @response_object.success?
            begin
              @person_services_response = person_services_request(options.merge(settings: settings), find_attribute_by(options.attribute_statements['rrn']))
              if @person_services_response.present? && @person_services_response.dig(:"v3:get_person_response", :"v1:error").present?
                Rails.logger.error @person_services_response
                # @person_services_response = nil
                @person_services_response = person_services_request(options.merge(settings: settings), options[:person_services_fallback_rrn]) if options[:person_services_fallback_rrn].present?
              end
            rescue Savon::SOAPFault => e
              Rails.logger.error e.to_hash
              @person_services_response = person_services_request(options.merge(settings: settings), options[:person_services_fallback_rrn]) if options[:person_services_fallback_rrn].present?
              # session["person_services_message_id"] = e.to_hash.dig(:"soapenv:fault", :detail, :message_id)
              # session["person_services_error"] = e.message
              # session["person_services_error_code"] = e.to_hash.dig(:"soapenv:fault", :detail, :"err:error", :code, :code)
              # session["person_services_error_description"] = e.to_hash.dig(:"soapenv:fault", :detail, :"err:error", :code, :description)
            rescue Savon::HTTPError => e
              Rails.logger.error e.to_hash
              session["person_services_error"] = "HTTPError (#{e.http.code}) : #{e.message}"
            rescue Savon::InvalidResponseError => e
              Rails.logger.error e.to_hash
              session["person_services_error"] = "InvalidResponseError : #{e.message}"
            rescue Exception => e
              Rails.logger.error e.message
              session["person_services_error"] = "#{e.class} : #{e.message}"
            end
          end

          @response_object = nil
          yield
        end
      end

      def person_services_request(opts, person_id)
        Rails.logger.debug "PersonServices request initiated for #{person_id}..."

        cert_file = opts[:person_services_cert]
        ca_cert_file = opts[:person_services_cert]
        key_file = opts[:person_services_key]
        password = opts[:person_services_secret]

        ps_client = Savon.client(
          wsdl: opts[:person_services_wsdl],
          # proxy: opts[:person_services_proxy],

          log: true,
          logger: Logger.new(STDOUT),
          pretty_print_xml: false,

          namespace_identifier: :v31,
          env_namespace: :soapenv,
          namespaces: {
            'xmlns:head' => 'http://fsb.belgium.be/header',
            'xmlns:v1' => 'http://fsb.belgium.be/data/business/context/v1_00',
            'xmlns:v3' => 'http://fsb.belgium.be/getPersonService/v3_00',
            'xmlns:v31' => 'http://fsb.belgium.be/getPersonService/messages/v3_00'
          },
          strip_namespaces: false,

          soap_header: {
            'head:fsbHeader' => {
              'head:messageId' => SecureRandom.uuid
            }
          },
          wsse_timestamp: true
        )

        if ps_client.operations.include?(:get_person)

          # Build a request to produce its xml
          request = ps_client.build_request(:get_person, message_tag: :getPersonRequest, message: {
                                              "v1:userContext": {
                                                "v1:personNumber": person_id,
                                                "v1:language": 'en'
                                              },
                                              "v31:personNumber": person_id
                                            })
          xml = request.body
          doc = Nokogiri::XML(xml)

          # Sign xml using Signer
          signer = Signer.new(doc.to_xml(encoding: 'UTF-8', indent: 0))
          signer.cert = OpenSSL::X509::Certificate.new(OneLogin::RubySaml::Utils.format_cert(cert_file + ca_cert_file))
          signer.private_key = OpenSSL::PKey::RSA.new(OneLogin::RubySaml::Utils.format_private_key(key_file), password)
          signer.ds_namespace_prefix = 'ds'

          signer.document.xpath('//soapenv:Body').each do |node|
            signer.digest!(node, inclusive_namespaces: %w[head soapenv v1 v3 v31 xsd xsi])
          end
          signer.document.xpath('//u:Timestamp', 'u' => 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd').each do |node|
            signer.digest!(node, inclusive_namespaces: %w[wsse head soapenv v1 v3 v31 xsd xsi])
          end

          signer.sign!(security_token: true, inclusive_namespaces: %w[head soapenv v1 v3 v31 xsd xsi])
          signed_xml = signer.to_xml

          # Making an actual call to API
          response = ps_client.call(:get_person, message_tag: :getPersonRequest, xml: signed_xml)

          # Handle the response
          Rails.logger.debug response
          Rails.logger.debug '----------------------------------'
          Rails.logger.debug response.body
          return response.body
        end
      end
    end
  end
end

OmniAuth.config.add_camelization 'saml', 'SAML'
