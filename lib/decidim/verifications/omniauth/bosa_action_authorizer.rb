# frozen_string_literal: true

module Decidim
  module Verifications
    module Omniauth
      class BosaActionAuthorizer < Decidim::Verifications::DefaultActionAuthorizer
        # Overrides the parent class method, but it still uses it to keep the base behavior
        def authorize

          status_code, data = *super
          minimum_age = manifest&.minimum_age

          if status_code == :ok && action == "vote" && minimum_age.present? && under_minimum_age?(minimum_age)
            status_code = :unauthorized
            data[:fields] = { "date_of_birth" => I18n.t("decidim.verifications.omniauth.errors.minimum_age", minimum_age: minimum_age, locale: authorization.user.locale) }
          end

          [status_code, data]
        end

        def under_minimum_age?(minimum_age)
          authorization.metadata[:official_birth_date].present? &&
            (((Time.zone.now - authorization.metadata[:official_birth_date].to_time) / 1.year.seconds).floor < minimum_age)
        end

        def manifest
          @manifest ||= Decidim::Verifications.find_workflow_manifest(authorization&.name)
        end
      end
    end
  end
end
