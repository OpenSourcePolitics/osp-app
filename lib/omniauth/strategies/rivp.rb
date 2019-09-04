# frozen_string_literal: true

require "omniauth"

module Omniauth
  module Strategies
    class RIVP
      include OmniAuth::Strategy

      CIPHER_METHOD = "AES-256-CBC"

      def self.inherited(subclass)
        OmniAuth::Strategy.included(subclass)
      end

      args [:authorization_uri, :client_secret]

      option :name, :rivp
      option :authorization_uri, nil
      option :client_secret, nil

      uid do
        "#{raw_info["esi"]}-#{raw_info["apartment_number"]}-#{raw_info["contract_number"]}"
      end

      info do
        {
          email: raw_info["email"],
          nickname: Decidim::UserBaseEntity.nicknamize("#{raw_info["esi"]}_#{raw_info["apartment_number"]}"),
          name: "Résidence n°#{raw_info["esi"]} - Appartement n° #{raw_info["apartment_number"]}"
        }
      end

      extra do
        {
          esi: raw_info["esi"],
          apartment_number: raw_info["apartment_number"],
          contract_number: raw_info["contract_number"]
        }
      end

      def request_phase
        if options.authorization_uri
          redirect options.authorization_uri
        else
          raise ::OmniAuth::Error, "RIVP - authorization_uri is undefined"
        end
      end

      def raw_info
        @raw_info ||= access_token
      end

      def self.update_permissions(identity)
        user_info = identity.uid.split("-")
        byebug
        if user_info.size == 3 && !user_info[0].blank?
          Decidim::ParticipatoryProcess.where("meta_scope ->> 'fr' = ?", user_info[0]).find_each do |process|
            Decidim::ParticipatorySpacePrivateUser.find_or_create_by!(
              user: identity.user,
              privatable_to: process
            )
          end
        end
      end

      def self.destroy_permissions(identity)
        user_info = identity.uid.split("-")
        if user_info.size == 3 && !user_info[0].blank?
          Decidim::ParticipatoryProcess.where("meta_scope ->> 'fr' = ?", user_info[0]).find_each do |process|
            Decidim::ParticipatorySpacePrivateUser.where(
              user: identity.user,
              privatable_to: process
            ).delete_all
          end
        end
      end

      private

      def access_token
        result = {}
        if request.params["token"].present?
          decrypted_payload ||= token_decrypt(request.params["token"], options.client_secret)
          decrypted_list = decrypted_payload.split("-")
          if decrypted_list.size == 3
            if decrypted_list[0].length == 11
              result["esi"] = decrypted_list[0][0..5]
              result["apartment_number"] = decrypted_list[0][7..10]
            else
              raise ::OmniAuth::Error, "RIVP - decrypt ESI : expected size was 11 - #{decrypted_list[0]} given"
            end

            if decrypted_list[1].present?
              result["contract_number"] = decrypted_list[1]
            else
              raise ::OmniAuth::Error, "RIVP - decrypt contract : is missing - #{decrypted_list[1]} given"
            end

            if decrypted_list[2] =~ URI::MailTo::EMAIL_REGEXP
              result["email"] = decrypted_list[2]
            else
              raise ::OmniAuth::Error, "RIVP - decrypt email : #{decrypted_list[2]} is not email"
            end

            return result
          else
            raise ::OmniAuth::Error, "RIVP - decrypt : expected 3 parts on token split"
          end
        else
          raise ::OmniAuth::Error, "RIVP - raw_info : token is missing"
        end
      end

      def token_encrypt(str, key)
        # binding.pry
        cipher = OpenSSL::Cipher.new(CIPHER_METHOD)
        cipher.encrypt
        cipher.key = key
        data = cipher.update(str) + cipher.final
        return Base64.urlsafe_encode64(data)
      end

      def token_decrypt(str, key)
        data = Base64.urlsafe_decode64(str)
        cipher = OpenSSL::Cipher.new(CIPHER_METHOD)
        cipher.decrypt
        cipher.key = key
        return cipher.update(data) + cipher.final
      end

    end
  end
end

OmniAuth.config.add_camelization "rivp", "RIVP"
