# frozen_string_literal: true

Decidim::Initiatives.configure do |config|
  # Public Setting that defines the similarity minimum value to consider two
  # initiatives similar. Defaults to 0.25.
  config.similarity_threshold = 0.25

  # Public Setting that defines how many similar initiatives will be shown.
  # Defaults to 5.
  config.similarity_limit = 5
end
