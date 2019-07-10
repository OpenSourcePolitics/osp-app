require "omniauth_openid_connect"

Devise.setup do |config|
  config.omniauth :openid_connect, {
    name: "openid_connect",
    issuer: "https://myprovider.com",
    scope: [:openid],
    client_options: {
      host: "myprovider.com",
      authorization_endpoint: '/api/v1/authorize',
      token_endpoint: '/api/v1/token',
      userinfo_endpoint: '/api/v1/userinfo',
      jwks_uri: '/api/v1/jwk',
      identifier: ENV["OP_CLIENT_ID"],
      secret: ENV["OP_SECRET_KEY"],
      redirect_uri: "http://myapp.com/users/auth/openid_connect/callback",
    }
  }
end

Decidim::User.omniauth_providers << :openid_connect
