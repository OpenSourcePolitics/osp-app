# frozen_string_literal: true
# This migration comes from decidim_questions (originally 20190517153331)

class MigrateQuestionRecipients < ActiveRecord::Migration[5.2]
  def change
    Decidim::Questions::Question.where(state: "evaluating", recipient: ["committee", "service"]).find_each do |question|
      next unless question.component
      next unless question.component.participatory_space

      recipients = Decidim::ParticipatoryProcessUserRole
                   .includes(:user)
                   .where(participatory_process: question.component.participatory_space)
                   .where(role: question.recipient).map(&:user)

      question.recipient_ids = recipients.map(&:id)
      question.save!
    end
  end
end
