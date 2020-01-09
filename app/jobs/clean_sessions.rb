# frozen_string_literal: true

class CleanSessions < ApplicationJob

  def perform
    application_name = Rails.application.class.parent_name
    application = Object.const_get(application_name)
    application::Application.load_tasks
    Rake::Task["db:sessions:trim"].invoke
  end
end
