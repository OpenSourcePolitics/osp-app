# frozen_string_literal: true

module ProposalSerializerExtends

  # Public: Exports a hash with the serialized data for this proposal.
  def serialize
    {
        id: proposal.id,
        category: {
            id: proposal.category.try(:id),
            name: proposal.category.try(:name) || empty_translatable
        },
        scope: {
            id: proposal.scope.try(:id),
            name: proposal.scope.try(:name) || empty_translatable
        },
        authors: authors_id,
        participatory_space: {
            id: proposal.participatory_space.id,
            url: Decidim::ResourceLocatorPresenter.new(proposal.participatory_space).url
        },
        collaborative_draft_origin: proposal.collaborative_draft_origin,
        component: { id: component.id },
        title: present(proposal).title,
        body: present(proposal).body,
        state: proposal.state.to_s,
        reference: proposal.reference,
        answer: ensure_translatable(proposal.answer),
        supports: proposal.proposal_votes_count,
        endorsements: proposal.endorsements.count,
        comments: proposal.comments.count,
        amendments: proposal.amendments.count,
        attachments_url: attachments_url,
        attachments: proposal.attachments.count,
        followers: proposal.followers.count,
        published_at: proposal.published_at,
        url: url,
        meeting_urls: meetings,
        related_proposals: related_proposals
    }
  end

  def authors_id
    authors = proposal.authors.map do |author|
      author.class.name == "Decidim::Organization" ? "Official" : author.id
    end

    return authors.first if authors.one?

    authors
  end

  def attachments_url
    proposal.attachments.map { |attachment| proposal.organization.host + attachment.url }
  end
end

Decidim::Proposals::ProposalSerializer.class_eval do
  prepend(ProposalSerializerExtends)
end
