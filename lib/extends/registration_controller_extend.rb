# frozen_string_literal: true
require "active_support/concern"

module RegistrationsControllerExtend
  extend ActiveSupport::Concern

  included do
    before_action :build_date_of_birth, only: [:show, :create, :update, :edit]
    # before_action :extras_permitted_parameters
    # after_action :update_resource_extras, only: [:update]

    def build_date_of_birth
      return unless %w(
        decidim/devise/registrations
        decidim/devise/omniauth_registrations
        decidim/devise/invitations
        decidim/account
      ).include?(params[:controller])
      return unless params[:user]

      Rails.logger.debug "+++++++++++++++++++++++++"
      Rails.logger.debug "RegistrationsControllerExtend.build_date_of_birth (before_filters)"
      Rails.logger.debug params
      Rails.logger.debug "+++++++++++++++++++++++++"

      parts = []
      params[:user].each { |key, value| parts << value if (key =~ /^date_of_birth/) && value.present?  }
      if parts.size >= 3
        params[:user][:date_of_birth] = Date.parse parts.join("-") if (parts.any? && parts.size >= 3)
      elsif parts.any? && current_user
        params[:user][:date_of_birth] = current_user.date_of_birth
      end
    end

    def update_resource_extras
      return unless self.respond_to? :accept_resource

      Rails.logger.debug "+++++++++++++++++++++++++"
      Rails.logger.debug "RegistrationsControllerExtend.update_resource_extras (after_filters)"
      Rails.logger.debug params
      Rails.logger.debug "+++++++++++++++++++++++++"

      resource = accept_resource
      resource.update!(gender: resource.gender)
      resource.update!(date_of_birth: resource.date_of_birth)
      resource.update!(region: resource.region)
      resource
    end

    def extras_permitted_parameters

      Rails.logger.debug "+++++++++++++++++++++++++"
      Rails.logger.debug "RegistrationsControllerExtend.extras_permitted_parameters (before_filters)"
      Rails.logger.debug params
      Rails.logger.debug "+++++++++++++++++++++++++"

      return unless %w(
        decidim/devise/registrations
        decidim/devise/omniauth_registrations
        decidim/devise/invitations
      ).include?(params[:controller])
      attributes = [:gender, :date_of_birth, "date_of_birth(3i)".to_sym, "date_of_birth(2i)".to_sym, "date_of_birth(1i)".to_sym, :region]
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :tos_agreement] << attributes)
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:nickname, :tos_agreement, :newsletter_notifications] << attributes)
    end
  end
end

::Devise::RegistrationsController.send(:include, RegistrationsControllerExtend)
# ::Devise::InvitationsController.send(:include, RegistrationsControllerExtend)
::Devise::OmniauthCallbacksController.send(:include, RegistrationsControllerExtend)
