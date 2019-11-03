# frozen_string_literal: true
# This migration comes from decidim_unique_identity (originally 20191005163713)

class AddPhoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :phone, :string
  end
end
