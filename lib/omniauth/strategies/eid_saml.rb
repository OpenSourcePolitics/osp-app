require "omniauth-saml"

module OmniAuth
  module Strategies
    class EidSaml < OmniAuth::Strategies::SAML
      option :name, :eid_saml
      option :origin_param, "redirect_url"
    end
  end
end
