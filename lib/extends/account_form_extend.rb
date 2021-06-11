# frozen_string_literal: true
require "active_support/concern"
require "valid_email2"

module AccountFormExtend
  extend ActiveSupport::Concern

  included do
    include Decidim::JsonbAttributes

    attribute :email_on_notification, Virtus::Attribute::Boolean

    validates :email, 'valid_email_2/email': { mx: true }
    validates :avatar, file_size: { less_than_or_equal_to: ->(_record) { Decidim.maximum_avatar_size } }

    validate :unique_email
  end
end

Decidim::AccountForm.class_eval do
  clear_validators!
  include AccountFormExtend
end
