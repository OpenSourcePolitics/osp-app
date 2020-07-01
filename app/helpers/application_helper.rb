module ApplicationHelper
  def allowed_omniauth?(provider_name)
    return true if request.env['PATH_INFO'].end_with?('/users/sign_in')
    return true if request.env['PATH_INFO'].end_with?('/committee_requests/new')

    (available_authorizations? && request.env.dig(:available_authorizations).include?(provider_name.to_s))
  end

  private

  def available_authorizations?
    !(request.env.dig(:available_authorizations).nil? || request.env.dig(:available_authorizations).empty?)
  end
end
