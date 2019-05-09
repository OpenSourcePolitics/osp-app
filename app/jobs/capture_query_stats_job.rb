class CaptureQueryStatsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    application_name = Rails.application.class.parent_name
    application = Object.const_get(application_name)
    application::Application.load_tasks
    Rake::Task["pghero:capture_query_stats"].invoke
  end
end
