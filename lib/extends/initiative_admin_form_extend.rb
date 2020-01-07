# frozen_string_literal: true
require "active_support/concern"

module InitiativeAdminFormExtend
  extend ActiveSupport::Concern

  included do
    def signature_type_updatable?
      @signature_type_updatable ||= begin
                                      state ||= context.initiative.state
                                      state == "validating" && context.current_user.admin?
                                    end
    end
  end
end

Decidim::Initiatives::Admin::InitiativeForm.class_eval do
  include InitiativeAdminFormExtend
end
