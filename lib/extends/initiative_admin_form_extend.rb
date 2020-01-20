# frozen_string_literal: true
require "active_support/concern"

module InitiativeAdminFormExtend
  extend ActiveSupport::Concern

  included do

    validate :title, :title_max_length

    def signature_type_updatable?
      @signature_type_updatable ||= begin
                                      state ||= context.initiative.state
                                      state == "validating" && context.current_user.admin?
                                    end
    end

    def title_max_length
      title.each do |locale, value|
        if value.length > 150
          errors.add("title_#{locale}".to_s, :too_long, { count: 150 })
        end
      end
    end
  end
end

Decidim::Initiatives::Admin::InitiativeForm.class_eval do
  include InitiativeAdminFormExtend
end
