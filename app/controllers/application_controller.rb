class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, :only => [:post_logout_callback]

  def post_logout_callback
    redirect_to "/"
  end
end
