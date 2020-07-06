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

  def omniauth_buttons_cache_version
    "omniauth_buttons/#{omniauth_buttons_cache_digest}"
  end

  def omniauth_buttons_cache_digest
    Digest::MD5.hexdigest(current_organization.cache_version + request_digest + request_available_authorizations)
  end

  def request_digest
    request.env['PATH_INFO']
  end

  def request_available_authorizations
    return "" if request.env.dig(:available_authorizations).nil? || request.env.dig(:available_authorizations).empty?

    "/" + request.env.dig(:available_authorizations).join("-")
  end
end
