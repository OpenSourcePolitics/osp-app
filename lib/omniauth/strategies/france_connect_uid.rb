# frozen_string_literal: true

require "omniauth/strategies/france_connect"
require "zlib"

module OmniAuth
  module Strategies
    class FranceConnectUid < OmniAuth::Strategies::FranceConnect

      option :name, :france_connect_uid
      option :scope, [:openid, :birthdate]

      info do
        {
          name: I18n.t("decidim.anonymous_user"),
          nickname: Zlib::crc32(uid),
          email: "",
          date_of_birth: user_info.birthdate
        }
      end
    end
  end
end
