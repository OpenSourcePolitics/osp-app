# frozen_string_literal: true

module Decidim
  module Verifications
    module Omniauth
      class UbxActionAuthorizer < Decidim::Verifications::DefaultActionAuthorizer
        # Overrides the parent class method, but it still uses it to keep the base behavior
        def authorize

          status_code, data = *super

          if status_code == :ok && authorization.metadata[:status] != "student"
            status_code = :unauthorized
            data[:fields] = { "status" => authorization.metadata[:status] }
          end

          [status_code, data]
        end
      end
    end
  end
end
