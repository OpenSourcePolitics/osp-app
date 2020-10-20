class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def post_logout_callback
    redirect_to "/"
  end
end
