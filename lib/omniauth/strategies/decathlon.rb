require 'omniauth-oauth2'
require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Decathlon < OmniAuth::Strategies::OAuth2
      args %i[client_id client_secret]

      option :name, 'decathlon'
      option :client_options, {
        authorize_url: '/as/authorization.oauth2',
        token_url: '/as/token.oauth2'
      }

      def callback_url
        full_host + script_name + callback_path
      end

      def build_access_token
        options.token_params.merge!(:headers => {'Accept-Encoding'=>'none'})
        super
      end

      uid { raw_info['uid'] }

      info do
        {
          email: raw_info["mail"],
          nickname: raw_info["displayName"],
          name: raw_info["displayName"],
          image: raw_info["photourl"]
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.post('/idp/userinfo.openid', headers: {'Accept-Encoding'=>'none'}).parsed
      end
    end
  end
end
