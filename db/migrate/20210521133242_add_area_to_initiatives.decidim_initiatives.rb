# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20200604083719)

class AddAreaToInitiatives < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_initiatives, :decidim_area, index: true
  end
end
