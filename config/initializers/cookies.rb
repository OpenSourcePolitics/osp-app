# frozen_string_literal: true

# Example of how to define new cookie in banner
#
Rails.application.config.cookies = [
  {
      name: "jsessionid",
      title: "JSESSIONID",
      cookies: %w(JSESSIONID),
      purposes: %w(session tracking analytics)
  },
  {
    name: "matomo",
    title: "Matomo",
    cookies: %w(matomo_session pk_id pk_ses _pk_ref _pk_cvar),
    purposes: %w(tracking analytics)
  }
]
