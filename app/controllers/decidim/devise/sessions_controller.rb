# frozen_string_literal: true

module Decidim
  module Devise
    # Custom Devise SessionsController to avoid namespace problems.
    class SessionsController < ::Devise::SessionsController
      include Decidim::DeviseControllers

      before_action :check_sign_in_enabled, only: :create

      def create
        super
      end

      def destroy
        saml_uid = session['saml_uid']
        saml_session_index = session['saml_session_index']
        current_user.invalidate_all_sessions!
        super do
          session['saml_uid'] = saml_uid
          session['saml_session_index'] = saml_session_index
        end
      end

      def after_sign_in_path_for(user)
        if first_login_and_not_authorized?(user) && !user.admin? && !pending_redirect?(user)
          decidim_verifications.first_login_authorizations_path
        else
          super
        end
      end

      # Calling the `stored_location_for` method removes the key, so in order
      # to check if there's any pending redirect after login I need to call
      # this method and use the value to set a pending redirect. This is the
      # only way to do this without checking the session directly.
      def pending_redirect?(user)
        store_location_for(user, stored_location_for(user))
      end

      def first_login_and_not_authorized?(user)
        user.is_a?(User) && user.sign_in_count == 1 && current_organization.available_authorizations.any? && user.verifiable?
      end

      def after_sign_out_path_for(user)
        if session['saml_uid'] && session['saml_session_index'] && current_organization.enabled_omniauth_providers.dig(:nyc, :idp_slo_target_url)
          user_nyc_omniauth_authorize_path + "/spslo"
        else
          request.referer || super
        end
      end

      private

      def check_sign_in_enabled
        redirect_to new_user_session_path unless current_organization.sign_in_enabled?
      end
    end
  end
end
