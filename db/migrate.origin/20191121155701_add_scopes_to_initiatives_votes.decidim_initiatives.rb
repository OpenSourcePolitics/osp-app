# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20191107134847)

class AddScopesToInitiativesVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_votes, :decidim_scope_id, :integer

    Decidim::InitiativesVote.reset_column_information

    Decidim::InitiativesVote.includes(initiative: :scoped_type).find_each do |vote|
      vote.decidim_scope_id = vote.initiative.scoped_type.decidim_scopes_id
      vote.save!
    end
  end
end
