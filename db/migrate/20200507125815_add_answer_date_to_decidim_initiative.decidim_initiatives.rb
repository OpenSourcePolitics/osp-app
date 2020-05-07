# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20200416173051)

class AddAnswerDateToDecidimInitiative < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives, :answer_date, :date, null: true
  end
end
