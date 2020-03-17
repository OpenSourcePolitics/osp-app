# frozen_string_literal: true
# This migration comes from decidim_initiatives_no_signature_allowed (originally 20200302163041)

class AddNoSignatureAllowedToDecidimInitiativeType < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :no_signature_allowed, :boolean, default: false
  end
end
