# frozen_string_literal: true
require "active_support/concern"

module InvitationsControllerExtend
  extend ActiveSupport::Concern

  included do
    # before_action :extras_permitted_parameters
    # after_action :update_resource_extras, only: [:update]

    around_action :configure_permitted_parameters

    def update_resource_extras
      return unless self.respond_to? :accept_resource

      Rails.logger.debug "+++++++++++++++++++++++++"
      Rails.logger.debug "InvitationsControllerExtend.update_resource_extras (after_filters)"
      Rails.logger.debug params
      Rails.logger.debug "+++++++++++++++++++++++++"

      resource = accept_resource
      resource.update!(gender: resource.gender)
      resource.update!(date_of_birth: resource.date_of_birth)
      resource.update!(region: resource.region)
      resource
    end

    def configure_permitted_parameters

      Rails.logger.debug "+++++++++++++++++++++++++"
      Rails.logger.debug "InvitationsControllerExtend.extras_permitted_parameters (before_filters)"
      Rails.logger.debug params
      Rails.logger.debug "+++++++++++++++++++++++++"

      attributes = [:gender, :date_of_birth, "date_of_birth(3i)".to_sym, "date_of_birth(2i)".to_sym, "date_of_birth(1i)".to_sym, :region]
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:nickname, :tos_agreement, :newsletter_notifications] << attributes)
      yield
    end
  end
end

::Devise::InvitationsController.send(:include, InvitationsControllerExtend)
