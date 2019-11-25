# frozen_string_literal: true

namespace :decidim_initiatives do
  desc "Check created initiatives and send them to technical validation after a configured time"
  task check_created: :environment do
    Decidim::Initiatives::OutdatedCreatedInitiatives
      .for(72.hours)
      .each do |initiative|
        Decidim::Initiatives::Admin::SendInitiativeToTechnicalValidation.call(initiative, initiative.author)
      end
  end
end
