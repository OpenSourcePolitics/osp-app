# frozen_string_literal: true
Rails.application.config.active_job.queue_adapter = :inline

task :disable_email_dummy_data => :environment do
  emails = %w[
  ascogin1g@eventbrite.com
  mcollop1h@japanpost.jp
  lwalby1i@amazon.de
  dspier1j@elpais.com
  rvesty1k@artisteer.com
  dyitzhakov1l@ovh.net
  ffavela1m@uol.com.br
  ablandamere1n@edublogs.org
  pkeener1o@bloomberg.com
  ebulford1p@prlog.org
  gmcleoid1q@soup.io
  mlehrahan1r@goo.ne.jp
  rsulter1s@shareasale.com
  gbrinson1t@princeton.edu
  alinn1u@unesco.org
  mmorfell1v@wsj.com
  wvango1w@cornell.edu
  cwarcup1x@marriott.com
  vleveridge1y@joomla.org
  lebbings1z@hud.gov
]

  emails.each_with_index do |email, index|
    Decidim::User.create!(
        email: email,
        password: email,
        password_confirmation: email,
        decidim_organization_id: 1,
        name: "azerty" + index.to_s,
        nickname: "azertya" + index.to_s,
        email_on_notification: true,
        newsletter_notifications: true,
        confirmed_at: Time.now.utc,
        tos_agreement: true
    )
  end
end
