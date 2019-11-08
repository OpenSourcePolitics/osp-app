# frozen_string_literal: true

class CheckValidatingInitiatives < ApplicationJob

  def perform
    application_name = Rails.application.class.parent_name
    application = Object.const_get(application_name)
    application::Application.load_tasks
    Rake::Task["decidim_initiatives:check_validating"].invoke
  end
end
