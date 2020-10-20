# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_scope :user do
    get '/admin_sign_in', to: "decidim/devise/sessions#new"
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  post '/', to: "application#post_logout_callback"

  mount Decidim::Core::Engine => '/'
  # mount Decidim::Map::Engine => '/map'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
