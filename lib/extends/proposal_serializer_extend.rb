# frozen_string_literal: true
require "active_support/concern"

module ProposalSerializerExtend
  extend ActiveSupport::Concern

  included do
    alias_method :core_serialize, :serialize

    def initialize(proposal)
      @proposal = proposal
    end

    def serialize
      core_serialize.except(:authors_url).merge({
        authors_gender: authors_gender,
        authors_birthyear: authors_birthyear,
        authors_region: authors_region
      })
    end

    def authors_gender
      return unless author_is_a_single_user? && proposal.authors.first.gender&.present?
      I18n.t(proposal.authors.first.gender, scope: "decidim.users.gender")
    end

    def authors_birthyear
      return unless author_is_a_single_user? && proposal.authors.first.date_of_birth&.present?
      proposal.authors.first.date_of_birth.year
    end

    def authors_region
      return unless author_is_a_single_user? && proposal.authors.first.region&.present?
      I18n.t(proposal.authors.first.region, scope: "decidim.users.region")
    end

    def author_is_a_single_user?
      (proposal.authors.count == 1) && ("Decidim::User".include? proposal.authors.first.class.to_s)
    end
  end
end

Decidim::Proposals::ProposalSerializer.send(:include, ProposalSerializerExtend)
