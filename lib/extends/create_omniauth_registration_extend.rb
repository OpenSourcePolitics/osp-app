# frozen_string_literal: true
require "active_support/concern"

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

        if request.path.end_with?("france_connect_profile/callback")
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

  end
end

Decidim::CreateOmniauthRegistration.send(:include, CreateOmniauthRegistrationExtend)
