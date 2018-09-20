# This migration comes from decidim_questions (originally 20180728150245)
class CreateDecidimQuestionsQuestionNotes < ActiveRecord::Migration[5.2]
  def change
    create_table "decidim_questions_question_notes", force: :cascade do |t|
      t.bigint "decidim_question_id", null: false
      t.bigint "decidim_author_id", null: false
      t.text "body", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["created_at"], name: "index_decidim_questions_question_notes_on_created_at"
      t.index ["decidim_author_id"], name: "decidim_questions_question_note_author"
      t.index ["decidim_question_id"], name: "decidim_questions_question_note_question"
    end
  end
end
