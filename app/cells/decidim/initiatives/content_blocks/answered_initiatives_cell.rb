# frozen_string_literal: true

module Decidim
  module Initiatives
    module ContentBlocks
      class AnsweredInitiativesCell < Decidim::ViewModel
        include Decidim::SanitizeHelper

        delegate :current_organization, to: :controller

        def show
          render if answered_initiatives.any?
        end

        def max_results
          model.settings.max_results
        end

        def answered_initiatives
          @answered_initiatives ||= OrganizationAnsweredInitiatives
                                        .new(current_organization)
                                        .query
                                        .limit(max_results)
        end

        def hide_cta_button_class
          return "hide_cta_button" if Decidim::ContentBlock.published
                                                           .for_scope(:homepage, organization: current_organization)
                                                           .map { |content_block| content_block&.manifest&.name }
                                                           .include?(:highlighted_initiatives)

          ""
        end

        def i18n_scope
          "decidim.initiatives.pages.home.answered_initiatives"
        end

        def decidim_initiatives
          Decidim::Initiatives::Engine.routes.url_helpers
        end
      end
    end
  end
end
