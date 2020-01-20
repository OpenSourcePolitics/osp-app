require "omniauth_openid_connect"

module OmniAuth
  module Strategies
    class FranceConnectProfile < OmniAuth::Strategies::OpenIDConnect

      option :name, :france_connect_profile
      option :origin_param, "redirect_url"

      info do
        {
          name: "#{user_info.given_name} #{find_name}".strip,
          email: user_info.email,
          nickname: ::Decidim::UserBaseEntity.nicknamize(find_name),
          first_name: user_info.given_name&.strip,
          last_name: find_name&.strip,
          date_of_birth: user_info.birthdate
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
        return unless client_options.end_session_endpoint

        end_session_uri = URI(options.issuer + client_options.end_session_endpoint)
        end_session_uri.query = URI.encode_www_form(
          id_token_hint: credentials[:id_token],
          state: session_state,
          post_logout_redirect_uri: "#{full_host}/users/auth/#{options.name}/logout"
        )
        end_session_uri.to_s
      end

      private

      def redirect_uri
        return omniauth_callback_url unless params["redirect_uri"]

        "#{ omniauth_callback_url }?redirect_uri=#{ CGI.escape(params["redirect_uri"]) }"
      end

      def omniauth_callback_url
        full_host + script_name + callback_path
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
