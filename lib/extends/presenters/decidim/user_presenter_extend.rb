module UserPresenterExtend
  include Decidim::BadgeHelper
end

Decidim::UserPresenter.class_eval do
  prepend(UserPresenterExtend)
end
