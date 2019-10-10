class ApplicationMailer < Decidim::ApplicationMailer
  default from: Decidim.config.mailer_sender
  layout "decidim/mailer"
end
