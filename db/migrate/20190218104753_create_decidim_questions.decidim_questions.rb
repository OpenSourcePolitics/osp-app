# This migration comes from decidim_questions (originally 20190108160127)
class CreateDecidimQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table "decidim_questions_collaborative_draft_collaborator_requests", force: :cascade do |t|
      t.bigint "decidim_questions_collaborative_draft_id", null: false
      t.bigint "decidim_user_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["decidim_questions_collaborative_draft_id"], name: "index_collab_requests_on_decidim_questions_collab_draft_id"
      t.index ["decidim_user_id"], name: "index_collab_requests_for_decidim_questions_on_decidim_user_id"
    end

    create_table "decidim_questions_collaborative_drafts", force: :cascade do |t|
      t.text "title", null: false
      t.text "body", null: false
      t.integer "decidim_component_id", null: false
      t.integer "decidim_scope_id"
      t.string "state"
      t.string "reference"
      t.text "address"
      t.float "latitude"
      t.float "longitude"
      t.datetime "published_at"
      t.integer "authors_count", default: 0, null: false
      t.integer "versions_count", default: 0, null: false
      t.integer "contributions_count", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "coauthorships_count", default: 0, null: false
      t.index ["body"], name: "decidim_questions_collaborative_draft_body_search"
      t.index ["decidim_component_id"], name: "decidim_questions_collaborative_drafts_on_decidim_component_id"
      t.index ["decidim_scope_id"], name: "decidim_questions_collaborative_drafts_on_decidim_scope_id"
      t.index ["state"], name: "decidim_questions_collaborative_drafts_on_state"
      t.index ["title"], name: "decidim_questions_collaborative_drafts_title_search"
      t.index ["updated_at"], name: "decidim_questions_collaborative_drafts_on_updated_at"
    end

    create_table "decidim_questions_participatory_texts", force: :cascade do |t|
      t.jsonb "title"
      t.jsonb "description"
      t.bigint "decidim_component_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["decidim_component_id"], name: "idx_participatory_questions_on_decidim_component_id"
    end

    create_table "decidim_questions_question_endorsements", force: :cascade do |t|
      t.bigint "decidim_question_id", null: false
      t.bigint "decidim_author_id", null: false
      t.bigint "decidim_user_group_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "decidim_author_type", null: false
      t.index "decidim_question_id, decidim_author_id, COALESCE(decidim_user_group_id, ('-1'::integer)::bigint)", name: "decidim_questions_question_endorsmt_question_auth_ugroup_uniq", unique: true
      t.index ["decidim_author_id", "decidim_author_type"], name: "index_decidim_questions_question_endorsements_on_decidim_author"
      t.index ["decidim_question_id"], name: "decidim_questions_question_endorsement_question"
      t.index ["decidim_user_group_id"], name: "decidim_questions_question_endorsement_user_group"
    end

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

    create_table "decidim_questions_question_votes", id: :serial, force: :cascade do |t|
      t.integer "decidim_question_id", null: false
      t.integer "decidim_author_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "temporary", default: false, null: false
      t.index ["decidim_author_id"], name: "decidim_questions_question_vote_author"
      t.index ["decidim_question_id", "decidim_author_id"], name: "decidim_questions_question_vote_question_author_unique", unique: true
      t.index ["decidim_question_id"], name: "decidim_questions_question_vote_question"
    end

    create_table "decidim_questions_questions", id: :serial, force: :cascade do |t|
      t.text "title", null: false
      t.text "body", null: false
      t.integer "decidim_component_id", null: false
      t.integer "decidim_scope_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "question_votes_count", default: 0, null: false
      t.string "state"
      t.datetime "answered_at"
      t.jsonb "answer"
      t.string "reference"
      t.text "address"
      t.float "latitude"
      t.float "longitude"
      t.integer "question_endorsements_count", default: 0, null: false
      t.datetime "published_at"
      t.integer "question_notes_count", default: 0, null: false
      t.integer "coauthorships_count", default: 0, null: false
      t.integer "position"
      t.string "participatory_text_level"
      t.boolean "created_in_meeting", default: false
      t.index ["body"], name: "decidim_questions_question_body_search"
      t.index ["created_at"], name: "index_decidim_questions_questions_on_created_at"
      t.index ["decidim_component_id"], name: "index_decidim_questions_questions_on_decidim_component_id"
      t.index ["decidim_scope_id"], name: "index_decidim_questions_questions_on_decidim_scope_id"
      t.index ["question_endorsements_count"], name: "idx_decidim_questions_questions_on_question_endorsemnts_count"
      t.index ["question_votes_count"], name: "index_decidim_questions_questions_on_question_votes_count"
      t.index ["state"], name: "index_decidim_questions_questions_on_state"
      t.index ["title"], name: "decidim_questions_question_title_search"
    end
  end
end
