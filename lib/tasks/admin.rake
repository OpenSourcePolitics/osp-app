
# frozen_string_literal: true

namespace :admin do
  desc 'Admin helpers'
  task create: :environment do
    Decidim::System::Admin.create!(email: 'system@example.org', password: 'decidim123456', password_confirmation: 'decidim123456')
  end
end
