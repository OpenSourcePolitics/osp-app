# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class StatsCell < Decidim::ViewModel
      cache :show do
        Digest::MD5.hexdigest(stats.highlighted + stats.not_highlighted)
      end
      def show
        return unless current_organization.show_statistics?

        render
      end

      def stats
        @stats ||= HomeStatsPresenter.new(organization: current_organization)
      end
    end
  end
end
