# frozen_string_literal: true
# This migration comes from decidim_initiatives_no_signature_allowed (originally 20200302110042)

class AddNoSignatureToDecidimInitiative < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives, :no_signature, :boolean, default: false
  end
end
