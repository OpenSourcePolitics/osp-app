# frozen_string_literal: true
require "active_support/concern"

module InitiativeModelExtend
  extend ActiveSupport::Concern

  included do
    alias_method :online?, :online_signature_type?
    alias_method :offline?, :offline_signature_type?
    alias_method :any?, :any_signature_type?
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
