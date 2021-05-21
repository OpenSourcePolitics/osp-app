# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20200206222320)

class UpdateInitiativesGlobalScope < ActiveRecord::Migration[5.2]
  def change
    Decidim::InitiativesType.where(only_global_scope_enabled: true).each(&:save)
  end
end
