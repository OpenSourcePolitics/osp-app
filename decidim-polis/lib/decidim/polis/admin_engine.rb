# frozen_string_literal: true

module Decidim
  module Polis
    # This is the engine that runs on the public interface of `decidim-polis`.
    # It mostly handles rendering the created projects associated to a participatory
    # process.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Polis::Admin

      paths["db/migrate"] = nil

      routes do
        resources :polis do
          resources :attachments
        end

        root to: "polis#index"
      end

      def load_seed
        nil
      end
    end
  end
end
