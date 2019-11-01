# frozen_string_literal: true
require "active_support/concern"

module InvitationsControllerExtend
  extend ActiveSupport::Concern

  included do
    around_action :configure_permitted_parameters

    def configure_permitted_parameters
      attributes = [:gender, :date_of_birth, "date_of_birth(3i)".to_sym, "date_of_birth(2i)".to_sym, "date_of_birth(1i)".to_sym, :region]
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:nickname, :tos_agreement, :newsletter_notifications] << attributes)
      yield
    end
  end
end

::Devise::InvitationsController.send(:include, InvitationsControllerExtend)
