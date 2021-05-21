# frozen_string_literal: true
# This migration comes from decidim (originally 20200605150335)

class AddColorAndImageToAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_areas, :color, :string
    add_column :decidim_areas, :logo, :string
  end
end
