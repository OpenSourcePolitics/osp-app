# frozen_string_literal: true

require "omniauth_openid_connect"

module OmniAuth
  module Strategies
    class GardianWebSSO < OmniAuth::Strategies::OpenIDConnect

      option :name, :gardian_websso
      option :origin_param, "redirect_uri"

      option :site
      option :client_id
      option :client_secret
      option :callback_url

      option :scope, [:openid, :uid, :email, :mail, :cn]
      option :send_scope_to_token_endpoint, false

      info do
        {
          name: user_info.raw_attributes["cn"].strip,
          email: user_info.raw_attributes["mail"] || user_info.raw_attributes["email"],
          nickname: user_info.raw_attributes["uid"].strip
        }
      end

      def authorize_uri
        super.gsub('+','%20')
      end

      private

      def issuer
        options.site
      end

      def client_options
        site_url = URI(options.site)

        _client_options = {
          host: site_url.host,
          port: site_url.port,
          identifier: options.client_id,
          secret: options.client_secret,
          authorization_endpoint: '/gardianwebsso/oauth2/multiauth/authorize',
          token_endpoint: '/gardianwebsso/oauth2/multiauth/access_token',
          userinfo_endpoint: '/gardianwebsso/oauth2/multiauth/userinfo',
          jwks_uri: '/gardianwebsso/oauth2/multiauth/connect/jwk_uri'
        }

        options.client_options.merge _client_options
      end

      def omniauth_callback_url
        options.callback_url
      end

      def redirect_uri
        return omniauth_callback_url unless params["redirect_uri"]

        "#{ omniauth_callback_url }?redirect_uri=#{ CGI.escape(params["redirect_uri"]) }"
      end
    end
  end
end
