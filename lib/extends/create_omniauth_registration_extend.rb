# frozen_string_literal: true
require "active_support/concern"

module CreateOmniauthRegistrationExtend
  extend ActiveSupport::Concern

  included do
    private

    def create_or_find_user
      generated_password = SecureRandom.hex

      @user = Decidim::User.find_or_initialize_by(
        email: verified_email,
        organization: organization
      )

      unless @user.persisted?
        @user.email = (verified_email || form.email)
        @user.name = form.name
        @user.nickname = form.normalized_nickname
        @user.newsletter_notifications_at = nil
        @user.email_on_notification = true
        @user.password = generated_password
        @user.password_confirmation = generated_password
        # TODO: raise ActiveRecord::RecordInvalid because of quality setting on uploader, this line is a quick fix
        @user.remote_avatar_url = form.avatar_url if form.avatar_url.present? && !form.avatar_url.end_with?("svg")
        @user.skip_confirmation! if verified_email
        @user.encrypted_gender = Decidim::AttributeEncryptor.encrypt(form.gender)
        @user.encrypted_date_of_birth = Decidim::AttributeEncryptor.encrypt(form.date_of_birth&.to_s)
        @user.encrypted_region = Decidim::AttributeEncryptor.encrypt(form.region)
      end

      @user.tos_agreement = "1"
      @user.save!
    end
  end
end

Decidim::CreateOmniauthRegistration.send(:include, CreateOmniauthRegistrationExtend)
