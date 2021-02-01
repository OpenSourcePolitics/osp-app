# frozen_string_literal: true

Rails.application.config.cookies = [
  {
    name: "matomo",
    title: "Matomo",
    cookies: %w(matomo_session pk_id pk_ses _pk_ref _pk_cvar),
    purposes: %w(tracking analytics)
  },

  {
    name: "google-analytics",
    title: "Google Analytics",
    cookies: %w(_ga _gat _gid __utma __utmb __utmc __utmt __utmz),
    purposes: %w(tracking analytics)
  }
]
