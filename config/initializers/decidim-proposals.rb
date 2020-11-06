Decidim::Proposals.configure do |config|
  # 0 means that 0% is required for the proposal to be proposed to the comparator.
  # 100% means the proposals have to be fully similar.
  config.similarity_threshold = 100

  # Number of proposals displayed
  config.similarity_limit = 0 # default value
end
