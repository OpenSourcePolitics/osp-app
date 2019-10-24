# frozen_string_literal: true
require "active_support/concern"

module OpenDataExporterExtend
  extend ActiveSupport::Concern

  included do
    private

    def open_data_manifests
      @open_data_manifests ||= Decidim.component_manifests.flat_map(&:export_manifests).select(&:include_in_open_data?)
    end
  end
end

Decidim::OpenDataExporter.send(:include, OpenDataExporterExtend)
