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
      @user.gender = @form.gender
      @user.date_of_birth = @form.date_of_birth
      @user.region = @form.region
    end
  end
end

Decidim::UpdateAccount.send(:include, UpdateAccountExtend)
