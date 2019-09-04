# frozen_string_literal: true

module CreateOmniauthRegistrationExtends

  def call
    verify_oauth_signature!

    begin

      if existing_identity
        Omniauth::Strategies::RIVP.update_permissions(existing_identity) if form.provider == "rivp"
        return broadcast(:ok, existing_identity.user)
      end
      return broadcast(:invalid) if form.invalid?

      transaction do
        if concurent_identity
          Omniauth::Strategies::RIVP.destroy_permissions(concurent_identity) if form.provider == "rivp"
          destroy_identity
        end
        create_or_find_user
        @identity = create_identity
        Omniauth::Strategies::RIVP.update_permissions(@identity) if form.provider == "rivp"
      end
      trigger_omniauth_registration

      broadcast(:ok, @user)
    rescue ActiveRecord::RecordInvalid => error
      broadcast(:error, error.record)
    end
  end

  def destroy_identity
    Identity.where(
      user: organization.users,
      provider: form.provider
    ).where(
      ["uid LIKE ?", "#{form.uid[0..12]}%"]
    ).delete_all
  end

  def concurent_identity
    if form.provider == "rivp"
      @concurent_identity ||= Identity.where(
        user: organization.users,
        provider: form.provider
      ).find_by(["uid LIKE ?", "#{form.uid[0..12]}%"])
    else
      existing_identity
    end
  end

end

Decidim::CreateOmniauthRegistration.class_eval do
  prepend(CreateOmniauthRegistrationExtends)
end
