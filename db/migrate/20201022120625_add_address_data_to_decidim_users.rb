class AddAddressDataToDecidimUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :address, :jsonb, default: {}, null: false
  end
end
