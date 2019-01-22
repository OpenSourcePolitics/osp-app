# frozen_string_literal: true
# This migration comes from decidim (originally 20180508111640)

class AddTosVersionToOrganization < ActiveRecord::Migration[5.1]

  def localized_attribute(slug, attribute)
    Decidim.available_locales.inject({}) do |result, locale|
      text = I18n.with_locale(locale) do
        I18n.t(attribute, scope: "decidim.system.default_pages.placeholders", page: slug)
      end

      result.update(locale => text)
    end
  end

  _now = Time.current

  def up
    add_column :decidim_organizations, :tos_version, :datetime
    Decidim::Organization.find_each do |organization|
      current_page = Decidim::StaticPage.find_by(slug: "terms-and-conditions", organization: organization)
      if current_page.nil?
        Decidim::StaticPage::DEFAULT_PAGES.map do |slug|
          Decidim::StaticPage.find_or_create_by!(slug: slug, organization: organization) do |page|
            page.title = localized_attribute(slug, :title)
            page.content = localized_attribute(slug, :content)
            page.updated_at = Time.current
          end
        end
        current_page = Decidim::StaticPage.find_by(slug: "terms-and-conditions", organization: organization)

      end
      tos_version = current_page.updated_at
      organization.update(tos_version: tos_version)
    end
  end

  def down
    remove_columns :decidim_organizations, :tos_version
  end
end
