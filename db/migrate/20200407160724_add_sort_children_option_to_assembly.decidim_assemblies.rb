# frozen_string_literal: true
# This migration comes from decidim_assemblies (originally 20200330143503)

class AddSortChildrenOptionToAssembly < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_assemblies, :sort_children, :boolean, default: false
  end
end
