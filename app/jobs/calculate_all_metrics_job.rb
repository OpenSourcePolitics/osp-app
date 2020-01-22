# frozen_string_literal: true

class CalculateAllMetricsJob < ApplicationJob

  def perform
    system "rake decidim:metrics:all"
  end
end
