# frozen_string_literal: true
require "active_support/concern"

module UpdateAccountExtend
  extend ActiveSupport::Concern

  included do

    private

    def update_personal_data
      @user.email = @form.email
      @user.email_on_notification = @form.email_on_notification
    end
  end
end

Decidim::UpdateAccount.send(:include, UpdateAccountExtend)
