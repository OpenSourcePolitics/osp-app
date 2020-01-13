# frozen_string_literal: true
require "active_support/concern"

module UserModelExtend
  extend ActiveSupport::Concern

  included do
    # Overrides devise email required validation.
    def email_required?
      false
    end
  end
end

Decidim::User.send(:include, UserModelExtend)
