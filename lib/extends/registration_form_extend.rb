# frozen_string_literal: true
require "active_support/concern"

module RegistrationFormExtend
  extend ActiveSupport::Concern

  included do
    attribute :gender, String
    attribute :date_of_birth, Date
    attribute :region, String

    validates_inclusion_of :gender, :in => ( Decidim::User.genders << "" )
    validates_inclusion_of :region, :in => ( Decidim::User.regions << "" )
  end
end

Decidim::RegistrationForm.send(:include, RegistrationFormExtend)
Decidim::AccountForm.send(:include, RegistrationFormExtend)
Decidim::OmniauthRegistrationForm.send(:include, RegistrationFormExtend)
