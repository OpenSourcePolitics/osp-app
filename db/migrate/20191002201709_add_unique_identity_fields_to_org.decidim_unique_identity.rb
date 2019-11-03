# frozen_string_literal: true
# This migration comes from decidim_unique_identity (originally 20190930083855)

class AddUniqueIdentityFieldsToOrg < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :unique_identity_methods, :string, array: true, default: ["online"]
    add_column :decidim_organizations, :unique_identity_explanation_text, :jsonb, default: {}

    # rubocop:disable Rails/SkipsModelValidations
    Decidim::Organization.reset_column_information
    Decidim::Organization.update_all(unique_identity_methods: ["online"])
    # rubocop:enable Rails/SkipsModelValidations
  end
end
