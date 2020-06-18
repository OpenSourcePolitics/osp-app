# frozen_string_literal: true
require "active_support/concern"

module InitiativeModelExtend
  extend ActiveSupport::Concern

  included do
    # Public: Publishes this initiative
    #
    # Returns true if the record was properly saved, false otherwise.
    def publish!
      return false if published?

      update(
          published_at: Time.current,
          state: "published",
          signature_start_date: Date.current,
          signature_end_date: signature_end_date || Date.new(2022,6,21)
      )
    end
  end
end

Decidim::Initiative.send(:include, InitiativeModelExtend)
