# frozen_string_literal: true
require "active_support/concern"

module OrganizationAppearanceFormExtend
  extend ActiveSupport::Concern

  included do
    attribute :header_snippets, String
    attribute :enable_custom_colors, Virtus::Attribute::Boolean
  end
end

Decidim::Admin::OrganizationAppearanceForm.send(:include, OrganizationAppearanceFormExtend)
