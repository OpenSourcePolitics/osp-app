# This migration comes from decidim_participations (originally 20180125154825)
class AddSqrStatusToModerations < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_moderations, :sqr_status, :string, default: "unmoderate"
  end
end
