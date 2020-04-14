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
      @user.full_address = @form.full_address
      @user.custom_agreement_at = DateTime.now if @form.custom_agreement
    end

  end
end

Decidim::UpdateAccount.send(:include, UpdateAccountExtend)
