
# SETUP_PROC = lambda do |env|
#   Rails.logger.debug 'SETUP_PROC'
#   req = Rack::Request.new(env)
#   # Note client_id & client_secret for Facebook
#   env['omniauth.strategy'].options[:client_id] = Rails.application.secrets.omniauth[:facebook][:app_id]
#   env['omniauth.strategy'].options[:client_secret] = Rails.application.secrets.omniauth[:facebook][:app_secret]
#   Rails.logger.debug env['omniauth.strategy'].options.to_yaml
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger

  # provider :facebook, setup: false
end
