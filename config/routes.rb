require "sidekiq/web"
Rails.application.routes.draw do

  get "api/traduction" => "translation#traduction"

  # devise_scope :user do
  #   get '/users/auth/:provider/setup' => 'decidim/omniauth_config#setup'
  # end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
    # mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  mount Decidim::Core::Engine => '/'
  # mount Decidim::Map::Engine => '/map'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
