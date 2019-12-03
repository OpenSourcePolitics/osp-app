# frozen_string_literal: true
# This migration comes from decidim_omniauth_extras (originally 20190904193824)

class AddOmniauthSettingsToDecidimOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :omniauth_settings, :jsonb
  end
end
