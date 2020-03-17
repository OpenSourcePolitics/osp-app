# frozen_string_literal: true

require "omniauth/strategies/france_connect"

module OmniAuth
  module Strategies
    class FranceConnectProfile < OmniAuth::Strategies::FranceConnect

      option :name, :france_connect_profile
      option :scope, [:openid, :birthdate]

      info do
        { date_of_birth: user_info.birthdate }
      end
    end
  end
end
