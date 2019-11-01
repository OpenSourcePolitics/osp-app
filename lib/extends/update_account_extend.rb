# frozen_string_literal: true
require "active_support/concern"

module UpdateAccountExtend
  extend ActiveSupport::Concern

  included do
    private

    def update_personal_data
      @user.name = @form.name
      @user.nickname = @form.nickname
      @user.email = @form.email
      @user.personal_url = @form.personal_url
      @user.about = @form.about
      @user.encrypted_gender = Decidim::AttributeEncryptor.encrypt(@form.gender)
      @user.encrypted_date_of_birth = Decidim::AttributeEncryptor.encrypt(@form.date_of_birth&.to_s)
      @user.encrypted_region = Decidim::AttributeEncryptor.encrypt(@form.region)
    end
  end
end

Decidim::UpdateAccount.send(:include, UpdateAccountExtend)
