# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class MetricsCell < Decidim::ViewModel
      cache :show do
        Digest::MD5.hexdigest(metrics.highlighted + metrics.not_highlighted)
      end

      def show
        return unless current_organization.show_statistics?

        render
      end

      def metrics
        @metrics ||= MetricChartsPresenter.new(organization: current_organization)
      end
    end
  end
end
