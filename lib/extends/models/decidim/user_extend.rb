module UserExtend
  def eid_verified?
    identities.map(&:provider).include?("saml")
  end
end

Decidim::User.class_eval do
  prepend(UserExtend)
end
