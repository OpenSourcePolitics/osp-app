# frozen_string_literal: true
require "active_support/concern"
require "valid_email2"

module AccountFormExtend
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates :email, presence: true, 'valid_email_2/email': { disposable: true }
    validates :nickname, presence: true

    validates :nickname, length: { maximum: Decidim::User.nickname_max_length, allow_blank: true }
    validates :name, length: { maximum: 25, allow_blank: true }
    validates :password, confirmation: true
    validates :password, password: { name: :name, email: :email, username: :nickname }, if: -> { password.present? }
    validates :password_confirmation, presence: true, if: :password_present
    validates :avatar, file_size: { less_than_or_equal_to: ->(_record) { Decidim.maximum_avatar_size } }

    validate :unique_email
    validate :unique_nickname
    validate :personal_url_format
  end
end

Decidim::AccountForm.class_eval do
  clear_validators!
  include AccountFormExtend
end
