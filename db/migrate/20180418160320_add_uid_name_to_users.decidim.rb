# This migration comes from decidim (originally 20180418124231)
class AddUidNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_users, :uid_name, :string
  end
end
