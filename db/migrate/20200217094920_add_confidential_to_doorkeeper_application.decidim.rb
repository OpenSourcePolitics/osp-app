# frozen_string_literal: true
# This migration comes from decidim (originally 20190725125056)

class AddConfidentialToDoorkeeperApplication < ActiveRecord::Migration[5.2]
  def change
    add_column(
      :oauth_applications,
      :confidential,
      :boolean,
      null: false,
      default: true # maintaining backwards compatibility: require secrets
    )
  end
end
