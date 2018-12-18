require "sidekiq/web"
Rails.application.routes.draw do

  if Rails.env.production?
      authenticate :user, lambda { |u| u.roles.include?("admin") } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  mount Decidim::Core::Engine => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
