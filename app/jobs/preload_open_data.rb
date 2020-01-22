# frozen_string_literal: true

class PreloadOpenDataJob < ApplicationJob

  def perform
    system "rake decidim:open_data:export"
  end
end
