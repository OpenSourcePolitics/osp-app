class AddUserExtraColumnsPpan < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :full_address, :string
    add_column :decidim_users, :custom_agreement_at, :datetime
  end
end
