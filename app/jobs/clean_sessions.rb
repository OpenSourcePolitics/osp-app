# frozen_string_literal: true

class CleanSessions < ApplicationJob

  def perform
    system "rake db:sessions:trim"
  end
end
