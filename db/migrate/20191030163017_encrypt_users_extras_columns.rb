class EncryptUsersExtrasColumns < ActiveRecord::Migration[5.2]
  def change

    %w(gender date_of_birth region).each do |field|
      # Add the encrypted columns if needed
      add_column :decidim_users, "encrypted_#{field}".to_sym, :string unless column_exists? :decidim_users, "encrypted_#{field}".to_sym

      # Migrate date if the old column still exist
      if column_exists? :decidim_users, field.to_sym
        Decidim::User.where.not("#{field}": nil).each do |user|
          user.update_columns(
            "encrypted_#{field}": Decidim::AttributeEncryptor.encrypt(user[field.to_sym])
          )
        end

        # remove the old column
        remove_column :decidim_users, field.to_sym, :string
      end
    end

  end
end
