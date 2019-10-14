# frozen_string_literal: true
require "active_support/concern"

module InitiativeModelExtend
  extend ActiveSupport::Concern

  included do
    # delegate :online_signature_type?, :offline_signature_type?, :any_signature_type?, to: :type
    alias_method :online?, :online_signature_type?
    alias_method :offline?, :offline_signature_type?
    alias_method :any?, :any_signature_type?
  end
end

Decidim::Initiative.send(:include, InitiativeModelExtend)
