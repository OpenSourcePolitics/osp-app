# frozen_string_literal: true
require "active_support/concern"
require "valid_email2"

module OmniauthRegistrationFormExtend
  extend ActiveSupport::Concern

  included do

    def self.extra_params
      [:custom_agreement, :full_address]
    end

    attribute :custom_agreement, Virtus::Attribute::Boolean
    attribute :full_address, String

    validates :email, 'valid_email_2/email': { mx: true }
    validates :name, presence: true
    validates :provider, presence: true
    validates :uid, presence: true
    validates :custom_agreement, acceptance: true

    validates :email, :full_address, presence: true, unless: -> (form) { form.email.blank? }
    validates_length_of :full_address, maximum: 256, allow_blank: false, unless: -> (form) { form.email.blank? }

    validate :email, :email_is_unique, unless: -> (form) { form.email.blank? }

    validate :minimum_age, if: -> { manifest.dig(:minimum_age).present? && raw_data.dig(:extra, :raw_info, :birthdate).present? }

    def minimum_age
      # Rails.logger.debug "+++ has_minimum_age? +++"
      # Rails.logger.debug manifest.dig(:minimum_age)
      # Rails.logger.debug raw_data.dig(:extra, :raw_info, :birthdate)
      # Rails.logger.debug (((Time.zone.now - raw_data.dig(:extra, :raw_info, :birthdate).to_time) / 1.year.seconds).floor > manifest.dig(:minimum_age).to_i)
      # Rails.logger.debug "+++ ++++++++++++++++ +++"

      if (((Time.zone.now - raw_data.dig(:extra, :raw_info, :birthdate).to_time) / 1.year.seconds).floor > manifest.dig(:minimum_age).to_i)
        return true
      else
        errors.add(:minimum_age, I18n.t("decidim.verifications.omniauth.errors.minimum_age", minimum_age: manifest.dig(:minimum_age), locale: I18n.locale))
        return false
      end
    end

    def manifest
      @manifest ||= current_organization.enabled_omniauth_providers[provider.to_sym]
    end
  end
end

Decidim::OmniauthRegistrationForm.class_eval do
  clear_validators!
  include OmniauthRegistrationFormExtend
end
