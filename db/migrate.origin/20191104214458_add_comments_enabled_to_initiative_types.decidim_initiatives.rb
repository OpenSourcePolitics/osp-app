# This migration comes from decidim_initiatives (originally 20191104213515)
class AddCommentsEnabledToInitiativeTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :comments_enabled, :boolean, null: false, default: true
  end
end
