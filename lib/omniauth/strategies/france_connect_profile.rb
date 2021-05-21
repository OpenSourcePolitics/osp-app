# frozen_string_literal: true

require "omniauth/strategies/france_connect"

module OmniAuth
  module Strategies
    class FranceConnectProfile < OmniAuth::Strategies::FranceConnect

      option :name, :france_connect_profile
      option :scope, [:email, :openid, :birthdate, :given_name, :family_name]

      info do
        {
          name: "#{user_info.given_name&.split(" ")&.first} #{find_name}".strip,
          email: user_info.email,
          nickname: ::Decidim::UserBaseEntity.nicknamize(find_name),
          first_name: user_info.given_name&.strip,
          last_name: find_name&.strip,
          date_of_birth: user_info.birthdate
        }
      end
    end
  end
end
