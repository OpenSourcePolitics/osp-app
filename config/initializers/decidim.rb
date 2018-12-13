# frozen_string_literal: true

Decidim.configure do |config|

  config.release = {
    commit: `git rev-parse --short HEAD`.strip,
    branch: `git rev-parse --abbrev-ref HEAD`.strip,
    repo: `basename \`git rev-parse --show-toplevel\``.strip
  }

  config.skip_first_login_authorization = ENV["SKIP_FIRST_LOGIN_AUTHORIZATION"] ? ActiveRecord::Type::Boolean.new.cast(ENV["SKIP_FIRST_LOGIN_AUTHORIZATION"]) : true
  config.application_name = "Concertations Région Nouvelle Aquitaine"
  config.mailer_sender = "Concertations Région Nouvelle Aquitaine <concertations@nouvelle-aquitaine.fr>"

  # Change these lines to set your preferred locales
  config.default_locale = :en
  config.available_locales = [:en, :ca, :es, :fr]

  config.maximum_attachment_height_or_width = 6000


  # Geocoder configuration
  if !Rails.application.secrets.geocoder[:here_app_id].blank?
    config.geocoder = {
      static_map_url: "https://image.maps.cit.api.here.com/mia/1.6/mapview",
      here_app_id: Rails.application.secrets.geocoder[:here_app_id],
      here_app_code: Rails.application.secrets.geocoder[:here_app_code]
    }
  end

  if defined?(Decidim::Initiatives) && defined?(Decidim::Initiatives.do_not_require_authorization)
    # puts "Decidim::Initiatives are loaded"
    Decidim::Initiatives.do_not_require_authorization = true
  end


  # Custom resource reference generator method
  # config.resource_reference_generator = lambda do |resource, feature|
  #   # Implement your custom method to generate resources references
  #   "1234-#{resource.id}"
  # end

  # Currency unit
  # config.currency_unit = "€"

  # The number of reports which an object can receive before hiding it
  # config.max_reports_before_hiding = 3
end

Rails.application.config.i18n.available_locales = Decidim.available_locales
Rails.application.config.i18n.default_locale = Decidim.default_locale
