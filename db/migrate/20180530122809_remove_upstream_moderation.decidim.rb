# This migration comes from decidim (originally 20180530072433)
class RemoveUpstreamModeration < ActiveRecord::Migration[5.1]
  def change
    remove_column :decidim_moderations, :upstream_moderation, :string
  end
end
