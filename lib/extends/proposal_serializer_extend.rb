# frozen_string_literal: true

require 'active_support/concern'

Decidim::Proposals::ProposalSerializer.class_eval do
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
        participatory_space: {
            id: proposal.participatory_space.id,
            url: Decidim::ResourceLocatorPresenter.new(proposal.participatory_space).url
        },
        component: { id: component.id },
        title: present(proposal).title,
        body: present(proposal).body,
        state: proposal.state.to_s,
        reference: proposal.reference,
        answer: ensure_translatable(proposal.answer),
        supports: proposal.proposal_votes_count,
        endorsements: {
            total_count: proposal.endorsements.count
        },
        comments: proposal.comments.count,
        attachments: proposal.attachments.count,
        followers: proposal.followers.count,
        published_at: proposal.published_at,
        url: url,
        meeting_urls: meetings,
        related_proposals: related_proposals,
        is_amend: proposal.emendation?,
        original_proposal: {
            title: proposal&.amendable&.title,
            url: original_proposal_url
        }
    }
  end
end
