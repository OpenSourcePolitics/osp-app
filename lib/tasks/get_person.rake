# frozen_string_literal: true

require "decidim/core"


desc "Usage: rake get_person <host> <provider>"
task get_person: :environment do |task|
  ARGV.each { |a| task a.to_sym do ; end }

  if ARGV.count != 3
    Rails.logger.error "Missing arguments ! Found : #{ARGV.drop(1)}"
    Rails.logger.error "Usage: rake get_person <host> <provider>"
    exit 1
  end

  if Decidim::Organization.exists?(:host => ARGV[1])
    @organization = Decidim::Organization.find_by(:host => ARGV[1])
  else
    Rails.logger.error "Could not find any organization with host \"#{ARGV[1]}\""
    exit 1
  end

  @person_services_options = @organization.enabled_omniauth_providers[ARGV[2].to_sym]

  if @person_services_options.blank?
    Rails.logger.error "No settings found for provider #{ARGV[2]}"
    Rails.logger.error "Settings available #{@organization.enabled_omniauth_providers.keys}"
    exit 1
  end

  @person_services_options.select! {|k,v| k.to_s.starts_with? "person_services" }

  Rails.logger.debug "Testing GetPerson request with params"
  @person_services_options.each do |k,v|
    Rails.logger.debug "-- #{k} --"
    Rails.logger.debug v
  end

  person_services_request(@person_services_options, @person_services_options[:person_services_fallback_rrn])

  Rails.logger.close
  exit
end

def person_services_request(opts, person_id)
  Rails.logger.debug "PersonServices request initiated for #{person_id}..."

  cert_file = opts[:person_services_cert]
  ca_cert_file = opts[:person_services_cert]
  key_file = opts[:person_services_key]
  password = opts[:person_services_secret]

  ps_client = Savon.client(
    wsdl: opts[:person_services_wsdl],
    proxy: opts[:person_services_proxy],

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
