# frozen_string_literal: true
require "active_support/concern"

module DebateSerializerExtend
  extend ActiveSupport::Concern

  included do
    alias_method :core_serialize, :serialize

    def serialize
      core_serialize.reject {|key, value| key.to_s == "author_url" }
    end
  end
end

Decidim::Debates::DebateSerializer.send(:include, DebateSerializerExtend)
