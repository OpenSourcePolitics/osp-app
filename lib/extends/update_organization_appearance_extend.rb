# frozen_string_literal: true
require "active_support/concern"

module UpdateOrganizationAppearanceExtend
  extend ActiveSupport::Concern

  included do
    private

    def attributes
      appearance_attributes
        .merge(highlighted_content_banner_attributes)
        .merge(omnipresent_banner_attributes)
        .merge(colors_attributes)
        .tap do |attributes|
          attributes[:header_snippets] = form.header_snippets
        end
    end

    def colors_attributes
      if form.enable_custom_colors
        {
          colors: {
            primary: form.primary_color,
            secondary: form.secondary_color,
            success: form.success_color,
            warning: form.warning_color,
            alert: form.alert_color
          }
        }
      else
        { colors: {} }
      end
    end
  end
end

Decidim::Admin::UpdateOrganizationAppearance.send(:include, UpdateOrganizationAppearanceExtend)
