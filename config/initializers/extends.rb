# frozen_string_literal: true

ActiveSupport.on_load(:active_record) {

  def database_exists?
    ActiveRecord::Base.connection
  rescue ActiveRecord::NoDatabaseError
    false
  else
    true
  end

  # Models needs to be loaded AFTER DB init because of legacy Migrations
  if database_exists?
    if ActiveRecord::Base.connection.table_exists?(:decidim_users)
      require 'extends/models/decidim/user_extend.rb'
    end
  end

}

require 'extends/presenters/decidim/user_presenter_extend.rb'
require 'extends/presenters/decidim/proposals/official_author_presenter_extend.rb'
require 'extends/cells/decidim/author_cell_extend.rb'
