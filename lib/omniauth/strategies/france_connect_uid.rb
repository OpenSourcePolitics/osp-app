# frozen_string_literal: true

require "omniauth/strategies/france_connect"
require "zlib"

module OmniAuth
  module Strategies
    class FranceConnectUid < OmniAuth::Strategies::FranceConnect

      option :name, :france_connect_uid
      option :scope, [:openid]

      info do
        {
          name: "Anonyme",
          nickname: uid.truncate(::Decidim::User.nickname_max_length),
          email: ""
        }
      end
    end
  end
end
