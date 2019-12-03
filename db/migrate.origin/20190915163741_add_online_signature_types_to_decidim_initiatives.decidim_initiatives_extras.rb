# frozen_string_literal: true
# This migration comes from decidim_initiatives_extras (originally 20190904193826)

class AddOnlineSignatureTypesToDecidimInitiatives < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives, :online_signature_types, :string, array: true, default: [:devise]
  end
end
