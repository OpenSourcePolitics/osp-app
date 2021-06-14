# frozen_string_literal: true

require 'active_support/concern'

module DestroyAccountExtend
  extend ActiveSupport::Concern

  included do
    def call
      return broadcast(:invalid) unless @form.valid?

      Decidim::User.transaction do
        notify_admins
        manage_user_initiatives
        destroy_user_account!
        destroy_user_authorizations
        destroy_user_identities
        destroy_user_group_memberships
        destroy_follows
      end

      broadcast(:ok)
    end

    private

    def notify_admins
      organization_admins.each do |admin|
        Decidim::DestroyAccountMailer.notify(admin).deliver_later
      end
    end

    def manage_user_initiatives
      Decidim::Initiative.where(author: @user).each do |initiative|
        initiative.update_columns(state: 'discarded')
      end
    end

    # Returns array of administrators with email on notification enabled
    def organization_admins
      Decidim::User.where(
        organization: @user.organization,
        admin: true,
        email_on_notification: true
      ).where.not(id: @user.id)
    end

    def destroy_user_authorizations
      Decidim::Verifications::Authorizations.new(
        organization: @user.organization,
        user: @user
      ).query.destroy_all
    end
  end
end

Decidim::DestroyAccount.send(:include, DestroyAccountExtend)
