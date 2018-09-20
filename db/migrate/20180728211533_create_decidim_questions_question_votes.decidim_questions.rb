# This migration comes from decidim_questions (originally 20180728150235)
class CreateDecidimQuestionsQuestionVotes < ActiveRecord::Migration[5.2]
  def change
    create_table "decidim_questions_question_votes", id: :serial, force: :cascade do |t|
      t.integer "decidim_question_id", null: false
      t.integer "decidim_author_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "weight"
      t.index ["decidim_author_id"], name: "decidim_questions_question_vote_author"
      t.index ["decidim_question_id", "decidim_author_id"], name: "decidim_questions_question_vote_question_author_unique", unique: true
      t.index ["decidim_question_id"], name: "decidim_questions_question_vote_question"
    end
  end
end
