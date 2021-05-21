# frozen_string_literal: true
if defined?(Decidim::Initiatives) && defined?(Decidim::Initiatives.do_not_require_authorization)
  Decidim::Initiatives.configure do |config|

    # Public Setting that defines the similarity minimum value to consider two
    # initiatives similar. Defaults to 0.25.
    # config.similarity_threshold = 0.25

    # Public Setting that defines how many similar initiatives will be shown.
    # Defaults to 5.
    # config.similarity_limit = 5

    # Minimum number of committee members required to pass the initiative to
    # technical validation phase. Only applies to initiatives created by
    # individuals.
    config.minimum_committee_members = 0

    # Number of days available to collect supports after an initiative has been
    # published.
    config.default_signature_time_period_length = 6.months

    # Components enabled for a new initiative
    config.default_components = []

    # Print functionality enabled. Allows the user to get
    # a printed version of the initiative from the administration
    # panel.
    config.print_enabled = false

    # Set a service to generate a timestamp on each vote. The
    # attribute is the name of a class whose instances are
    # initialized with a string containing the data to be
    # timestamped and respond to a timestamp method
    config.timestamp_service = "Decidim::Initiatives::UtcTimestamp"

  end
end
