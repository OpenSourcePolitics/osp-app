# frozen_string_literal: true

module ProposalSerializerExtends

  # Public: Exports a hash with the serialized data for this proposal.
  def serialize
    {
      id: @proposal.id,
      category: {
        id: @proposal.category.try(:id),
        name: @proposal.category.try(:name)
      },
      scope: {
        id: @proposal.scope.try(:id),
        name: @proposal.scope.try(:name)
      },
      author_id: author_id,
      title: @proposal.title,
      body: @proposal.body,
      votes: @proposal.proposal_votes_count,
      comments: @proposal.comments.count,
      created_at: @proposal.created_at,
      published_at: @proposal.published_at,
      hidden: @proposal.hidden?,
      url: url,
      component: { id: component.id },
      meeting_urls: meetings
    }
  end

  def author_id
    proposal.decidim_author_id ? proposal.decidim_author_id : "Official"
  end

end

Decidim::Proposals::ProposalSerializer.class_eval do
  prepend(ProposalSerializerExtends)
end
