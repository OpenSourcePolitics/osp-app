# frozen_string_literal: true
require "active_support/concern"

module ProposalSerializerExtend
  extend ActiveSupport::Concern

  included do
    alias_method :core_serialize, :serialize

    def serialize
      core_serialize.reject {|key, value| key.to_s == "authors_url" }
    end
  end
end

Decidim::Proposals::ProposalSerializer.send(:include, ProposalSerializerExtend)
