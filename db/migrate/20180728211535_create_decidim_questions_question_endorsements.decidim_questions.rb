# This migration comes from decidim_questions (originally 20180728150309)
class CreateDecidimQuestionsQuestionEndorsements < ActiveRecord::Migration[5.2]
  def change
    create_table "decidim_questions_question_endorsements", force: :cascade do |t|
      t.bigint "decidim_question_id", null: false
      t.bigint "decidim_author_id", null: false
      t.bigint "decidim_user_group_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index "decidim_question_id, decidim_author_id, (COALESCE(decidim_user_group_id, ('-1'::integer)::bigint))", name: "decidim_questions_question_endorsmt_question_auth_ugroup_uniq", unique: true
      t.index ["decidim_author_id"], name: "decidim_questions_question_endorsement_author"
      t.index ["decidim_question_id"], name: "decidim_questions_question_endorsement_question"
      t.index ["decidim_user_group_id"], name: "decidim_questions_question_endorsement_user_group"
    end
  end
end
