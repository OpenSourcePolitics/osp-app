# frozen_string_literal: true

class MigrateCommentsResults < ActiveRecord::Migration[5.1]
  class Comments < ApplicationRecord
    self.table_name = :decidim_comments_comments
  end

  def up
    # rubocop:disable Rails/SkipsModelValidations
    Comments.where(
      decidim_commentable_type: "Decidim::Results::Result"
    ).update_all("decidim_commentable_type = 'Decidim::Accountability::Result'")

    Comments.where(
      decidim_root_commentable_type: "Decidim::Results::Result"
    ).update_all("decidim_root_commentable_type = 'Decidim::Accountability::Result'")
  end
  # rubocop:enable Rails/SkipsModelValidations
end
