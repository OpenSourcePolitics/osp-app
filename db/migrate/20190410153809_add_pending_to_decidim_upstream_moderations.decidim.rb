# frozen_string_literal: true
# This migration comes from decidim (originally 20190321151939)

class AddPendingToDecidimUpstreamModerations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_upstream_moderations, :pending, :boolean, default: true
  end
end
