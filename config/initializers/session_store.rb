Rails.application.config.session_store :active_record_store, :key => '_decidim_session', expire_after: Decidim.config.expire_session_after
