# frozen_string_literal: true
require "active_support/concern"

module CreateRegistrationExtend
  extend ActiveSupport::Concern

  included do
    private

    def create_user
      @user = Decidim::User.create!(
        email: form.email,
        name: form.name,
        nickname: form.nickname,
        password: form.password,
        password_confirmation: form.password_confirmation,
        organization: form.current_organization,
        tos_agreement: form.tos_agreement,
        newsletter_notifications_at: form.newsletter_at,
        email_on_notification: true,
        accepted_tos_version: form.current_organization.tos_version,
        gender: form.gender,
        date_of_birth: form.date_of_birth,
        region: form.region
      )
    end
  end
end

Decidim::CreateRegistration.send(:include, CreateRegistrationExtend)
