# frozen_string_literal: true
require "active_support/concern"

module UserModelExtend
  extend ActiveSupport::Concern

  included do
    # Overrides devise email required validation.
    def email_required?
      false
    end

    def computed_full_address(address)
      "#{address["number_and_street"]}, #{address["postal_code"]} #{address["city"]}, #{address["country"]}"
    end
  end
end

Decidim::User.send(:include, UserModelExtend)
