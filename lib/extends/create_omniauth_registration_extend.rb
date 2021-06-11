# frozen_string_literal: true
require 'active_support/concern'

module CreateOmniauthRegistrationExtend
  extend ActiveSupport::Concern

  included do

    def call
      verify_oauth_signature!

      begin
        if existing_identity
          user = existing_identity.user
          verify_user_confirmed(user)

          return broadcast(:ok, user)
        end

        if request.path.end_with?('france_connect_profile/callback')
          form.minimum_age
          return broadcast(:error, user)
        end

        return broadcast(:invalid) if form.invalid?

        transaction do
          create_or_find_user
          @identity = create_identity
        end
        @user.after_confirmation if @after_confirmation
        trigger_omniauth_registration

        broadcast(:ok, @user)
      rescue ActiveRecord::RecordInvalid => e
        broadcast(:error, e.record)
      end
    end

    def create_or_find_user
      generated_password = SecureRandom.hex

      if (verified_email || form.email).blank?

        @user = Decidim::User.new(
          email: '',
          organization: organization,
          name: form.name,
          nickname: form.nickname,
          newsletter_notifications_at: nil,
          email_on_notification: false,
          accepted_tos_version: organization.tos_version,
          # managed: true,
          password: generated_password,
          password_confirmation: generated_password
        )
        @user.skip_confirmation!

      else

        @user = Decidim::User.find_or_initialize_by(
          email: (form.email || verified_email),
          organization: organization
        )

        if !@user.persisted? || @user.invited_to_sign_up?
          @user.email = (form.email || verified_email)
          @user.name = user_params[:name] || form.name
          @user.nickname = user_params[:nickname] || form.normalized_nickname
          @user.newsletter_notifications_at = nil
          @user.email_on_notification = true
          @user.password = generated_password
          @user.password_confirmation = generated_password


          # TODO: raise ActiveRecord::RecordInvalid because of quality setting on uploader, this line is a quick fix
          @user.remote_avatar_url = form.avatar_url if form.avatar_url.present? && !form.avatar_url.end_with?('svg')
          @user.skip_confirmation! if verified_email # unless verified_email != form.email
          @user.accept_invitation if @user.invited_to_sign_up?
          @after_confirmation = (verified_email != form.email)
        end
      end

      @user.tos_agreement = '1'
      @user.save!
    end
  end
end

Decidim::CreateOmniauthRegistration.send(:include, CreateOmniauthRegistrationExtend)
