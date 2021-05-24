# frozen_string_literal: true

require "sidekiq/web"
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_scope :user do
    get '/admin_sign_in', to: "decidim/devise/sessions#new"
  end

  authenticate(:user) do
    resources :conversations, to: redirect('/404')
    resources :notifications, to: redirect('/404')
    resource :user_interests, to: redirect('/404')
  end

  resources :profiles, only: [:show], param: :nickname, to: redirect('/404')
  scope "/profiles/:nickname", format: false, constraints: { nickname: %r{[^\/]+} } do
    get "following", to: redirect('/404')
    get "followers", to: redirect('/404')
    get "badges", to: redirect('/404')
    get "groups", to: redirect('/404')
    get "members", to: redirect('/404')
    get "activity", to: redirect('/404')
    get "timeline", to: redirect('/404')
  end

  get "/search", to: redirect('/404')

  scope "/initiatives/:initiative_slug" do
    resources :versions, to: redirect('/404')
  end

  mount Decidim::Core::Engine => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
