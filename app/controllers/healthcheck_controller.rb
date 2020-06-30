class HealthcheckController < ApplicationController
  def show
    render json: { status: 200, success: true }
  end
end
