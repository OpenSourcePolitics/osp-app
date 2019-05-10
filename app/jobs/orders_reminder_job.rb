class OrdersReminderJob < ApplicationJob
  queue_as :default

  def perform
    application_name = Rails.application.class.parent_name
    application = Object.const_get(application_name)
    application::Application.load_tasks
    Rake::Task["decidim:budgets:reminder"].invoke
  end
end
