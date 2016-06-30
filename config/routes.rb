require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  namespace :manage do
    resources :permissions, except: [:edit, :update]
    get 'users/search' => 'users#search', as: :users_search

    root to: 'welcome#index'
  end

  root :to => 'application#index'

  get '/(*path)', :to => 'application#index'
end
