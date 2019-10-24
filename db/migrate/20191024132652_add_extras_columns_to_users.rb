class AddExtrasColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :gender, :string
    add_column :decidim_users, :date_of_birth, :date
    add_column :decidim_users, :region, :string
  end
end
