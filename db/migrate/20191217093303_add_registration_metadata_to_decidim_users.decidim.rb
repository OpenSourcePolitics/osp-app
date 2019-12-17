# frozen_string_literal: true
# This migration comes from decidim (originally 20191211133811)

class AddRegistrationMetadataToDecidimUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :registration_metadata, :jsonb
  end
end
