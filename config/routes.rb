require "sidekiq/web"
Rails.application.routes.draw do

  # authenticate :user, lambda { |u| u.roles.include?("admin") } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end

  mount Sidekiq::Web => '/sidekiq'

  if Rails.env.development? || ENV["HEROKU_APP_NAME"].present?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  mount Decidim::Core::Engine => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
