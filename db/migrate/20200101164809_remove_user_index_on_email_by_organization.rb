class RemoveUserIndexOnEmailByOrganization < ActiveRecord::Migration[5.2]
  def change
    remove_index :decidim_users, %w(email decidim_organization_id)
  end
end
