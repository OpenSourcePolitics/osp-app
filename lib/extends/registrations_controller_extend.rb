# frozen_string_literal: true
require "active_support/concern"

module RegistrationsControllerExtend
  extend ActiveSupport::Concern

  included do
    before_action :build_date_of_birth, only: [:show, :create, :update, :edit]

    def build_date_of_birth
      return unless %w(
        decidim/devise/registrations
        decidim/devise/omniauth_registrations
        decidim/devise/invitations
        decidim/account
      ).include?(params[:controller])
      return unless params[:user]

      parts = []
      
      params[:user].each do |key, value|
        parts << value if (key =~ /^date_of_birth/) && value.present?
      end

      if parts.size >= 3
        params[:user][:date_of_birth] = Date.parse(parts.join("-"))
      elsif parts.any? && current_user
        params[:user][:date_of_birth] = current_user.date_of_birth
      end
    end
  end
end

::Devise::RegistrationsController.send(:include, RegistrationsControllerExtend)
::Devise::OmniauthCallbacksController.send(:include, RegistrationsControllerExtend)
