# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20191116170841)

class AllowMultipleInitiativeVotesCounterCaches < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives, :online_votes, :jsonb, default: {}

    Decidim::Initiative.reset_column_information

    Decidim::Initiative.find_each(&:update_online_votes_counters)

    remove_column :decidim_initiatives, :initiative_supports_count
    remove_column :decidim_initiatives, :initiative_votes_count
  end
end
