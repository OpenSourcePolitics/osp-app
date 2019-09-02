# frozen_string_literal: true

module Decidim
  # Helpers related to icons
  module BadgeHelper
    def badges
      badges = []

      if respond_to?(:officialized?) && officialized?
        badges << "verified-badge"
      end

      if respond_to?(:officialized?) && eid_verified?
        badges << "eid-verified"
      end

      badges
    end
  end
end
