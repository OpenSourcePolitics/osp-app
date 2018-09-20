# This migration comes from decidim_questions (originally 20180728150054)
class CreateDecidimQuestionsQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table "decidim_questions_questions", id: :serial, force: :cascade do |t|
      t.text "title", null: false
      t.text "body", null: false
      t.text "original_body"
      t.integer "decidim_component_id", null: false
      t.integer "decidim_author_id"
      t.integer "decidim_scope_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "question_votes_count", default: 0, null: false
      t.integer "decidim_user_group_id"
      t.string "state"
      t.string "question_type"
      t.string "recipient_role"
      t.date "answer_deadline"
      t.datetime "answered_at"
      t.jsonb "answer"
      t.string "reference"
      t.text "address"
      t.float "latitude"
      t.float "longitude"
      t.integer "question_endorsements_count", default: 0, null: false
      t.datetime "published_at"
      t.integer "question_notes_count", default: 0, null: false
      t.index ["body"], name: "decidim_questions_question_body_search"
      t.index ["created_at"], name: "index_decidim_questions_questions_on_created_at"
      t.index ["decidim_author_id"], name: "index_decidim_questions_questions_on_decidim_author_id"
      t.index ["decidim_component_id"], name: "index_decidim_questions_questions_on_decidim_component_id"
      t.index ["decidim_scope_id"], name: "index_decidim_questions_questions_on_decidim_scope_id"
      t.index ["question_endorsements_count"], name: "idx_decidim_questions_questions_on_question_endorsemnts_count"
      t.index ["question_votes_count"], name: "index_decidim_questions_questions_on_question_votes_count"
      t.index ["state"], name: "index_decidim_questions_questions_on_state"
      t.index ["title"], name: "decidim_questions_question_title_search"
      t.index ["question_type"], name: "decidim_questions_question_question_type_search"
    end
  end
end
