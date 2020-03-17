# frozen_string_literal: true

require "omniauth_openid_connect"

module OmniAuth
  module Strategies
    class FranceConnect < OmniAuth::Strategies::OpenIDConnect

      option :name, :france_connect
      option :origin_param, "redirect_url"

      option :site
      option :client_id
      option :client_secret
      option :end_session_endpoint

      option :scope, [:openid, :email, :preferred_username]
      option :client_signing_alg, :HS256
      option :client_auth_method, :body
      option :acr_values, "eidas1"

      info do
        {
          name: "#{user_info.given_name} #{find_name}".strip,
          email: user_info.email,
          nickname: ::Decidim::UserBaseEntity.nicknamize(find_name),
          first_name: user_info.given_name&.strip,
          last_name: find_name&.strip
        }
      end

      def find_name
        user_info.preferred_username.blank? ? user_info.family_name : user_info.preferred_username
      end

      def authorize_uri
        super + (options.acr_values.present? ? "&acr_values=#{options.acr_values}" : "")
      end

      def auth_hash
        hash = super
        hash.logout = end_session_uri
        hash
      end

      def end_session_uri
        return unless client_options.end_session_endpoint.present?

        end_session_uri = URI(options.issuer + client_options.end_session_endpoint)
        end_session_uri.query = URI.encode_www_form(
          id_token_hint: credentials[:id_token],
          state: session_state,
          post_logout_redirect_uri: "#{full_host}/users/auth/#{options.name}/logout"
        )
        end_session_uri.to_s
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
          authorization_endpoint: '/api/v1/authorize',
          token_endpoint: '/api/v1/token',
          userinfo_endpoint: '/api/v1/userinfo',
          jwks_uri: '/api/v1/jwk'
        }

        if options.end_session_endpoint.present?
          _client_options[:end_session_endpoint] = options.end_session_endpoint
        end

        options.client_options.merge _client_options
      end

      def redirect_uri
        return omniauth_callback_url unless params["redirect_uri"]

        "#{ omniauth_callback_url }?redirect_uri=#{ CGI.escape(params["redirect_uri"]) }"
      end

      def omniauth_callback_url
        full_host + script_name + callback_path
      end

      def new_state
        session['omniauth.state'] = SecureRandom.hex(16)
      end

      def session_state
        session['omniauth.state'] = params["state"] || SecureRandom.hex(16)
      end

      def other_phase
        call_app!
      end
    end
  end
end
