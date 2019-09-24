# frozen_string_literal: true
# This migration comes from decidim (originally 20190426133758)

class AddColorToDecidimCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_categories, :color, :string
  end
end
