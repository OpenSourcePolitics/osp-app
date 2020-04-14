# frozen_string_literal: true
require "active_support/concern"
require "valid_email2"

module AccountFormExtend
  extend ActiveSupport::Concern

  included do

    attribute :custom_agreement, Virtus::Attribute::Boolean
    attribute :full_address, String

    validates :email, 'valid_email_2/email': { mx: true }

    validates :avatar, file_size: { less_than_or_equal_to: ->(_record) { Decidim.maximum_avatar_size } }

    validates :custom_agreement, acceptance: true
    validates :full_address, presence: true
    validates_length_of :full_address, maximum: 256, allow_blank: false, unless: -> (form) { form.email.blank? }

    validate :unique_email
  end
end

Decidim::AccountForm.class_eval do
  clear_validators!
  include AccountFormExtend
end
