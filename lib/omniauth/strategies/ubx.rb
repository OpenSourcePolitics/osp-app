# frozen_string_literal: true

require "omniauth-cas"

module OmniAuth
  module Strategies
    class Ubx < OmniAuth::Strategies::CAS
      option :name, :cas
      option :origin_param, "redirect_url"

      def info
        Rails.logger.debug raw_info
        super.info
      end
    end
  end
end

OmniAuth.config.add_camelization 'cas', 'CAS'
