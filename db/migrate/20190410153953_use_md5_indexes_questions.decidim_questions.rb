# frozen_string_literal: true
# This migration comes from decidim_questions (originally 20190215113158)

class UseMd5IndexesQuestions < ActiveRecord::Migration[5.2]
  def up
    remove_index :decidim_questions_questions, name: "decidim_questions_question_title_search"
    remove_index :decidim_questions_questions, name: "decidim_questions_question_body_search"
    execute "CREATE INDEX decidim_questions_question_title_search ON decidim_questions_questions(md5(title::text))"
    execute "CREATE INDEX decidim_questions_question_body_search ON decidim_questions_questions(md5(body::text))"
  end

  def down
    remove_index :decidim_questions_questions, name: "decidim_questions_question_title_search"
    remove_index :decidim_questions_questions, name: "decidim_questions_question_body_search"
    add_index :decidim_questions_questions, :title, name: "decidim_questions_question_title_search"
    add_index :decidim_questions_questions, :body, name: "decidim_questions_question_body_search"
  end
end
