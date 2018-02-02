# frozen_string_literal: true

require_dependency "decidim/features/namer"

Decidim.register_feature(:polis) do |feature|
  feature.engine = Decidim::Polis::Engine
  feature.icon = "decidim/polis/icon.svg"
  feature.stylesheet = "decidim/polis/polis"

  feature.settings(:global) do |settings|
    settings.attribute :title, type: :text, translated: true
    settings.attribute :description, type: :text, editor: true, translated: true
    settings.attribute :sign_in_social, type: :boolean, default: false
    settings.attribute :visualization, type: :boolean, default: false
  end
  
  feature.settings(:step) do |settings|
    settings.attribute :user_can_write, type: :boolean, default: false
    settings.attribute :user_can_vote, type: :boolean, default: false
  end
end
