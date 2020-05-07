# frozen_string_literal: true
require "active_support/concern"

module DestroyAccountExtend
  extend ActiveSupport::Concern

  included do

    def call
      return broadcast(:invalid) unless @form.valid?

      Decidim::User.transaction do

        manage_user_initiatives
        destroy_user_account!
        destroy_user_authorizations
        destroy_user_identities
        destroy_user_group_memberships
        destroy_follows
      end

      broadcast(:ok)
    end

    def manage_user_initiatives
      # Rails.logger.debug "+++++++++++++++++++++++++"
      # Rails.logger.debug "DestroyAccount.manage_user_initiatives"
      # Rails.logger.debug "with @user" if @user
      # Rails.logger.debug @form.to_h
      # Rails.logger.debug "+++++++++++++++++++++++++"

      Decidim::Initiative.where(author: @user).each do |initiative|
        # Rails.logger.debug initiative.id
        # Rails.logger.debug initiative.state
        if %w(created validating accepted).include?(initiative.state)
          # Rails.logger.debug "will be discarded"
          initiative.update_columns(state: "discarded")
        else
          # Rails.logger.debug "will be rejected"
          initiative.update_columns(state: "rejected")
        end
        # Rails.logger.debug "--"
      end

    end

    def destroy_user_authorizations
      Decidim::Verifications::Authorizations.new(organization: @user.organization, user: @user).query.destroy_all
    end

  end
end

Decidim::DestroyAccount.send(:include, DestroyAccountExtend)
