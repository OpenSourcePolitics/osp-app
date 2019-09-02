module OfficialAuthorPresenterExtend
  include Decidim::BadgeHelper
end

Decidim::Proposals::OfficialAuthorPresenter.class_eval do
  prepend(OfficialAuthorPresenterExtend)
end
