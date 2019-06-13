# frozen_string_literal: true
# This migration comes from decidim_questions (originally 20190606140303)

class AddFirstInteractedAtToDecidimQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_questions_questions, :first_interacted_at, :datetime

    Decidim::Questions::Question.where(first_interacted_at: nil).each { |q| q.update(first_interacted_at: q.published_at) }
  end
end
