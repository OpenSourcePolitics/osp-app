# frozen_string_literal: true

# require "omniauth-saml"
# require "omniauth_openid_connect"
require "omniauth-oauth2"
# require "omniauth-jwt"
# require "open-uri"

module OmniAuth
  module Strategies
    # class CultuurConnect < OmniAuth::Strategies::SAML
    # class CultuurConnect < OmniAuth::Strategies::OpenIDConnect
    class CultuurConnect < OmniAuth::Strategies::OAuth2
      args [:client_id, :client_secret, :site]

      option :name, :cultuur_connect
      option :site, nil
      option :client_options, {}
      option :origin_param, "redirect_url"

      uid do
        raw_info["id"]
      end

      info do
        raw_info
      end

      def client
        options.client_options[:site] = options.site
        options.client_options[:authorize_url] = URI.join(options.site, "/auth/authorize").to_s
        options.client_options[:token_url] = URI.join(options.site, "/auth/token").to_s
        super
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/me").parsed
      end

      # https://github.com/intridea/omniauth-oauth2/issues/81
      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
