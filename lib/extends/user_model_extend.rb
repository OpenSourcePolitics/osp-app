# frozen_string_literal: true
require "active_support/concern"

module UserModelExtend
  extend ActiveSupport::Concern

  included do
    # Overrides devise email required validation.
    def email_required?
      false
    end

    def signataire?
      email.blank? && name == "Anonyme" && identities.collect(&:provider).include?("france_connect_uid")
    end
  end
end

Decidim::User.send(:include, UserModelExtend)
